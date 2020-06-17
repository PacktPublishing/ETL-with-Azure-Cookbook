#region References
using Microsoft.SqlServer.Dts.Pipeline;
using Microsoft.SqlServer.Dts.Pipeline.Wrapper;
using Microsoft.SqlServer.Dts.Runtime.Wrapper;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
#endregion

namespace EtlWithAzure
{
    /// <summary>
    /// Adds a column to the pipeline with the hash value computed from one or more pipeline columns specified at design time.
    /// </summary>
    [DtsPipelineComponentAttribute(
        ComponentType = ComponentType.Transform,
        DisplayName = "Row Hash",
        Description = "Generates a hash of selected columns in the pipeline row.",
        NoEditor = false,
        RequiredProductLevel = DTSProductLevel.DTSPL_NONE,
        CurrentVersion = 2
        )]
    public class RowHashTransformation : PipelineComponent
    {
        #region Private Constants
        private const Byte DEFAULT_BYTE = (Byte)0;
        private const String INPUT_NAME = "RowHashInput";
        private const String OUTPUT_NAME = "RowHashOutput";
        private const String ROW_HASH_COLUMN_NAME = "_RowHash";
        private const String IS_INTERNAL_CUSTOM_PROPERTY_NAME = "IsInternal";
        private const String NO_INPUT_MESSAGE = "At least one input must be connected.";
        private const String TOO_MANY_INPUTS_MESSAGE = "This transformation only supports a single input.";
        private const String TOO_MANY_OUTPUTS_MESSAGE = "This transformation only supports a single output.";
        private const String NO_INPUT_COLUMN_MESSAGE = "At least one input column must be selected.";
        private const String USER_COLUMNS_NOT_ALLOWED_MESSAGE = "User-defined output columns are not allowed.";
        private const String CANNOT_REMOVE_DEFAULT_OUTPUT_MESSAGE = "The default output cannot be removed.";
        private const String CANNOT_REMOVE_DEFAULT_OUTPUT_COLUMN_MESSAGE = "The built-in output column cannot be removed.";
        private const String COLUMN_ORDER_CUSTOM_PROPERTY_NAME = "Ordinal";
        private const String DUPLICATE_ORDINAL_VALUE_MESSAGE = "Ordinal values must be unique.\r\nDuplicate ordinal values encountered: {0}.";
        #endregion

        #region Private Variables
        private SortedList<Int32, IDTSInputColumn100> _columnCollection;
        #endregion

        #region Design-time Methods
        #region ProvideComponentProperties
        /// <summary>
        /// Initalizes a new instance of the RowHashTransformation.
        /// </summary>
        public override void ProvideComponentProperties()
        {
            base.ProvideComponentProperties();

            // Name the input.
            IDTSInput100 input = ComponentMetaData.InputCollection[0];
            input.Name = INPUT_NAME;

            // Create one synchronized output, and marks it as a built-in output, which cannot be removed.
            IDTSCustomProperty100 isInternal;
            IDTSOutput100 output = ComponentMetaData.OutputCollection[0];
            output.Name = OUTPUT_NAME;
            output.SynchronousInputID = ComponentMetaData.InputCollection[INPUT_NAME].ID;
            isInternal = output.CustomPropertyCollection.New();
            isInternal.Name = IS_INTERNAL_CUSTOM_PROPERTY_NAME;
            isInternal.State = DTSPersistState.PS_PERSISTASDEFAULT;
            isInternal.TypeConverter = typeof(Boolean).AssemblyQualifiedName;
            isInternal.Value = true;

            // Create the output column to hold the hash value, and marks it as a built-in output column, which cannot be removed.
            IDTSOutputColumn100 rowHashColumn = output.OutputColumnCollection.New();
            rowHashColumn.Name = ROW_HASH_COLUMN_NAME;
            // The size of a SHA1 hash value is 20 bytes.
            rowHashColumn.SetDataTypeProperties(DataType.DT_BYTES, 20, 0, 0, 0);
            isInternal = rowHashColumn.CustomPropertyCollection.New();
            isInternal.Name = IS_INTERNAL_CUSTOM_PROPERTY_NAME;
            isInternal.State = DTSPersistState.PS_PERSISTASDEFAULT;
            isInternal.TypeConverter = typeof(Boolean).AssemblyQualifiedName;
            isInternal.Value = true;
        }
        #endregion

