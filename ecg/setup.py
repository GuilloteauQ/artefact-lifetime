from setuptools import setup

setup(
    # Application name:
    name="ecg",

    # Version number (initial):
    version="0.0.1",

    # Application author details:
    author="Quentin Guilloteau",
    author_email="Quentin.Guilloteau@univ-grenoble-alpes.fr",

    # Packages
    packages=["app"],

    # Include additional files into the package
    # include_package_data=True,
    entry_points={
        'console_scripts': ['ecg=app.ecg:main'],
    },

    # Details
    url="https://github.com/GuilloteauQ/artefact-lifetime",

    #
    # license="LICENSE.txt",
    description="Check if a project still builds or not",

    # long_description=open("README.txt").read(),

    # Dependent packages (distributions)
    install_requires=[
    ],
    
    include_package_data=True,
)
