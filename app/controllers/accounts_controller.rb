class AccountsController < ApplicationController
  before_action :set_account, only: %i(show destroy)

  def index
    @accounts = Account.all
  end

  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account Deleted' }
      format.json { head :no_content }
    end
  end

  private

  def set_account
    @account = Account.find params[:id]
  end
end
