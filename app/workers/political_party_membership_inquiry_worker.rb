class PoliticalPartyMembershipInquiryWorker
  include Sidekiq::Worker

  def perform(contact_id)
    PoliticalPartyMembershipInquiryParser.new(contact_id).parse_page
  end
  
end