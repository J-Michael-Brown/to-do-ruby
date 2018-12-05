class Task
  attr_reader(:description, :list_id, :id)
  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    if attributes.include?(:id)
      @id = attributes.fetch(:id)
    else
      @id = nil
    end
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      id = task.fetch("id").to_i
      tasks.push(Task.new({
        :description => description,
        :list_id => list_id,
        :id => id
        }))
    end
    tasks
  end

  def self.for_list_id(list_id)
    display_tasks = []
    self.all.each do |task|
      if task.list_id == list_id
        display_tasks.push(task)
      end
    end
    display_tasks
  end

  def save
    result = DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM tasks WHERE id = #{id};")
    output_task = Task.new({
      :description => result.first.fetch("description"),
      :list_id => result.first.fetch("list_id").to_i,
      :id => result.first.fetch("id").to_i
      })
  end

  def ==(another_task)
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id())).&(self.id().==(another_task.id()))
  end

  def delete()
    DB.exec("DELETE FROM tasks Where list_id = #{self.list_id} AND description = '#{self.description}'")
    new_list = Task.all
    new_list.include?(self)
  end

  def update(attributes)
    description = attributes.fetch(:description)
    DB.exec("UPDATE tasks SET description = '#{description}' WHERE id = #{@id};")
    @description = description
  end
end
