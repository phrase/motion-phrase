# motion-phrase

motion-phrase lets you connect your RubyMotion application to PhraseApp and enables you to benefit from the best internationalization workflow for your (iOS) projects.

It lets you use iOS Localizable.strings files to store and read translations but at the same time work on your translation files collaboratively with translators, developers and product managers.

[Learn more about PhraseApp](https://phraseapp.com/)

## Installation

Using the service requires a PhraseApp account. Just sign up at [phraseapp.com/signup](https://phraseapp.com/signup) and get your free trial account (we offer free plans for small and open source projects).

You can skip the introduction wizard and simply create your first project to get your Auth Token directly from the project overview in PhraseApp.

### Install the Gem

Add this line to your application's Gemfile:

    gem 'motion-phrase'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install motion-phrase
    
Require the gem (unless you use bundler):

	require 'motion-phrase'
    
### Configure PhraseApp

Add the Auth Token to your application's Rakefile:

	Motion::Project::App.setup do |app|
	  app.name = "Test Application"
	  . . .
	  app.phrase.auth_token = "YOUR_AUTH_TOKEN"
	  . . .
	end

This will automatically create the `phrase_config.rb` configuration file in your app folder during the first build process.

Now you can initialize your PhraseApp setup using rake:

	rake phrase:init AUTH_TOKEN=YOUR_AUTH_TOKEN
	
This will:

1. Create the first locale in your PhraseApp project (and make it your default locale as well)
2. Create a `.phrase` config file that contains information required by the underlying [phrase gem](https://github.com/phrase/phrase)

## Usage

Using PhraseApp with motion-phrase enables you to:

1. Send new translations to the PhraseApp API automatically without having to write them into your Localizable.strings file or uploading them - just by browsing the app.
2. Upload and download your most recent translations from/to the PhraseApp API using rake commands.
3. Spend less time sending emails or fixing broken Localizable.strings files ;-)

### Localizing Strings ###

The first step towards a localized app is to localize all strings by extending them with their localized counterparts. This can be done by simply calling the `#__` method on each string that is implemented by motion-phrase:

	"Hello World"
	
now becomes:

	"Hello World".__
	
or (when using a fallback translation):
	
	"Hello World".__("My fallback translation")
	
Of course you can use more generic names for your keys as well, such as:

	"HOME_WELCOME_BUTTON_LABEL".__
	

	
[Learn more about localization in iOS](https://developer.apple.com/internationalization/)

### Browsing translations in your app

Simply build and run your app (in the simulator). When in development mode, motion-phrase will send all of your localized strings to PhraseApp automatically! Log into your [PhraseApp account](https://phraseapp.com/account/login) and check your newly created translation keys. If you already have your localization files in the correct place, it will transmit translations as well.

### Push localization files

If you already have localization files in place, you can transmit them to PhraseApp by using the following rake command:

	rake phrase:push
	
Simply execute this from inside your project directory and it will upload all Localizable.strings files that are found in your `resources` folder. All new keys and translation will be created in your PhraseApp project during the upload.

### Pull localization files

Of course you want to include all recent translations in your application before releasing or testing it. Simply fetch all translations from PhraseApp using rake:

	rake phrase:pull
	
This will download and replace all existing Localizable.strings files that sit in your `resources` folder. You can now build/test/release your application with the most recent localization files.

### Extended Usage ###

motion-phrase uses the [phrase gem](https://github.com/phrase/phrase) to communicate with the service. Feel free to use the `phrase` command to gain control over extended configuration options. 

[Learn more about phrase gem](https://phraseapp.com/docs/installation/general-information)

## Your new workflow (Best Practice)

Once you have your PhraseApp integration up and running, we recommend the following workflow:

1. Let developers introduce new keys (localizable strings) in the code
2. Browse the new feature in your app
3. Log into PhraseApp and fill out the remaining translations in all other locale (or simply order the missing translations through our expert network)
4. Download all translations using the pull command
5. Ship it ;-)

## Important ##

Please remember the following hints (especially when something goes wrong):

* The locale/language that you want to send translations from must exist in your PhraseApp project (e.g. if you are running your simulator in French and want to send translations to PhraseApp by browsing the app, you first have to create a "fr" locale in your PhraseApp project)
* We only transmit translations to the API when you run your app in development mode (`RUBYMOTION_ENV` must be development)
* **Please double-check that no API traffic is triggered in the release/releasable version of your application!!!**

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Support

* [PhraseApp documentation](https://phraseapp.com/docs)
* [PhraseApp Support Channel](https://phraseapp.com/support)
