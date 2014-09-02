actions :config, :cleanup
default_action :config

attribute :name, :kind_of => String, :name_attribute => true
attribute :rails_env, :kind_of => String, :default => node['ruby']['rails-env'] || "production"
attribute :user, :kind_of => String, :default => node['ruby']['user'] || "www-data"
attribute :group, :kind_of => String, :default => node['ruby']['group'] || "www-data"
attribute :default_server, :kind_of => [TrueClass, FalseClass], :default => true
