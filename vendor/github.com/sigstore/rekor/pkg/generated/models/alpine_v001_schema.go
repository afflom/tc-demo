// Code generated by go-swagger; DO NOT EDIT.

//
// Copyright 2021 The Sigstore Authors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

package models

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"context"
	"encoding/json"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/strfmt"
	"github.com/go-openapi/swag"
	"github.com/go-openapi/validate"
)

// AlpineV001Schema Alpine v0.0.1 Schema
//
// # Schema for Alpine Package entries
//
// swagger:model alpineV001Schema
type AlpineV001Schema struct {

	// package
	// Required: true
	Package *AlpineV001SchemaPackage `json:"package"`

	// public key
	// Required: true
	PublicKey *AlpineV001SchemaPublicKey `json:"publicKey"`
}

// Validate validates this alpine v001 schema
func (m *AlpineV001Schema) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validatePackage(formats); err != nil {
		res = append(res, err)
	}

	if err := m.validatePublicKey(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *AlpineV001Schema) validatePackage(formats strfmt.Registry) error {

	if err := validate.Required("package", "body", m.Package); err != nil {
		return err
	}

	if m.Package != nil {
		if err := m.Package.Validate(formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("package")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("package")
			}
			return err
		}
	}

	return nil
}

func (m *AlpineV001Schema) validatePublicKey(formats strfmt.Registry) error {

	if err := validate.Required("publicKey", "body", m.PublicKey); err != nil {
		return err
	}

	if m.PublicKey != nil {
		if err := m.PublicKey.Validate(formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("publicKey")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("publicKey")
			}
			return err
		}
	}

	return nil
}

// ContextValidate validate this alpine v001 schema based on the context it is used
func (m *AlpineV001Schema) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	var res []error

	if err := m.contextValidatePackage(ctx, formats); err != nil {
		res = append(res, err)
	}

	if err := m.contextValidatePublicKey(ctx, formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *AlpineV001Schema) contextValidatePackage(ctx context.Context, formats strfmt.Registry) error {

	if m.Package != nil {
		if err := m.Package.ContextValidate(ctx, formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("package")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("package")
			}
			return err
		}
	}

	return nil
}

func (m *AlpineV001Schema) contextValidatePublicKey(ctx context.Context, formats strfmt.Registry) error {

	if m.PublicKey != nil {
		if err := m.PublicKey.ContextValidate(ctx, formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("publicKey")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("publicKey")
			}
			return err
		}
	}

	return nil
}

// MarshalBinary interface implementation
func (m *AlpineV001Schema) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *AlpineV001Schema) UnmarshalBinary(b []byte) error {
	var res AlpineV001Schema
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}

// AlpineV001SchemaPackage Information about the package associated with the entry
//
// swagger:model AlpineV001SchemaPackage
type AlpineV001SchemaPackage struct {

	// Specifies the package inline within the document
	// Format: byte
	Content strfmt.Base64 `json:"content,omitempty"`

	// hash
	Hash *AlpineV001SchemaPackageHash `json:"hash,omitempty"`

	// Values of the .PKGINFO key / value pairs
	// Read Only: true
	Pkginfo map[string]string `json:"pkginfo,omitempty"`
}

// Validate validates this alpine v001 schema package
func (m *AlpineV001SchemaPackage) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateHash(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *AlpineV001SchemaPackage) validateHash(formats strfmt.Registry) error {
	if swag.IsZero(m.Hash) { // not required
		return nil
	}

	if m.Hash != nil {
		if err := m.Hash.Validate(formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("package" + "." + "hash")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("package" + "." + "hash")
			}
			return err
		}
	}

	return nil
}

// ContextValidate validate this alpine v001 schema package based on the context it is used
func (m *AlpineV001SchemaPackage) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	var res []error

	if err := m.contextValidateHash(ctx, formats); err != nil {
		res = append(res, err)
	}

	if err := m.contextValidatePkginfo(ctx, formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *AlpineV001SchemaPackage) contextValidateHash(ctx context.Context, formats strfmt.Registry) error {

	if m.Hash != nil {
		if err := m.Hash.ContextValidate(ctx, formats); err != nil {
			if ve, ok := err.(*errors.Validation); ok {
				return ve.ValidateName("package" + "." + "hash")
			} else if ce, ok := err.(*errors.CompositeError); ok {
				return ce.ValidateName("package" + "." + "hash")
			}
			return err
		}
	}

	return nil
}

