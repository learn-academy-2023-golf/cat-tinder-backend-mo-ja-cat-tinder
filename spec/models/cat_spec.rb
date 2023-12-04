require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name" do
    cat = Cat.create(age: 2, enjoys: 'Get under blankets and make everyone else uncomfortable.', image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80')
    expect(cat.errors[:name]).to_not be_empty
  end

  it "should have an age" do
    cat = Cat.create(name: 'lila', enjoys: 'Get under blankets and make everyone else uncomfortable.', image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80')
    expect(cat.errors[:age]).to_not be_empty
  end

  it "should enjoy stuff" do
    cat = Cat.create(name: 'lila', age: 2, image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80')
    expect(cat.errors[:enjoys]).to_not be_empty
  end

  it "should have an image" do
    cat = Cat.create(name: 'lila', age: 2, enjoys:'Get under blankets and make everyone else uncomfortable.')
    expect(cat.errors[:image]).to_not be_empty
  end
end