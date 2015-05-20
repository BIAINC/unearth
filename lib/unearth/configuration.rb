module Unearth
  class Configuration
    attr_accessor :insights_url,
                  :insights_account_id,
                  :insights_api_key,
                  :logger,
                  :enable_log

    def initialize
    end
  end
end
