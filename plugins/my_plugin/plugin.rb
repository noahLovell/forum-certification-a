# plugin.rb
# frozen_string_literal: true
# name: my-plugin
# version: 0.1
# authors: you

after_initialize do
    module ::MyPlugin
      class Engine < ::Rails::Engine
        engine_name "my_plugin"
        isolate_namespace MyPlugin
      end
    end
  
    MyPlugin::Engine.routes.draw do
      post "/submit" => "actions#submit"
    end
  
    Discourse::Application.routes.append do
      mount ::MyPlugin::Engine, at: "/my_plugin"
    end
  
    class ::MyPlugin::ActionsController < ::ApplicationController
      requires_plugin "my-plugin"
  
      before_action :ensure_logged_in # restrict to logged-in users
  
      def submit
        email = params[:email].to_s
        id = params[:id].to_s
  
        # Validate or sanitize as appropriate here
  
        # Your actual external API call
        response = Excon.post("https://your.external/api/endpoint",
          body: {email: email, id: id}.to_json,
          headers: {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{SiteSetting.my_plugin_api_secret}"
          }
        )
  
        if response.status == 200
          render json: success_json
        else
          render_json_error("API error", status: 400)
        end
      end
    end
  end