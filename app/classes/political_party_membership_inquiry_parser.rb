class PoliticalPartyMembershipInquiryParser
  require 'mechanize'

  ATTRIBUTES = {
    url: 'https://ariregister.rik.ee/erakonnad.py/search',
    form_name: 'era',
    first_name: 'eesnimi',
    last_name: 'perenimi',
    class_to_find: '.tbl_listing tr td.td_v',
    table_columns: [:number, :full_name, :birthdate, :political_party_name, :political_party_code, :political_party_status, :engagement_date, :resignation_date, :suspension_date]
  } 

  def initialize(contact_id)
    @contact = Contact.find(contact_id)
    @mechanize = Mechanize.new
  end

  def parse_page
    page = @mechanize.get(ATTRIBUTES[:url])
    filled_form = search_form(page)
    result = row_result(filled_form.submit)
    parsed_result = parse_result(result)
    result_save(parsed_result)
  end

  def search_form(page)
    form = page.form_with(ATTRIBUTES[:form_name])
    form[ATTRIBUTES[:first_name]] = @contact.name
    form[ATTRIBUTES[:last_name]] = @contact.last_name
    form
  end

  def row_result(page_result)
    page_result.search(ATTRIBUTES[:class_to_find]).to_a.in_groups_of(9)
  end

  def parse_result(result)
    ready = []
    result.each do |row|
      data = {}
      ATTRIBUTES[:table_columns].each do |column_name|
        data[column_name] = row.shift.text.strip
      end
      ready << data
    end
    {data: ready.to_json}
  end

  def result_save(result)
    @contact.update!(political_party_membership: result)
  end

end