import React, { Fragment } from 'react';
import { useState } from 'react';

import {
    Card,
    CardContent,
    CardDescription,
    CardFooter,
    CardHeader,
    CardTitle,
  } from "@/components/ui/card"  
import { Button } from '@/components/ui/button';
import { Input } from "@/components/ui/input"
import { useGetParkingSlipsQuery, usePostParkMutation, usePostUnparkMutation } from '@/api';

const Home = () => {
    const [postPark] = usePostParkMutation();
    const [postUnpark] = usePostUnparkMutation();
    const { data } = useGetParkingSlipsQuery([]);

    console.log(data);

    const [entrance, setEntrance] = useState('');
    const [plateNumber, setPlateNumber] = useState('');
    const [size, setSize] = useState('');
    const [parkingSlipId, setParkingSlipId] = useState(null);

    const handleEntranceChange = (event) => {
        setEntrance(event.target.value);
    };
    const handlePlateNumberChange = (event) => {
        setPlateNumber(event.target.value);
    };
    const handleSizeChange = (event) => {
        setSize(event.target.value);
    };
    const handleParkingSlipIdChange = (event) => {
        setParkingSlipId(event.target.value);
    };

    const handleIngoingSubmit = () => {
        console.log(entrance);
        console.log(plateNumber);
        console.log(size);
        console.log("submit");
        const data = {
            vehicle: { plate_number: plateNumber, size: size},
            parking_entry_point: { name: entrance}
        }
        console.log(data)
        const response = postPark(data);
        console.log(response)
    };

    const handleOutgoingSubmit = () => {
        console.log(parkingSlipId);
        const data = {
            parking_slip_id: parkingSlipId
        }
        const response = postUnpark(data);
        console.log(response)
    }

    return (
        <div style={{ display: "flex", justifyContent: "center" }}>
            <Card style={{ display: "flex", minWidth: "80vh", minHeight: "60vh", justifyContent: "center", direction: "column"}}>
                <CardContent style={{width: "50%", paddingTop: "1.5rem"}}>
                    <div style={{display: "flex", flexDirection: "column", justifyContent: "space-evenly", alignItems: "center", height: "100%"}}>
                    <Card style={{ width: "95%", height: "45%"}}>
                        <CardHeader> Ingoing </CardHeader>
                        <CardContent >
                            <Input placeholder="Entrance" onChange={handleEntranceChange} />
                            <Input placeholder="Plate number" onChange={handlePlateNumberChange}/>
                            <Input placeholder="Size" onChange={handleSizeChange}/>
                            <Button onClick={handleIngoingSubmit}> Submit </Button>
                        </CardContent>
                    </Card>
                    <Card style={{ width: "95%", height: "45%"}}>
                        <CardHeader> Outgoing </CardHeader>
                        <CardContent>
                            <Input placeholder="Parking Slip #" onChange={handleParkingSlipIdChange}/>
                            <Button onClick={handleOutgoingSubmit}> Submit </Button>
                        </CardContent>
                    </Card>
                    </div>
                </CardContent>
                <CardContent style={{width: "50%", paddingTop: "1.5rem"}}>
                        { data ? 
                            data.map(parkingSlip => <div>
                                <p>id: {parkingSlip.id}</p>
                                <p>effective_time_in: {parkingSlip.effective_time_in}</p>
                                <p>time_out: {parkingSlip.time_out}</p>
                                <p>total_parking_fee: {parkingSlip.total_parking_fee}</p>
                            </div>) : <p> Loading... </p>}
                </CardContent>
            </Card>
        </div>
    )
}

export default Home
