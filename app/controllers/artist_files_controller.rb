class ArtistFilesController < ApplicationController
  before_action :set_artist, :require_login

  def show
    @artist_file = @artist.artist_files.find(params[:id])
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def create
    artist = Artist.find(params[:artist_id])
   
    if params[:artist_file][:artist][:style].present?
      style = params[:artist_file][:artist][:style]
    end

    prompt_response = AiFacade.new(artist_file_params[:goals], style).prompt_response

    if prompt_response.present? && artist_file_params[:goals].present?
      artist_file = ArtistFile.create!(
          artist_id: artist.id,
          style: style,
          goals: artist_file_params[:goals],
          action_steps: prompt_response.action_steps,
          resources: prompt_response.resources,
          image_url: prompt_response.image_url
        )

      render json: ResponseSerializer.new(prompt_response)
    else
      render json: ErrorSerializer.format_errors("You must share your goal for this to work."), status: :unprocessable_entity
    end
  end

  def update
    @artist_file = @artist.artist_files.find(params[:id])

    if params[:fetch_new_image]
      new_image_url = AiFacade.new(@artist_file.goals, @artist_file.style).get_image

      @artist_file.saved_image.purge if @artist_file.saved_image.attached?
      @artist_file.update(image_url: new_image_url[:image_url])
      
      redirect_to artist_path(@artist)
      return
    end

    if @artist_file.update(saved_image: artist_file_params[:saved_image])
      flash[:success] = "File updated successfully."
      redirect_to artist_path(@artist)
    end
  end

  def destroy
    @artist_file = @artist.artist_files.find(params[:id])

    if @artist_file.destroy
      flash[:success] = "File deleted successfully."
    end

      redirect_to artist_path(@artist)
  end
  
  private

  def set_artist
    @artist = Artist.find(session[:artist_id]) if session[:artist_id].present?
    @artist_files = @artist.artist_files
  end

  def artist_file_params
    params.require(:artist_file).permit(:goals, :saved_image, :style, :other_style, artist: [:style])
  end

end
