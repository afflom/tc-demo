# Emporous SSSC Demo

This demo shows the following workflow

1. Build hello world go app
2. Populate component information (CPE) via dataset-config
3. Publish app
4. Pull and run app (as container process)
5. Poll for CVEs (returns none)
6. Create CVE
7. Publish CVE
8. Poll for CVEs (returns CVE from step 7)
9. Publish hello world update
10. Poll for update
11. Pull update
12. Delete running hello world app
13. Run update
14. Continue polling for app and CVE updates

Run the dam