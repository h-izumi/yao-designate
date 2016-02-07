$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/its'

require 'yao/designate'

Yao.configure do
  auth_url    'https://identity.tyo1.conoha.io/v2.0'
  tenant_name ENV['OS_TENANT_NAME']
  username    ENV['OS_USERNAME']
  password    ENV['OS_PASSWORD']
end
