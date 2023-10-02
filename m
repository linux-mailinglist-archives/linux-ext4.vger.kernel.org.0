Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D957B577B
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Oct 2023 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjJBPzN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Oct 2023 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjJBPzM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Oct 2023 11:55:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22EC93
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 08:55:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40446C433C7
        for <linux-ext4@vger.kernel.org>; Mon,  2 Oct 2023 15:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696262109;
        bh=gksVJL3lAmJSQnnsXgfeGzK2Wj1joFtL41MpI4ME2rk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CXRHb/FVLVsYOw+Hf9c7ypBrOwabGJ5ko4e85QnYS6+RxNopbgjT27Z4q2jknfCHd
         K/5OFHL8FjQaw+3UrS0EVDw1DZENstPCRiToCTIq6sHYOcYdQHZBcBPiVPMU7PYW3Q
         qAvlGU3bokbTjhNmAlO4A5A9plU4ZdwfUyS5Lxdx+w9wVfhvQmJN58qjWtHVvnceyl
         aOwPNyklaRo4hvHtajoymh8CAUQ5Myig1UvaMFJKm77KScEQXmfrnRfZRHA/NAW0fS
         FxT1SJ1EJkKo+hF2hScOL/DhDLdHeHxNJHdTr0+0G+j+5BHKkmgYGqq/7lJAQMUn5U
         RYRwNTqoPDnJg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 22333C53BCD; Mon,  2 Oct 2023 15:55:09 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 217965] ext4(?) regression since 6.5.0 on sata hdd
Date:   Mon, 02 Oct 2023 15:55:08 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: iivanich@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217965-13602-QKKfb6hXF9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217965-13602@https.bugzilla.kernel.org/>
References: <bug-217965-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217965

--- Comment #4 from Ivan Ivanich (iivanich@gmail.com) ---

(In reply to Theodore Tso from comment #3)
> What sort of information can you give about the ext4 file system where th=
is
> is happening?  How much free space is there?   Can you run "df" and
> "dumpe2fs -h" on the system so we can see which file system features were
> enabled?   Also, can you specify the kind of the block device?
>=20
> Differential debugging would be useful.  For example, can you try is to c=
opy
> the file system image to a hardware, and see if you can reproduce the
> behavior using the same kernel build workload?   What if you copy to the
> file system image to a USB attached SSD, and see if you can reproduce the
> behavior?   What you attach the USB attached SSD, and use a freshly
> formatted ext4 file system?   Does it reproduce then?   If the file system
> is nearly full, what if you delete a lot of unused space, to provide a lot
> more free space, and see if it reproduces then?

mount |grep sdb2
/dev/sdb2 on /mnt/sdb2 type ext4 (rw,relatime,stripe=3D32752)

df /mnt/sdb2/
Filesystem      1K-blocks       Used Available Use% Mounted on
/dev/sdb2      2667140496 2125391752 539022500  80% /mnt/sdb2


dumpe2fs -h /dev/sdb2
dumpe2fs 1.47.0 (5-Feb-2023)
Filesystem volume name:   <none>
Last mounted on:          /mnt/sdb2
Filesystem UUID:          3bd82ee7-f08a-4a23-8e50-2df3786b0858
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filet=
ype
needs_recovery extent flex_bg sparse_super large_file huge_file uninit_bg
dir_nlink extra_isize
Filesystem flags:         signed_directory_hash=20
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              169369600
Block count:              677467392
Reserved block count:     677465
Overhead clusters:        10682268
Free blocks:              135437186
Free inodes:              168057645
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      862
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8192
Inode blocks per group:   512
RAID stride:              32752
Flex block group size:    16
Filesystem created:       Wed Jun 25 13:10:17 2014
Last mount time:          Mon Oct  2 18:46:12 2023
Last write time:          Mon Oct  2 18:46:12 2023
Mount count:              23
Maximum mount count:      -1
Last checked:             Thu Sep 28 14:37:21 2023
Check interval:           0 (<none>)
Lifetime writes:          84 TB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      a90aaa2d-577c-4181-83f9-696dee7ea92d
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Total journal size:       128M
Total journal blocks:     32768
Max transaction length:   32768
Fast commit length:       0
Journal sequence:         0x002a8661
Journal start:            9556

I don't have physical access to this machine so can't do any manipulations =
to
the hardware or attaching USB drives etc.

Device is=20
Model Family:     Toshiba 3.5" DT01ACA... Desktop HDD
Device Model:     TOSHIBA DT01ACA300
Serial Number:    14KP58HGS
LU WWN Device Id: 5 000039 ff4d7b718
Firmware Version: MX6OABB0
User Capacity:    3,000,592,982,016 bytes [3.00 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        In smartctl database
ATA Version is:   ATA8-ACS T13/1699-D revision 4
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Mon Oct  2 18:53:26 2023 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled
AAM feature is:   Unavailable
APM feature is:   Disabled
Rd look-ahead is: Enabled
Write cache is:   Enabled
DSN feature is:   Unavailable
ATA Security is:  Disabled, frozen [SEC2]
Wt Cache Reorder: Enabled

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
