Return-Path: <linux-ext4+bounces-11640-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A44C3EE69
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 09:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED663B3846
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 08:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27F30F812;
	Fri,  7 Nov 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCcXqWhH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0847494
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503020; cv=none; b=TZtGsLdE4xIt5vKrNuZd3MEkVhmLHrnSN758o3/nHa8HX1/4de570dyR8PMC9eh8eOsn7czaBlSqgAsXvkJZOsxnaTFv6yex/vgPFJeCHerjHsmksE2Z2D0p2E8EeS2zZNUXSA/+zdd2Qw/pLoRIr36zKT0W0nTYahLwR3+byms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503020; c=relaxed/simple;
	bh=JH6EpzHDDOKZ9X/qUeOGLrVUFHrWbP6JeOabD/0ZuYg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UhZFDiwm/Tka2orBewueIG/6MpLRv/VUyj1sXrf52VLi6Mt+yTOBnrG+HTxpFQVP3Aueo4LL44qwSOgeEt0n8lkHgcUPvxfoaTAwve8Kqm0wF2rEcFqyNf4sNn2TTxjmLiiJYW55xDZep5MlQFc1ji5XhXhQ89vzaOG5ORoYzfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCcXqWhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1ADCC116C6
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762503019;
	bh=JH6EpzHDDOKZ9X/qUeOGLrVUFHrWbP6JeOabD/0ZuYg=;
	h=From:To:Subject:Date:From;
	b=rCcXqWhH/b6c9f5KYIOTHBJ594Kk6elORCj9rTdDdWwzy5x0l2631kXkgRVNdncaI
	 hc5lQH+0TbZDAm1EJk1sMpVnuwGRNiWK6mZ9PvInRC5x1Q6gcXr5rz6uzHhECqAdkN
	 8buNFaVfbNMx07GWCdCubxRqj4lhZQ/rb4PETyouNzlkXhNYe0h0y8eoyWGxJuiNBj
	 OyiyfAbokqG2+rSEZF/ZI3eEjm3w21g2yapiKFtaacJV85eLA18UXeaQtB75raRryD
	 mkDP0obsepoI20AjKqL+SnX+ZswPHlRWCL5UKWhZSptGjNGYQANlEaDbbWRZJjzGe3
	 ElNwJJw2u93nw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id B48BEC53BC9; Fri,  7 Nov 2025 08:10:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-ext4@vger.kernel.org
Subject: [Bug 220760] New: Observed  data-race in _find_next_bit+0x42/0xf0
Date: Fri, 07 Nov 2025 08:10:19 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: parsishashank351@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-220760-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D220760

            Bug ID: 220760
           Summary: Observed  data-race in _find_next_bit+0x42/0xf0
           Product: File System
           Version: 2.5
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: parsishashank351@gmail.com
        Regression: No

Created attachment 308913
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D308913&action=3Dedit
_find_next_bit+0x42/0xf0

Hello Team,
i have build linux kernel 6.17.7 by taking code from kernel.org and i have
enabled CONFIG_KCSAN in kernel config file and installed the kernel.
After the initial boot, i saw some concurrency issues in dmesg kernel ring
buffer.
Few are related to ACPI and few are related to timer subsystem.

ref dmesg log:
[  356.704237] BUG: KCSAN: data-race in _find_next_bit+0x42/0xf0

[  356.704264] race at unknown origin, with read to 0xffff88a9c0004230 of 8
bytes by interrupt on cpu 0:
[  356.704279]  _find_next_bit+0x42/0xf0
[  356.704297]  _nohz_idle_balance.isra.0+0x219/0x3a0
[  356.704317]  sched_balance_softirq+0x73/0x90
[  356.704335]  handle_softirqs+0xd8/0x310
[  356.704358]  __irq_exit_rcu+0x11a/0x140
[  356.704377]  irq_exit_rcu+0xe/0x20
[  356.704396]  sysvec_call_function_single+0x96/0xb0
[  356.704421]  asm_sysvec_call_function_single+0x1b/0x20
[  356.704440]  pv_native_safe_halt+0xb/0x10
[  356.704454]  arch_cpu_idle+0x9/0x10
[  356.704471]  default_idle_call+0x30/0x110
[  356.704489]  do_idle+0x203/0x240
[  356.704505]  cpu_startup_entry+0x2c/0x30
[  356.704520]  rest_init+0x121/0x140
[  356.704536]  start_kernel+0x9ed/0xe60
[  356.704559]  x86_64_start_reservations+0x18/0x30
[  356.704579]  x86_64_start_kernel+0xfe/0x150
[  356.704596]  common_startup_64+0x13e/0x141

