# frozen_string_literal: true
class API::V1::CollectionsController < ApplicationController
  def index
    @collections = Collection.all

    render json: @collections
  end

  def show
    @collection = Collection.find(params[:id])

    data = {}
    data[:id] = @collection.id
    data[:name] = @collection.name
    data[:default_label] = @collection.default_label
    data[:templates] = @collection.templates.map do |t|
      {
        label: t.label,
        generator: { id: t.generator.tableize, name: t.generator },
      }
    end
    render json: data
  end

  def generate
    @collection = Collection.find(params[:id])

    data = {}
    data[:title] = @collection.default_label
    data[:data] = @collection.execute

    render json: data
  end

  def create
  end

  def update
  end

  def destroy
  end
end
