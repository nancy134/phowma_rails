module ApplicationHelper
  def app_flash_messages!
    @flash_alerts = []
    if !flash.empty?
      @flash_alerts.push(flash[:error]) if flash[:error]
      @flash_alerts.push(flash[:alert]) if flash[:alert]
      @flash_alerts.push(flash[:notice]) if flash[:notice]
    end
    flash.clear
    return "" if !flash_messages?

    html = <<-HTML
      <div class="alert alert-warning">
        <strong>Warning!&nbsp;</strong>#{@flash_alerts[0]}
      </div>
    HTML

    html.html_safe

  end

  def flash_messages?
    if @flash_alerts.length > 0
      return !@flash_alerts[0].empty?
    end
  end
  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-error"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end
end
