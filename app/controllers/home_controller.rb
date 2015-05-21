class HomeController < ApplicationController
  skip_before_filter :authenticate_admin

  def index
  end

end