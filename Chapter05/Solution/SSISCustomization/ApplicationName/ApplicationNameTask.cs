#region References
using Microsoft.SqlServer.Dts.Runtime;
using System;
using System.Collections.Generic;
using System.Data.Common;
#endregion

namespace EtlWithAzure
{
    #region ApplicationNameTask
    /// <summary>
    /// Adds the application name to the connection string of each supported connection manager.
    /// </summary>
    [DtsTaskAttribute(
        Description = "Assign SSIS Package Name as Application Name to Connection Strings.",
        DisplayName = "Application Name",
        TaskType = "Application Name Task",
        RequiredProductLevel = DTSProductLevel.None
        )]
    public class ApplicationNameTask : Task
    {
        #region Private Constants
        private const String SYSTEM_NAMESPACE = "System";
        private const String NAMESPACE_DELIMITER = "::";
        private const String DOUBLE_QUOTE = "\"";
        private const String PACKAGE_NAME_VARIABLE_NAME = "PackageName";
        private const String PACKAGE_NAME_QUALIFIED_VARIABLE_NAME = SYSTEM_NAMESPACE + NAMESPACE_DELIMITER + PACKAGE_NAME_VARIABLE_NAME;
        private const String TASK_NAME_VARIABLE_NAME = "TaskName";
        private const String TASK_NAME_QUALIFIED_VARIABLE_NAME = SYSTEM_NAMESPACE + NAMESPACE_DELIMITER + TASK_NAME_VARIABLE_NAME;
        private const String COULD_NOT_RESOLVE_SYSTEM_VARIABLE_MESSAGE = "Could not resolve one or more system variables.\r\n\r\n";
        private const String USER_NAME_KEY = "UserName";
        private const String CONNECTION_STRING_KEY = "ConnectionString";
        private const String UNRESOLVED_APPLICATION_NAME_MESSAGE = "The default Application Name could not be resolved.";
        private const String SUPPORTED_CONNECTION_MANAGER_NAME_MESSAGE = "Supported Connection Manager name: {0}";
        private const String UNSUPPORTED_CONNECTION_MANAGER_NAME_MESSAGE = "Unsupported Connection Manager name: {0}";
        private const String ORIGINAL_CONNECTION_STRING_MESSAGE = "Original Connection Manager connection string: {0}";
        private const String ENHANCED_CONNECTION_STRING_MESSAGE = "Modified Connection Manager connection string: {0}";
        #endregion

        #region Private Variables
        private String _taskName;
        private String _defaultApplicationName;
        private String _applicationName;

        private static Dictionary<String, ConnectionManagerType> _connectionManagerTypeRules;
        /// <summary>
        /// A set of rules used to determine the type of a connection manager.
        /// </summary>
        private static Dictionary<String, ConnectionManagerType> ConnectionManagerTypeRules
        {
            get
            {
                if (_connectionManagerTypeRules == null)
                {
                    _connectionManagerTypeRules = new Dictionary<String, ConnectionManagerType>
                    {
                        {
                            "OLEDB",
                            ConnectionManagerType.OleDb
                        },
                        {
                            "ADO.NET",
                            ConnectionManagerType.AdoNet
                        },
                        {
                            "ODBC",
                            ConnectionManagerType.ODBC
                        }
                    };
                }
                return _connectionManagerTypeRules;
            }
        }
        #endregion

        #region Public Members
        /// <summary>
        /// Holds a user-defined application name to be used in the connection string.
        /// </summary>
        public String ApplicationName { get; set; }

        /// <summary>
        /// Determines the behaviour of the task:
        /// - true ... information messages are emitted at run time;
        /// - false ... information messages are not emitted.
        /// </summary>
        public Boolean IsVerbose { get; set; }
        #endregion

        #region Design-time Methods
        #region InitializeTask
        /// <summary>
        /// Initializes a new instance of the task at design time.
        /// </summary>
        /// <param name="connections"></param>
        /// <param name="variableDispenser"></param>
        /// <param name="events"></param>
        /// <param name="log"></param>
        /// <param name="eventInfos"></param>
        /// <param name="logEntryInfos"></param>
        /// <param name="refTracker"></param>
        public override void InitializeTask(Connections connections, VariableDispenser variableDispenser, IDTSInfoEvents events, IDTSLogging log, EventInfos eventInfos, LogEntryInfos logEntryInfos, ObjectReferenceTracker refTracker)
        {
            // Initialize public members.
            this.ApplicationName = String.Empty;
            this.IsVerbose = true;

            // Retrieve system variables.
            this.ResolveSystemVariables(ref variableDispenser);

            base.InitializeTask(connections, variableDispenser, events, log, eventInfos, logEntryInfos, refTracker);
        }
        #endregion

