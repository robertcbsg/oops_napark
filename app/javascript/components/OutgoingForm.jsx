import React from "react";
import { useForm } from "react-hook-form"

import { usePostUnparkMutation } from '@/api';
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

export default OutgoingForm;