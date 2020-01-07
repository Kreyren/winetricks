# Security Policy

### Using third party windows executables without checksum
This policy is an attempt is to avoid ransomware like wannaCry which works on wine (https://www.youtube.com/watch?v=7cUL1HKfTK0) to be invoked on end-user's system.

If you are using a verb that downloads windows executables from **ANY** mirror then you **HAVE TO**:
- check it using virustotal (https://www.virustotal.com/) and provide a virustotal url on used **url** (not uploaded file) in the code itself as comment.
- Provide checksum (if possible)

If virustotal throws away any detections then **YOU HAVE TO** make an issue for it so that the security risk would be archived and investigated then wait for further instructions to proceed with the solution.
You are also encouraged to suggest your own solution to the problem.

If it's possible to make a tracking using checksum, then provide it with the file itself.
If the file is updated too often then make a `w_askpermission()` with warning and requesting user-input.
