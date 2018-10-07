source 'http://rubygems.org'

ruby '2.5.1'

gem 'rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# for PostGreSQL databases
gem 'pg', '~> 0.18'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'

  # See http://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'  
end


##########################
## Our custom gems! :) ###
##########################

gem 'jquery-rails'
gem "select2-rails", "~> 3.2.1"

# Twitter Bootstrap gem + SASS (CSS extension)
gem 'bootstrap-sass', "~> 2.3.1.2"

# Extension of Twitter Bootstrap icons
gem 'font-awesome-sass-rails'

# Module for User's sessions and registrations
gem 'devise', "~> 2.2.4"

# Amazong S3 File Uploading
gem 'paperclip', "~> 3.4.2"
gem 'aws-sdk'
gem 's3_swf_upload'

# Google Analytics
gem 'google-analytics-rails'

# For pagination
gem 'will_paginate', '~> 3.0'
gem 'bootstrap-will_paginate'

# Adds UTF8 encoding to all files
gem "magic_encoding"

# Users activities recording and displaying
gem "public_activity"

# Beautiful tagclouds
gem "jqcloud-rails"

# Helpers for HTML meta tags
gem "headliner"
gem 'metamagic', "~> 2.0.5"

# Sitemap generator (for Google Webmaster Tools)
# gem 'sitemap_generator'

# Queries optimizer
# gem "bullet", :group => "development"

# E-mail encoder
gem 'actionview-encoded_mail_to', '~> 1.0.4'

gem 'bootstrap-wysihtml5-rails', "~> 0.3.1.20"


# Gems to be added only when running on Linux
platforms :ruby do
  gem 'execjs'
  # gem 'therubyracer'
end


##########################
##### default stuff ######
##########################

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'