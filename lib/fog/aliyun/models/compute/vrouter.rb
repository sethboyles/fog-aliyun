# frozen_string_literal: true

require 'fog/core/model'
module Fog
  module Aliyun
    class Compute
      class VRouter < Fog::Model
        identity :id, aliases: 'VRouterId'

        attribute :name, aliases: 'VRouterName'
        attribute :route_table_ids, aliases: 'RouteTableIds'
        attribute :created_at, aliases: 'CreationTime'
        attribute :description, aliases: 'Description'
        attribute :region_id, aliases: 'RegionId'
        attribute :vpc_id, aliases: 'VpcId'

        def vpc
          requires :vpc_id
          $vpc = Fog::Aliyun::Compute::Vpcs.new(service: service).all('vpcId' => vpc_id)[0]
        end

        def route_tables
          @route_tables ||= begin
            Fog::Aliyun::Compute::RouteTables.new(
              v_router: self,
              service: service
            )
          end
        end
      end
    end
  end
end

# "VRouters"=>{"VRouter"=>[{"VRouterName"=>"", "RouteTableIds"=>{"RouteTableId"=>["vtb-2504onoxh"]},
# "CreationTime"=>"2015-08-03T11:23:35Z", "Description"=>"", "RegionId"=>"cn-beijing",
# "VRouterId"=>"vrt-25azmd2wm", "VpcId"=>"vpc-25mj6mguq"}]}
