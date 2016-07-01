class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  #index action
  get '/recipes' do
    @allrecipes= Recipe.all

    erb :index
  end

  #new action
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do 
    @recipe =Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end
 
  #show action
  get '/recipes/:id' do 
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  #Update Action 
  patch '/recipes/:id' do  #updates a recipe
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end


  #delete action
  delete '/recipes/:id/delete' do 
    @recipe = Recipe.find_by_id(params[:id])
    @deleteditem= @recipe
    @recipe.delete
    redirect to '/recipes'
  end


end