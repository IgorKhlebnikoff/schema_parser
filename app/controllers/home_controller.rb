class HomeController < ApplicationController
  def index
    @parsings = Parsing.all.first(10)
  end
end
