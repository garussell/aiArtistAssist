# Artist Assist
[UI Video Walkthrough](https://www.loom.com/share/2a21a2152b024118bf7d3df30188410d)

## Overview

The Artist Prompts API is a Rails application that leverages OpenAI's GPT-3.5 Turbo model to generate prompts and suggestions for artists. It allows artists to receive personalized recommendations for their goals, action steps, and resources based on their input.

## Features

- **Generate Artist Prompts:** Utilize the OpenAI GPT-3.5 Turbo model to generate prompts for artists based on their specified goals.
- **Save Prompts to Database:** Save the generated prompts, along with associated information, to the database for future reference.
- **Handle Errors Gracefully:** Implement error handling to gracefully manage scenarios such as artist not found, invalid parameters, and other potential issues.

## Getting Started

### Prerequisites

- Ruby 3.2.2
- Rails 7.0.8
- [OpenAI API Key](https://platform.openai.com/account/api-keys): Obtain an API key from OpenAI to enable communication with the GPT-3.5 Turbo model, or GPT-4 model.

### Installation

1. **Clone the repository:**

`git@github.com:garussell/artist_assist.git`

2. **Install dependencies:**

`bundle install`

3. **Setup database:**

`rails db:create`
`rails db:migrate`

4. **Configure OpenAi API Key:**

`$ EDITOR="code --wait" rails credentials:edit`

`open_ai:`
  `api_key: your_openai_api_key`

- Save by closing the credentials.yml file

## Usage

1. Start the Rails server:

`rails server`

2. Make API requests to `/api/v1/:id/post_idea`
- Artist ID is part of the URL
- The prompt is passed into the body of the request (see endpoints)

## Endpoints

`POST /api/v1/post_idea`

- Generate a prompt from OpenAI based on the artist's specified goals:

### Request Body:

```
  {
    "goals": "I want to learn to play the drums"
  }
```

### Response

1. Status Code: 200 
- Body: 
```
  {
    "data": {
        "id": null,
        "type": "response",
        "attributes": {
            "id": null,
            "action_steps": "Stuf about drumming:,
            "resources": "Resources with links",
            "goals": "I want to learn to play the drums",
            "image_url": "https://oaidalleapiprodscus.blob.core.windows.net/private/org-DUWm0ko8w9epxLgtftuHr2ZP/user-C3kDGpQ319mqmHmO4pjG7bKq/img-7aiQAzBdz1lPJJN2adBKBMSg.png?st=2023-11-20T19%3A35%3A08Z&se=2023-11-20T21%3A35%3A08Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-11-20T20%3A28%3A47Z&ske=2023-11-21T20%3A28%3A47Z&sks=b&skv=2021-08-06&sig=Qk6szB/AlQ7eUIZnuO4Fdbh0YVl5%2BFluLWuUGJ87Crs%3D"
        }
    }
}
```

2. Status Code: 404 :not_found
- If the artist does not exist:
```
  {
    "error": "Artist not found"
  }
```

3. Status Code: 422 :unprocessable_enity
- If "goals" were left blank
```
  {
    "error": "You must provide your creative goals."
  }
```

## Future Iterations / In progress

1. CRUD functionality for Artist
2. Authentication for Artist
3. User Interface

##  Contributing

If you'd like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature`
3. Makes changes and commit: `git commit -m "Add your feature"`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a pull request

## Created by:

- Allen Russell
  - GitHub: @garussell
  - LinkedIn: @garyallenrusselljr
