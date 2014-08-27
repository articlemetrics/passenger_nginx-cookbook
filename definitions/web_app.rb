define :web_app, :template => 'web_app.conf.erb', :local => false, :enable => true do

  application_name = params[:name]
  conf_dir = "#{node['nginx']['dir']}/conf.d"

  # create nginx directory if it doesn't exist, e.g. because nginx hasn't been installed yet
  directory conf_dir do
    owner 'root'
    group 'root'
    mode '0644'
    recursive true
  end

  template "#{conf_dir}/#{application_name}.conf" do
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
