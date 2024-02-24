import React from "react";
import { useForm } from "react-hook-form"

import { usePostParkMutation } from '@/api';
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
        const data = {
            vehicle: { plate_number: values.plateNumber, size: values.size},
            parking_entry_point: { name: values.entryPoint}
        }
        postPark(data);

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

export default IngoingForm;