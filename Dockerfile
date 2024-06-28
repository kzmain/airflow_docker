FROM apache/airflow:2.9.2

RUN pip install build

# 1. Build and Install Apache Airflow Provider Packages with China Supportted
COPY ./airflow_kzmain/airflow/providers/microsoft/azure/ ./apache_airflow_providers_microsoft_azure/airflow/providers/microsoft/azure/
COPY ./apache_airflow_providers_microsoft_azure/ ./apache_airflow_providers_microsoft_azure/
# 1.2 Use 'root' permission to build the azure provider package
USER root
RUN cd /opt/airflow/apache_airflow_providers_microsoft_azure && python -m build
RUN chmod -R 777 /opt/airflow/apache_airflow_providers_microsoft_azure
USER 1001
# 1.2 Use normal user permission to install the azure provider package
RUN pip install apache_airflow_providers_microsoft_azure/dist/apache_airflow_providers_microsoft_azure-10.1.2-py3-none-any.whl