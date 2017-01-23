$(function() {
  function buildHtmlBody(message) {
    var html = $('<div class="view__messages__message__body">').append(message);
    return html;
  }

  $('.view__message--new').on('submit', function(){
    var messageInput = $('.view__message--new__input');
    var message = messageInput.val();
    var html = buildHtmlBody(message);
    var element = $("<div>", { class: "view__messages__message"}).append(html);
    $('.view__messages').append(element);

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
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});
