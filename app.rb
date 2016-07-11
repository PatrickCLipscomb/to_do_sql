require('sinatra')
require('sinatra/reloader')
require('./lib/task')
require('./lib/list')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get('/list_page') do
  @lists = List.all()
  erb(:list)
end

get('/add_new_list_page') do
  erb(:new_list)
end

post('/new_list') do
  name = params.fetch('name')
  list = List.new({:name => name, :id => nil})
  list.save()
  @lists = List.all()
  erb(:list)
end

get('/lists/:id') do
  @list_id = params.fetch('id').to_i()
  @tasks = Task.all()
  @task_arry = []
  @tasks.each do |task|
    if task.list_id == @list_id
      @task_arry.push(task)
    end
  end
  @task_arry
  erb(:tasks)
end

get('/add_new_task_page') do
  @id = params.fetch('id').to_i()
  erb(:new_task_page)
end

post('/new_task') do
  description = params.fetch('description')
  @list_id = params.fetch('id').to_i()
  new_task = Task.new({:description => description, :list_id => @list_id, :id => nil})
  new_task.save()
  @tasks = Task.all()
  @task_arry = []
  @tasks.each do |task|
    if task.list_id == @list_id
      @task_arry.push(task)
    end
  end
  @task_arry
  erb(:tasks)
end

get('/tasks/:list_id/:id') do
  id = params.fetch('id').to_i()
  @list_id = params.fetch("list_id").to_i()
  Task.delete(id)
  @tasks = Task.all()
  @task_arry = []
  @tasks.each do |task|
    if task.list_id == @list_id
      @task_arry.push(task)
    end
  end
  @task_arry
  erb(:tasks)
end
