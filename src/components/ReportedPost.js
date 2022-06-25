import React from 'react'

const ReportedPost = ({id}) => {

  const handleReport = (status) => {
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
        <ul className='list-group'>
            <li className='list-group-item'>Post has been reported
                <span>
                    <div className='report-approval'>
                        <button onClick={() => handleReport('hidden')} className='btn btn-success'>Accept</button>
                        <button onClick={() => handleReport(null)} className='btn btn-danger'>Deny</button>
                    </div>
                </span>
            </li>
        </ul>
    <br/><br/></div>
  )
}

export default ReportedPost;