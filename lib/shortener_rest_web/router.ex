defmodule ShortenerRestWeb.Router do
  use ShortenerRestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShortenerRestWeb do
    pipe_through :api

    get "/create", URLController, :create
    get "/get", URLController, :get
  end
end
