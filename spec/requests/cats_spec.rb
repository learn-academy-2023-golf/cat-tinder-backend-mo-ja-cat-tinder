require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do 
    Cat.create(
        name: 'Luca',
        age: 1,
        enjoys: 'Running around and keeping his humans up at night.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      get '/cats'

      cat = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
  end
end

  describe "POST /create" do
    it "creates a cat" do
    cat_params = {
        cat:( {
        name: 'Luca',
        age: 1,
        enjoys: 'Running around and keeping his humans up at night.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        })
        }
        post '/cats', params: cat_params

        expect(response).to have_http_status(200)

        cat = Cat.first

        expect(cat.name).to eq 'Luca'
        expect(cat.age).to eq 1
        expect(cat.enjoys).to eq 'Running around and keeping his humans up at night.'
        expect(cat.image).to eq 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    end
  end

  describe "PATCH /update" do 
    it "updates a cat" do 
    cat_params = {
        cat: {
        name: 'Luca',
        age: 1,
        enjoys: 'Running around and keeping his humans up at night.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      post '/cats', params: cat_params 

      cat = Cat.first 

      updated_cat_params = {
        cat: {
        name: 'Luca',
        age: 1,
        enjoys: 'sitting at the window',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      patch "/cats/#{cat.id}", params: updated_cat_params

      expect(response).to have_http_status(200)

      updated_cat = Cat.find(cat.id)
      expect(updated_cat.enjoys).to eq 'sitting at the window'
    end
  end

  describe "DELETE /destroy" do
    it "deletes a cat" do
    cat_params = {
      cat: {
        name: 'Luca',
        age: 1,
        enjoys: 'Running around and keeping his humans up at night.',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      }
    }

     post '/cats', params: cat_params

     cat = Cat.first

      delete "/cats/#{cat.id}"

     expect(response).to have_http_status(200)
     cats = Cat.all
     expect(cats).to be_empty
    end
  end

  describe "cannot create a cat without valid attributes" do 
    it "doesn't create a cat without a name" do 
      cat_params = {
        cat: {
          age: 3,
          enjoys: 'Likes to go on candle lit dinners.',
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }

      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end

    it "doesn't create a cat without an age" do 
      cat_params = {
        cat: {
          name:'kat',
          enjoys: 'Likes to go on candle lit dinners.',
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
    end

    it "doesn't create a cat without an enjoys" do 
      cat_params = {
        cat: {
          name:'kat',
          age: 3,
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['enjoys']).to include "can't be blank"
    end

    it "doesn't create a cat without an image" do 
    cat_params = {
      cat: {
        name:'kat',
        age: 3,
        enjoys: 'Likes to go on candle lit dinners.'
      }
    }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['image']).to include "can't be blank"
    end
  end

  describe "cannot update a cat without valid attributes" do 
    it "doesn't update a cat without a name" do 
      cat_params = {
        cat: {
          age: 3,
          enjoys: 'Likes to go on candle lit dinners.',
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }

      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end

    it "doesn't update a cat without an age" do 
      cat_params = {
        cat: {
          name:'kat',
          enjoys: 'Likes to go on candle lit dinners.',
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['age']).to include "can't be blank"
    end

    it "doesn't update a cat without an enjoys" do 
      cat_params = {
        cat: {
          name:'kat',
          age: 3,
          image: 'https://images.unsplash.com/photo-1492370284958-c20b15c692d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1049&q=80'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['enjoys']).to include "can't be blank"
    end

    it "doesn't update a cat without an image" do 
    cat_params = {
      cat: {
        name:'kat',
        age: 3,
        enjoys: 'Likes to go on candle lit dinners.'
      }
    }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['image']).to include "can't be blank"
    end
  end
end