$(function() {
  function buildHtml(message) {
    var htmlName = $('<div class="view__messages__message__name">').append(message.name);
    var htmlDate = $('<div class="view__messages__message__date">').append(message.date);
    var htmlBody = $('<div class="view__messages__message__body">').append(message.body);
    var element = $("<div>", { class: "view__messages__message" }).append(htmlName, htmlDate, htmlBody);
    var html = $('.view__messages').append(element);
    return html;
  }

  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var messageInput = $('.view__message--new__input');
    var fd = new FormData($('form#new_message').get(0));

    $.ajax({
      type: 'POST',
      url: './messages.json',
      data: fd,
      processData: false,
      contentType: false,
      dataType: 'json'
    })
    .done(function(message) {
      var html = buildHtml(message);
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });
});



