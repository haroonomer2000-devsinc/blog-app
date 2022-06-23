import React from 'react'

const Suggestions = ({postData}) => {
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
                                        <tr key={suggestion.suggestion_id}>
                                            <td>{suggestion.email}</td>
                                            <td>{suggestion.to_replace}</td>
                                            <td>{suggestion.replacement}</td>
                                            {/* <td><%= link_to 'Approve', apply_post_suggestion_path(@post, suggestion.id), method: :patch, data: { confirm: 'Are you sure?' }, className:'btn btn-success'%> <%= link_to 'Deny', post_suggestion_path(@post,suggestion.id),  method: :delete, data: { confirm: 'Are you sure?' }, className:'btn btn-danger'%></td> */}
                                            <td><button className = 'btn btn-success'>Accept</button><button className = 'btn btn-danger'>Deny</button></td>
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