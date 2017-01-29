$(function() {

  $("[id=btn]").click(function(){
    if ($(this).attr("class") === "chat-group-user__btn--add"){
      var addUserId = this.getAttribute('data-user-id')
      $(this).removeClass("chat-group-user__btn--add").addClass("chat-group-user__btn--remove");
      this.textContent = "削除";
      var addUser = $(this).parents('.chat-group-user');
      var ele = document.createElement('input');
      ele.id = "hidden_id";
      ele.type = "hidden";
      ele.name = "chat_group[user_ids][]";
      ele.style = "border:none";
      ele.value = addUserId;
      $(this).removeAttr('data-user-id');
      addUser.append(ele);
      $("#added_users").append(addUser);
    } else {
      var removeUser = $(this).parents('.chat-group-user');
      var removeUserInput = removeUser.children('input');
      var removeUserId = removeUserInput.val();
      $(this).removeClass("chat-group-user__btn--remove").addClass("chat-group-user__btn--add");
      this.textContent = "追加";
      $(this).attr('data-user-id', removeUserId);
      removeUserInput.remove();
      $("#user_info").append(removeUser);
    }
  });
});
