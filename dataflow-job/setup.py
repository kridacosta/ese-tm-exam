import setuptools

setuptools.setup(
    name='mt_to_db',
    version='1.5.0',
    packages=setuptools.find_packages(),
    install_requires=[
        'apache-beam[gcp]',
        'sendgrid',
        'pyyaml',
        'google-cloud-pubsub',
    ],
    package_data={'': ['params.yaml']},
    include_package_data=True,
)
