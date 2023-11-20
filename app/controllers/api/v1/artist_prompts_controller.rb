class Api::V1::ArtistPromptsController < ApplicationController
  def create
    begin
      artist = Artist.find(params[:id])
      prompt_response = AiFacade.new(params[:goals]).prompt_response
    
      if prompt_response.present? && params[:goals].present?
        artist_file = ArtistFile.create!(
          artist_id: artist.id,
          goals: params[:goals],
          action_steps: prompt_response.action_steps,
          resources: prompt_response.resources,
          image_url: prompt_response.image_url
        )

        render json: ResponseSerializer.new(prompt_response)
      else
        render json: ErrorSerializer.format_errors("You must provide your creative goals."), status: :not_found
      end
      
    rescue ActiveRecord::RecordNotFound
      render json: ErrorSerializer.format_errors("Artist not found"), status: :not_found
    end
  end
end