using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SmartCourierApp.Models;
using SmartCourierApp.DeliveryCalculators;
using SmartCourierApp.Notifications;
using SmartCourierApp.Invoices;
using SmartCourierApp.Services;

namespace SmartCourierApp
{
    class Program
    {
        static void Main(string[] args)
        {
            Customer customer = new Customer();
            Console.Write("Enter Name: ");
            customer.Name = Console.ReadLine();
            Console.Write("Enter Email: ");
            customer.Email = Console.ReadLine();
            Console.Write("Enter Mobile: ");
            customer.Mobile = Console.ReadLine();
            Parcel parcel = new Parcel();
            Console.Write("Enter Weight: ");
            parcel.Weight = Convert.ToDouble(Console.ReadLine());
            Console.Write("Source City: ");
            string source = Console.ReadLine();
            Console.Write("Destination City: ");
            string destination = Console.ReadLine();
            Console.Write("Delivery Type (Standard/Express/International): ");
            string deliveryType = Console.ReadLine();
            Console.Write("Notification Type (Email/SMS/WhatsApp): ");
            string notificationType = Console.ReadLine();

            IDeliveryChargeCalculator calculator;

            if (deliveryType.ToLower() == "express")
                calculator = new ExpressDeliveryCalculator();
            else if (deliveryType.ToLower() == "international")
                calculator = new InternationalDeliveryCalculator();
            else
                calculator = new StandardDeliveryCalculator();

            INotificationService notification;

            if (notificationType.ToLower() == "sms")
                notification = new SmsNotificationService();
            else if (notificationType.ToLower() == "whatsapp")
                notification = new WhatsAppNotificationService();
            else
                notification = new EmailNotificationService();

            CourierBooking booking = new CourierBooking
            {
                Customer = customer,
                Parcel = parcel,
                SourceCity = source,
                DestinationCity = destination,
                DeliveryType = deliveryType
            };

            CourierBookingService service = new CourierBookingService(calculator, notification, new ConsoleInvoiceGenerator());

            service.BookCourier(booking);
            Console.ReadKey();
        }
    }
}
