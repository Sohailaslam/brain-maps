class Question < ActiveRecord::Base
    belongs_to :quiz
    has_many :answers, :dependent => :destroy
    has_many :responses, :dependent => :destroy
    belongs_to :learning_outcome
    accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
end
