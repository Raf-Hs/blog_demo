class CommentsController < ApplicationController
	before_action :set_post

  def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)

		if @comment.save
			redirect_to @post, notice: 'Comment created successfully.'
		else
			# Handle errors
			render 'posts/show' # Puedes personalizar la vista aquí
		end
	end


	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end


	private

	def comment_params
		params.require(:comment).permit(:name, :email, :content)
	end

	def set_post
    @post = Post.find(params[:post_id])
  end
end
