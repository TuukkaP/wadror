class PlacesController < ApplicationController


  def index
  end

  def search
    return redirect_to places_path, notice:"City was empty" if params[:city].empty?
    @places = BeermappingApi.places_in(params[:city])
    session[:city] = "#{params[:city]}" unless @places.empty?
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    unless session[:city].empty?
      @places = BeermappingApi.places_in(session[:city])
      @places.each { |p| @place = p if p.id==params[:id] }
      @place
    else
      redirect_to places_path, notice: "No city was specified"
    end
  end

end