require 'yao/designate/timestamp'

module Yao
  module Designate
    class BaseResource < Yao::Resources::Base

      # The JSON formatting in Designate REST API is slightly different from other OS components
      class << self
        def get(id_or_permalink, query={})
          res = if id_or_permalink =~ /^https?:\/\//
                  GET(id_or_permalink, query)
                else
                  GET(create_url([api_version, resources_path, id_or_permalink]), query)
                end
          return_resource(res.body)
        end
        alias find get

        def create(resource_params)
          params = resource_params
          res = POST(create_url([api_version, resources_path])) do |req|
            req.body = params.to_json
            req.headers['Content-Type'] = 'application/json'
          end
          return_resource(res.body)
        end

        def update(id, resource_params)
          params = resource_params
          res = PUT(create_url([api_version, resources_path, id])) do |req|
            req.body = params.to_json
            req.headers['Content-Type'] = 'application/json'
          end
          return_resource(res.body)
        end
      end

      include Yao::Designate::Timestamp
    end
  end
end
