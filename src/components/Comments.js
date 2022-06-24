import React from 'react'
import Comment from './Comment'

const Comments = ({comments, users}) => {
  return (
    <div>
        <h3>Comments</h3><hr/><br/>
        {
            comments.map((comment) => {
                if (!comment.parent_id) {
                    return (
                        <Comment key = {comment.id} comment = {comment} comments = {comments} users = {users}/>
                    )
                }
            })
        }
    </div>
  )
}

export default Comments;