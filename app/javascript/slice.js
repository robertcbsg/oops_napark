// src/features/counter/counterSlice.js
import { createSlice } from '@reduxjs/toolkit';

const initialState = {
    parkingLotName: '',
}

export const slice = createSlice({
  name: 'slice',
  initialState,
  reducers: {
    saveParkingLotName: (state, action) => {
        state.parkingLotName = action.payload;
    },
  },
});

export const { saveParkingLotName } = slice.actions;

export default slice;
