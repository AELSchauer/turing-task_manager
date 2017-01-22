require 'sqlite3'

class Task

  attr_reader :description,
              :title,
              :id

  def initialize(task_params)
    @database = Task.database
    @description = task_params["description"]
    @title       = task_params["title"]
    @id          = task_params["id"] if task_params["id"]
  end

  def save
    @database.execute("INSERT INTO tasks (title, description) VALUES (?, ?);", @title, @description)
  end

  def self.all
    database = Task.database
    tasks = database.execute("SELECT * FROM tasks")
    tasks.map do |task|
      Task.new(task)
    end
  end

  def self.find(id)
    database = Task.database
    task = database.execute("SELECT * FROM tasks WHERE id = ?", id).first
    Task.new(task)
  end

  def self.database
    database = SQLite3::Database.new('db/task_manager_development.db')
    database.results_as_hash = true
    database
  end
end