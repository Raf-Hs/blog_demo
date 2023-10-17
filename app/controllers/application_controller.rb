class ApplicationController < ActionController::Base
    before_action :set_query

    def set_query
      @query = Post.ransack(params[:q])
      @posts = @query.result(distinct: true)
    end
  end
