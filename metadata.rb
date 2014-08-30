name              "passenger_nginx"
maintainer        "Martin Fenner"
maintainer_email  "mfenner@plos.org"
license           "Apache 2.0"
description       "Configure nginx with passenger"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.12"
depends           "apt", "~> 2.5.3"
depends           "build-essential", "2.0.0"
depends           "ruby", "~> 0.1.0"

%w{ ubuntu }.each do |platform|
  supports platform
end
