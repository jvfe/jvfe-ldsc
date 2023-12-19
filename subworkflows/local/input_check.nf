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
        .map { get_sample_info(it) }
        .set { sumstats }

    emit:
    sumstats                                     // channel: [ val(meta), [ reads ] ]
}

def get_sample_info(row) {

    def array = []
    if (!file(row.url).exists()) {
        print("***")
        print(row.url)
        print("***")
        exit 1, "ERROR: Please check input samplesheet -> No URL"
    }
    array = [row.abbreviation, row.url]

    return array
}
