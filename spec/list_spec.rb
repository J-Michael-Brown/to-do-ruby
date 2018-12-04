require('spec_helper')
require('pry')

describe(List) do
  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Integer))
    end
  end

  describe("#save") do
    it("lets you save lists to the database") do
      list = List.new({:name => "Epicodus stuff", :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same list if it has the same name") do
      list1 = List.new({:name => "Epicodus stuff", :id => nil})
      list2 = List.new({:name => "Epicodus stuff", :id => nil})
      expect(list1).to(eq(list2))
    end
  end

  describe("#delete!") do
    it "deletes list from database" do
      list3 = List.new({:name => "deletion test", :id => nil})
      list3.save()
      expect(List.all()).to(eq([list3]))
      list3.delete!()
      expect(List.all()).to(eq([]))
    end
  end

  describe("#delete!") do
    it "deletes list from database and all tasks for that list" do
      list3 = List.new({:name => "deletion test", :id => nil})
      list3.save()
      task1 = Task.new(:description => 'A task', :list_id => list3.id)
      task1.save
      length = Task.all.length
      expect(Task.all.length).to(eq(length))
      list3.delete!()
      expect(Task.all.length).to(eq(length - 1))
    end
  end

end
