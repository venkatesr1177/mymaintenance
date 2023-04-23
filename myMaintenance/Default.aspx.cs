using NAM.Common;
using System;
using System.Web.UI;

namespace myMaintenance
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var objEmployee = new Employee { 
                Id =1,
                Name = "Demo"
            };
            Response.Write("Id: " + objEmployee.Id);
            Response.Write("Name: " + objEmployee.Name);
        }
    }
}