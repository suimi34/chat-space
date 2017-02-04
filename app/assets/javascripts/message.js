$(function() {
  function buildHtml(message) {
    var htmlName = $('<div class="view__messages__message__name">').append(message.name);
    var htmlDate = $('<div class="view__messages__message__date">').append(message.date);
    var htmlBody = $('<div class="view__messages__message__body">').append(message.body);
    if (message.image.url) {
      var htmlImage = document.createElement('img');
      htmlImage.src = message.image.url;
    }
    var element = $("<div>", { class: "view__messages__message" }).append(htmlName, htmlDate, htmlBody, htmlImage);
    var html = $('.view__messages').append(element);
    return html;
  }

  $('#new__message').on('submit', function(e){
    e.preventDefault();
    var messageInput = $('.view__message--new__input');
    var fd = new FormData($(this).get(0));

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

  //自動更新機能
  //一定間隔でmessagesコントローラーのindexアクションにAjaxで通信する。
  //messagesの数が異なる場合は全てのmessagesに対してHTML加工処理
  function reflesh(message) {
    var htmlName = $('<div class="view__messages__message__name">').append(message.name);
    var htmlDate = $('<div class="view__messages__message__date">').append(message.date);
    var htmlBody = $('<div class="view__messages__message__body">').append(message.body);
    if (message.image.url) {
      var htmlImage = document.createElement('img');
      htmlImage.src = message.image.url;
    }
    var element = $("<div>", { class: "view__messages__message" }).append(htmlName, htmlDate, htmlBody, htmlImage);
    return element;
  }

  var allMessages = document.getElementsByClassName("view__messages__message");
  var num = allMessages.length;
  var refMessages;

  function autoReflesh() {
    $.ajax({
      type: "GET",
      url: './messages.json',
      dataType: 'json'
    })
    .done(function(messages) {
      if (num != messages.length) {
        $("#wrapper").empty();
        $.each(messages, function(i, message) {
          var refMessage = reflesh(message)
          $("#wrapper").append(refMessage);
        });
      }
    })
  };
  var timer = setInterval(function() { autoReflesh() }, 3000);
});