        #region Validate
        /// <summary>
        /// Validates the component at design time, and at run time.
        /// </summary>
        /// <returns></returns>
        public override DTSValidationStatus Validate()
        {
            IDTSInput100 input = ComponentMetaData.InputCollection[INPUT_NAME];

            // At least one input must be available.
            if (input == null ||
                ComponentMetaData.InputCollection.Count == 0)
            {
                ComponentMetaData.FireWarning(0, ComponentMetaData.Name, NO_INPUT_MESSAGE, String.Empty, 0);
                return DTSValidationStatus.VS_ISBROKEN;
            }
            else
            {
                // Only a single input is supported.
                if (ComponentMetaData.InputCollection.Count > 1)
                {
                    ComponentMetaData.FireWarning(0, ComponentMetaData.Name, TOO_MANY_INPUTS_MESSAGE, String.Empty, 0);
                    return DTSValidationStatus.VS_ISBROKEN;
                }

                // At least one input column must be selected for the hash to be generated.
                if (input.InputColumnCollection.Count == 0)
                {
                    ComponentMetaData.FireWarning(0, ComponentMetaData.Name, NO_INPUT_COLUMN_MESSAGE, String.Empty, 0);
                    return DTSValidationStatus.VS_ISVALID;
                }
                else
                {
                    // Version 2: Each input column must have the Ordinal custom property.
                    foreach (IDTSInputColumn100 inputColumn in input.InputColumnCollection)
                    {
                        if (!this.InputColumnCustomPropertyExists(0, inputColumn.LineageID, COLUMN_ORDER_CUSTOM_PROPERTY_NAME))
                        {
                            return DTSValidationStatus.VS_NEEDSNEWMETADATA;
                        }
                    }

                    // Version 2: Ordinal values must uniquely identify each input column.
                    List<Int32> ordinals = new List<Int32>();
                    List<Int32> duplicateOrdinals = new List<Int32>();
                    foreach (IDTSInputColumn100 inputColumn in input.InputColumnCollection)
                    {
                        Int32 ordinal = (Int32)inputColumn.CustomPropertyCollection[COLUMN_ORDER_CUSTOM_PROPERTY_NAME].Value;
                        if (ordinals.Contains(ordinal))
                        {
                            duplicateOrdinals.Add(ordinal);
                        }
                        else
                        {
                            ordinals.Add(ordinal);
                        }
                    }

                    if (duplicateOrdinals.Count > 0)
                    {
                        Boolean cancel;
                        ComponentMetaData.FireError(0, ComponentMetaData.Name, String.Format(DUPLICATE_ORDINAL_VALUE_MESSAGE, String.Join(", ", duplicateOrdinals)), String.Empty, 0, out cancel);
                        return DTSValidationStatus.VS_ISBROKEN;
                    }
                }
            }

            // Only a single output is supported.
            if (ComponentMetaData.OutputCollection.Count > 1)
            {
                ComponentMetaData.FireWarning(0, ComponentMetaData.Name, TOO_MANY_OUTPUTS_MESSAGE, String.Empty, 0);
                return DTSValidationStatus.VS_ISBROKEN;
            }

            return base.Validate();
        }
        #endregion

        #region Events
        /// <summary>
        /// Responds to the input path being attached; automatically selects all input columns by default.
        /// Version 2: Creates missing input column custom properties.
        /// </summary>
        /// <param name="inputID"></param>
        public override void OnInputPathAttached(int inputID)
        {
            base.OnInputPathAttached(inputID);

            for (Int32 n = 0; n < ComponentMetaData.InputCollection.Count; n++)
            {
                ComponentMetaData.InputCollection[n].InputColumnCollection.RemoveAll();

                IDTSVirtualInput100 input = ComponentMetaData.InputCollection[n].GetVirtualInput();

                foreach (IDTSVirtualInputColumn100 inputColumn in input.VirtualInputColumnCollection)
                {
                    Int32 inputColumnLineageID = inputColumn.LineageID;
                    input.SetUsageType(inputColumnLineageID, DTSUsageType.UT_READONLY);

                    this.CreateInputColumnCustomProperties(n, inputColumnLineageID);
                }
            }

            this.Validate();
        }

        public override void OnInputPathDetached(int inputID)
        {
            this.Validate();
        }

        public override void OnOutputPathAttached(int outputID)
        {
            this.Validate();
        }

