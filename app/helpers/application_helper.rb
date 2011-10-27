module ApplicationHelper
  def time_ago_in_words_with_cutoff(from_time, include_seconds = false, cutoff = 6.hours.ago, format = "on %F at %T %Z")
    if from_time > cutoff
      time_ago_in_words(from_time, include_seconds) + " ago"
    else
      from_time.strftime(format)
    end
  end
  
  def time_ago_in_words_with_hint(from_time, include_seconds = false, hint_format = "%F at %T %Z")
    %{<span title="#{h(from_time.strftime(hint_format))}">#{time_ago_in_words(from_time, include_seconds)}</span>}.html_safe
  end
end
