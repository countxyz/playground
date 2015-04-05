module TimeHelper

  def task_time_format datetime, message='N/A'
    datetime ? l(datetime, format: :task_list) : message
  end
end
