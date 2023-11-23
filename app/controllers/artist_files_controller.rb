class ArtistFilesController < ApplicationController
  before_action :set_artist

  def index
    @artist_files = @artist.artist_files
  end

  def new
    @artist_file = @artist.artist_files.build
  end

  def create
    artist = Artist.find(params[:artist_id])
    prompt_response = AiFacade.new(artist_file_params[:goals]).prompt_response

    if prompt_response.present? && artist_file_params[:goals].present?
      artist_file = ArtistFile.create!(
          artist_id: artist.id,
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

  def show
    @artist_files = @artist.artist_files.all
  end

  def destroy
    @artist_file = @artist.artist_files.find(params[:id])

    if @artist_file.destroy
      flash[:success] = "File deleted successfully."
    else
      flash[:warning] = @artist_file.errors.full_messages.join(", ")
    end

      redirect_to artist_path(@artist)
  end

  private

  def set_artist
    @artist = Artist.find(params[:artist_id])
  end

  def artist_file_params
    params.require(:artist_file).permit(:goals)
  end
end
