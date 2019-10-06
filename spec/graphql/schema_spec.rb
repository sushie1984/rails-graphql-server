require 'rails_helper'

RSpec.describe GraphqlServerSchema do
  let(:schema) { described_class }
  describe '.execute' do
    subject(:execute) { schema.execute(query)['data'][query_type] }
    let(:query) do
      <<-QUERY
        query { #{query_type}(#{query_conditions}) { #{query_return_fields} } }
      QUERY
    end

    context 'when querying for departments' do
      let(:query_type) { 'departments' }
      let(:query_conditions) do
        "id: [#{department.id}],
         name: [\"#{department.name}\"],
         location: [\"#{department.location}\"]"
      end
      let(:query_return_fields) { 'id name location' }

      let(:department) { create(:department) }
      let(:response_hash) do
        { 'id' => department.id.to_s,
          'name' => department.name,
          'location' => department.location }
      end

      it { is_expected.to eq([response_hash]) }

      context 'with employees' do
        let(:department) { create(:department, :with_employees) }
        let(:employee) { department.employees.first }

        let(:query_return_fields) do
          'id name location employees { id name age yearlySalary workStart }'
        end

        let(:response_hash) do
          {
            'id' => department.id.to_s,
            'name' => department.name,
            'location' => department.location,
            'employees' => [{
                'id' => employee.id.to_s,
                'name' => employee.name,
                'age' => employee.age,
                'yearlySalary' => employee.yearly_salary,
                'workStart' => employee.work_start.iso8601
             }]
          }
        end

        it { is_expected.to eq([response_hash]) }
      end
    end
  end
end
