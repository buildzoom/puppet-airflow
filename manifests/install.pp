# == Class: airflow::install
# == Description: Install airflow python package using pip.
#
class airflow::install inherits airflow {
	# Create virtualenv for airflow
	ensure_resource(
		python::virtualenv,
		$airflow::virtualenv,
		{
			ensure       => present,
			version      => 'system',
			systempkgs   => true,
			venv_dir     => "/home/${airflow::user}/${airflow::virtualenv}",
			owner        => $airflow::user,
			group        => $airflow::group,
		}
	)

	# Install airflow python package
	ensure_resource(
		python::pip,
		$airflow::package_name,
		{
			pkgname => "${airflow::package_name}[mysql]",
			virtualenv => "/home/${airflow::user}/${airflow::virtualenv}",
			ensure => $airflow::version,
			owner => $airflow::user
		}
	)
}
