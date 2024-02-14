import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const api = createApi({
  reducerPath: 'api',
  baseQuery: fetchBaseQuery({ baseUrl: '/' }),
  endpoints: (builder) => ({
    getTime: builder.query({
      query: () => 'api/v1/clock',
    }),
  }),
});

export const { useGetTimeQuery } = api;