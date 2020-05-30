using System.Collections.Generic;
using System.Linq;
using System.Text;
using Varigence.Biml.Extensions;
//test
public static class BIMLHelper
{
    public static string GetDataType(string strDataType, string CharLength, string NumPrecision, string NumScale, string DatePrecision)
    {

        string strResult = strDataType;

        if (strDataType == "int" || strDataType == "bigint" || strDataType == "geography" || strDataType == "varbinary" || strDataType == "date"
            )
            strResult += "";

        else if (!string.IsNullOrEmpty(CharLength))
            strResult += " (" + CharLength + ")";

        else if (!string.IsNullOrEmpty(NumScale) && NumScale != "0" && !string.IsNullOrEmpty(NumPrecision))
            strResult += " (" + NumPrecision + "," + NumScale + ")";

        else if (!string.IsNullOrEmpty(NumPrecision))
            strResult += " (" + NumPrecision + ")";

        else if (!string.IsNullOrEmpty(DatePrecision))
            strResult += " (" + DatePrecision + ")";

        return strResult;

    }
}