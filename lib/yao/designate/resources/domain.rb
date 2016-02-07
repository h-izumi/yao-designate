require 'yao/designate/base_resource'

module Yao
  module Designate
    module Resources
      class Domain < Yao::Designate::BaseResource
        self.service = 'dns'
        self.api_version = 'v1'
        self.resource_name = 'domain'
        self.resources_name = 'domains'

        friendly_attributes :name, :ttl, :serial, :email, :description

        def servers
          parent = self
          @servers ||= Class.new(Yao::Designate::BaseResource) do |kls|
            kls.service = 'dns'
            kls.api_version = 'v1'
            kls.resource_name = 'server'
            kls.resources_name = 'servers'
            kls.resources_path = [parent.class.resources_path, parent.id, kls.resources_name].join(?/)

            friendly_attributes :name
          end
        end

        def records
          parent = self
          @records ||= Class.new(Yao::Designate::BaseResource) do |kls|
            kls.service = 'dns'
            kls.api_version = 'v1'
            kls.resource_name = 'record'
            kls.resources_name = 'records'
            kls.resources_path = [parent.class.resources_path, parent.id, kls.resources_name].join(?/)

            friendly_attributes :name, :type, :priority, :ttl, :data, :description, :domain_id
          end
        end
      end
    end
  end
end
