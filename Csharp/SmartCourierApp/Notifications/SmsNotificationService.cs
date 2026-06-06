using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SmartCourierApp.Notifications
{
    public class SmsNotificationService : INotificationService
    {
        public void Send(string message)
        {
            Console.WriteLine("SMS: " + message);
        }
    }
}