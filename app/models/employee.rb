# frozen_string_literal: true

class Employee < ApplicationRecord
  has_and_belongs_to_many :departments
end
