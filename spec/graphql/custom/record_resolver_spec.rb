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

    context 'with empty hash as condition' do
      let(:conditions) { { } }
      let!(:departments) { create_list(:department, 2) }

      it { is_expected.to contain_exactly(Department, Department) }
    end

    context 'with appended _from condition' do
      let!(:old_department) { create(:department, created_at: 7.days.ago) }
      let!(:new_department) { create(:department) }
      let(:conditions) do
        { created_at_from: old_department.created_at + 1.day }
      end

      it 'returns only new department' do
        is_expected.to contain_exactly(new_department)
      end
    end

    context 'with appended _to condition' do
      let!(:old_department) { create(:department, created_at: 7.days.ago) }
      let!(:new_department) { create(:department) }
      let(:conditions) { { created_at_to: new_department.created_at - 1.day } }

      it 'returns only old department' do
        is_expected.to contain_exactly(old_department)
      end
    end

    context 'with appended _from and _to conditions' do
      let!(:old_department) { create(:department, created_at: 7.days.ago) }
      let!(:current_department) { create(:department) }
      let!(:future_department) do
        create(:department, created_at: 7.days.from_now)
      end
      let(:conditions) do
        { created_at_from: 1.day.ago, created_at_to: 1.day.from_now }
      end

      it 'returns only current department' do
        is_expected.to contain_exactly(current_department)
      end
    end
  end
end
