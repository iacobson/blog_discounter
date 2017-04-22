defmodule Shop.Web.Router do
  use Shop.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Shop.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end

  scope "/api", Shop.Web do
    pipe_through :api
    get "/get_discounts/:version", ProductController, :get_discounts
    get "/new_product/:version", ProductController, :new_product
  end
end
