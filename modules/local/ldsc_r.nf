process LDSC_R {
    label 'process_medium'

    conda "conda-forge::python=3.8.3"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/python:3.8.3' :
        'docker.io/pegi3s/r_data-analysis:4.1.1_v3' }"

    input:
    tuple val(meta), path(sumstats)
    path(variants)

    output:
    tuple val(meta), path("${meta.id}_ldsc.tsv"), emit: sumstats_ldsc

    when:
    task.ext.when == null || task.ext.when

    script:
    """
    ldsc_sumstats_setup.R \\
        $sumstats \\
        $variants \\
        ${meta.id}_ldsc.tsv
    """
}
