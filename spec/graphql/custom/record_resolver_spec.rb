require 'rails_helper'

RSpec.describe Custom::RecordResolver do
  let(:resolver) { described_class }
  describe '.query' do
    subject(:query) { resolver.query(model, conditions) }
    let(:model) { Department }
    let(:conditions) { { id: department.id } }
    let(:departments) { create_list(:department, 2) }
    let(:department) { departments.first }

    it { is_expected.to contain_exactly(department) }

    context 'when no department matches condition' do
      let(:conditions) { { id: nil } }

      it { is_expected.to be_empty }
    end

    context 'with multiple conditions' do
      let(:conditions) { { id: department.id, name: department.name } }

      it { is_expected.to contain_exactly(department) }
    end

    context 'with limit condition' do
      let(:conditions) { { id: departments.pluck(:id), limit: 1 } }
      let(:departments) { create_list(:department, 2) }

      it { is_expected.to contain_exactly(Department) }
    end

    context 'with offset condition' do
      let(:conditions) { { id: departments.pluck(:id), offset: 1 } }
      let(:departments) { create_list(:department, 2) }

      it { is_expected.to contain_exactly(Department) }
    end
  end
end
