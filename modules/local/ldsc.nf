process LDSC {
    label 'process_medium'

    conda "conda-forge::python=3.8.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.8.3' :
        'quay.io/biocontainers/ldsc:1.0.1--pyhdfd78af_2' }"

    input:
    tuple val(meta), path(sumstats_ldsc)
    path(depression)
    path(european_ref)
    path(weights)

    output:
    path "${meta.id}_dep.log", emit: ldsc_log

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    ldsc.py --rg $depression,$sumstats_ldsc \\
        --ref-ld-chr $european_ref/ \\
        --w-ld-chr $weights/ \\
        --out "${meta.id}_dep"
    """
}
