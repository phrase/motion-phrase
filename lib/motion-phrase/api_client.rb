module MotionPhrase
  class ApiClient
    API_CLIENT_IDENTIFIER = "motion_phrase"
    API_BASE_URI = "https://phraseapp.com/api/v1/"

    def self.sharedClient
      Dispatch.once { @instance ||= new }
      @instance
    end

    def storeTranslation(keyName, content, fallbackContent, currentLocale)
      return unless development?
      
      content ||= fallbackContent
      data = {
        locale: currentLocale,
        key: keyName,
        content: content,
        allow_update: false,
        skip_verification: true,
        api_client: API_CLIENT_IDENTIFIER,
      }
      client.post("translations/store", authenticated(data)) do |result|
        if result.success?
          log "Translation stored [#{data.inspect}]"
        elsif result.failure?
          log "Error while storing translation [#{data.inspect}]"
        end
      end
    end

  private
    def development?
      RUBYMOTION_ENV == "development"
    end

    def client 
      @client ||= buildClient
    end

    def buildClient
      AFMotion::Client.build_shared(API_BASE_URI) do
        header "Accept", "application/json"
        operation :json
      end
    end

    def log(msg="")
      $stdout.puts "PHRASEAPP #{msg}"
    end

    def authenticated(params={})
      params.merge(auth_token: PHRASE_AUTH_TOKEN)
    end      
  end
end
