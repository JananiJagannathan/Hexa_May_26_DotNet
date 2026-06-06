using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartCourierApp.Models
{
    public class CourierBooking
    {
        public Customer Customer { get; set; }
        public Parcel Parcel { get; set; }
        public string SourceCity { get; set; }
        public string DestinationCity { get; set; }
        public string DeliveryType { get; set; }
        public double Charge { get; set; }
    }
}