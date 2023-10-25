class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
    @posts = Post.paginate(page: params[:page], per_page: 5)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post.update(views: @post.views + 1)
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def rate
    @post = Post.find(params[:id])
    rating_value = params[:post][:rating].to_i

    # Obtén el rating actual del post
    current_rating = @post.rating || 0

    # Verifica si el usuario ya ha calificado el post en esta sesión
    if session[:post_modified_post_ids]&.include?(@post.id)
      redirect_to @post, alert: 'No puedes calificar este artículo más de 1 vez.'
    else
      # Calcula el nuevo rating promediando el rating actual y el nuevo rating
      new_rating = (current_rating + rating_value) / 2.0

      # Actualiza el rating del post con el nuevo valor
      @post.update(rating: new_rating)

      # Agrega el ID del post a la lista de posts calificados en esta sesión
      session[:post_modified_post_ids] ||= []
      session[:post_modified_post_ids] << @post.id

      redirect_to @post, notice: 'Post rated successfully.'
    end
  end



  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :image, :rating)
    end
end
