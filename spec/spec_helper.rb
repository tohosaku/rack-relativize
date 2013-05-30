$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

%w(rack rack/test rack/relativize).each do |f|
  require f
end

class TestRackApp
  DummyBody = '<img src="/test">'

  def call(env)
    case env['PATH_INFO']
    when '/'
      [200, {"Content-Type" => "text/html"}, [DummyBody]]
    when '/sub/'
      [200, {"Content-Type" => "text/html"}, [DummyBody]]
    when '/image.jpg'
      [200, {"Content-Type" => "image/ipg"}, [DummyBody]]
    end
  end
end


