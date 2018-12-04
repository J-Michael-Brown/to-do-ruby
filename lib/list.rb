class List
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_lists = DB.exec("SELECT * FROM lists;")
    lists = []
    returned_lists.each() do |list|
      name = list.fetch("name")
      id = list.fetch("id").to_i()
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_list)
    self.name().==(another_list.name()).&(self.id().==(another_list.id()))
  end

  def delete!()
    DB.exec("DELETE FROM lists Where id = #{self.id}")
    DB.exec("DELETE FROM tasks Where list_id = #{self.id}")
    new_list = List.all
    if new_list.include?(self)
      return 'deleted'
    else
      return 'didn\'t work'
    end
  end

end
