class ContactsController < ApplicationController
  def index
    @addressbook = Addressbook.find params[:addressbook_id]
    @contacts = @addressbook.contacts.paginate(page: params[:page], per_page: 10 ).order('created_at DESC')
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @addressbook = Addressbook.find params[:addressbook_id]
    @contact = Contact.new
  end

  def create
    @addressbook = Addressbook.find params[:addressbook_id]
    @contact = @addressbook.contacts.build(contact_params)

    if @contact.save
      flash[:success] = 'Contact was successfully created.' 
      redirect_to addressbook_contacts_path
    else
      flash[:danger] = 'Something goes wrong and contact is not created'
      render :new
    end
  end

  def destroy
    addressbook = Addressbook.find params[:addressbook_id]
    contact = Contact.find(params[:id])
    contact.destroy
    flash[:success] = 'Contact was successfully deleted.'
    redirect_to addressbook_contacts_path(addressbook)
  end

  def send_inquiry
    PoliticalPartyMembershipInquiryWorker.perform_async(params[:contact_id])
    flash[:success] = 'Inquiry was successfully sent'
    redirect_to addressbook_contact_path(params[:addressbook_id], params[:contact_id])
  end

  private
    def contact_params
      params.require(:contact).permit(:name, :last_name, :phone, :email, :id_number)
    end
end
