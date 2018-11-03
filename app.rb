require 'sinatra/base'
require 'twilio-ruby'

class App < Sinatra::Base
  get '/auth' do
    content_type :json
    grant = ::Twilio::JWT::AccessToken::ChatGrant.new
    grant.service_sid = ENV['TWILIO_CHAT_SERVICE_SID']

    token = ::Twilio::JWT::AccessToken.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_API_KEY'],
      ENV['TWILIO_API_SECRET'],
      [grant],
      ttl: 86400,
      identity: params[:identity]
    )
    token.to_jwt
    {identity: params[:identity], token: token.to_jwt}.to_json
  end
end

App.run!
