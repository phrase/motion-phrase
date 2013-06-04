module MotionPhrase
  class ApiClient
    def self.sharedClient
      Dispatch.once { @instance ||= new }
      @instance
    end

    def storeTranslation(keyName, content, fallbackContent, currentLocale)
      return false unless development?
      
      data = {
        "locale" => currentLocale,
        "key" => keyName,
        "content" => content,
        "skip_verification" => true,
        "auth_token" => PHRASE_AUTH_TOKEN
      }
      client.post("translations/store", data) do |result|
        if result.success?
          log "Stored Translation for #{keyName}"
        elsif result.failure?
          log "Could not store translation for #{keyName}"
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
      AFMotion::Client.build_shared(PHRASE_API_BASE_URI) do
        header "Accept", "application/json"
        operation :json
      end
    end

    def log(msg="")
      $stdout.puts msg
    end
  end
end
