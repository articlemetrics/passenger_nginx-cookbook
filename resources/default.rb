actions :config, :cleanup
default_action :config

attribute :name, :kind_of => String, :name_attribute => true
attribute :rails_env, :kind_of => String, :default => "production"
attribute :owner, :kind_of => String, :default => "production"
attribute :group, :kind_of => String, :default => "www-data"
attribute :default_server, :kind_of => [TrueClass, FalseClass], :default => true
