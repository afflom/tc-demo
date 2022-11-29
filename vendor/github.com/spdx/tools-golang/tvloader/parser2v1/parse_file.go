// SPDX-License-Identifier: Apache-2.0 OR GPL-2.0-or-later

package parser2v1

import (
	"fmt"

	"github.com/spdx/tools-golang/spdx"
)

func (parser *tvParser2_1) parsePairFromFile2_1(tag string, value string) error {
	// expire fileAOP for anything other than an AOPHomePage or AOPURI
	// (we'll actually handle the HomePage and URI further below)
	if tag != "ArtifactOfProjectHomePage" && tag != "ArtifactOfProjectURI" {
		parser.fileAOP = nil
	}

	switch tag {
	// tag for creating new file section
	case "FileName":
		// check if the previous file contained a spdxId or not
		if parser.file != nil && parser.file.FileSPDXIdentifier == nullSpdxElementId2_1 {
			return fmt.Errorf("file with FileName %s does not have SPDX identifier", parser.file.FileName)
		}
		parser.file = &spdx.File2_1{}
		parser.file.FileName = value
	// tag for creating new package section and going back to parsing Package
	case "PackageName":
		// check if the previous file contained a spdxId or not
		if parser.file != nil && parser.file.FileSPDXIdentifier == nullSpdxElementId2_1 {
			return fmt.Errorf("file with FileName %s does not have SPDX identifier", parser.file.FileName)
		}
		parser.st = psPackage2_1
		parser.file = nil
		return parser.parsePairFromPackage2_1(tag, value)
	// tag for going on to snippet section
	case "SnippetSPDXID":
		parser.st = psSnippet2_1
		return parser.parsePairFromSnippet2_1(tag, value)
	// tag for going on to other license section
	case "LicenseID":
		parser.st = psOtherLicense2_1
		return parser.parsePairFromOtherLicense2_1(tag, value)
	// tags for file data
	case "SPDXID":
		eID, err := extractElementID(value)
		if err != nil {
			return err
		}
		parser.file.FileSPDXIdentifier = eID
		if parser.pkg == nil {
			if parser.doc.UnpackagedFiles == nil {
				parser.doc.UnpackagedFiles = map[spdx.ElementID]*spdx.File2_1{}
			}
			parser.doc.UnpackagedFiles[eID] = parser.file
		} else {
			if parser.pkg.Files == nil {
				parser.pkg.Files = map[spdx.ElementID]*spdx.File2_1{}
			}
			parser.pkg.Files[eID] = parser.file
		}
	case "FileType":
		parser.file.FileType = append(parser.file.FileType, value)
	case "FileChecksum":
		subkey, subvalue, err := extractSubs(value)
		if err != nil {
			return err
		}
		switch subkey {
		case "SHA1":
			parser.file.FileChecksumSHA1 = subvalue
		case "SHA256":
			parser.file.FileChecksumSHA256 = subvalue
		case "MD5":
			parser.file.FileChecksumMD5 = subvalue
		default:
			return fmt.Errorf("got unknown checksum type %s", subkey)
		}
	case "LicenseConcluded":
		parser.file.LicenseConcluded = value
	case "LicenseInfoInFile":
		parser.file.LicenseInfoInFile = append(parser.file.LicenseInfoInFile, value)
	case "LicenseComments":
		parser.file.LicenseComments = value
	case "FileCopyrightText":
		parser.file.FileCopyrightText = value
	case "ArtifactOfProjectName":
		parser.fileAOP = &spdx.ArtifactOfProject2_1{}
		parser.file.ArtifactOfProjects = append(parser.file.ArtifactOfProjects, parser.fileAOP)
		parser.fileAOP.Name = value
	case "ArtifactOfProjectHomePage":
		if parser.fileAOP == nil {
			return fmt.Errorf("no current ArtifactOfProject found")
		}
		parser.fileAOP.HomePage = value
	case "ArtifactOfProjectURI":
		if parser.fileAOP == nil {
			return fmt.Errorf("no current ArtifactOfProject found")
		}
		parser.fileAOP.URI = value
	case "FileComment":
		parser.file.FileComment = value
	case "FileNotice":
		parser.file.FileNotice = value
	case "FileContributor":
		parser.file.FileContributor = append(parser.file.FileContributor, value)
	case "FileDependency":
		parser.file.FileDependencies = append(parser.file.FileDependencies, value)
	// for relationship tags, pass along but don't change state
	case "Relationship":
		parser.rln = &spdx.Relationship2_1{}
		parser.doc.Relationships = append(parser.doc.Relationships, parser.rln)
		return parser.parsePairForRelationship2_1(tag, value)
	case "RelationshipComment":
		return parser.parsePairForRelationship2_1(tag, value)
	// for annotation tags, pass along but don't change state
	case "Annotator":
		parser.ann = &spdx.Annotation2_1{}
		parser.doc.Annotations = append(parser.doc.Annotations, parser.ann)
		return parser.parsePairForAnnotation2_1(tag, value)
	case "AnnotationDate":
		return parser.parsePairForAnnotation2_1(tag, value)
	case "AnnotationType":
		return parser.parsePairForAnnotation2_1(tag, value)
	case "SPDXREF":
		return parser.parsePairForAnnotation2_1(tag, value)
	case "AnnotationComment":
		return parser.parsePairForAnnotation2_1(tag, value)
	// tag for going on to review section (DEPRECATED)
	case "Reviewer":
		parser.st = psReview2_1
		return parser.parsePairFromReview2_1(tag, value)
	default:
		return fmt.Errorf("received unknown tag %v in File section", tag)
	}

	return nil
}
