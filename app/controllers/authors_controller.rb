class AuthorsController < ApplicationController
  def index
  end

  def show
    #require 'pry';binding.pry
    @author = Author.find(params[:id])
  end
end
