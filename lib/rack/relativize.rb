# encoding: utf-8
require 'rack/relativize/version'

class Rack::Relativize

  def initialize(app)
    @app        = app
  end

  def call(env)
    status, headers, enumerable_body = original_response = @app.call(env.dup)

    if headers["Content-Type"].to_s.match(/(ht|x)ml/) # FIXME: Use another pattern
      type = :html
    elsif headers["Content-Type"].to_s.match(/css/)
      type = :css
    else
      return original_response
    end

    path    = env['PATH_INFO']
    raise  "PATH_INFO is Empty" if path == ""

    content = join_body(enumerable_body)

    case type
    when :html
      processed_body = content.gsub(/(<[^>]+\s+(src|href))=(['"]?)(\/.*?)\3([ >])/) do
        $1 + '=' + $3 + relative_path_to(path, $4) + $3 + $5
      end
    when :css
      processed_body = content.gsub(/url\((['"]?)(\/.*?)\1\)/) do
        'url(' + $1 + relative_path_to(path, $2) + $1 + ')'
      end
    else
      raise RuntimeError.new(
        "The relativize_paths needs to know the type of content to " +
          "process. Pass :type => :html for HTML or :type => :css for CSS."
      )
    end
    processed_headers = headers.merge({
        "Content-Length" => processed_body.size.to_s
      })
    [status, processed_headers, [processed_body]]
  end

  private

  def relative_path_to(src, target)
    require 'pathname'

    # Find path
    if target.is_a?(String)
      path = target
    else
      path = target.path
      raise RuntimeError, "Cannot get the relative path to #{target.inspect} because this target is not outputted (its routing rule returns nil)" if path.nil?
    end

    # Get source and destination paths
    dst_path   = Pathname.new(path)
    raise RuntimeError, "Cannot get the relative path to #{path} because the current item representation, #{src.inspect}, is not outputted (its routing rule returns nil)" if src == nil
    src_path   = Pathname.new(src)

    # Calculate the relative path (method depends on whether destination is
    # a directory or not).
    if src_path.to_s[-1,1] != '/'
      relative_path = dst_path.relative_path_from(src_path.dirname).to_s
    else
      relative_path = dst_path.relative_path_from(src_path).to_s
    end

    # Add trailing slash if necessary
    if dst_path.to_s[-1,1] == '/'
      relative_path << '/'
    end

    # Done
    relative_path
  end

  def join_body(enumerable_body)
    parts = []
    enumerable_body.each { |part| parts << part }
    return parts.join("")
  end
end
