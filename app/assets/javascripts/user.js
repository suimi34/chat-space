$(function() {

// 追加ボタンが押された時に、そのテキストとクラスを変更すると同時にinput要素にuser_idを持たせる
  $(".chat-group-user").on("click", ".chat-group-user__btn--add", function(){
    var addUserId = this.getAttribute("data-user-id");
    var addUser = $(this).parents('.chat-group-user');
    this.textContent = "削除"
    $(this).removeClass("chat-group-user__btn--add").addClass("chat-group-user__btn--remove");
    var ele = document.createElement("input");
    ele.id = "hidden_id";
    ele.type = "hidden";
    ele.name = "chat_group[user_ids][]";
    ele.style = "border:none";
    ele.value = addUserId;
    addUser.append(ele);
    $("#added_users").append(addUser);
  });

  // 削除ボタンが押された時に、そのテキストとクラスを変更すると同時にinput要素を削除する
  $(".chat-group-user").on("click", ".chat-group-user__btn--remove", function(){
    var removeUser = $(this).parents(".chat-group-user");
    var removeUserInput = removeUser.children('input');
    var removeUserId = removeUserInput.val();
    this.textContent = "追加"
    $(this).removeClass("chat-group-user__btn--remove").addClass("chat-group-user__btn--add");
    removeUserInput.remove();
    $("#user_info").append(removeUser);
  });
});


//インクリメンタルサーチ

$(function() {

  function editElement(element) {
    var result = "^" + element;
    return result;
  }

//JSONで戻ってきた配列に対し、１つずつHTML加工処理
  function buildHtml(results) {
    $.each(results, function(i, result) {
      var html = $("<div>", { "class": "chat-group-user" });
      var htmlName = $('<div class="chat-group-user__name">').append(result.name);
      var htmlBtn = $("<div>", { "class": "chat-group-user__btn" });
      var htmlBtnAdd = $("<div>", { "class": "chat-group-user__btn--add", text: "追加" });
      htmlBtnAdd.attr('user-id', result.id);
      htmlBtn.append(htmlBtnAdd);
      html.append(htmlName, htmlBtn);
      $("#user_info").append(html);
    });
  };

//入力フォームに入力されたワードを前方一致の正規表現
  $("#keyword").on("keyup", function() {
    var input = $(this).val();
    var inputs = input.split(" ").filter(function(e) { return e; });
    var newInputs = inputs.map(editElement);
    var word = newInputs.join("|");
    var reg = RegExp(word);

    if (input.length === 0) {
      $("#user_info").remove();
    }

    $.ajax({
      type: 'GET',
      url: 'user_search',
      data: {
        user: {
          name: reg
        }
      },
      dataType: 'json'
    })
    .done(function(results) {
      var html = buildHtml(results);
    })
    .fail(function() {
      alert('error');
    });
  });
});
