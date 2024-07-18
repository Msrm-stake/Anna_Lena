class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :about, :contributors ]

  def home
  end

  def about
  end
end
