class Company < ApplicationRecord
    has_many :indicators, class_name: 'Indicator', foreign_key: 'company_id'
end
