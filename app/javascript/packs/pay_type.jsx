import React from "react";
/*import ReactDOM from "react-dom";*/
import PayTypeSelector from "PayTypeSelector";
import { createRoot } from "react-dom/client";

document.addEventListener("turbolinks:load", function () {
  /*var element = document.getElementById("pay-type-component");
  ReactDOM.render(<PayTypeSelector />, element);*/
  const container = document.getElementById("pay-type-component");
  const root = createRoot(container); // createRoot(container!) if you use TypeScript
  root.render(<PayTypeSelector />);
});
