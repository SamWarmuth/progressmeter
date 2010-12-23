class Main
  
  before do headers "Content-Type" => "text/html; charset=utf-8" end
  
  get "/" do
    haml :index
  end
  
  get "/css/style.css" do
    content_type 'text/css', :charset => 'utf-8'
    sass :style
  end

  
  post "/new-task" do
    return "You left one of the fields empty! There are only two, come on!" if params[:name].empty? || params[:finished_value].empty?
    
    task = Task.new
    task.name = params[:name]
    task.current_progress = params[:current_progress].to_i || 0
    task.finished_value = params[:finished_value].to_i || 100
    task.date = Time.now.to_i
    task.save
    redirect "/"
  end
  
  post "/update-progress" do
    task = Task.get(params[:task_id])
    return 404 if task.nil?
    task.current_progress = params[:current_progress].to_i
    task.finished_value = params[:finished_value].to_i
    return 401 if task.current_progress.nil?
    task.save
    return task.percent_progress.to_s
  end
  
  post "/delete-task/:task_id" do
    task = Task.get(params[:task_id])
    return 404 if task.nil?
    task.deleted = true
    task.save
    return 200
  end
  
  post "/complete-task/:task_id" do
    task = Task.get(params[:task_id])
    return 404 if task.nil?
    task.completed = true
    task.save
    return 200
  end
end
