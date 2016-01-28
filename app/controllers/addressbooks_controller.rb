class AddressbooksController < ApplicationController
  def index
    @addressbooks = Addressbook.all.order(id: :desc)
  end

  def new
    @addressbook = Addressbook.new
  end

  def create
    @addressbook = Addressbook.new addressbook_params 
    if @addressbook.save
      flash[:success] = 'Addressbook was successfully created.' 
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    addressbook = Addressbook.find params[:id]
    addressbook.destroy
    flash[:success] = "#{addressbook.name} was successfully deleted."
    redirect_to root_path
  end

  def export
    addressbook = Addressbook.find params[:addressbook_id]
    respond_to do |format|      
      format.csv { send_data addressbook.to_csv, filename: "#{addressbook.name.downcase}.csv" }
    end
  end

  def import_page
    @addressbook = Addressbook.find params[:addressbook_id]  
  end

  def import
    addressbook = Addressbook.find params[:addressbook_id] 
    begin 
      addressbook.import params[:file] 
      flash[:success] = "#{params[:file].original_filename} imported to #{addressbook.name}"
      redirect_to root_path
    rescue => error
      redirect_to addressbook_import_page_path(addressbook), :flash => { danger: "Some errors while importing file: #{error}"}
    end
  end

  private
    def addressbook_params
      params.require(:addressbook).permit(:name)
    end
end
