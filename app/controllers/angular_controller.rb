class AngularController < ApplicationController
  def index
      render 'angular/index'
  end

  def show
      render params[:id], layout: nil
  end
end
