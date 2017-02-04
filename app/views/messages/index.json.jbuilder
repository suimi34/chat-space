json.array! @messages do |message|
  json.name message.user.name
  json.date message.post_time
  json.body message.body
  json.image message.image
end
