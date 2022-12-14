package cyclonedxjson

import (
	"github.com/CycloneDX/cyclonedx-go"

	"github.com/anchore/syft/syft/formats/common/cyclonedxhelpers"
	"github.com/anchore/syft/syft/sbom"
)

const ID sbom.FormatID = "cyclonedx-1-json"

func Format() sbom.Format {
	return sbom.NewFormat(
		ID,
		encoder,
		cyclonedxhelpers.GetDecoder(cyclonedx.BOMFileFormatJSON),
		cyclonedxhelpers.GetValidator(cyclonedx.BOMFileFormatJSON),
	)
}
