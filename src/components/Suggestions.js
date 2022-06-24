import React from 'react'

const Suggestions = ({postData, users}) => {

  const handleSuggestion = (status, post_id, id) => {
    if (status === 'accept'){
        let params = {
            post_id,
            id
        }
        fetch(`http://127.0.0.1:3000/posts/${post_id}/suggestions/${id}/apply`,{
        method: "PATCH",
        headers: {
            "Content-Type":"application/json"
        },
        body: JSON.stringify(params)
        }).then((response) => response.json()).then(status => {
            window.location.reload();
        })
    }
  }

  return (
    <div>
        {
            (postData.post_suggestions.length > 0) ? (
                <div>
                    <table className='table'>
                        <thead>
                        <tr>
                            <th scope='col'>Suggested by</th>
                            <th scope='col'>To Replace</th>
                            <th scope='col'>Replacement</th>
                            <th scope='col'>Handle</th>
                        </tr>
                        </thead>
                        <tbody>
                            {
                                postData.post_suggestions.map((suggestion) => {
                                    return (
                                        <tr key={suggestion.id}>
                                            <td>{users[suggestion.user_id]}</td>
                                            <td>{suggestion.to_replace}</td>
                                            <td>{suggestion.replacement}</td>
                                            {/* <td><%= link_to 'Approve', apply_post_suggestion_path(@post, suggestion.id), method: :patch, data: { confirm: 'Are you sure?' }, className:'btn btn-success'%> <%= link_to 'Deny', post_suggestion_path(@post,suggestion.id),  method: :delete, data: { confirm: 'Are you sure?' }, className:'btn btn-danger'%></td> */}
                                            <td><button onClick={() => handleSuggestion('accept', postData.post.id, suggestion.id)} className = 'btn btn-success'>Accept</button><button className = 'btn btn-danger'>Deny</button></td>
                                        </tr>
                                    )
                                })
                            }
                        </tbody>
                    </table>
                </div>
            )
            :
                <blockquote className='blockquote'>
                    <p>No suggestions for this post</p>
                </blockquote>
        }
    <br/><br/></div>
  )
}

export default Suggestions;