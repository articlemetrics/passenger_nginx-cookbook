use_inline_resources

include Chef::DSL::IncludeRecipe

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::PassengerNginx.new(new_resource.name)
end

action :config do
  include_recipe "passenger_nginx"

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :nothing
  end

  # optionally delete default configuration file
  file "#{node['nginx']['dir']}/sites-enabled/default" do
    only_if { node['nginx']['default_site_enabled'] }
    action :delete
    notifies :reload, 'service[nginx]'
  end

  # create root folder and set permissions
  directory "/var/www/#{new_resource.name}" do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
    recursive true
  end

  directory "/var/www/#{new_resource.name}/current/public" do
    owner new_resource.owner
    group new_resource.group
    mode '0755'
    recursive true
  end

  template "#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}.conf" do
    source "app.conf.erb"
    owner 'root'
    group 'root'
    mode '0644'
    cookbook 'passenger_nginx'
    variables(
      :application    => new_resource.name,
      :rails_env      => new_resource.rails_env,
      :default_server => new_resource.default_server
    )
    notifies :reload, 'service[nginx]'
  end
end

action :cleanup do
  file "#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}.conf" do
    action :delete
    notifies :reload, 'service[nginx]'
  end
end
