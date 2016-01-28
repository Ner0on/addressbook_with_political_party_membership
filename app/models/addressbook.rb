class Addressbook < ActiveRecord::Base
  require 'csv'

  has_many :contacts, dependent: :destroy
  validates :name, presence: true
  
  def to_csv
    attributes = %w{name last_name phone email id_number}
    CSV.generate do |csv|
      csv << attributes
      contacts.each do |contact|
        csv << contact.attributes.values_at(*attributes)
      end
    end
  end

  def import file
    CSV.foreach(file.path, headers: true) do |row|
      contacts.create! row.to_hash
    end
  end
  
end