        public override void OnDeletingInputColumn(int inputID, int inputColumnID)
        {
            this.Validate();
        }
        #endregion

        #region Metadata
        public override IDTSInput100 InsertInput(DTSInsertPlacement insertPlacement, int inputID)
        {
            throw new NotSupportedException(TOO_MANY_INPUTS_MESSAGE);
        }

        public override IDTSOutput100 InsertOutput(DTSInsertPlacement insertPlacement, int outputID)
        {
            throw new NotSupportedException(TOO_MANY_OUTPUTS_MESSAGE);
        }

        public override IDTSOutputColumn100 InsertOutputColumnAt(int outputID, int outputColumnIndex, string name, string description)
        {
            throw new NotSupportedException(USER_COLUMNS_NOT_ALLOWED_MESSAGE);
        }

        public override void DeleteInput(int inputID)
        {
            throw new InvalidOperationException(NO_INPUT_MESSAGE);
        }

        /// <summary>
        /// Responds to the attempt to remove outputs at design time.
        /// </summary>
        /// <param name="outputID"></param>
        public override void DeleteOutput(int outputID)
        {
            Boolean isInternal = (Boolean)(ComponentMetaData
                .OutputCollection
                .GetObjectByID(outputID)
                .CustomPropertyCollection[IS_INTERNAL_CUSTOM_PROPERTY_NAME]
                .Value);

            if (isInternal)
            {
                throw new InvalidOperationException(CANNOT_REMOVE_DEFAULT_OUTPUT_MESSAGE);
            }
            else
            {
                base.DeleteOutput(outputID);
            }
        }

        /// <summary>
        /// Responds to the attempt to remove output columns at design time.
        /// </summary>
        /// <param name="outputID"></param>
        /// <param name="outputColumnID"></param>
        public override void DeleteOutputColumn(int outputID, int outputColumnID)
        {
            Boolean isInternal = (Boolean)(ComponentMetaData
                .OutputCollection
                .GetObjectByID(outputID)
                .OutputColumnCollection
                .GetObjectByID(outputColumnID)
                .CustomPropertyCollection[IS_INTERNAL_CUSTOM_PROPERTY_NAME]
                .Value);

            if (isInternal)
            {
                throw new InvalidOperationException(CANNOT_REMOVE_DEFAULT_OUTPUT_COLUMN_MESSAGE);
            }
            else
            {
                base.DeleteOutputColumn(outputID, outputColumnID);
            }
        }
        #endregion

        #region ReinitializeMetaData
        /// <summary>
        /// Version 2: Initializes component meta data; creates missing input column custom properties.
        /// </summary>
        public override void ReinitializeMetaData()
        {
            this.CreateInputCustomProperties();

            base.ReinitializeMetaData();
        }
        #endregion

        #region PerformUpgrade
        /// <summary>
        /// Version 2: Perform the upgrade from an earlier version; creates missing input column custom properties.
        /// </summary>
        /// <param name="pipelineVersion"></param>
        public override void PerformUpgrade(int pipelineVersion)
        {
            DtsPipelineComponentAttribute pipelineComponentAttribute = (DtsPipelineComponentAttribute)Attribute.GetCustomAttribute(this.GetType(), typeof(DtsPipelineComponentAttribute), false);
            Int32 componentLatestVersion = pipelineComponentAttribute.CurrentVersion;

            if (pipelineVersion < componentLatestVersion)
            {
                this.CreateInputCustomProperties();
            }

            ComponentMetaData.Version = componentLatestVersion;
        }
        #endregion
        #endregion

        #region Run-time Methods
        #region PreExecute
        /// <summary>
        /// Prepares private variables to be used during row processing.
        /// </summary>
        public override void PreExecute()
        {
            IDTSInput100 input = ComponentMetaData.InputCollection[INPUT_NAME];

            _columnCollection = new SortedList<Int32, IDTSInputColumn100>();
            foreach (IDTSInputColumn100 inputColumn in input.InputColumnCollection)
            {
                _columnCollection.Add((Int32)inputColumn.CustomPropertyCollection[COLUMN_ORDER_CUSTOM_PROPERTY_NAME].Value, inputColumn);
            }

            base.PreExecute();
        }
        #endregion

