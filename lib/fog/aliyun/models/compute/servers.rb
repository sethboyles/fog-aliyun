# frozen_string_literal: true

require 'fog/core/collection'
require 'fog/aliyun/models/compute/server'

module Fog
  module Aliyun
    class Compute
      class Servers < Fog::Collection
        model Fog::Aliyun::Compute::Server

        def all(options = {})
          data = Fog::JSON.decode(service.list_servers(options).body)['Instances']['Instance']
          load(data)
        end

        # Creates a new server and populates ssh keys
        # @return [Fog::Compute::OpenStack::Server]
        # @raise [Fog::Compute::OpenStack::NotFound] - HTTP 404
        # @raise [Fog::Compute::OpenStack::BadRequest] - HTTP 400
        # @raise [Fog::Compute::OpenStack::InternalServerError] - HTTP 500
        # @raise [Fog::Compute::OpenStack::ServiceError]
        # @example
        #   service.servers.bootstrap :name => 'bootstrap-server',
        #                             :flavor_ref => service.flavors.first.id,
        #                             :image_ref => service.images.find {|img| img.name =~ /Ubuntu/}.id,
        #                             :public_key_path => '~/.ssh/fog_rsa.pub',
        #                             :private_key_path => '~/.ssh/fog_rsa'
        #
        #        def bootstrap(new_attributes = {})
        #          server = create(new_attributes)
        #          server.wait_for { ready? }
        #          server.setup(:password => server.password)
        #          server
        #        end

        def get(server_id)
          self.class.new(service: service).all(instanceId: server_id)[0] if server_id
        end
      end
    end
  end
end
