$(function() {
    function buildHtmlName(message) {
      var htmlName = $('.view__messages__message__name').append(message.name);
      return htmlName;
    }
    function buildHtmlDate(message) {
      var htmlDate = $('.view__messages__message__date').append(message.date);
      return htmlDate;
    }
    function buildHtmlBody(message) {
      var htmlBody = $('.view__messages__message__body').append(message.body);
      return htmlBody;
    }

  $('.view__message--new').on('submit', function(e){
    e.preventDefault();
    var messageInput = $('.view__message--new__input');
    var message = messageInput.val();

    $.ajax({
      type: 'POST',
      url: '/chat_groups/chat_group_id/messages.json',
      data: {
        messages: {
          body: message
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      var htmlBody = buildHtmlBody(message);
      $('.view__messages__message').append(htmlBody);
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});
