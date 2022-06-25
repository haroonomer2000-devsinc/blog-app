import React, { useState } from 'react'

const AddSuggestion = ({post_id}) => {

  const [to_replace, setToReplace] = useState('');
  const [replacement, setReplacement] = useState('');

  const submitSuggestion = (e) => {
    e.preventDefault();
    let post = {
        post_id,
        to_replace,
        replacement,
    }
    let params = {
        post
    }
    console.log('agya')
    fetch(`http://127.0.0.1:3000/posts/${post_id}/suggestions`,{
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
        <form onSubmit={submitSuggestion}>
            <div className="mb-3">
                <label htmlFor="to_replace" className="form-label">To Replace</label>
                <input onChange={(e) => {setToReplace(e.target.value)}} required type="text" className="form-control"  placeholder='to replace...' />
            </div>
            <div className="mb-3">
                <label htmlFor="replacement" className="form-label">Replacement</label>
                <input onChange={(e) => {setReplacement(e.target.value)}} required type="text" className="form-control"  placeholder='replacement...' />
            </div>
            <button className='btn btn-primary' type='submit'>Submit</button>
        </form>
    <br/><br/>
    </div>
  )
}

export default AddSuggestion;