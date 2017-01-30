$(function() {

  $(".chat-group-user").on('click', 'p', function(){
    var addUserId = this.getAttribute('data-user-id');
    var btn = $(this).parent();
    var addUser = $(this).parents('.chat-group-user');
    var ele = document.createElement('input');
    ele.id = "hidden_id";
    ele.type = "hidden";
    ele.name = "chat_group[user_ids][]";
    ele.style = "border:none";
    ele.value = addUserId;
    var removeBtn = $("<li>",{
      "class" : "chat-group-user__btn--remove",
      text: "削除"
    });
    $(this).remove();
    btn.append(removeBtn);
    addUser.append(ele, btn);
    $("#added_users").append(addUser);
  });

  $(".chat-group-user").on('click', 'li', function(){
    var removeUser = $(this).parents('.chat-group-user');
    var btn = $(this).parent();
    var removeUserInput = removeUser.children('input');
    var removeUserId = removeUserInput.val();
    var addBtn = $("<p>",{
      "class" : "chat-group-user__btn--add",
      text: "追加"
    });
    addBtn.attr('data-user-id', removeUserId),
    btn.append(addBtn);
    removeUser.append(btn);
    $(this).remove();
    removeUserInput.remove();
    $('#user_info').append(removeUser);
  });
});
