import React, { Fragment } from 'react';
import { useGetTimeQuery } from '../../api';

const ParkingEntryPoints = () => {
    const { data } = useGetTimeQuery();
    console.log(data)

    return (
        <Fragment>
            <div class="text-3xl font-bold">
                ParkingEntryPoints <br></br>
                { !data ? <p> Loading...</p> : data }
            </div>
        </Fragment>
    )
}

export default ParkingEntryPoints