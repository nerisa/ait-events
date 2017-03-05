set :default_env, {
    'http_proxy' =>'http://192.41.170.23:3128',
		'ftp_proxy' =>'http://192.41.170.23:3128',
		'https_proxy' =>'http://192.41.170.23:3128',
    'BAZOOKA_USER' => ENV['BAZOOKA_USER']
}


server 'web13.cs.ait.ac.th',
	user: 'deploy',
	roles: %w{web app db},
	ssh_options: {
	     forward_agent: true,
	}

