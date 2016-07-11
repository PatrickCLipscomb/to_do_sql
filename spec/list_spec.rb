require("spec_helper")

describe(List) do
  describe(":all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('saves the list object to the database') do
      list = List.new({:name => 'Pats stuff', :id => nil})
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end
  describe("#name") do
    it("tells you its name") do
      list = List.new({:name => 'Epicodus stuff', :id => nil})
      expect(list.name()).to(eq("Epicodus stuff"))
    end
  end
  describe('#id') do
    it('sets its ID when you save it') do
      list = List.new({:name => 'Pats stuff', :id => nil})
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end
  describe('#==') do
    it('will return true if two lists have the same name') do
      list1 = List.new({:name => 'Pats stuff', :id => nil})
      list2 = List.new({:name => 'Pats stuff', :id => nil})
      expect(list1).to(eq(list2))
    end
  end
  describe('#delete') do
    it('will delete a list from the table of lists') do
      test1 = List.new({:name => 'sinatra magic', :id => nil})
      test1.save()
      List.delete(test1.id())
      expect(List.all()).to(eq([]))
    end
  end
end
