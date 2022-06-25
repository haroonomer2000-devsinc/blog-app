import moment from 'moment';
import React, {useEffect, useState} from 'react'
import AddComment from './AddComment';
import AddSuggestion from './AddSuggestion';
import Comments from './Comments';
import ReportedPost from './ReportedPost';
import Suggestions from './Suggestions';

const PostShow = () => {
  
  const [postData, setPostData] = useState(null);
  const [users, setUsers] = useState(null);
  const [showSuggestions, setShowSuggestions] = useState(false);
  const [addSuggestion, setAddSuggestion] = useState(false);

  useEffect(()=>{
    fetch('http://127.0.0.1:3000/posts/31.json',{
        method : "GET",
    }).then( response => response.json()).then(status => {
       console.log(status);
       setPostData(status);
       let temp_users = {};
       status['users'].map((user)=>{
            temp_users[user.id] = user.email;
       })
       setUsers(temp_users);
    });
  },[])

  const reportPost = (id, status) => {
    let params = {
        id,
        status
    }
    fetch(`http://127.0.0.1:3000/posts/${id}/set_status`,{
        method: "PATCH",
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
                                        ((postData.current_user.id === postData.post_user.id) && (postData.post.status === "PUBLISHED")) ?
                                            <div>
                                                <button onClick={() => setShowSuggestions(!showSuggestions)} type="button" className="btn btn-link">Show Suggestions</button><br/><br/>
                                                {
                                                    (showSuggestions) ?
                                                        <Suggestions postData = {postData} users = {users} />
                                                    :
                                                        false
                                                }
                                            </div>
                                        : 
                                            ((postData.current_user.id !== postData.post_user.id) && (postData.post.status === "PUBLISHED")) ?
                                                <div>
                                                    <button onClick={() => setAddSuggestion(!addSuggestion)} type="button" className="btn btn-link">Add Suggestion</button><br/><br/>
                                                    {
                                                        (addSuggestion) ?
                                                            <AddSuggestion post_id = {postData.post.id} />
                                                        :
                                                            false
                                                    }
                                                </div>
                                            :
                                                false
                                    }
                                    {
                                        (postData.current_user.role === "moderator") ?
                                            <div>
                                                {
                                                    (postData.post.report_status === 'reported') ?
                                                        <ReportedPost id = {postData.post.id} />
                                                    :
                                                        false
                                                }
                                            </div>
                                        : (postData.current_user.role !== "moderator" && postData.post.user_id !== postData.current_user.id) ?
                                                <div>
                                                    <button onClick={ () => reportPost(postData.post.id, 'reported')} className='btn btn-link'>Report</button><br/><br/>
                                                </div>
                                            :
                                                false
                                    }
                                    <button className='btn btn-warning'>Edit</button>
                                    <button className='btn btn-danger'>Delete</button>
                                </div>
                            )
                            :
                                false
                        }
                    </div>
                </div>
            </div>
        </div>
        {
            (postData !== null) ?
            <div>
                <Comments comments = {postData.comments} users = {users} current_user = {postData.current_user} />
                <h3>Add comment</h3><hr/><br/>
                <AddComment parent={null} post_id={postData.post.id} />
            </div>
            :
                false
        }
    <button className='btn btn-primary'>Back</button>
    <br/><br/></div>
  )
}

export default PostShow;