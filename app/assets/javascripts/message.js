$(function() {
  function buildHtmlBody(message) {
    var html = $('.view__messages__message').append(message);
    return html;
  }

  $('.view__message--new').on('submit', function(){
    var messageInput = $('.view__message--new__input');
    var message = messageInput.val();

    $.ajax({
      type: 'POST',
      url: gon.url,
      data: {
        message: {
          body: message
        }
      },
      dataType: 'json'
    })
    .done(function(data) {
      var html = buildHtmlBody(message);
      $('.view__messages').push(html);
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});