func (m *AlpineV001SchemaPackage) contextValidatePkginfo(ctx context.Context, formats strfmt.Registry) error {

	return nil
}

// MarshalBinary interface implementation
func (m *AlpineV001SchemaPackage) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *AlpineV001SchemaPackage) UnmarshalBinary(b []byte) error {
	var res AlpineV001SchemaPackage
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}

// AlpineV001SchemaPackageHash Specifies the hash algorithm and value for the package
//
// swagger:model AlpineV001SchemaPackageHash
type AlpineV001SchemaPackageHash struct {

	// The hashing function used to compute the hash value
	// Required: true
	// Enum: [sha256]
	Algorithm *string `json:"algorithm"`

	// The hash value for the package
	// Required: true
	Value *string `json:"value"`
}

// Validate validates this alpine v001 schema package hash
func (m *AlpineV001SchemaPackageHash) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateAlgorithm(formats); err != nil {
		res = append(res, err)
	}

	if err := m.validateValue(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

var alpineV001SchemaPackageHashTypeAlgorithmPropEnum []interface{}

func init() {
	var res []string
	if err := json.Unmarshal([]byte(`["sha256"]`), &res); err != nil {
		panic(err)
	}
	for _, v := range res {
		alpineV001SchemaPackageHashTypeAlgorithmPropEnum = append(alpineV001SchemaPackageHashTypeAlgorithmPropEnum, v)
	}
}

const (

	// AlpineV001SchemaPackageHashAlgorithmSha256 captures enum value "sha256"
	AlpineV001SchemaPackageHashAlgorithmSha256 string = "sha256"
)

// prop value enum
func (m *AlpineV001SchemaPackageHash) validateAlgorithmEnum(path, location string, value string) error {
	if err := validate.EnumCase(path, location, value, alpineV001SchemaPackageHashTypeAlgorithmPropEnum, true); err != nil {
		return err
	}
	return nil
}

func (m *AlpineV001SchemaPackageHash) validateAlgorithm(formats strfmt.Registry) error {

	if err := validate.Required("package"+"."+"hash"+"."+"algorithm", "body", m.Algorithm); err != nil {
		return err
	}

	// value enum
	if err := m.validateAlgorithmEnum("package"+"."+"hash"+"."+"algorithm", "body", *m.Algorithm); err != nil {
		return err
	}

	return nil
}

func (m *AlpineV001SchemaPackageHash) validateValue(formats strfmt.Registry) error {

	if err := validate.Required("package"+"."+"hash"+"."+"value", "body", m.Value); err != nil {
		return err
	}

	return nil
}

// ContextValidate validate this alpine v001 schema package hash based on the context it is used
func (m *AlpineV001SchemaPackageHash) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	var res []error

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

// MarshalBinary interface implementation
func (m *AlpineV001SchemaPackageHash) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *AlpineV001SchemaPackageHash) UnmarshalBinary(b []byte) error {
	var res AlpineV001SchemaPackageHash
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}

// AlpineV001SchemaPublicKey The public key that can verify the package signature
//
// swagger:model AlpineV001SchemaPublicKey
type AlpineV001SchemaPublicKey struct {

	// Specifies the content of the public key inline within the document
	// Required: true
	// Format: byte
	Content *strfmt.Base64 `json:"content"`
}

// Validate validates this alpine v001 schema public key
func (m *AlpineV001SchemaPublicKey) Validate(formats strfmt.Registry) error {
	var res []error

	if err := m.validateContent(formats); err != nil {
		res = append(res, err)
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}

func (m *AlpineV001SchemaPublicKey) validateContent(formats strfmt.Registry) error {

	if err := validate.Required("publicKey"+"."+"content", "body", m.Content); err != nil {
		return err
	}

	return nil
}

// ContextValidate validates this alpine v001 schema public key based on context it is used
func (m *AlpineV001SchemaPublicKey) ContextValidate(ctx context.Context, formats strfmt.Registry) error {
	return nil
}

// MarshalBinary interface implementation
func (m *AlpineV001SchemaPublicKey) MarshalBinary() ([]byte, error) {
	if m == nil {
		return nil, nil
	}
	return swag.WriteJSON(m)
}

// UnmarshalBinary interface implementation
func (m *AlpineV001SchemaPublicKey) UnmarshalBinary(b []byte) error {
	var res AlpineV001SchemaPublicKey
	if err := swag.ReadJSON(b, &res); err != nil {
		return err
	}
	*m = res
	return nil
}
