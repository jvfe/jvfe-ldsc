process MUNGE {
    label 'process_medium'

    conda "conda-forge::python=3.8.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.8.3' :
        'quay.io/biocontainers/ldsc:1.0.1--pyhdfd78af_2' }"

    input:
    tuple val(meta), path(sumstats_ldsc)
    path(snplist)

    output:
    tuple val(meta), path("${meta.id}.sumstats.gz"), emit: munged_sumstats

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    munge_sumstats.py \\
        --sumstats $sumstats_ldsc \\
        --merge-alleles $snplist \\
        --out "${meta.id}" \\
        --chunksize 500000
    """
}
