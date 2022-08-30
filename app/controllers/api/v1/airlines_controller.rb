module Api 
  module V1
    class AirlinesController < ApplicationController
      protect_from_forgery with: :null_session

      def index 
        #get all airlines from DB and render data using airline serializer
        airlines = Airline.all 

        render json: AirlineSerializer.new(airlines, options).serializable_hash.to_json
      end 

      def show 
        airline = Airline.find_by(slug: params[:slug])

        render json: AirlineSerializer.new(airline, options).serializable_hash.to_json
      end 

      def create 
        airline = Airline.new(airline_params)
        if airline.save 
          render json: AirlineSerializer.new(airline).serializable_hash.to_json
        else 
          render json: { error: airline.errors.messages }, status: 422 
        end 
      end

      def update 
        airline = Airline.find_by(slug: params[:slug])

        if airline.update(airline_params) 
          render json: AirlineSerializer.new(airline, options).serializable_hash.to_json
        else 
          render json: { error: airline.errors.messages }, status: 422 
        end 
      end

      def destroy
        airline = Airline.find_by(slug: params[:slug])

        if airline.destroy
          head :no_content
        else 
          render json: { error: airline.errors.messages }, status: 422 
        end 
      end 
      
      private 

      #setting strong parameters
      #set up a whitelist of parameters that we want to allow
      def airline_params 
        params.require(:airline).permit(:name, :image_url)
      end 

      #setting this up so when we render data using serializer, this makes sure we can include any related reviews in payload 
      #structuring response as a compound document 
      #optional options hash that specifies additional resources
      def options 
        @options ||= { include: %i[reviews]} #array of resouces
      end 
    end 
  end 
end 