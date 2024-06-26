### How to efficiently construct serverless ETL tasks using AWS Glue
The knowledge of these AWS services is essential for data engineers who are building their data systems on AWS. As illustrated in the subsequent diagram.

![Data Engineer](https://github.com/mingyu110/Best-Practice/assets/48540798/c1269ae9-7f7c-41da-ad8c-b49c266a7626)


AWS Glue is a fully managed Extract, Transform, and Load (ETL) service that enables data registration, cleansing, enrichment, and reliable movement between various data stores.
The components of Glue encompass data catalog, crawlers and classifiers, ETL operations, as well as ETL job operation.
The AWS website provides comprehensive information on the topic at hand:[AWS Glue](https://docs.aws.amazon.com/glue/?icmpid=docs_homepage_analytics)
The advantages of Gule include：
- Focus on data : Low maintenance serverless solution
- Pay only per use : Avoid licensing cost and infrastructure ide time
- Powerful open source engines : No lock in, support from wide innovative ecosystem
- All in one : Support all your users and workloads

Batch ETL is well-suited for scenarios where historical data analysis, routine reporting, or resource optimization is paramount.

Streaming ETL excels in situations demanding real-time responses, immediate analysis of data, and quick decision-making.

The next step involves utilizing Terraform to construct a robust data pipeline, connecting S3 with Redshift on top of the Glue core service, while also considering secure isolation designs.
