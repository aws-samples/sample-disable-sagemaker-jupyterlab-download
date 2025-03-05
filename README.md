# Disable SageMaker JupyterLab Download

An AWS SageMaker AI lifecycle configuration script to disable download capabilities in an isolated/secured AWS SageMaker JupyterLab environment.

## Overview

This solution provides an AWS SageMaker AI lifecycle configuration script that disables download functionality in SageMaker JupyterLab environments, enhancing security in isolated or restricted JupyterLab environments.

## Features

- Disables download capabilities in JupyterLab interface, by disabling the following JupyterLab extensions:
    - `@jupyterlab/docmanager-extension:download`
    - `@jupyterlab/filebrowser-extension:download`
    - `@jupyterlab/filebrowser-extension:open-browser-tab`    
- Supports isolated/airgapped SageMaker JupyterLab environments
- Enhances security compliance for sensitive data environments

## Prerequisites

- An AWS SageMaker AI domain
- IAM permissions to create/modify SageMaker AI lifecycle configurations
- Basic understanding of SageMaker lifecycle scripts

## Configuration

1. [Create a new Lifecycle Configuration in SageMaker AI](https://docs.aws.amazon.com/sagemaker/latest/dg/jl-lcc-create.html#jl-lcc-create-console)
2. Copy the contents of the [lifecycle-config.sh](lifecycle-config.sh) into the lifecycle configuration's Scripts field
3. This lifecycle configuration can be attached at two levels:
    - Domain: Applies to all user profiles in the SageMaker AI domain
    - User profile: Applies to specific user profiles
4. When [creating a SageMaker AI JupyterLab space](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-updated-jl-user-guide-create-space.html), specify the lifecycle configuration in the Space Settings


## Verification

After enabling the lifecycle configuration, verify that the download capabilities are disabled by attempting the following actions in your SageMaker JupyterLab interface:

1. File Browser Panel:
   - Right-click any file --> "Download" option should be unavailable
   - Right-click any file --> "Open in Browser Tab" option should be unavailable

2. Top Menu Bar:
   - File --> Download option should be disabled or hidden

If any of these actions remain available, please refer to the Debugging section below.

## Debugging

The script of this lifecycle configuration logs debug information to CloudWatch logs. 
Navigate to CloudWatch Logs:
   - Log group: `/aws/sagemaker/studio`
   - Log stream pattern: `[domain-id]/[space-name]/JupyterLab/default/LifecycleConfigOnStart`


## Contributing

Contributions are welcome! Please read the [code of conduct](CODE_OF_CONDUCT.md) and the [contributing guidelines](CONTRIBUTING.md).

## License

This library is licensed under the  MIT-0 license. See the [LICENSE](LICENSE.md) file.

## Authors

[Kai Xu](https://github.com/kaix-aws)
