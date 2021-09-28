# frozen_string_literal: true

module API
  module V1
    class GeneratorsController < ApplicationController
      def index
        @generators = RandomTables::REGISTRY

        @data = @generators.map do |generator|
          name = generator.name.gsub(/\ARandomTables::/, '')
          slug = name.tableize
          { id: slug, name: name, description: 'TODO' }
        end

        render json: @data
      end

      def show
        slug = params[:slug]
        name = slug.classify
        @generator = RandomTables.klass(name)

        if @generator
          @data = {
            id: slug,
            name: name,
            sample_data: if @generator.respond_to?(:first)
              @generator.first.attributes
            else
              @generator.random
            end
          }
          render json: @data
        else
          render json: 'Not Found', status: 404
        end
      end
    end
  end
end