        #region ProcessInput
        /// <summary>
        /// Processes the only supported input.
        /// </summary>
        /// <param name="inputID"></param>
        /// <param name="buffer"></param>
        public override void ProcessInput(int inputID, PipelineBuffer buffer)
        {
            IDTSInput100 input = ComponentMetaData.InputCollection.GetObjectByID(inputID);
            IDTSOutput100 output = ComponentMetaData.OutputCollection[OUTPUT_NAME];

            IDTSOutputColumn100 rowHashColumn = output.OutputColumnCollection[ROW_HASH_COLUMN_NAME];
            Int32 rowHashColumnIndex = BufferManager.FindColumnByLineageID(input.Buffer, rowHashColumn.LineageID);

            // Processes each incoming pipeline row.
            while (buffer.NextRow())
            {
                List<Byte[]> columnBytesCollection = new List<Byte[]>();

                // Version 2: In the order of the input columns specified by the Ordinal custom property ...
                foreach (IDTSInputColumn100 inputColumn in _columnCollection.Values)
                {
                    Int32 inputColumnIndex = input.InputColumnCollection.GetObjectIndexByID(inputColumn.ID);

                    // ... retrieves the binary representation of the column value.
                    columnBytesCollection.Add(this.GetColumnValueBytes(buffer, inputColumn, inputColumnIndex));
                }

                // Writes the current row hash value to the built-in output column.
                buffer.SetBytes(rowHashColumnIndex, this.ComputeHash(columnBytesCollection));
            }
        }
        #endregion
        #endregion

        #region Private Methods
        /// <summary>
        /// Retrieves binary data from the given pipeline input column of any type.
        /// </summary>
        /// <param name="buffer"></param>
        /// <param name="inputColumn"></param>
        /// <param name="inputColumnIndex"></param>
        /// <returns></returns>
        private Byte[] GetColumnValueBytes(PipelineBuffer buffer, IDTSInputColumn100 inputColumn, Int32 inputColumnIndex)
        {
            if (buffer.IsNull(inputColumnIndex))
            {
                return new Byte[] { DEFAULT_BYTE };
            }
            else
            {
                switch (inputColumn.DataType)
                {
                    case DataType.DT_TEXT:
                    case DataType.DT_NTEXT:
                    case DataType.DT_IMAGE:
                        return buffer.GetBlobData(inputColumnIndex, 0, inputColumn.Length);
                    case DataType.DT_BYTES:
                        return buffer.GetBytes(inputColumnIndex);
                    case DataType.DT_STR:
                    case DataType.DT_WSTR:
                        return Encoding.Unicode.GetBytes(buffer.GetString(inputColumnIndex));
                    case DataType.DT_BOOL:
                        return Encoding.Unicode.GetBytes(buffer.GetBoolean(inputColumnIndex).ToString());
                    case DataType.DT_DBDATE:
                        return Encoding.Unicode.GetBytes(buffer.GetDate(inputColumnIndex).ToString());
                    case DataType.DT_DBTIMESTAMP:
                    case DataType.DT_DBTIMESTAMP2:
                    case DataType.DT_FILETIME:
                        return Encoding.Unicode.GetBytes(buffer.GetDateTime(inputColumnIndex).ToString());
                    case DataType.DT_DBTIME:
                    case DataType.DT_DBTIME2:
                        return Encoding.Unicode.GetBytes(buffer.GetTime(inputColumnIndex).ToString());
                    case DataType.DT_DBTIMESTAMPOFFSET:
                        return Encoding.Unicode.GetBytes(buffer.GetDateTimeOffset(inputColumnIndex).ToString());
                    case DataType.DT_CY:
                    case DataType.DT_DECIMAL:
                    case DataType.DT_NUMERIC:
                        return Encoding.Unicode.GetBytes(buffer.GetDecimal(inputColumnIndex).ToString());
                    case DataType.DT_I1:
                        return Encoding.Unicode.GetBytes(buffer.GetSByte(inputColumnIndex).ToString());
                    case DataType.DT_I2:
                        return Encoding.Unicode.GetBytes(buffer.GetInt16(inputColumnIndex).ToString());
                    case DataType.DT_I4:
                        return Encoding.Unicode.GetBytes(buffer.GetInt32(inputColumnIndex).ToString());
                    case DataType.DT_I8:
                        return Encoding.Unicode.GetBytes(buffer.GetInt64(inputColumnIndex).ToString());
                    case DataType.DT_UI1:
                        return Encoding.Unicode.GetBytes(buffer.GetByte(inputColumnIndex).ToString());
                    case DataType.DT_UI2:
                        return Encoding.Unicode.GetBytes(buffer.GetUInt16(inputColumnIndex).ToString());
                    case DataType.DT_UI4:
                        return Encoding.Unicode.GetBytes(buffer.GetUInt32(inputColumnIndex).ToString());
                    case DataType.DT_UI8:
                        return Encoding.Unicode.GetBytes(buffer.GetUInt64(inputColumnIndex).ToString());
                    case DataType.DT_R4:
                        return Encoding.Unicode.GetBytes(buffer.GetSingle(inputColumnIndex).ToString());
                    case DataType.DT_R8:
                        return Encoding.Unicode.GetBytes(buffer.GetDouble(inputColumnIndex).ToString());
                    case DataType.DT_GUID:
                        return Encoding.Unicode.GetBytes(buffer.GetGuid(inputColumnIndex).ToString());
                    default:
                        return new Byte[] { DEFAULT_BYTE };
                }
            }
        }

