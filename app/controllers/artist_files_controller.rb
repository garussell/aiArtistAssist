class ArtistFilesController < ApplicationController
  before_action :set_artist

  def show
    @artist_file = @artist.artist_files.find(params[:id])
  end

  def create
    artist = Artist.find(params[:artist_id])
    style = artist.style
    prompt_response = AiFacade.new(artist_file_params[:goals], style).prompt_response

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

  # def edit; end

  def update
    @artist_file = @artist.artist_files.find(params[:id])

    if @artist_file.update(saved_image: artist_file_params[:saved_image])
      flash[:success] = "File updated successfully."
    else
      flash[:error] = "Something went wrong."
    end
      redirect_to artist_path(@artist)
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
    @artist = Artist.find(params[:artist_id])
  end

  def artist_file_params
    params.require(:artist_file).permit(:goals, :saved_image)
  end
end
