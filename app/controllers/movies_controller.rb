class MoviesController < ApplicationController
  def index
    if params[:query].present?

      ## METHOD 1: ACTIVE RECORD SEARCH
      ## WHERE: result is exactly what I search
      # @movies = Movie.where(title: params[:query])

      ##  WHERE ILIKE: lowercase is accepted
      # @movies = Movie.where("title ILIKE ?", params[:query])

      ## WHERE ILIKE: larger -> word is contained in the string
      # @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%")

      ## WHERE ILIKE: larger -> search in title but also synopsis (OR)
      # @movies = Movie.where("title ILIKE :query OR synopsis ILIKE :query", query: "%#{params[:query]}%")

      ## Return all the movie from a director name search (i.e. Nolan)
      # sql_subquery = <<~SQL
      # movies.title ILIKE :query
      #   OR movies.synopsis ILIKE :query
      #   OR directors.first_name ILIKE :query
      #   OR directors.last_name ILIKE :query
      # SQL
      # @movies = Movie.joins(:director).where(sql_subquery, query: "%#{params[:query]}%")

      ## @@ (replace ILIKE) we can now look at two key words (batman and superman)
      # sql_subquery = <<~SQL
      # movies.title @@ :query
      #   OR movies.synopsis @@ :query
      #   OR directors.first_name @@ :query
      #   OR directors.last_name @@ :query
      # SQL
      # @movies = Movie.joins(:director).where(sql_subquery, query: "%#{params[:query]}%")

      ## METHOD 2: PG SEARCH
      @movies = Movie.search_by_title_and_synopsis(params[:query])
    else
      @movies = Movie.all
    end
  end
end
