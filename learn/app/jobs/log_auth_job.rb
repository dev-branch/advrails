class LogAuthJob < ApplicationJob
  queue_as :default

  def perform(*args)
    data = args.first
    HTTParty.post('http://logger:5555/logs', {body: {log: data}})
  end
end
