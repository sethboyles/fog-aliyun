# frozen_string_literal: true

module Fog
  module Aliyun
    class Compute
      class Real
        # {Aliyun API Reference}[https://docs.aliyun.com/?spm=5176.100054.3.1.DGkmH7#/pub/ecs/open-api/vpc&describevpcs]
        def list_vpn_connections(options = {})
          action = 'DescribeVpnConnections'
          sigNonce = randonStr
          time = Time.new.utc

          parameters = defalutVPCParameters(action, sigNonce, time)
          pathUrl = defaultAliyunVPCUri(action, sigNonce, time)

          _VpnGatewayId = options[:vpngatewayId]
          if _VpnGatewayId
            parameters['VpnGatewayId'] = _VpnGatewayId
            pathUrl += '&VpnGatewayId='
            pathUrl += _VpnGatewayId
          end

          pageNumber = options[:pageNumber]
          pageSize = options[:pageSize]
          if pageNumber
            parameters['PageNumber'] = pageNumber
            pathUrl += '&PageNumber='
            pathUrl += pageNumber
          end

          pageSize ||= '50'
          parameters['PageSize'] = pageSize
          pathUrl += '&PageSize='
          pathUrl += pageSize

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
