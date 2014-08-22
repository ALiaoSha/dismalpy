from __future__ import division, print_function, absolute_import

def configuration(parent_package='', top_path=None):
    from numpy.distutils.misc_util import Configuration, get_info

    config = Configuration('ssm', parent_package, top_path)

    info = get_info("npymath")
    config.add_extension('_statespace',
                         include_dirs=['dismalpy/src'],
                         sources=['_statespace.c'], extra_info=info)
    config.add_data_dir('tests')

    config.make_config_py()
    return config

if __name__ == '__main__':
    from numpy.distutils.core import setup
    setup(**configuration(top_path='').todict())