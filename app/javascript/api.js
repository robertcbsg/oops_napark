import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const api = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({ baseUrl: '/' }),
  endpoints: (builder) => ({
    getTime: builder.query({
      query: () => 'api/v1/clock',
    }),
    getParkingSlips: builder.query({
      query: () => 'api/v1/parking/slips',
    }),
    postPark: builder.mutation({
      query: (parkBody) => ({
        url: 'api/v1/park',
        method: 'POST',
        body: parkBody,
      })
    }),
    postUnpark: builder.mutation({
      query: (unparkBody) => ({
        url: 'api/v1/unpark',
        method: 'POST',
        body: unparkBody,
      })
    }),
  }),
});

export const { useGetTimeQuery, useGetParkingSlipsQuery, usePostParkMutation, usePostUnparkMutation } = api;