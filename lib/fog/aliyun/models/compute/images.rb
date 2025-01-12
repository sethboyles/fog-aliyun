# frozen_string_literal: true

require 'fog/core/collection'
require 'fog/aliyun/models/compute/image'

module Fog
  module Aliyun
    class Compute
      class Images < Fog::Collection
        model Fog::Aliyun::Compute::Image

        def all(filters_arg = {})
          unless filters_arg.is_a?(Hash)
            Fog::Logger.deprecation("all with #{filters_arg.class} param is deprecated, use all('diskIds' => []) instead [light_black](#{caller.first})[/]")
            filters_arg = { imageId: filters_arg }
          end
          data = Fog::JSON.decode(service.list_images(filters_arg).body)['Images']['Image']
          load(data)
        end

        def get(image_id)
          self.class.new(service: service).all(imageId: image_id)[0] if image_id
        end
      end
    end
  end
end
