$(function() {

  $("[id=btn]").click(function(e){
    e.preventDefault();
    var userId = this.getAttribute('data-user-id')
    if ($(this).attr("class") === "chat-group-user__btn--add"){
      $(this).removeClass("chat-group-user__btn--add").addClass("chat-group-user__btn--remove");
      this.textContent = "削除";
      var addUser = $(this).parents('.chat-group-user');
      var ele = document.createElement('input');
      ele.type = "hidden";
      ele.name = "chat_group[user_ids][]";
      ele.style = "border:none";
      ele.value = userId;
      addUser.append(ele);
      $("#added_users").append(addUser);
    } else {
      $(this).removeClass("chat-group-user__btn--remove").addClass("chat-group-user__btn--add");
      this.textContent = "追加";
      var removeUser = $(this).parents('.chat-group-user');
      $(this).data('data-user-id', userId);
      $("#result").append(removeUser);
    }
  });
});
