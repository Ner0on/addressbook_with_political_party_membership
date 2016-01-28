class Contact < ActiveRecord::Base
  belongs_to :addressbook
  validates_presence_of :name, :last_name, :email, :phone, :id_number
  validates_format_of :name, :with => /[a-z]/
  validates_format_of :last_name, :with => /[a-z]/
  validates_format_of :phone, :with => /[0-9]/
  validates_format_of :id_number, :with => /[0-9]/
  validates :email, email: true

  before_create :is_max?

  def is_max? 
    if addressbook.contacts.count >= Rails.configuration.max_contacts
      errors.add(:addressbook, "#{addressbook.name} has reached maximum amount of contacts")
      false
    end
  end

end
