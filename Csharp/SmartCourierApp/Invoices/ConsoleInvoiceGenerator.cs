using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SmartCourierApp.Models;

namespace SmartCourierApp.Invoices
{
    public class ConsoleInvoiceGenerator : IInvoiceGenerator
    {
        public void GenerateInvoice(CourierBooking booking)
        {
            Console.WriteLine("Customer Name: "+booking.Customer.Name);
            Console.WriteLine("Source City: " + booking.SourceCity);
            Console.WriteLine("Destination City: " + booking.DestinationCity);
            Console.WriteLine("Parcel Weight: " + booking.Parcel.Weight);
            Console.WriteLine("Delivery Type: " + booking.DeliveryType);
            Console.WriteLine("Total Delivery Charge: " + booking.Charge);
        }
    }
}
