# frozen_string_literal: true

module Fog
  module Aliyun
    class Compute
      class Real
        def delete_vpn_customergateway(vpn_customergatewayid)
          # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vswitch&deletevswitch]
          action = 'DeleteCustomerGateway'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutVPCParameters(action, sigNonce, time)
          pathUrl = defaultAliyunVPCUri(action, sigNonce, time)

          if vpn_customergatewayid
            parameters['CustomerGatewayId'] = vpn_customergatewayid
            pathUrl += '&CustomerGatewayId='
            pathUrl += vpn_customergatewayid
          else
            raise ArgumentError, 'Missing required vpn_customergatewayid'
          end

          signature = sign(@aliyun_accesskey_secret, parameters)
          pathUrl += '&Signature='
          pathUrl += signature

          VPCrequest(
            expects: [200, 203],
            method: 'GET',
            path: pathUrl
          )
        end
      end
    end
  end
end
