import React from "react";

const Clock = ({ data }) => {
    return (
        <div>
            <div className='pr-5 flex flex-row'>
                { data ?<div className='font-medium text-white'> {data.formatted_datetime_now}</div> : null}
            </div>
        </div>
    );
}

export default Clock;