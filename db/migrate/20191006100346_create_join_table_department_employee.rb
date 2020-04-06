# frozen_string_literal: true

class CreateJoinTableDepartmentEmployee < ActiveRecord::Migration[6.0]
  def change
    create_join_table :departments, :employees do |t|
      t.index [:department_id, :employee_id]
      t.index [:employee_id, :department_id]
    end
  end
end
