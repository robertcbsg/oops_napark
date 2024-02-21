import React, { Fragment } from 'react';
import { useForm } from "react-hook-form"
import {
    useGetTimeQuery,
    useGetParkingSlipsQuery,
    usePostParkMutation,
    usePostUnparkMutation
} from '@/api';
import { Button } from "@/components/ui/button"
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
  } from "@/components/ui/table"


const Header = () => {
    return (
        <div className='pl-5 flex flex-row space-x-4'>
            <div className='font-medium text-white'>Home</div>
        </div>
    );
}

const Clock = ({ data }) => {
    return (
        <div>
            <div className='pr-5 flex flex-row'>
                { data ?<div className='font-medium text-white'> {data.formatted_datetime_now}</div> : null}
            </div>
        </div>
    );
}

const OutgoingForm = () => {
    const [postUnpark] = usePostUnparkMutation();

    const form = useForm({
        defaultValues: {
            parkingSlipID: "",
        },
      });

    const onSubmit = (values) => {
        const data = {
            parking_slip_id: values.parkingSlipID
        }
        const response = postUnpark(data);
        console.log(response)

        form.reset();
    }

    return (
        <Form {...form}>
        <form id="outgoingForm" onSubmit={form.handleSubmit(onSubmit)}>
            <div className='pt-5 font-medium text-2xl text-white'>
                Outgoing Form
            </div>
            <div className='pt-5 pl-5 space-y-2'>
                <FormField
                    control={form.control}
                    name="parkingSlipID"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel className="text-white">Parking Slip ID</FormLabel>
                        <FormControl>
                        <Input className="text-white" placeholder="" {...field} />
                        </FormControl>
                        <FormDescription className='text-gray-300'>
                            The parking slip number given on entry
                        </FormDescription>
                        <FormMessage />
                    </FormItem>
                    )}
                />
            </div>
        </form>
      </Form>
    );
}

const IngoingForm = () => {
    const [postPark] = usePostParkMutation();
    const form = useForm({
        defaultValues: {
            entryPoint: "",
            plateNumber: "",
            size: "",
        },
      });

    const onSubmit = (values) => {
        console.log(values);

        const data = {
            vehicle: { plate_number: values.plateNumber, size: values.size},
            parking_entry_point: { name: values.entryPoint}
        }
        const response = postPark(data);
        console.log(response);

        form.reset();
    }

    return (
        <Form {...form}>
        <form id="ongoingForm" onSubmit={form.handleSubmit(onSubmit)}>
            <div className='pt-5 font-medium text-2xl text-white'>
                Ingoing Form
            </div>
            <div className='pt-5 pl-5 space-y-2'>
                <FormField
                    control={form.control}
                    name="entryPoint"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel className="text-white">Entry Point</FormLabel>
                        <FormControl>
                        <Input className="text-white" placeholder="e.g. North Exit" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="plateNumber"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel className="text-white">Plate number</FormLabel>
                        <FormControl>
                        <Input className="text-white" placeholder="e.g. AAA111" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
                <FormField
                    control={form.control}
                    name="size"
                    render={({ field }) => (
                    <FormItem>
                        <FormLabel className="text-white">Size</FormLabel>
                        <FormControl>
                        <Input className="text-white" placeholder="e.g. S, M, L" {...field} />
                        </FormControl>
                        <FormMessage />
                    </FormItem>
                    )}
                />
            </div>
        </form>
      </Form>
    );
}

const ParkingSlipTable = ({ data }) => {
    return (
        <div className='pt-6 text-white'>
            <Table>
                <TableCaption className='text-bg-gray-600'>List of recent parking transactions</TableCaption>
                <TableHeader>
                    <TableRow>
                    <TableHead className='text-white font-bold'>ID</TableHead>
                    <TableHead className='text-white font-bold'>Plate Number</TableHead>
                    <TableHead className='text-white font-bold'>Parking Slot</TableHead>
                    <TableHead className="text-white text-center font-bold w-[180px]">Time In</TableHead>
                    <TableHead className="text-white text-center font-bold w-[180px]">Time Out</TableHead>
                    <TableHead className="text-white font-bold text-right">Parking Fee</TableHead>
                    </TableRow>
                </TableHeader>
                <TableBody>
                    {data ? data.map(entry => (
                        <TableRow key={entry.id}>
                            <TableCell>{entry.id}</TableCell>
                            <TableCell>{entry.plate_number}</TableCell>
                            <TableCell>{entry.parking_slot_size}</TableCell>
                            <TableCell className='w-[180px]'>{entry.time_in}</TableCell>
                            <TableCell className='w-[180px]'>{entry.time_out}</TableCell>
                            <TableCell className='text-right'>{entry.parking_fee}</TableCell>
                        </TableRow>                         
                )) : null }    
                </TableBody>
            </Table> 
        </div>
    );
}

const Home = () => {
    const { data } = useGetParkingSlipsQuery([]);
    const timeData = useGetTimeQuery("");
    // console.log(timeData.data);

    return (
        <div>
            <div className="max-w-[80vw] mx-auto mt-20 ">
                <div className="grid grid-cols-12 grid-rows-12 min-h-[80vh] ">
                    <div className='mb-1 rounded-l-lg  col-span-8 row-start-1 row-span-1 bg-gray-900 flex items-center z-1'>
                        <Header />
                    </div>

                    <div className='mb-1 rounded-r-lg col-start-9 col-span-4 row-start-1 row-span-1 bg-gray-900 flex items-center z-1'>
                    </div> 
                    <div className='mb-1 rounded-r-lg col-start-9 col-span-4 row-start-1 row-span-1 flex justify-self-end items-center z-0'>
                        <Clock data={ timeData.data } />
                    </div>

                    <div className='mr-1 rounded-lg border-2 border-white col-span-8 row-start-2 row-span-10 bg-gray-900 flex justify-center items-top'>
                        <ParkingSlipTable data={data} />
                    </div>

                    <div className='ml-1 rounded-t-lg col-start-9 col-span-4 row-start-2 row-span-6 bg-gray-900 flex items-center z-1'>
                    </div>
                    <div className='ml-1 pl-5 rounded-t-lg col-start-9 col-span-4 row-start-2 row-span-6 bg-gray-900 flex place-self-start z-0'>
                        <IngoingForm />
                    </div>
                    <div className='ml-1 col-start-9 col-span-4 row-start-2 row-span-6 bg-gray-900 flex place-self-end z-0'>
                        <Button className='mb-5 mr-5 rounded-lg border-2 bg-gray-900 hover:bg-gray-200 hover:text-gray-900' type="submit" form="ongoingForm">
                            <div className='font-bold'> Submit </div>
                        </Button> 
                    </div>

                    <div className='ml-1 rounded-b-lg col-start-9 col-span-4 row-start-8 row-span-4 bg-gray-900 flex justify-center items-center z-1'>
                    </div>
                    <div className='ml-1 pl-5 rounded-b-lg col-start-9 col-span-4 row-start-8 row-span-4 bg-gray-900 flex place-self-start z-0'>
                        <OutgoingForm />
                    </div>
                    <div className='ml-1 rounded-b-lg col-start-9 col-span-4 row-start-8 row-span-4 bg-gray-900 flex place-self-end z-0'>
                        <Button className='mb-5 mr-5 rounded-lg border-2 bg-gray-900 hover:bg-gray-200 hover:text-gray-900' type="submit" form="outgoingForm">
                            <div className='font-bold'> Submit </div>
                        </Button> 
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Home
