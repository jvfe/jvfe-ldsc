//
// Check input samplesheet and get read channels
//

include { SAMPLESHEET_CHECK } from '../../modules/local/samplesheet_check'

workflow INPUT_CHECK {
    take:
    samplesheet // file: /path/to/samplesheet.csv

    main:
    samplesheet
        .splitCsv ( header:true, sep:',' )
        .map { it -> get_sample_info(it) }
        .set { sumstats }

    emit:
    sumstats                                     // channel: [ val(meta), [ reads ] ]
}

def get_sample_info(row) {
    def meta = [:]
    meta.id           = row.abbreviation

    def array = []
    array = [meta, row.url]

    return array
}
