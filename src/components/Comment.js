import moment from 'moment';
import React, { useState } from 'react'
import AddComment from './AddComment';

const Comment = ({comment, comments, users, current_user}) => {

  const [reply, setReply] = useState(false);

  const removeComment = (post_id, id) => {
    let post = {
        post_id,
        id
    }
    let params = {
        post
    }
    fetch(`http://127.0.0.1:3000/posts/${post_id}/comments/${id}`,{
        method: "DELETE",
        headers: {
            "Content-Type":"application/json"
        },
        body: JSON.stringify(params)
        }).then((response) => response.json()).then(status => {
            window.location.reload();
    })
  }

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
                {
                    (current_user !== undefined) ?
                        (current_user.id === comment.user_id) ?
                            <button onClick={()=>removeComment(comment.post_id, comment.id)} className='btn btn-link'>Delete</button>
                        :
                            false
                    :
                        false
                }
                <br/><button onClick={() => setReply(!reply)} className='btn btn-link'>Reply</button><br/><br/>
                {
                    (reply) ?
                        <AddComment parent_id={comment.id} post_id={comment.post_id} />
                    :
                        false
                }
                {/* 
                    <%= link_to 'Report', post_comment_path(comment.post_id,comment.id, status: 'reported'), method: :patch, data: { confirm: 'Are you sure?' } %>
                <% end %><br/><br/> */}
            {/* 
                <%= render partial: 'likes/button', locals: { likeable: comment, like: current_user.likes.find_by(likeable: comment) } %>

                <div className='sub-comment'>
                    <%= render comment.comments.active %>
                </div> */}
                </span>
                {
                    (comments.map((c) => {
                        if (c.parent_id === comment.id){
                            return (
                                <Comment key = {c.id} comment={c} comments = {comments} users = {users} current_user={current_user}/>
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