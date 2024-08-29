app_lib_sources = files(
    'Lib.vala'
)

app_lib_dependencies = [
    global_dependencies
]

app_lib = static_library(
    meson.project_name(),
    sources: app_lib_sources,
    dependencies: app_lib_dependencies,
    install: false
)

app_lib_dep = declare_dependency(
    link_with: app_lib,
    include_directories: include_directories('.')
)