json.name @message.user.name
json.date @message.created_at.strftime("\t%Y/%m/%d/ %H:%M:%S")
json.body @message.body

