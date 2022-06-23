import moment from 'moment';
import React, {useEffect, useState} from 'react'
import Comments from './Comments';
import Suggestions from './Suggestions';

const PostShow = () => {
  
  const [postData, setPostData] = useState(null);

  useEffect(()=>{
    fetch('http://127.0.0.1:3000/posts/31.json',{
        method : "GET",
    }).then( response => response.json()).then(status => {
       console.log(status);
       setPostData(status);
    });
  },[])
    
  return (
    <div>
        <div className='card mb-3' style={{"maxWidth": "90%"}} >
            <div className='row g-0'>
                <div className='col-md-12'>
                    <div className='card-body'>      
                        
                        {
                            (postData !== null) ? (
                                <div>
                                    <h5 className='card-title'>{postData.post.title}</h5>
                                    <p><b>Posted by: </b>{postData.post_user.email}</p>
                                    <p className='card-text'>{postData.post.description}</p>
                                    <p className='card-text'><small className='text-muted'>Posted {moment(postData.post.published_at).fromNow()} </small></p>
                                    <p className='card-text'><small className='text-muted'>Last Updated {moment(postData.post.updated_at).fromNow()} </small></p> 

                                    {
                                        ((postData.current_user.id == postData.post_user.id) && (postData.post.status === "PUBLISHED")) ?
                                            <Suggestions postData = {postData} />
                                        : 
                                            false
                                    }

                                    <button className='btn btn-warning'>Edit</button>
                                    <button className='btn btn-danger'>Delete</button>
                                    {/* <%= link_to 'Edit', edit_post_path(post), className:'btn btn-warning' %>
                                    <%= link_to 'Delete', post, method: :delete, data: { confirm: 'Are you sure?' }, className:'btn btn-danger' %> */}
                                </div>
                            )
                            :
                                false
                        }


                        {/* <!-- Post details -->
            
                    
                        <% else %>
                            <!-- Show reported posts for the moderator -->
                            <% if current_user.role == 'moderator' && post.report_status == 'reported' %>
                            <%= render partial: 'reported', locals: {post: post} %><br/><br/>
                            <% end %> remaining
                    
                            <!-- Show post suggestions to post owner -->
                            <% if current_user.id == post.user_id && post.PUBLISHED? %>
                            <a className='suggestions-display' href='#'>Show Suggestions</a>
                            <div className='suggestion-form'>
                                <%= render partial: 'suggestions/suggestions', locals: {post: post} %>
                            </div><br/><br/>
                            <%= link_to 'Edit', edit_post_path(post), className:'btn btn-warning' %>
                            <%= link_to 'Delete', post, method: :delete, data: { confirm: 'Are you sure?' }, className:'btn btn-danger' %> done
                            
                            <!-- Add suggestions if post not owned -->
                            <% elsif current_user.id != post.user_id %>
                            <a className='suggestion-form-display' href='#'>Add Suggestion</a>
                            <div className='suggestion-form'>
                            <%= render partial: 'suggestions/form', locals: {post: post} %>
                            </div><br/><br/>
                            <%= link_to 'Report', set_status_post_path(post.id, status: 'reported'), method: :patch, data: { confirm: 'Are you sure?' } %>
                            
                            <% end %>
                    
                        <% end %> */}
                    </div>
                </div>
            </div>
        </div>
        {
            (postData !== null) ?
                <Comments comments = {postData.comments} />
            :
                false
        }
    </div>
  )
}

export default PostShow;