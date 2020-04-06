# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :age
      t.float :yearly_salary
      t.date :work_start

      t.timestamps
    end
  end
end
