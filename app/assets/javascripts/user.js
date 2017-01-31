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
