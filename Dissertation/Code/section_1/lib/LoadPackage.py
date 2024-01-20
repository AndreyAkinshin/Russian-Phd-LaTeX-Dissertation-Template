import importlib.util


def load_pkg(pkg_name, path):
    spec = importlib.util.spec_from_file_location(pkg_name, path)

    config = importlib.util.module_from_spec(spec)

    spec.loader.exec_module(config)

    return config
