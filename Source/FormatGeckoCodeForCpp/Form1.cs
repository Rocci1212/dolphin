namespace FormatGeckoCodeForCpp
{
  public partial class Form1 : Form
  {
    public Form1()
    {
      InitializeComponent();
    }

    private void button1_Click(object sender, EventArgs e)
    {
      var x = new char[] { ' ', '\n' };
      int i = 0;
      int j = 0;
      int maxSegments = 6;
      string result = "";
      foreach (string s in tbGeckoCode.Text.Split(x))
      {
        if (i == 0)
        {
          switch (s.Substring(0, 2))
          {
            case "C3":
              result = "0x81";
              break;
            default: // "80"
              result = "0x80";
              break;
          }
          result += s.Substring(2, 6) + ", 0, {";
        }
        else if (i > 1) // skip the second segment of the first line
        {
          if (s == "00000000") // ignore the filler
            break;
          else
          {
            j++;
            result += "0x" + s.Trim() + ", ";
            if (j == maxSegments)
            {
              result += Environment.NewLine +  "                      ";
              j = 0;
            }
          }
        }
        i++;
      }

      tbCppCode.Text = result;
    }
  }
}