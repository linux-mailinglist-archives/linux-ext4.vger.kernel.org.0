Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234C50D2C4
	for <lists+linux-ext4@lfdr.de>; Sun, 24 Apr 2022 17:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiDXPhz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 24 Apr 2022 11:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiDXPXi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 24 Apr 2022 11:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E420BFF
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 08:20:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5610660F4E
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4E3EC385A9
        for <linux-ext4@vger.kernel.org>; Sun, 24 Apr 2022 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650813635;
        bh=6L/I98L0V4tjth6UkVeuJFRB/4m1IJnZ4O898YAGF4E=;
        h=From:To:Subject:Date:From;
        b=hVXxsofnI485wyWUQ65pmN1b1dMvqpjkxfbzPpAdnXjWNqX8XJx1m0xd7a3u/MWgQ
         4TmM6GDNTrgRGFK88WmjaTFDzME+85IZ1qZAPYuIBy6OGxiTJsoswa3t4KgvuuxGas
         7XQikQDnZWBKqD4EiB4NEhves7/KdkFLHyvmwv7HDonpdUZMdMjSDWGCJzxtJiNBbK
         tPVqeww/xwLopgUpPKDOiL5cJR8j18jBY10rxpyRCuYr/3Wh5DeZy04RZyzMjyGOXB
         Gozi0u+DL0B/BIOc7r8rUyVIKDYsM75JeLF6YV9dKOPVVTeVaUiziB3Z0P/wh7yM3K
         HHj0F/SJrC2qQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8E495C05FD6; Sun, 24 Apr 2022 15:20:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 215879] New: EXT4-fs error - __ext4_find_entry:1612: inode #2:
 comm systemd: reading directory lblock 0
Date:   Sun, 24 Apr 2022 15:20:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ionut_n2001@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215879-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215879

            Bug ID: 215879
           Summary: EXT4-fs error - __ext4_find_entry:1612: inode #2: comm
                    systemd: reading directory lblock 0
           Product: File System
           Version: 2.5
    Kernel Version: 5.18.0-rc3
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: ionut_n2001@yahoo.com
        Regression: No

Hi Kernel Team,

I notice this issue:

EXT4-fs error - __ext4_find_entry:1612: inode #2: comm systemd: reading
directory lblock 0


I think this error is sporadic.


Drives:    Local Storage: total: 953.87 GiB used: 45.04 GiB (4.7%)=20
           ID-1: /dev/nvme0n1 vendor: Intel model: SSDPEKNU010TZ size: 953.=
87
GiB temp: 52.9 C=20
Partition: ID-1: / size: 250.25 GiB used: 40.4 GiB (16.1%) fs: ext4 dev:
/dev/nvme0n1p2=20
           ID-2: /boot/efi size: 252 MiB used: 274 KiB (0.1%) fs: vfat dev:
/dev/nvme0n1p1=20
           ID-3: /home size: 678.39 GiB used: 4.65 GiB (0.7%) fs: ext4 dev:
/dev/nvme0n1p4=20
Swap:      ID-1: swap-1 type: partition size: 8 GiB used: 0 KiB (0.0%) dev:
/dev/nvme0n1p3=20

OS: Debian 11/MXLinux KDE
Kernel: 5.18.0-rc3 vanilla

cat /proc/cmdline=20
BOOT_IMAGE=3D/boot/vmlinuz-5.18.0-1-generic
root=3DUUID=3D166304ea-bc80-458b-99a1-8a39a4e71a09 ro quiet splash clocksou=
rce=3Dhpet
init=3D/lib/systemd/systemd

dpkg -l | grep -E "systemd|preload"
ii  libpam-systemd:amd64                          1:247.3-6mx21=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
         amd64        system and service manager - PAM module
ii  libsystemd0:amd64                             1:247.3-6mx21=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
         amd64        systemd utility library
ii  preload                                       0.6.4-5+b1=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         amd64        adaptive readahead daemon
ii  systemd                                       1:247.3-6mx21=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
         amd64        system and service manager
ii  systemd-shim                                  10-5=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
         amd64        shim for systemd

lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne Root
Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Brid=
ge
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne PCIe =
GPP
Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy H=
ost
Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe=
 GPP
Bridge to Bus
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 51)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166a
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166b
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166c
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166d
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166e
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166f
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1670
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1671
01:00.0 VGA compatible controller: NVIDIA Corporation GA106M [GeForce RTX 3=
060
Mobile / Max-Q] (rev a1)
01:00.1 Audio device: NVIDIA Corporation Device 228e (rev a1)
02:00.0 Network controller: MEDIATEK Corp. Device 7961
03:00.0 Non-Volatile memory controller: Intel Corporation Device f1aa (rev =
03)
04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne (rev c4)
04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Renoir Radeon =
High
Definition Audio Controller
04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) Platform Security Processor
04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir/Cezanne U=
SB
3.1
04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
10h-1fh) HD Audio Controller

CPU Model name:                      AMD Ryzen 9 5900HS with Radeon Graphics

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
