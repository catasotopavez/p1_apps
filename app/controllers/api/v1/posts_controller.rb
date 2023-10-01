class API::V1::PostsController < APIController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_with_api_key!


  def new
    @post = Post.new
  end

  def create
    @post = Post.new()
    author = User.find_by(email: params[:author])
    @post.author = author
    trip = Trip.find(params[:trip_id])
    @post.trip = trip
    @post.title = params[:title]
    @post.body = params[:description]
    @post.public = params[:public]
    @post.files.attach(params[:files])

    dest_list = []

    params[:destinations].each do |key, destination|
      @dest = Destination.new()
      @dest.name = destination[:name]
      @dest.latitude = destination[:latitude]
      @dest.longitude = destination[:longitude]
      @dest.country = destination[:country]
      @dest.city = destination[:city]
      @dest.save
      dest_list.push(@dest)
    end

    if @post.save

      dest_list.each do |dest|
        @post.destinations << dest
        dest.post_ids << @post.id
      end



      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  def index
    @posts = Post.where(trip_id: params[:trip_id])
    render json: @posts
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end

  def update
    if @post.update(post_params)
      render :show, status: :ok, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end

  end


  private

  def set_post
    @post = Post.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  # #TODO: More params like users, destinations, photos, etc.
  def post_params
    params.fetch(:post, {}).permit(:id, :trip_id, :title, :description, :author, :public, :files, destinations: [ destination: [:id, :name, :latitude, :longitude, :country, :city]])
  end

  def update_params

    params.fetch(:post, {}).permit(:id, :trip_id, :title, :description, :author, :public, :files, destinations: [ destination: [:id, :name, :latitude, :longitude, :country, :city]])
  end


end
