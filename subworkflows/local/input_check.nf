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

    emit:
    reads                                     // channel: [ val(meta), [ reads ] ]
    versions = SAMPLESHEET_CHECK.out.versions // channel: [ versions.yml ]
}

def get_sample_info(row) {

    def array = []
    if (!file(row.url).exists()) {
        print("***")
        print(rowurl)
        print("***")
        exit 1, "ERROR: Please check input samplesheet -> No URL"
    }
    array = [ file(row)]

    return array
}