        /// <summary>
        /// Computes a SHA1 hash value from the supplied binary array.
        /// </summary>
        /// <param name="columnBytesCollection"></param>
        /// <returns></returns>
        private Byte[] ComputeHash(List<Byte[]> columnBytesCollection)
        {
            Byte[] result;

            // Writes the binary array to a memory stream, ...
            using (MemoryStream composite = new MemoryStream())
            {
                foreach (Byte[] columnBytes in columnBytesCollection)
                {
                    foreach (Byte columnByte in columnBytes)
                    {
                        composite.WriteByte(columnByte);
                    }
                }
                composite.Flush();

                // ... and computes the hash value.
                using (SHA1Managed algorithm = new SHA1Managed())
                {
                    result = algorithm.ComputeHash(composite.GetBuffer());
                }
            }

            return result ?? (new Byte[] { DEFAULT_BYTE });
        }

        /// <summary>
        /// Checks whether the given input column of the given input contains a custom property of the given name.
        /// </summary>
        /// <param name="inputIndex"></param>
        /// <param name="inputColumnLineageID"></param>
        /// <param name="customPropertyName"></param>
        /// <returns>True ... the custom property exists, false ... the custom property does not exist.</returns>
        private Boolean InputColumnCustomPropertyExists(int inputIndex, int inputColumnLineageID, String customPropertyName)
        {
            Boolean result = false;

            foreach (IDTSCustomProperty100 customProperty in ComponentMetaData
                .InputCollection[inputIndex]
                .InputColumnCollection
                .GetInputColumnByLineageID(inputColumnLineageID)
                .CustomPropertyCollection)
            {
                if (customProperty.Name == customPropertyName)
                {
                    result = true;
                    break;
                }
            }

            return result;
        }

        /// <summary>
        /// Creates all relevant input custom properties.
        /// </summary>
        private void CreateInputCustomProperties()
        {
            IDTSInput100 input = ComponentMetaData.InputCollection[INPUT_NAME];

            foreach (IDTSInputColumn100 inputColumn in input.InputColumnCollection)
            {
                this.CreateInputColumnCustomProperties(0, inputColumn.LineageID);
            }
        }

        /// <summary>
        /// Creates all relevant input column custom properties.
        /// </summary>
        /// <param name="inputIndex"></param>
        /// <param name="inputColumnLineageID"></param>
        private void CreateInputColumnCustomProperties(int inputIndex, int inputColumnLineageID)
        {
            if (!this.InputColumnCustomPropertyExists(inputIndex, inputColumnLineageID, COLUMN_ORDER_CUSTOM_PROPERTY_NAME))
            {
                IDTSCustomProperty100 ordinal = ComponentMetaData
                    .InputCollection[inputIndex]
                    .InputColumnCollection
                    .GetInputColumnByLineageID(inputColumnLineageID)
                    .CustomPropertyCollection
                    .New();
                ordinal.Name = COLUMN_ORDER_CUSTOM_PROPERTY_NAME;
                ordinal.State = DTSPersistState.PS_PERSISTASDEFAULT;
                ordinal.TypeConverter = typeof(Int32).AssemblyQualifiedName;
                ordinal.Value = inputColumnLineageID;
            }
        }
        #endregion
    }
}
