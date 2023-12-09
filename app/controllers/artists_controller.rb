class ArtistsController < ApplicationController
def index; end

def show
    @artist = Artist.find_by(id: params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @style_question = QuestionsModule.random_style_question
    @goal_question = QuestionsModule.random_goal_question

    if @artist.nil?
      flash[:warning] = "Artist not found"
      redirect_to root_path
    else
      @artist_files = @artist.artist_files
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
    elsif !password_match?(artist)
      flash[:warning] = "Passwords do not match"
      redirect_to new_artist_path
    else
      flash[:warning] = artist.errors.full_messages.join(", ")
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
    password_params = params[:artist][:current_password]

    if @artist.update(artist_params) && current_password_match?(@artist, password_params) && password_match?(@artist)
      flash[:success] = "Your profile has been updated"
      redirect_to artist_path(@artist)
    elsif !password_match?(@artist) || !current_password_match?(@artist, password_params)
      flash[:warning] = "Passwords do not match"
      redirect_to edit_artist_path(@artist)
    else
      flash[:warning] = @artist.errors.full_messages.join(", ")
      redirect_to edit_artist_path(@artist)
    end
  end  

  def upload_avatar
    @artist = Artist.find_by(id: session[:artist_id])
    @artist.avatar.attach(params[:artist][:avatar])
    if @artist.save
      flash[:success] = "Your avatar has been updated"
    else
      flash[:warning] = "Your avatar could not be updated"
    end

    redirect_to root_path
  end

  def destroy
    @artist = Artist.find_by(id: params[:id])
    
    @artist.destroy
    log_out_artist

    flash[:success] = "Your profile has been deleted"
    redirect_to root_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :email, :style, :bio, :password, :password_confirmation)
  end

  def password_match?(artist)
    if params[:artist][:password] == params[:artist][:password_confirmation]
      true
    else
      false
    end
  end  

  def current_password_match?(artist, password_params)
    artist&.authenticate(password_params)
  end
end
