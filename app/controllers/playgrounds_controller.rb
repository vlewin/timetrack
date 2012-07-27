class PlaygroundsController < ApplicationController
  def index
    @playground = Playground.find_or_create_by_name("test")

    respond_to do |format|
      format.html
    end
  end

  def show
    @playground = Playground.find(params[:id])

    respond_to do |format|
      format.html
      format.js { render :partial => "playground" }
    end
  end
end
