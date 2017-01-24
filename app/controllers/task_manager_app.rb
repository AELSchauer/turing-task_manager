require_relative "../models/task.rb"

class TaskManagerApp < Sinatra::Base            # when creating a modular app, use Sinatra::Base
  set :root, File.expand_path("..", __dir__)    # the 'root' directory is the app folder
  set :method_override, true                    # this allows us to use the _method in the edit form

  get '/' do
    erb :dashboard                              # this says to find "dashboard.erb" in the views folder
  end

  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do                           # 'new' needs to go before ':id' because these methods are done sequentially
    erb :new                                    #     if 'new' is not first, it searches the database for a Task with the id of 'new'
  end

  get '/tasks/:id' do                           # a symbol in a route indicates a dynamic value
    @task = Task.find(params[:id])
    erb :show
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  put '/tasks/:id' do |id|
    Task.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id|
    Task.destroy(id.to_i)
    redirect '/tasks'
  end

end