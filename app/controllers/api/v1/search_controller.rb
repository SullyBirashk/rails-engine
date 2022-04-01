class Api::V1::SearchController < ApplicationController

  def index
    item = Item.where("name = ?", params[:name])
  end
end
