class CommentsController < ApplicationController
	before_action :set_post

  def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(comment_params)

		if @comment.save
			redirect_to @post, notice: 'Comment created successfully.'
		else
			# Renderiza la vista de la página de inicio o la vista que desees.
			render 'pages/home' # Asegúrate de ajustar el nombre de la vista según tu estructura de carpetas y rutas.
		end

	end


	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	def update
		@comment = @post.comments.find(params[:id])

		respond_to do |format|
			if @comment.update(comment_params)
				format.html { redirect_to post_url(@post), notice: 'Comment has been updated' }
			else
				format.html { redirect_to post_url(@post), notice: 'Comment was not updated' }
			end
		end
	end


	private

	def comment_params
		params.require(:comment).permit(:name, :email, :content)
	end

	def set_post
    @post = Post.find(params[:post_id])
  end
end
