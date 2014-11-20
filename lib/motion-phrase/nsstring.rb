class NSString
  def _localized(value=nil, table=nil)
    @localized = NSBundle.mainBundle.localizedStringForKey(self, value:value, table:table)
    storeTranslation(self, @localized, value, table) if phraseEnabled?
    @localized
  end
  alias __ _localized

private
  def storeTranslation(key, localized, defaultValue=nil, table=nil)
    @client = MotionPhrase::ApiClient.sharedClient
    @client.storeTranslation(key, localized, defaultValue, currentLocaleName)
  end

  def phraseEnabled?
    PHRASE_ENABLED == true && development?
  end

  def currentLocaleName
    currentLocale.localeIdentifier
  end

  # @return [NSLocale] locale of user settings
  def currentLocale
    languages = NSLocale.preferredLanguages
    if languages.count > 0
      return NSLocale.alloc.initWithLocaleIdentifier(languages.first)
    else
      return NSLocale.currentLocale
    end
  end

  def environment
    RUBYMOTION_ENV
  end

  def development?
    environment == 'development'
  end

end
