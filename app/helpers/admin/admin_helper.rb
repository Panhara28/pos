module Admin::AdminHelper
  def free?(obj)
    if obj === 0.0
      content_tag(:td, "Free")
    else
      content_tag(:td, number_to_currency(obj))
    end
  end

  def in_invoice_free?(obj)
    if obj === 0.0
      content_tag(:td, number_to_currency(obj), class: "price")
    else
      content_tag(:td, number_to_currency(obj), class: "price")
    end
  end

  def custom_flash_message
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe

  end

  def get_active(id, correct: "active", incorrect: "inactive")
    if id === 1
      correct
    else
      incorrect
    end
  end

  def fullname(first, last)
    "#{first} #{last}"
  end

  def status_converter(status, correct: 'active', incorrect: 'inactive')
    if status
     correct
    else
      incorrect
    end
  end

  def check_if_course_equal_20(search, correct: '', incorrect: '')
    if search == 3 || search >= 3
      incorrect
    else
      correct
    end
  end

  def time_ago(time)
    "#{time_ago_in_words(time)} ago"
  end

  def section_time(section)
    if section == "Morning"
      "8am to 11am"
    elsif section == "Afternoon"
      "2pm to 5pm"
    end
  end

  def title(blog_title)
    content_for(:title) {blog_title}
  end

  def meta_description(blog_text)
    content_for(:meta_description) {blog_text}
  end
end
