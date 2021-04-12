# Userstamper

## Overview

Userstamp extends `ActiveRecord::Base` to add automatic updating of `creator` and `updater` attributes.

Two class methods (`model_stamper` and `stampable`) are implemented in this gem. The `model_stamper`
method is used in models that are responsible for creating or updating other objects.
Typically this would be the `User` model of your application. The `stampable` method is used in 
models that are subject to being created or updated by stampers.

Gem is tested with Ruby 2.7.2 and Rails 6.1.3.1

## Features
to result in a `belongs_to` relation which looks like:

```ruby
  belongs_to :creator, class_name: '::User', foreign_key: :created_by
```

### Saving before validation
This includes changes to perform model stamping before validation. This allows models to
enforce the presence of stamp attributes:

```ruby
  validates :created_by, presence: true
  validates :updated_by, presence: true
```

Furthermore, the `creator` attribute is set only if the value is blank allowing for a manual
override.

## Usage
Assume that we are building a blog application, with User and Post objects. Add the following 
to the application's Gemfile:

```ruby
  gem 'userstamper'
```

Define an initializer in your Rails application to configure the gem:
config/initilialize/userstamper.rb:

```ruby
Userstamper.configure do |config|
  # config.default_stamper = 'User'
  # config.creator_attribute = :creator_id
  # config.updater_attribute = :updater_id
  config.deleter_attribute = nil
end
```

Ensure that each model has a set of columns for creators and updaters.

```ruby
  class CreateUsers < ActiveRecord::Migration
    def change
      create_table :users do |t|
        ...
        t.userstamps
      end
    end
  end

  class CreatePosts < ActiveRecord::Migration
    def change
      create_table :posts do |t|
        ...
        t.userstamps
      end
    end
  end
```

If you use `protect_from_forgery`, make sure the hooks are prepended:

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true # with: anything will do, note `prepend: true`!
end
```

Declare the stamper on the User model:

```ruby
  class User < ActiveRecord::Base
    model_stamper
  end
```

If your stamper is called `User`, that's it; you're done.

## Customisation
The association which is created on each of the `creator_id` and `updater_id` can
be customised. Also, the stamper used by each class can also be customised. For this purpose, the
 `ActiveRecord::Base.stampable` method can be used:

```ruby
  class Post < ActiveRecord::Base
    stampable
  end
```

The `stampable` method allows you to customize the `creator` and `updater` associations.
It also allows you to specify the name of the stamper for the class being declared. Any additional
arguments are passed to the `belongs_to` declaration.

## Upgrade
When upgradeing from activerecord_userstamp gem, please remove deleted attributes. 
Soft delete is not supported and not recommended. Soft delete is more pain in real life.

## Tests
Run

    $ bundle exec rspec

## Forkception

This is a fork of:
 - the [activerecord-userstamp](https://github.com/lowjoel/activerecord-userstamp) gem
 - the [magiclabs-userstamp](https://github.com/magiclabs/userstamp) gem
 - which is a fork of [Michael Grosser's](https://github.com/grosser)
   [userstamp gem] (https://github.com/grosser/userstamp) 
 - which is a fork of the original [userstamp plugin](https://github.com/delynn/userstamp) by
   [delynn](https://github.com/delynn)

In addition to these, some ideas are cherry picked from the following forks:

 - [simplificator](https://github.com/simplificator/userstamp)
 - [akm](https://github.com/akm/magic_userstamp)
 - [konvenit](https://github.com/konvenit/userstamp)

## Authors
 - [DeLynn Berry](http://delynnberry.com/): The original idea for this plugin came from the Rails
   Wiki article entitled
   [Extending ActiveRecord](http://wiki.rubyonrails.com/rails/pages/ExtendingActiveRecordExample)
 - [Michael Grosser](http://pragmatig.com)
 - [John Dell](http://blog.spovich.com/)
 - [Chris Hilton](https://github.com/chrismhilton)
 - [Thomas von Deyen](https://github.com/tvdeyen)
 - [Joel Low](http://joelsplace.sg)
 - [Priit Tark](https://github.com/priit)
