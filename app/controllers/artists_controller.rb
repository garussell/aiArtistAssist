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
    if password_match?(artist) && artist.save 
      flash[:success] = "Your profile has been created"
      session[:artist_id] = artist.id
      redirect_to artist_path(artist)
    else
      flash[:warning] = "Invalid entry, please try again"
      redirect_to new_artist_path
    end
  end

  def edit
    if session[:artist_id].nil?
      flash[:warning] = "You must be logged in to edit your profile"
      redirect_to root_path
    else
      @artist = Artist.find_by(id: session[:artist_id])
    end
  end

  def update
    @artist = Artist.find_by(id: session[:artist_id])
    
    if @artist.update(artist_params)
      flash[:success] = "Your profile has been updated"
      redirect_to artist_path(@artist)
    else
      flash[:errors] = @artist.errors.full_messages
      redirect_to edit_artist_path(@artist)
    end
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

  def password_match?(artist)
    params[:artist][:password] == params[:artist][:password_confirmation]
  end
end
