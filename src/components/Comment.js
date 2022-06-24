import moment from 'moment';
import React from 'react'

const Comment = ({comment, comments, users}) => {
  return (
    <div>
        <ul className='list-group'>
            <li className='list-group-item comment'>
                { 
                    (users !== undefined) ?
                        <strong>{users[comment.user_id]}: </strong>
                    :
                        false
                   
                }
                {comment.body}
                <span>
                <p className='card-text'>
                    <small className='text-muted'>Posted {moment(comment.created_at).fromNow()} ago </small>
                </p>

                {/* <!-- Current user can delete their comment else if not theirs, report it -->
                <% if current_user.id == comment.user.id %>  
                    <%= link_to 'Delete', post_comment_path(comment.post_id,comment.id), method: :delete, data: { confirm: 'Are you sure?' } %>
                <% else %>
                    <%= link_to 'Report', post_comment_path(comment.post_id,comment.id, status: 'reported'), method: :patch, data: { confirm: 'Are you sure?' } %>
                <% end %><br/><br/> */}
            {/* 
                <!-- Reply comment -->
                <a className='comment-form-display' href='#'>Reply</a>
                <div className='comment-form'>
                    <%= render 'comments/form', locals: {post: @post, parent: @parent = comment} %>
                </div>

                <%= render partial: 'likes/button', locals: { likeable: comment, like: current_user.likes.find_by(likeable: comment) } %>

                <div className='sub-comment'>
                    <%= render comment.comments.active %>
                </div> */}
                </span>
                {
                    (comments.map((c) => {
                        if (c.parent_id === comment.id){
                            return (
                                <Comment key = {c.id} comment={c} comments = {comments} users = {users}/>
                            )
                        }
                    }))
                }

            </li><br/>
        </ul>
    </div>
  )
}

export default Comment;