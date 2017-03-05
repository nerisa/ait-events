OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '854350761629-4k9adm29rb3c78g10vpj9511vuge4kiv.apps.googleusercontent.com', 'j5LnhTZLq1bqF_p2q1XsUNSS',
           {
               ssl: {ca_file: Rails.root.join("cacert.pem").to_s},
               hd: 'ait.asia',
               access_type: 'online',
               skip_jwt: true
           }
end

OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)