# frozen_string_literal: true

Rack::Attack.throttled_responder = lambda do |request|
  if request.env['rack.attack.matched'] == 'attempts'
    [ 503, {}, [File.read('public/throttled/attempts.html')]]
  else
    [ 503, {}, [File.read('public/throttled/requests.html')]]
  end
end

Rack::Attack.throttle('attempts', limit: 6, period: 60) do |request|
  if request.path == '/login' && request.post?
    request.ip
  end
end

Rack::Attack.throttle('requests', limit: 6, period: 2) do |request|
  request.ip
end