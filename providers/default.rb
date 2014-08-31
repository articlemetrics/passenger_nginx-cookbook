def whyrun_supported?
  true
end

use_inline_resources

def load_current_resource
  @current_resource = Chef::Resource::PassengerNginx.new(new_resource.name)
end

action :config do
  run_context.include_recipe "passenger_nginx"

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action   :nothing
  end

  # optionally delete default configuration file
  file "#{node['nginx']['dir']}/sites-enabled/default" do
    not_if { node['nginx']['default_site_enabled'] }
    action :delete
    notifies :reload, 'service[nginx]'
  end

  # create application root folder and set permissions
  %W{ #{new_resource.name} #{new_resource.name}/current #{new_resource.name}/current/public }.each do |dir|
    directory "/var/www/#{dir}" do
      owner new_resource.deploy_user
      group new_resource.group
      mode '0755'
      recursive true
    end
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