        #region Validate
        /// <summary>
        /// Validates the task and its settings at desing time, and at run time.
        /// </summary>
        /// <param name="connections"></param>
        /// <param name="variableDispenser"></param>
        /// <param name="componentEvents"></param>
        /// <param name="log"></param>
        /// <returns></returns>
        public override DTSExecResult Validate(Connections connections, VariableDispenser variableDispenser, IDTSComponentEvents componentEvents, IDTSLogging log)
        {
            if (String.IsNullOrEmpty(_defaultApplicationName))
            {
                componentEvents.FireError(0, _taskName, UNRESOLVED_APPLICATION_NAME_MESSAGE, String.Empty, 0);
                return DTSExecResult.Failure;
            }

            return DTSExecResult.Success;
        }
        #endregion
        #endregion

        #region Run-time Methods
        #region Execute
        /// <summary>
        /// Performs the task work at run time.
        /// </summary>
        /// <param name="connections"></param>
        /// <param name="variableDispenser"></param>
        /// <param name="componentEvents"></param>
        /// <param name="log"></param>
        /// <param name="transaction"></param>
        /// <returns></returns>
        public override DTSExecResult Execute(Connections connections, VariableDispenser variableDispenser, IDTSComponentEvents componentEvents, IDTSLogging log, object transaction)
        {
            try
            {
                this.ResolveSystemVariables(ref variableDispenser);
                _applicationName = this.GetApplicationName();

                // Traverse all connection managers, ...
                foreach (ConnectionManager connection in connections)
                {
                    // ... and determine the connection manager type.
                    ConnectionManagerType connectionManagerType = this.GetConnectionManagerType(connection);

                    // If the connection manager type is supported, ...
                    if (connectionManagerType == ConnectionManagerType.Unsupported)
                    {
                        if (this.IsVerbose)
                        {
                            this.FireInformation(ref componentEvents, String.Format(UNSUPPORTED_CONNECTION_MANAGER_NAME_MESSAGE, connection.Name));
                        }
                    }
                    else
                    {
                        if (this.IsVerbose)
                        {
                            this.FireInformation(ref componentEvents, String.Format(SUPPORTED_CONNECTION_MANAGER_NAME_MESSAGE, connection.Name));
                            this.FireInformation(ref componentEvents, String.Format(ORIGINAL_CONNECTION_STRING_MESSAGE, connection.ConnectionString));
                        }

                        // ... get the connection string with the application name argument.
                        String enhancedConnectionString = this.GetEnhancedConnectionString(connection.ConnectionString, connectionManagerType);

                        // If the connection string is supplied through an expression, ...
                        if (connection.HasExpressions &&
                            !String.IsNullOrEmpty(connection.GetExpression(CONNECTION_STRING_KEY)))
                        {
                            // ... replace the connection string expression; ...
                            connection.SetExpression(CONNECTION_STRING_KEY, String.Concat(DOUBLE_QUOTE, enhancedConnectionString, DOUBLE_QUOTE));

                            if (this.IsVerbose)
                            {
                                this.FireInformation(ref componentEvents, String.Format(ENHANCED_CONNECTION_STRING_MESSAGE, connection.GetExpression(CONNECTION_STRING_KEY)));
                            }
                        }
                        else
                        {
                            // ... otherwise, replace the connection string.
                            connection.ConnectionString = enhancedConnectionString;

                            if (this.IsVerbose)
                            {
                                this.FireInformation(ref componentEvents, String.Format(ENHANCED_CONNECTION_STRING_MESSAGE, connection.ConnectionString));
                            }
                        }
                    }
                }

                return DTSExecResult.Success;
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        #endregion

        #region Private Methods
        /// <summary>
        /// Resolves system variables, and assigns their values to local variables for later use.
        /// </summary>
        /// <param name="variableDispenser"></param>
        private void ResolveSystemVariables(ref VariableDispenser variableDispenser)
        {
            Variables variables = null;

            try
            {
                variableDispenser.LockForRead(TASK_NAME_QUALIFIED_VARIABLE_NAME);
                variableDispenser.LockForRead(PACKAGE_NAME_QUALIFIED_VARIABLE_NAME);

                variableDispenser.GetVariables(ref variables);

                if (variables.Contains(TASK_NAME_VARIABLE_NAME))
                {
                    _taskName = variables[TASK_NAME_QUALIFIED_VARIABLE_NAME].Value.ToString();
                }

                if (variables.Contains(PACKAGE_NAME_VARIABLE_NAME))
                {
                    _defaultApplicationName = variables[PACKAGE_NAME_QUALIFIED_VARIABLE_NAME].Value.ToString();
                }
            }
            catch (Exception exc)
            {
                throw new Exception(COULD_NOT_RESOLVE_SYSTEM_VARIABLE_MESSAGE, exc.InnerException);
            }
            finally
            {
                if (variables.Locked)
                {
                    variables.Unlock();
                }
            }
        }

        /// <summary>
        /// Retrieves the application name.
        /// If the name is not supplied through the ApplicationName property, it uses the default value (that is, the SSIS package name).
        /// </summary>
        /// <returns></returns>
        private String GetApplicationName()
        {
            return !String.IsNullOrEmpty(this.ApplicationName) ? this.ApplicationName : _defaultApplicationName;
        }

        /// <summary>
        /// Uses the rules specified in the ConnectionManagerTypeRules variable to determine the connection manager type.
        /// </summary>
        /// <param name="connection"></param>
        /// <returns></returns>
        private ConnectionManagerType GetConnectionManagerType(ConnectionManager connection)
        {
            ConnectionManagerType result = ConnectionManagerType.Unsupported;
            String creationName = connection.CreationName;

            // Use the rules in the ConnectionManagerTypeRules variable ...
            foreach (var rule in ConnectionManagerTypeRules)
            {
                // ... to determine whether the connection manager is supported.
                if (creationName.StartsWith(rule.Key))
                {
                    // If the connection string contains user credentials, resolve the connection manager as unsupported; ...
                    if (!String.IsNullOrEmpty(connection.Properties[USER_NAME_KEY].GetValue(connection)?.ToString()))
                    {
                        break;
                    }
                    else
                    {
                        // ... otherwise, return tha actual connection manager type.
                        result = rule.Value;
                        break;
                    }
                }
            }

            return result;
        }

        /// <summary>
        /// Adds the application name argument to a connection string of a supported connection manager type.
        /// </summary>
        /// <param name="connectionString"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        private String GetEnhancedConnectionString(String connectionString, ConnectionManagerType type)
        {
            // Create a new database connection string builder, and initialize it with the supplied connection string.
            DbConnectionStringBuilder connectionStringBuilder = new DbConnectionStringBuilder(type == ConnectionManagerType.ODBC)
            {
                ConnectionString = connectionString
            };

            // If the connection manager is supported and the application name is available, ...
            if (type != ConnectionManagerType.Unsupported &&
                !String.IsNullOrEmpty(_applicationName))
            {
                // ... determine the application name connection string argument name, ...
                String applicationNameKey;
                switch (type)
                {
                    case ConnectionManagerType.OleDb:
                    case ConnectionManagerType.ODBC:
                        applicationNameKey = "APP";
                        break;
                    case ConnectionManagerType.AdoNet:
                    default:
                        applicationNameKey = "Application Name";
                        break;
                }
                // ... and add the application name argument to the connection string builder.
                connectionStringBuilder.Add(applicationNameKey, _applicationName);
            }

            // Return the enhanced connection string.
            return connectionStringBuilder.ConnectionString;
        }

        /// <summary>
        /// Emits an informational message at run time.
        /// </summary>
        /// <param name="componentEvents"></param>
        /// <param name="message"></param>
        private void FireInformation(ref IDTSComponentEvents componentEvents, String message)
        {
            Boolean fireAgain = true;
            componentEvents.FireInformation(0, _taskName, message, String.Empty, 0, ref fireAgain);
        }
        #endregion
    }
    #endregion

    #region ConnectionManagerType
    /// <summary>
    /// Supported Connection Manager types.
    /// If you extend the support, you must also provide:
    /// - New rules to the switch command in GetEnhancedConnectionString;
    /// - New rules in the ConnectionManagerTypeRules private variable definition.
    /// </summary>
    internal enum ConnectionManagerType : Byte
    {
        Unsupported = 0,
        OleDb = 1,
        AdoNet = 2,
        ODBC = 3
    }
    #endregion
}
