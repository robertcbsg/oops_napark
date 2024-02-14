import React, { Fragment } from 'react';
import { useGetTimeQuery } from '../../api';

const ParkingEntryPoints = () => {
    const { data } = useGetTimeQuery();

    return (
        <Fragment>
            <p class="text-3xl font-bold">
                ParkingEntryPoints <br></br>
                { !data ? <div> Loading...</div> : data.datetime_now }
            </p>
        </Fragment>
    )
}

export default ParkingEntryPoints