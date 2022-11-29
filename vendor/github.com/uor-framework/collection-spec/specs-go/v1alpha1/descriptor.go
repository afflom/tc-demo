package v1alpha1

import (
	"encoding/json"

	digest "github.com/opencontainers/go-digest"
)

// Descriptor describes the disposition of targeted content.
type Descriptor struct {
	// MediaType is the media type of the object this schema refers to.
	MediaType string `json:"mediaType,omitempty"`

	// ArtifactType is the artifact type of the object this schema refers to.
	//
	// When the descriptor is used for blobs, this property must be empty.
	ArtifactType string `json:"artifactType,omitempty"`

	// Digest is the digest of the targeted content.
	Digest digest.Digest `json:"digest"`

	// Size specifies the size in bytes of the blob.
	Size int64 `json:"size"`

	// URLs specifies a list of URLs from which this object MAY be downloaded
	URLs []string `json:"urls,omitempty"`

	// Attributes contains typed attributes for this artifact.
	Attributes map[string]json.RawMessage `json:"attributes,omitempty"`

	// Annotations contains arbitrary metadata relating to the targeted content.
	Annotations map[string]string `json:"annotations,omitempty"`
}
