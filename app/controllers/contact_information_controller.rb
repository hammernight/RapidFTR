class ContactInformationController < ApplicationController
  skip_before_filter :check_authentication, :only => %w{show}
  
  before_filter :administrators_only, :except => %w{show}

  # GET /contact_information/Administrator  
  def show
    @contact_information = ContactInformation.get_by_id(params[:id]) 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contact_information }
    end
  end

  # GET /contact_information/Administrator/edit
  def edit
    @contact_information = ContactInformation.get_or_create(params[:id])
  end
  
  # PUT /contact_information/Administrator
  def update
    @contact_information = ContactInformation.get_by_id(params[:id])
    @contact_information.update_attributes(params[:contact_information])  
    @contact_information.save!
    flash[:notice] = 'Contact information was successfully updated.'
    redirect_to edit_contact_information_path(params[:id]) 
  end
end