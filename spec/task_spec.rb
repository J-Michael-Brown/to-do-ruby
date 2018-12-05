require('spec_helper')

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task2 = Task.new({:description => "learn SQL", :list_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe("#delete") do
    it("deletes task from database") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1})
      task1.save
      task2 = Task.new({:description => "learn MS Access", :list_id => 1})
      task2.save
      task1.delete
      expect(Task.all.include?(task1)).to(eq(false))
      expect(Task.all.include?(task2)).to(eq(true))
    end
  end

  describe('.find') do
    it "takes an id and returns the task object associated with that id" do
      task_found = Task.new({
        :description => "Find task",
        :list_id => 5})
      task_found.save
      expect(Task.find(task_found.id)).to(eq(task_found))
    end
  end

  describe('#update') do
    it "updates a selected task with a new description" do
      task1 = Task.new({:description => "version 1.0", :list_id => 1})
      task1.save
      task1.update({:description => "version 1.1"})
      expect(task1.description).to(eq("version 1.1"))
      expect(Task.find(task1.id)).to(eq(task1))
    end
  end
end
