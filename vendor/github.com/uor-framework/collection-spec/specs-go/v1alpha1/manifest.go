package v1alpha1

import "encoding/json"

// Manifest provides a schema for UOR Collection.
type Manifest struct {
	// MediaType is the media type of the object this schema refers to.
	MediaType string `json:"mediaType"`

	// ArtifactType is the IANA media type of the artifact this schema refers to.
	ArtifactType string `json:"artifactType"`

	// Blobs is a collection of blobs referenced by this manifest.
	Blobs []Descriptor `json:"blobs,omitempty"`

	// Attributes contains typed attributes for this artifact.
	Attributes map[string]json.RawMessage `json:"attributes,omitempty"`

	// Links defines references to any manifest(s) for Collections that this Collection
	// is dependent on or relates to.
	// If the descriptor only contains attributes, the client should attempt to resolve
	// attributes to descriptor using the attributes API.
	Links []Descriptor `json:"links,omitempty"`

	// Annotations contains arbitrary metadata for the artifact manifest.
	Annotations map[string]string `json:"annotations,omitempty"`
}
