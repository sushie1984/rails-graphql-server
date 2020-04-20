# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateDepartment do
  let(:mutation) { described_class.new(object: {}, context: {}, field: {}) }

  describe '#resolve' do
    subject(:resolve) { mutation.resolve(attributes: attributes) }
    let(:attributes) { FactoryBot.attributes_for(:department) }

    it 'creates a department' do
      expect { resolve }
        .to change { Department.where(attributes).count }.from(0).to(1)
    end

    it 'responds with created department' do
      is_expected.to include(department: Department.find_by(attributes))
    end

    it 'responds with no errors' do
      is_expected.to include(errors: [])
    end

    context 'when department cannot be created' do
      let(:attributes) { { name: nil, location: nil } }

      it 'responds with no created deparment' do
        is_expected.to include(department: nil)
      end

      it 'responds with errors' do
        is_expected.to include(errors: ["Name can't be blank",
                                        "Location can't be blank"])
      end
    end
  end
end
