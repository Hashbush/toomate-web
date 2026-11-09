# Helper script to push to GitHub using GitHub Desktop's stored credentials
$code = @"
using System;
using System.Runtime.InteropServices;
using System.Text;

public class CredReader {
    [DllImport("Advapi32.dll", SetLastError = true, EntryPoint = "CredReadW", CharSet = CharSet.Unicode)]
    public static extern bool CredRead(string target, int type, int reservedFlag, out IntPtr credentialPtr);

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
    public struct CREDENTIAL {
        public int Flags;
        public int Type;
        public string TargetName;
        public string Comment;
        public long LastWritten;
        public int CredentialBlobSize;
        public IntPtr CredentialBlob;
        public int Persist;
        public int AttributeCount;
        public IntPtr Attributes;
        public string TargetAlias;
        public string UserName;
    }

    public static string GetToken(string target) {
        IntPtr credPtr;
        if (CredRead(target, 1, 0, out credPtr)) {
            CREDENTIAL cred = (CREDENTIAL)Marshal.PtrToStructure(credPtr, typeof(CREDENTIAL));
            byte[] b = new byte[cred.CredentialBlobSize];
            Marshal.Copy(cred.CredentialBlob, b, 0, cred.CredentialBlobSize);
            return Encoding.UTF8.GetString(b);
        }
        return null;
    }
}
"@
if (-not ([System.Management.Automation.PSTypeName]'CredReader').Type) {
    Add-Type -TypeDefinition $code
}
$token = [CredReader]::GetToken("GitHub - https://api.github.com/Hashbush")
$git = "$env:LOCALAPPDATA\GitHubDesktop\app-3.6.10\resources\app\git\cmd\git.exe"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root
& $git push "https://${token}@github.com/Hashbush/toomate-web.git" main
