using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SmartCourierApp.Models;
using SmartCourierApp.Notifications;
using SmartCourierApp.Invoices;
using SmartCourierApp.DeliveryCalculators;

namespace SmartCourierApp.Services
{
    public class CourierBookingService
    {
        private readonly IDeliveryChargeCalculator calculator;
        private readonly INotificationService notification;
        private readonly IInvoiceGenerator invoice;

        public CourierBookingService(
            IDeliveryChargeCalculator calculator,
            INotificationService notification,
            IInvoiceGenerator invoice)
        {
            this.calculator = calculator;
            this.notification = notification;
            this.invoice = invoice;
        }

        public void BookCourier(CourierBooking booking)
        {
            booking.Charge =
                calculator.CalculateCharge(booking.Parcel.Weight);

            notification.Send("Courier Booked Successfully");

            invoice.GenerateInvoice(booking);
        }
    }
}