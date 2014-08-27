define :web_app, :template => 'web_app.conf.erb', :local => false, :enable => true do

  application_name = params[:name]

  # create nginx directory if it doesn't exist, e.g. because nginx hasn't been installed yet
  directory node['nginx']['dir'] do
    owner 'root'
    group 'root'
    mode '0644'
    recursive true
  end

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
