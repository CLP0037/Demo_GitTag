using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

using System.Reflection;
using System.Diagnostics;
using System.Deployment.Application;

namespace Demo_GitTag
{
    public partial class VersionShow : Form
    {
        public VersionShow()
        {
            InitializeComponent();
        }

        private void VersionShow_Load(object sender, EventArgs e)
        {
            try
            {
                label1.Text = "";
                label2.Text = "";
                label3.Text = "";
                label5.Text = "";

                Assembly asm = Assembly.GetExecutingAssembly();
                FileVersionInfo fvi = FileVersionInfo.GetVersionInfo(asm.Location);

                label1.Text = "AssemblyVersion：" + System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();//+ "\n"
                label2.Text = "FileVersion：" + fvi.FileVersion;
                label3.Text = "ProductVersion：" + fvi.ProductVersion;
                if (fvi.ProductVersion.Contains("Modified"))
                    label3.ForeColor = Color.Red;

                label5.Text = DateTime.Now.ToShortDateString();
            }
            catch
            {

            }
        }
    }
}
