import React from "react";
import NoPayType from "./NoPayType";
import CreditCardPayType from "./CreditCardPayType";
import CheckPayType from "./CheckPayType";
import PurchaseOrderPaytype from "./PurchaseOrderPayType";

class PayTypeSelector extends React.Component {
  constructor(props) {
    super(props);
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
    this.state = { selectedPayType: null };
  }
  onPayTypeSelected(event) {
    this.setState({ selectedPayType: event.target.value });
  }
  render() {
    let PayTypeCustomComponent = NoPayType;
    if (this.state.selectedPayType == "Credit card") {
      PayTypeCustomComponent = CreditCardPayType;
    } else if (this.state.selectedPayType == "Check") {
      PayTypeCustomComponent = CheckPayType;
    } else if (this.state.selectedPayType == "Purchase order") {
      PayTypeCustomComponent = PurchaseOrderPaytype;
    }
    return (
      <div>
        <div className="field">
          <label htmlFor="order_pay_type">Pay type</label>
          <select
            id="order_pay_type"
            onChange={this.onPayTypeSelected}
            name="order[pay_type]"
          >
            <option value="">Select a payment method</option>
            <option value="Check">Check</option>
            <option value="Credit card">Credit card</option>
            <option value="Purchase order">Purchase order</option>
          </select>
        </div>
      </div>
    );
  }
}

export default PayTypeSelector;