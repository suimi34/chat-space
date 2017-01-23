$(function() {
  function buildHtmlName(message) {
    var htmlName = $('<div class="view__messages__message__name">').append(message.name);
    return htmlName;
  }
  function buildHtmlDate(message) {
    var htmlDate = $('<div class="view__messages__message__date">').append(message.date);
    return htmlDate;
  }
  function buildHtmlBody(message) {
    var htmlBody = $('<div class="view__messages__message__body">').append(message.body);
    return htmlBody;
  }

  $('.view__message--new').on('submit', function(e){
    e.preventDefault();
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
    .done(function(message) {
      var htmlName = buildHtmlName(message);
      var htmlDate = buildHtmlDate(message);
      var htmlBody = buildHtmlBody(message);

      var element = $("<div>", { class: "view__messages__message"}).append(htmlName).append(htmlDate).append(htmlBody);
      $('.view__messages').append(element);
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});
