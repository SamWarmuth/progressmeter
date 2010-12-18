class Main
  get "/" do
    haml :index
  end
  
  get "/css/style.css" do
    content_type 'text/css', :charset => 'utf-8'
    sass :style
  end
  
  get "/task/:task_id" do
    @task = Task.get(params[:task_id])
    return "Not found." if @task.nil?
    
    haml :task
  end
  
  
  get "/new-task" do
    haml :new_task
  end
  
  post "/new-task" do
    return "You left one of the fields empty! There are only two, come on!" if params[:name].empty? || params[:finished_value].empty?
    
    task = Task.new
    task.name = params[:name]
    task.current_progress = 0
    task.finished_value = params[:finished_value].to_i
    task.date = Time.now.to_i
    task.save
    redirect "/task/#{task.id}"
  end
  
  post "/update-progress/:task_id" do
    task = Task.get(params[:task_id])
    return "Not Found." if task.nil?
    task.current_progress = params[:progress].to_i
    task.save
    redirect "/task/#{task.id}"
  end
end
