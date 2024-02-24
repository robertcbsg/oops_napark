import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "@/pages/Home";
import ParkingEntryPoints from "../pages/parking/ParkingEntryPoints";


export default (
  <Router>
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/parking/entry-points" element={<ParkingEntryPoints />} />
    </Routes>
  </Router>
);