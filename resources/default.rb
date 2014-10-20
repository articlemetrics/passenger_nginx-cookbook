actions :config, :cleanup
default_action :config

attribute :name, :kind_of => String, :name_attribute => true
attribute :rails_env, :kind_of => String, :default => ENV['RAILS_ENV']
attribute :user, :kind_of => String, :default => ENV['USER']
attribute :group, :kind_of => String, :default => ENV['GROUP']
attribute :default_server, :kind_of => [TrueClass, FalseClass], :default => true
