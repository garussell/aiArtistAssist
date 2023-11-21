class ArtistsController < ApplicationController
  def index; end

  def show
    @artist = Artist.find_by(id: params[:id])

    if @artist.nil?
      flash[:warning] = "Artist not found"
      redirect_to root_path
    else
      @artist_files = ArtistFile.where(artist_id: params[:id])
    end
  end

  def new
    @artist = Artist.new
  end

  def create
    artist = Artist.new(artist_params)
    if artist.save
      session[:artist_id] = artist.id
      redirect_to artist_path(artist)
    else
      flash[:errors] = artist.errors.full_messages
      redirect_to new_artist_path
    end
  end

  def edit
    @artist = Artist.find_by(id: params[:id])
  end

  def update
    artist = Artist.find_by(id: params[:id])
    artist.update(artist_params)
    redirect_to artist_path(artist)
  end

  def destroy
    @artist = Artist.find_by(id: params[:id])
    
    @artist.destroy

    flash[:success] = "Your profile has been deleted"
    redirect_to root_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :email, :style, :bio, :password)
  end
end
