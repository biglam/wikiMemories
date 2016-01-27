require 'rails_helper'

RSpec.describe MemoriesController, type: :controller do
    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates the memory' do
          post :create, memory: attributes_for(:memory)
          expect(Memory.count).to eq(1)
        end

        it 'redirects to the "show" action for the new memory' do
          post :create, memory: attributes_for(:memory)
          expect(response).to redirect_to Memory.first
        end
      end

      context 'with invalid attributes' do
        it 'does not create the memory' do
          post :create, memory: attributes_for(:memory, title: nil)
          expect(Memory.count).to eq(0)
        end

        it 're-renders the "new" view' do
          post :create, memory: attributes_for(:memory, year: nil)
          expect(response).to render_template :new
        end
        
      end
    end
  end