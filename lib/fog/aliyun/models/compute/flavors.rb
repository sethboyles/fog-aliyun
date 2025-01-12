module Fog
  module Aliyun
    class Compute
      class Flavors < Fog::Collection
        model Fog::Aliyun::Compute::Flavor
        def all
          data = Fog::JSON.decode(service.list_server_types.body)['InstanceTypes']['InstanceType']
          load(data)
        end
      end
    end
  end
end
