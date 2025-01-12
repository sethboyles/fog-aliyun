# frozen_string_literal: true

require 'fog/core/model'
module Fog
  module Aliyun
    class Compute
      class EipAddress < Fog::Model
        identity :id, aliases: 'AllocationId'

        attribute :allocated_at, aliases: 'AllocationTime'
        attribute :bandwidth, aliases: 'Bandwidth'
        attribute :server_id, aliases: 'InstanceId'
        attribute :charge_type, aliases: 'InternetChargeType'
        attribute :ip_address, aliases: %w[IpAddress EipAddress]
        attribute :opertion_locks, aliases: 'OperationLocks'
        attribute :region_id, aliases: 'RegionId'
        attribute :state, aliases: 'Status'

        def destroy
          requires :id
          service.release_eip_address(id)
          true
        end

        def ready?
          requires :state
          state == 'Available'
        end

        def save(options = {})
          # raise Fog::Errors::Error.new('Resaving an existing object may create a duplicate') if persisted?
          # requires :availability_zone
          options[:bandwidth] = bandwidth if bandwidth
          options[:internet_charge_type] = charge_type if charge_type

          data = Fog::JSON.decode(service.allocate_eip_address(options).body)
          merge_attributes(data)
          true
        end

        def associate(new_server, options = {})
          if persisted?
            @server = nil
            self.server_id = new_server.id
            service.associate_eip_address(server_id, id, options)
          else
            @server = new_server
          end
        end

        def disassociate(new_server, options = {})
          @server = nil
          self.server_id = new_server.id
          service.unassociate_eip_address(server_id, id, options) if persisted?
        end
      end
    end
  end
end
