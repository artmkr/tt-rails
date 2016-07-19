class ContactMailController < ApplicationController
  def create
    @mail = ContactMail.new(mail_params)
    respond_to do |format|
      if @mail.save
        format.html { redirect_to root_path, notice: 'Mail was sent' }
      else
        format.html { redirect_to page_path('contact') }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_params
      params.require(:contact_mail).permit(:name,:email,:text)
    end
end
