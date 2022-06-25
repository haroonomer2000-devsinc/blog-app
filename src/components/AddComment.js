import React, { useState } from 'react'

const AddComment = ({parent_id, post_id}) => {

  const [comment, setComment] = useState('');

  const addComment = (e) => {
    e.preventDefault();
    let body = comment;
    let post = {
        post_id,
        body,
        parent_id
    }
    let params = {
        post
    }
    fetch(`http://127.0.0.1:3000/posts/${post_id}/comments`,{
        method: "POST",
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
        <form onSubmit={addComment}>
            <div className="mb-3">
                <input onChange={(e) => {setComment(e.target.value)}} required type="text" className="form-control"  placeholder='Add a comment' />
            </div>
            <button className='btn btn-primary'>Post</button>
        </form>
    <br/><br/></div>
  )
}

export default AddComment;