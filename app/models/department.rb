# frozen_string_literal: true

class Department < ApplicationRecord
  has_and_belongs_to_many :employees

  validates :name, :location, presence: true
end