[  356.704627] value changed: 0x000000009ffdfbfd -> 0x000000009ffdebfd

[  356.704645] Reported by Kernel Concurrency Sanitizer on:
[  356.704658] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.7 #4
PREEMPT(voluntary)
[  356.704678] Hardware name: VMware, Inc. VMware20,1/440BX Desktop Referen=
ce
Platform, BIOS VMW201.00V.23553139.B64.2403260940 03/26/2024
[  356.704690]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  356.705780] scsi host28: ahci
[  356.707193] scsi host29: ahci
[  356.708567] scsi host30: ahci
[  356.709878] scsi host31: ahci
[  356.711303] scsi host32: ahci
[  356.712465] ata3: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210100
irq 34 lpm-pol 1 ext
[  356.712481] ata4: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210180
irq 34 lpm-pol 1 ext
[  356.712531] ata5: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210200
irq 34 lpm-pol 1 ext
[  356.712545] ata6: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210280
irq 34 lpm-pol 1 ext
[  356.712559] ata7: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210300
irq 34 lpm-pol 1 ext
[  356.712572] ata8: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210380
irq 34 lpm-pol 1 ext
[  356.712596] ata9: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210400
irq 34 lpm-pol 1 ext
[  356.712674] ata10: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2104=
80
irq 34 lpm-pol 1 ext
[  356.712687] ata11: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2105=
00
irq 34 lpm-pol 1 ext
[  356.712701] ata12: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2105=
80
irq 34 lpm-pol 1 ext
[  356.712770] ata13: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2106=
00
irq 34 lpm-pol 1 ext
[  356.712784] ata14: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2106=
80
irq 34 lpm-pol 1 ext
[  356.712798] ata15: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2107=
00
irq 34 lpm-pol 1 ext
[  356.712812] ata16: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2107=
80
irq 34 lpm-pol 1 ext
[  356.712826] ata17: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2108=
00
irq 34 lpm-pol 1 ext
[  356.712840] ata18: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2108=
80
irq 34 lpm-pol 1 ext
[  356.712914] ata19: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2109=
00
irq 34 lpm-pol 1 ext
[  356.712928] ata20: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe2109=
80
irq 34 lpm-pol 1 ext
[  356.712942] ata21: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210a=
00
irq 34 lpm-pol 1 ext
[  356.712955] ata22: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210a=
80
irq 34 lpm-pol 1 ext
[  356.712968] ata23: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210b=
00
irq 34 lpm-pol 1 ext
[  356.713031] ata24: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210b=
80
irq 34 lpm-pol 1 ext
[  356.713044] ata25: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210c=
00
irq 34 lpm-pol 1 ext
[  356.713057] ata26: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210c=
80
irq 34 lpm-pol 1 ext
[  356.713072] ata27: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210d=
00
irq 34 lpm-pol 1 ext
[  356.713125] ata28: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210d=
80
irq 34 lpm-pol 1 ext
[  356.713138] ata29: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210e=
00
irq 34 lpm-pol 1 ext
[  356.713164] ata30: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210e=
80
irq 34 lpm-pol 1 ext
[  356.713240] ata31: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210f=
00
irq 34 lpm-pol 1 ext
[  356.713253] ata32: SATA max UDMA/133 abar m4096@0xfe210000 port 0xfe210f=
80
irq 34 lpm-pol 1 ext
[  356.738288] usbcore: registered new interface driver usbhid
[  356.738300] usbhid: USB HID core driver
[  357.022742] ata27: SATA link down (SStatus 0 SControl 300)
[  357.022941] ata25: SATA link down (SStatus 0 SControl 300)
[  357.023093] ata22: SATA link down (SStatus 0 SControl 300)
[  357.023241] ata31: SATA link down (SStatus 0 SControl 300)
[  357.023373] ata13: SATA link down (SStatus 0 SControl 300)
[  357.023490] ata24: SATA link down (SStatus 0 SControl 300)
[  357.023618] ata20: SATA link down (SStatus 0 SControl 300)
[  357.023763] ata7: SATA link down (SStatus 0 SControl 300)
[  357.023994] ata18: SATA link down (SStatus 0 SControl 300)
[  357.024218] ata32: SATA link down (SStatus 0 SControl 300)
[  357.024352] ata19: SATA link down (SStatus 0 SControl 300)
[  357.024499] ata9: SATA link down (SStatus 0 SControl 300)
[  357.024712] ata6: SATA link down (SStatus 0 SControl 300)
[  357.024901] ata26: SATA link down (SStatus 0 SControl 300)
[  357.025010] ata12: SATA link down (SStatus 0 SControl 300)
[  357.025116] ata30: SATA link down (SStatus 0 SControl 300)
[  357.025308] ata17: SATA link down (SStatus 0 SControl 300)
[  357.025426] ata28: SATA link down (SStatus 0 SControl 300)
[  357.025544] ata4: SATA link down (SStatus 0 SControl 300)
[  357.025630] ata23: SATA link down (SStatus 0 SControl 300)
[  357.025760] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  357.025908] ata15: SATA link down (SStatus 0 SControl 300)
[  357.026035] ata16: SATA link down (SStatus 0 SControl 300)
[  357.026210] ata29: SATA link down (SStatus 0 SControl 300)
[  357.026322] ata21: SATA link down (SStatus 0 SControl 300)
[  357.026432] ata10: SATA link down (SStatus 0 SControl 300)
[  357.026631] ata5: SATA link down (SStatus 0 SControl 300)
[  357.026733] ata11: SATA link down (SStatus 0 SControl 300)
[  357.026848] ata8: SATA link down (SStatus 0 SControl 300)
[  357.027037] ata14: SATA link down (SStatus 0 SControl 300)
[  357.027222] ata3.00: ATAPI: VMware Virtual SATA CDRW Drive, 00000001, max
UDMA/33
[  357.027523] ata3.00: configured for UDMA/33
[  357.028728] scsi 3:0:0:0: CD-ROM            NECVMWar VMware SATA CD00 1.=
00
PQ: 0 ANSI: 5
[  357.030610] sr 3:0:0:0: [sr0] scsi3-mmc drive: 1x/1x writer dvd-ram cd/rw
xa/form2 cdda tray
[  357.030693] cdrom: Uniform CD-ROM driver Revision: 3.20
[  357.071982] sr 3:0:0:0: Attached scsi CD-ROM sr0
[  357.072960] sr 3:0:0:0: Attached scsi generic sg1 type 5
[  357.098035] input: VMware VMware Virtual USB Mouse as
/devices/pci0000:02/0000:02:01.0/usb1/1-1/1-1:1.0/0003:0E0F:0003.0001/input=
/input5
[  357.099472] hid-generic 0003:0E0F:0003.0001: input,hidraw0: USB HID v1.10
Mouse [VMware VMware Virtual USB Mouse] on usb-0000:02:01.0-1/input0
[  357.398735] fbcon: Taking over console
[  357.402271] Console: switching to colour frame buffer device 128x48
[  357.549114] EXT4-fs (sda4): mounted filesystem
574a78d5-a611-492b-a2fd-0fd9308f950d ro with ordered data mode. Quota mode:
none.
[  363.330092] systemd[1]: Inserted module 'autofs4'
[  363.381819] systemd[1]: systemd 249.11-0ubuntu3.16 running in system mode
(+PAM +AUDIT +SELINUX +APPARMOR +IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENS=
SL
+ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP
+LIBFDISK +PCRE2 -PWQUALITY -P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD
-XKBCOMMON +UTMP +SYSVINIT default-hierarchy=3Dunified)
[  363.382132] systemd[1]: Detected virtualization vmware.
[  363.382510] systemd[1]: Detected architecture x86-64.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=

