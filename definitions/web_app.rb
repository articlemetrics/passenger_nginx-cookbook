define :web_app, :template => 'web_app.conf.erb', :local => false, :enable => true do

  application_name = params[:name]

  include_recipe 'passenger_nginx'

  template "#{node['nginx']['dir']}/conf.d/#{application_name}.conf" do
    source params[:template]
    local params[:local]
    owner 'root'
    group 'root'
    mode '0644'
    cookbook params[:cookbook] if params[:cookbook]
    variables(
      :application_name => application_name,
      :params           => params
    )
  end
end
