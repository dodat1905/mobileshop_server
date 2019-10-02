class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CurrentCart

  before_action :set_locale
  before_action :current_cart

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, notice: exception.message }
      format.js do
        redirect_to main_app.root_url, notice: exception.message
      end
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def force_json
    request.format = :json
  end

  def find_coupon
    coupon = session[:coupon_code]

    return unless coupon
    @coupon = Coupon.find_by code: coupon
  end
end
