Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A435C1D0A9D
	for <lists+linux-ext4@lfdr.de>; Wed, 13 May 2020 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgEMIPn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 13 May 2020 04:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbgEMIPn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 May 2020 04:15:43 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207729] New: Mounting EXT4 with data_err=abort does not abort
 journal on data block write failure
Date:   Wed, 13 May 2020 08:15:42 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rebello.anthony@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-207729-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207729

            Bug ID: 207729
           Summary: Mounting EXT4 with data_err=abort does not abort
                    journal on data block write failure
           Product: File System
           Version: 2.5
    Kernel Version: 5.3.2
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: rebello.anthony@gmail.com
        Regression: No

Created attachment 289111
  --> https://bugzilla.kernel.org/attachment.cgi?id=289111&action=edit
TGZ containing shell script and c code to reproduce the bug

Hi,

I've been performing some experiments that involve fault injection in the ext4
file system and noticed something that might be a bug.

According to [ext4
Documentation](https://www.kernel.org/doc/Documentation/filesystems/ext4.txt), 
`data_err=abort` should abort the journal if an error occurs in a file data
buffer in ordered mode.

The assumption I'm making is that the mount option `data_err=abort` will abort
the journal if the file system fails to write a data block to disk (I'm not
sure about my assumption since the documentation mentions a "file data
buffer").

### Overview

I have noticed that when fsync fails due to a failed data block write, the
journal is not aborted even when the file system is mounted with
`data_err=abort`. The file system continues to accept and handle future writes
and fsyncs.

I've attached a tgz which contains a small C program along with a shell script
to reproduce the problem. The C file is a simple workload that writes and
fsyncs a file. The shell script uses losetup to create a loop device,
configures the device mapper to fail certain sectors, mounts the ext4 file
system, and runs the compiled C file to demonstrate the issue.

Usage

```
tar -xvzf ext4-data-err-abort-bug.tgz
cd ext4-data-err-abort-bug
bash run_bug.sh
```

### Steps to reproduce independently

1. Create a 1GB loopdevice and mkfs -t ext4
2. Create a file with 12K data on the mounted loopdevice
3. Using debugfs, identify the 3 blocks for the file
4. Create a device mapper device using the dmsetup create command, configure
the 2nd block to use error target while everything else is a linear target
5. Open the file, write to the 2nd page, fsyncs (this fsync should fail)
6. Write to the 3rd page, fsync (This passes even though we expect it to fail
because of the `data_err=abort` mount option)
7. close file, unmount, dmsetup remove, etc

### Actual results

I observed that the first fsync fails because of the write failure. However,
the journal is not aborted. The second write and fsync succeed.

### Expected results

The first fsync should fail and the journal should be aborted. Any future
write/fsync would cause the file system to detect an aborted journal and
probably remount in read only mode.


### Other information

I used an unmodified linux 5.3.2 from
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/snapshot/linux-5.3.2.tar.gz
on an Intel Xeon Silver 4114 deca core processor.

```
$ awk -f scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux my-hostname 5.3.2 #1 SMP Mon May 11 14:13:56 CDT 2020 x86_64 x86_64
x86_64 GNU/Linux

GNU Make                4.1
Binutils                2.30
Util-linux              2.31.1
Mount                   2.31.1
Module-init-tools       24
E2fsprogs               1.44.1
Xfsprogs                4.9.0
Nfs-utils               1.3.3
Linux C Library         2.27
Dynamic linker (ldd)    2.27
Linux C++ Library       6.0.25
Procps                  3.3.12
Net-tools               2.10
Kbd                     2.0.4
Console-tools           2.0.4
Sh-utils                8.28
Udev                    237
Modules Loaded          acpi_pad acpi_power_meter aesni_intel aes_x86_64 ahci
autofs4 binfmt_misc coretemp crc32_pclmul crct10dif_pclmul cryptd crypto_simd
dca drm drm_kms_helper drm_vram_helper fb_sys_fops fscache ghash_clmulni_intel
glue_helper grace hid hid_generic i2c_algo_bit i40e ib_cm ib_core ib_iser
input_leds intel_cstate intel_powerclamp intel_rapl_common intel_rapl_msr
intel_rapl_perf ioatdma ipmi_devintf ipmi_msghandler ipmi_si ipmi_ssif ipod
ip_tables irqbypass iscsi_tcp iw_cm ixgbe joydev kvm kvm_intel libahci
libcrc32c libiscsi libiscsi_tcp lockd lpc_ich mac_hid mdio mei mei_me mgag200
mpt3sas nfit nfs nfs_acl nfsv3 pps_core ptp raid_class rdma_cm sch_fq_codel
scsi_transport_iscsi scsi_transport_sas skx_edac sunrpc syscopyarea sysfillrect
sysimgblt ttm usbhid wmi x86_pkg_temp_thermal xfrm_algo xfs x_tables
```

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
