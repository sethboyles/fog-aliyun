# frozen_string_literal: true

class Aliyun < Fog::Bin
  class << self
    def class_for(key)
      case key
      when :storage
        Fog::Aliyun::Storage
      when :compute
        Fog::Aliyun::Compute
      else
        raise ArgumentError, "Unrecognized service: #{key}"
      end
    end

    def [](service)
      @@connections ||= Hash.new do |hash, key|
        hash[key] =
          case key
          when :storage
            Fog::Logger.warning('Aliyun[:storage] is not recommended, use Storage[:openstack] for portability')
            Fog::Storage.new(provider: 'aliyun')
          else
            raise ArgumentError, "Unrecognized service: #{key.inspect}"
          end
      end
      @@connections[service]
    end

    def services
      Fog::Aliyun.services
    end
  end
end
