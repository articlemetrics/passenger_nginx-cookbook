actions :config, :cleanup
default_action :config

attribute :name, :kind_of => String, :name_attribute => true
attribute :rails_env, :kind_of => String, :default => node['ruby']['rails-env']
attribute :user, :kind_of => String, :default => node['ruby']['user']
attribute :group, :kind_of => String, :default => node['ruby']['group']
attribute :default_server, :kind_of => [TrueClass, FalseClass], :default => true
