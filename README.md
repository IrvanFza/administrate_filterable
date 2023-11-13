# Administrate Custom Filter

![Gem](https://img.shields.io/gem/v/administrate_filterable.svg)
![CI](https://github.com/IrvanFza/administrate_filterable/workflows/CI/badge.svg)

An [Administrate](https://github.com/thoughtbot/administrate/) plugin to add custom filter in your index page. Highly inspired by [ActiveAdmin](https://github.com/activeadmin/activeadmin)'s filter.

## Why you need this?

Let's agree that the Administrate's team has done a great job with the default search or filter functionality. It's simple and easy to use. It supports multiple search fields, cross relation search, and it's easy to customize (like enable/disable the search, defining custom search fields, etc).

But there are some drawbacks that I found:
1. Since it uses single search box, the search process behind it is quite heavy. It will search all the attributes of the model, and it will be slower if you have a lot of data.
2. Again, because it search all the attributes, it will be hard to search for a specific attribute. For example, if you have `registration_status` and `employment_status`, and you want to search for "active" registration status only, you will get all the "active" records, including the employment status.
3. It's not user friendly when it comes to defined search list (e.g. dropdown list). The user will have to type the value manually, and it's not good for the user experience.

Please share your thoughts if you have any other reasons.

## Requirements

- Ruby on Rails version >= 5.0
- Administrate version >= 0.2.2

## Installation

Add `administrate_filterable` to your Gemfile:

```ruby
gem 'administrate_filterable'
```

And then execute:
```
$ bundle install
```

Or, simply just run:
```
$ bundle add administrate_filterable
```

## Usage

For each resource you want to add custom filter, add the following line to the their respective Administrate controller.
```ruby
include AdministrateFilterable::Filterer
```

Example:
```ruby
class UsersController < Administrate::ApplicationController
  include AdministrateFilterable::Filterer

  # ...
end
```

By default all the attributes from COLLECTION_ATTRIBUTES will be rendered as the filter fields. You can override this by adding FILTER_ATTRIBUTES to your Administrate's dashboard file.

Example (`app/dashboards/user_dashboard.rb`):
```ruby
class UserDashboard < Administrate::BaseDashboard
  # ..
  FILTER_ATTRIBUTES = [
    :first_name,
    :last_name,
    :email,
    :created_at
  ].freeze
  # ..
end
```

By default this gem will add a filter button to the partial `views/admin/application/_index_header.html.erb`. But if you have your own Administrate index views or override that partial in your application you can add the button manually by adding the following line:
```erb
<%= render('index_filter', page: page) %>
```

Example (`app/views/admin/users/_index_header.html.erb`):
```erb
... other code here ...
<header class="main-content__header">
  ... other code here ...

  <%= render('index_filter', page: page) %>
</header>
```

If you use assets pipeline, you need to include this gem's assets to your `app/assets/config/manifest.js` file:
```javascript
// ... other code here ...

//= link administrate_filterable/application.css
//= link administrate_filterable/application.js
```

## To Do
There are still a lot of things to do to make this gem better. Here are some of them (sorted highest priority first):
- [ ] Add support for relational filter (e.g. filter by `belongs_to` association, etc)
- [ ] Add support to customize the dropdown list (e.g. add `prompt` option, add `include_blank` option, etc)
- [ ] Exclude checkbox, radio, or select value from the filter params if no action is performed on them
- [ ] Figure out a better way to implement the filter functionality (currently I override the `scoped_resource` method)
- [ ] Figure out a better way to pass the filter attributes to the form (currently I use instance variable in the overridden `scoped_resource` method)
- [ ] Add capability to customize the filter behavior (e.g. search by exact match, search by partial match, etc just like in the ActiveAdmin filter)
- [ ] Improve the toggle button user experience (e.g. add open/close animation, add dynamic open/close title, etc)

## Contributing

1. Contribution are welcome (codes, suggestions, and bugs)
2. Please test your code: `bundle exec rspec`
3. Please document your code

## License

[MIT License](https://github.com/IrvanFza/administrate_filterable/blob/master/LICENSE)

## Credits
Huge thanks for the following resources that help me a lot in creating this gem:
- [administrate_filterable](https://github.com/SourceLabsLLC/administrate_exportable): Basically I just copy the code from this gem and modify it to suit my needs, highly recommended if you need to export your data from Administrate.
- [Off-Canvas Menu](https://web.archive.org/web/20210304195120/https://codepen.io/11bits/pen/jryEGW): I found this CodePen from Google Images when I was looking for a way to create an off-canvas menu. I modified it a little bit to suit my needs. But it seems the codepen is no longer available, so I put the archived version here. If any of you know the original author, please let me know so I can give the proper credit.