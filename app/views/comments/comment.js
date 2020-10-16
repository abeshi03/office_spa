$("#comment_area").html("<%= j(render 'comment', { comments: @comment.request.comments }) %>")
$("textarea").val('')