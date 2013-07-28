GuardPost-ObjectiveC
====================

An objective-C implementation of Mailgun's Guardpost email validation service


## How to install

The easiest way to install GuardPost-ObjectiveC is using cocoapods. Add the
following to your `Podfile`:

    pod 'Guardpost-ObjectiveC', :git => 'git@github.com:sammyd/GuardPost-ObjectiveC.git'

And then run:

    pod install


Alternatively you can clone this repo and use the classes defined in the Classes
subdirectory. Note that `AFNetworking` is a dependency of this tool.


## How to use

GuardPost offers 2 API methods - email validation and email list parsing. Before
using either of these you need to set the API key. GuardPost is a service
provided buy [MailGun](https://mailgun.net/) and therefore you need an account
with them in order to use it. The GuardPost service is free - to sign up for a
free account visit [here](https://mailgun.com/signupb?plan=free).

Once you've signed up you need to get hold of your **public** API key (of the
form 'pubkey-...'). To set it in your app you need to call the following method
once:

    [GPGuardPost setPublicAPIKey:@"pubkey-your-key-here"];

This is a static method - once you've set it it will be used for all calls to
the GuardPost API throughout the lifetime of the app. Therefore setting it in
the AppDelegate or viewDidLoad of the main view controller is a good idea.

### Validating Emails

To Validate an email use the `+validateAddress:success:failure:` method. This
takes a string for the address to validate, and 2 blocks - one to be called in
the event of a successful API call, and one for failure. For example:

    [GPGuardPost validateAddress:self.emailField.text success:^(BOOL validity, NSString *suggestion) {
        NSLog(@"API call successful");
    } failure:^(NSError *error) {
        NSLog(@"There was an error: %@", [error localizedDescription]);
    }];

The success block has 2 arguments:
- `validity` is a `BOOL` which specifies whether the email address sent is valid
- `suggestion` is an `NSString` which has a suggestion for an email address, or
is nil. Note that valid email addresses can have a non-nil suggestion, and similarly
invalid addresses don't necessarily have a suggestion.

The error block has an `NSError` argument.

### Parsing lists of email addresses

An email address field can be comprised of a string of comma or semi-colon delimited
email addresses. However, parsing the list is not always trivial. Therefore the
`+parseListOfAddresses:success:failure` method is provided by mailgun. Provded a
string which contains a list of addresses the method again has success and failure
callback blocks. The failure block is of the same form as for email validation.

The success block has 2 `NSArray` arguments - the first for a list of parsed
email addresses, and the second for unparseable parts of the list string. Note
that these email addresses have only been parsed for grammar, and additional
validation can then be performed with calls to the `validateAddress` method.

## Sample code

There is a sample app inside the Samples subdirectory called `GuardPostExample`.
This is a basic email validation app, which takes an email and reports back
whether it has been found to be valid or not.

In order to try this app out you'll need to provide your own API key. There is a
plist called `GPSettings-Sample.plist`. Duplicate this as `GPSettings.plist` and
update the `MailGunPublicAPIKey` key with your public key.

Alternatively, update the source code with your public key.

## Further Info

This project is an interface to the excellent GuardPost API provided by mailgun.
The documentation for this API can be found [here](http://documentation.mailgun.com/api-email-validation.html).

## Development

Feel free to raise an issue, or send a pull request. All contributions welcome!

## About

This project was written by Sam Davies. You should have a peruse of his blog at
(iwantmyreal.name)[http://iwantmyreal.name/] and follow him on twitter
[@iwantmyrealname](https://twitter.com/iwantmyrealname) or ADN
[@samd](https://app.net/samd).

