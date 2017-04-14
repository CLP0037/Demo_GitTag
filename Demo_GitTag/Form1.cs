using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Demo_GitTag
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void 版本信息ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            VersionShow fm1 = new VersionShow();
            fm1.Show();
        }


    }
}
