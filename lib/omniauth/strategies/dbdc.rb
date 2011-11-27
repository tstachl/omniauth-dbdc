require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Dbdc < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE   = "id api refresh_token"
      DEFAULT_DISPLAY = "page"
      
      option :name, "dbdc"
      
      option :client_options, {
        :site          => "https://login.database.com", 
        :authorize_url => "/services/oauth2/authorize", 
        :token_url     => "/services/oauth2/token"
      }
      
      option :access_token_options, {
        :grant_type    => "authorization_code"
      }
      
      option :authorize_options, {
        :response_type => "code"
      }
      
      uid { raw_info["id"] }
      
      info do
        prune!({
          'user_id'    => raw_info["user_id"],
          'org_id'     => raw_info["organization_id"],
          'username'   => raw_info["username"],
          'name'       => raw_info["display_name"],
          'email'      => raw_info["email"],
          'user_type'  => raw_info["user_type"],
          'language'   => raw_info["language"],
          'locale'     => raw_info["locale"],
          'utc_offset' => raw_info["utcOffset"]
        })
      end
      
      credentials do
        prune!({
          'expires'       => access_token.expires?,
          'expires_at'    => access_token.expires_at,
          'instance_url'  => raw_info["instance_url"],
          'refresh_token' => raw_info["refresh_token"]
        })
      end
      
      extra do
        prune!({
          'raw_info' => raw_info
        })
      end
      
      def authorize_params
        super.tap do |params|
          params[:display] ||= DEFAULT_DISPLAY
          params[:scope] ||= DEFAULT_SCOPE
        end
      end
      
      def raw_info
        access_token.options = {
          :mode => :header,
          :header_format => "OAuth %s",
          :param_name => "access_token"
        }
        @raw_info ||= access_token.params.merge(access_token.get(access_token.params["id"]).parsed)
      end
      
      private
      
      def prune!(hash)
        hash.delete_if do |_, value| 
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
   end
 end
end