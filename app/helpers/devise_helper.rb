module DeviseHelper
  def devise_error_messages!

  @flash_alerts = []
  if !flash.empty?
      @flash_alerts.push(flash[:error]) if flash[:error]
      @flash_alerts.push(flash[:alert]) if flash[:alert]
      @flash_alerts.push(flash[:notice]) if flash[:notice]
      error_key = 'devise.failure.invalid'
    end
   flash[:alert] = ""
   flash_messages?
  #return "" unless devise_error_messages? || !flash_alerts.empty?
   return "" if !devise_error_messages? && !flash_messages?

   errors = resource.errors.empty? ? @flash_alerts : resource.errors.full_messages
   messages = errors.map { |msg| content_tag(:li, msg) }.join
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
      <div class="alert alert-warning">
        <strong>Warning!&nbsp;</strong>#{@flash_alerts[0]}
      </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
  def flash_messages?
    if @flash_alerts.length > 0
      return !@flash_alerts[0].empty?
    end
  end

end
