require 'yao'
require 'yao/designate/version'
require 'yao/designate/resources'

module Yao
  Resources.send(:include, Designate::Resources)
end
