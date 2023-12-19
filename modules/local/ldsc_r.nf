process LDSC_R {
    label 'process_medium'

    conda "conda-forge::python=3.8.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.8.3' :
        'pegi3s/r_data-analysis:latest' }"

    input:
    tuple val(meta), path(sumstats)
    path(variants)

    output:
    path "${meta.id}_ldsc.tsv", emit: sumstats_ldsc

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    ldsc_sumstats.R \\
        $sumstats \\
        ${meta.id}_ldsc.tsv
    """
}
