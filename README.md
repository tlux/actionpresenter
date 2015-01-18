# ActionPresenter

[![Code Climate](https://codeclimate.com/github/tlux/actionpresenter/badges/gpa.svg)](https://codeclimate.com/github/tlux/actionpresenter)

A lightweight presenter implementation for Ruby on Rails.

### Requirements
* Ruby on Rails >= 4

### Installation
1. Add this to your Gemfile:
  ```ruby
  gem 'actionpresenter', '0.2.0'
  ```

2. Create the `app/presenters` folder in your project which will be holding your presenter files.

### Usage
Lets say we have a model named `User`.

```ruby
class User < ActiveRecord::Base
  # Model with columns first_name and last_name
  # ...
  def name
    "#{first_name} #{last_name}".strip
  end
end
```

##### Creating a Presenter
In our views we always want to display the name of a specific user with a link to his profile. The simplest way of providing similar behavior to all our views is to create a `UserPresenter` in `app/presenters/user_presenter.rb`.

```ruby
class UserPresenter < ActionPresenter::Base
  presents :user

  def name(linked = true)
    h.link_to_if linked, super(), h.user_profile_path(user)
  end
end
```

We can use `super` as alternative to `user.name` or `object.name` in this case to get the value from the original `User` instance.

All helpers from the view context are available through the `template` accessor (or its short variant `h`).

You can also make all view helpers available to the presenter as if they were mixed into the presenter by including `ActionPresenter::TemplateDelegation`:

```ruby
class UserPresenter < ActionPresenter::Base
  include ActionPresenter::TemplateDelegation

  presents :user

  def name(linked = true)
    link_to_if linked, super(), user_profile_path(user)
  end
end
```

##### Using Presenters in a View
A presenter can be embedded into a view by using the `present` helper.
```erb
<% present @user do |user| %>
  <strong>Name:</strong>
  <br>
  <%= user.name %>
<% end %>
```
You can also use reference to any custom presenter:
```erb
<% present @user, with: Admin::UserPresenter do |user| %>
  ...
<% end %>
```

Alternatively, you can use:
```erb
<% present [:admin, @user] do |user| %>
  ...
<% end %>
```

If you have a collection of objects you can rely on `present_collection` which will wrap each element of the collection with its own presenter:

```erb
<% present_collection(@users).each do |user| %>
  ...
<% end %>
```

The following snippet will search for matching presenter classes within the `Admin` module:
```erb
<% present_collection(@users, scope: :admin).each do |user| %>
  ...
<% end %>
```

##### Keeping it DRY
To share common functionality between different presenters we encourage you to use presenter concerns. Latter should be put into `app/presenters/concerns`. Note: As this folder is not recognized by the default Rails setup, it has to be added manually to `config/application.rb`:
```ruby
config.autoload_paths << Rails.root.join('app', 'presenters', 'concerns').to_s
```

### Contributing to ActionPresenter
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright
Copyright (c) 2015 Tobias Casper. See LICENSE.txt for
further details.

