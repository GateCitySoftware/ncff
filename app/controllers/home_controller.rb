class HomeController < ApplicationController
  def index
    @data = OpenStruct.new
    @data.artists = Artist.all
  end
end
