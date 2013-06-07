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

  def development?
    App.development?
  end

  def currentLocaleName
    App.current_locale.localeIdentifier
  end
end
