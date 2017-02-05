$(function() {

  var wrapper = $("#wrapper");
  var allMessages = wrapper.children();
  var num = allMessages.length;
  var refMessages;

  function buildHtml(message) {
    var htmlName = $('<div class="view__messages__message__name">').append(message.name);
    var htmlDate = $('<div class="view__messages__message__date">').append(message.date);
    var htmlBody = $('<div class="view__messages__message__body">').append(message.body);
    var element = $("<div>", { class: "view__messages__message" }).append(htmlName, htmlDate, htmlBody);
    if (message.image.url) {
      var htmlImage = document.createElement('img');
      htmlImage.src = message.image.url;
      element.append(htmlImage);
    }
    return element
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
      var element = buildHtml(message);
      wrapper.append(element);
      wrapper.animate({ scrollTop: wrapper[0].scrollHeight}, 'normal');
      messageInput.val('');
    })
    .fail(function() {
      alert('error');
    });
  });

  //自動更新機能
  //一定間隔でmessagesコントローラーのindexアクションにAjaxで通信する。
  //messagesの数が異なる場合は全てのmessagesに対してHTML加工処理
  // チャット画面である"#wrapper"が存在しないときは自動更新しない

  function autoReflesh() {
    if (!(wrapper).length) {
      return true;
    }
    $.ajax({
      type: "GET",
      url: './messages.json',
      dataType: 'json'
    })
    .done(function(messages) {
      if (num === messages.length) {
        wrapper.empty();
        $.each(messages, function(i, message) {
          var refMessage = buildHtml(message);
          wrapper.append(refMessage);
        });
      }
    })
  };
  var timer = setInterval(function() { autoReflesh() }, 1000);
});



