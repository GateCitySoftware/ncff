if Rails.env.development?
  Aws.config.update({
                      region: Rails.application.credentials.dig(:aws, :region),
                      credentials: Aws::Credentials.new(
                        Rails.application.credentials.dig(:aws, :access_key_id),
                        Rails.application.credentials.dig(:aws, :secret_access_key)
                      )
                    })
else
  Aws.config.update({
                      region: ENV['AWS_REGION'],
                      credentials: Aws::Credentials.new(
                        ENV['AWS_ACCESS_KEY_ID'],
                        ENV['AWS_SECRET_ACCESS_KEY']
                      )
                    })
end
