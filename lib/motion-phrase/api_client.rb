module MotionPhrase
  class ApiClient
    API_CLIENT_IDENTIFIER = "motion_phrase"
    API_BASE_URI = "https://phraseapp.com/api/v1/"

    def self.sharedClient
      Dispatch.once { @instance ||= new }
      @instance
    end

    def storeTranslation(keyName, content, fallbackContent, currentLocale)
      return unless auth_token_present?

      content ||= fallbackContent
      data = {
        locale: currentLocale,
        key: keyName,
        content: content,
        allow_update: false,
        skip_verification: true,
        api_client: API_CLIENT_IDENTIFIER,
      }

      client.POST("translations/store", parameters:authenticated(data), success:lambda {|task, responseObject|
        log "Translation stored [#{data.inspect}]"
      }, failure:lambda {|task, error|
        log "Error while storing translation [#{data.inspect}]"
      })
    end

  private
    def client
      Dispatch.once do
        @client = begin
          _client = AFHTTPSessionManager.alloc.initWithBaseURL(NSURL.URLWithString(API_BASE_URI))
          _client
        end
      end
      @client
    end

    def log(msg="")
      $stdout.puts "PHRASEAPP #{msg}"
    end

    def authenticated(params={})
      params.merge(auth_token: auth_token)
    end

    def auth_token
      if defined?(PHRASE_AUTH_TOKEN)
        PHRASE_AUTH_TOKEN
      else
        nil
      end
    end

    def auth_token_present?
      !auth_token.nil? && auth_token != ""
    end
  end
end
