using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SmartCourierApp.DeliveryCalculators;

namespace SmartCourierApp.DeliveryCalculators
{
    public class ExpressDeliveryCalculator : IDeliveryChargeCalculator
    {
        public double CalculateCharge(double weight)
        {
            return weight * 80 + 100;
                    }
    }
}
