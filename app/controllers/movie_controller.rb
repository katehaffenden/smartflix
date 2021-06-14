
class MovieController < ApplicationController
  def get
    result = Movie.find_by(title: params[:title])
    if result == nil
      CreateMovieWorker.new(title = params[:title]).perform
    else
      result
    end
  end

end
