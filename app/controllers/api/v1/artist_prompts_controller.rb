class Api::V1::ArtistPromptsController < ApplicationController
  def create
    begin
      artist = Artist.find(params[:id])
      style = artist.style
    
      prompt_response = AiFacade.new(artist_params[:goals], style).prompt_response

      if prompt_response.present? && artist_params[:goals].present?
        artist_file = ArtistFile.create!(
          artist_id: artist.id,
          goals: artist_params[:goals],
          action_steps: prompt_response.action_steps,
          resources: prompt_response.resources,
          image_url: prompt_response.image_url
        )

        render json: ResponseSerializer.new(prompt_response)
      else
        render json: ErrorSerializer.format_errors("You must share your goal for this to work."), status: :unprocessable_entity
      end

    rescue ActiveRecord::RecordNotFound
      render json: ErrorSerializer.format_errors("Artist not found"), status: :not_found
    end
  end

  private

  def artist_params
    params.permit(:id, :goals) 
  end
end
