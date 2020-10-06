class Question < ApplicationRecord
	belongs_to :mapping, optional: true
	belongs_to :role, optional: true
end
