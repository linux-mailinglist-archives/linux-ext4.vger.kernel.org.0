Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0BB307CF0
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jan 2021 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhA1Rr0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jan 2021 12:47:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231920AbhA1RqM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 28 Jan 2021 12:46:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 46F8A64DD8
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jan 2021 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611855929;
        bh=wC0u0xX8j57buomNTbdhoSJ5I5lqjZq9aRQZdI1aqRk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GQTX0qpPDXUAUVqmvg+w85sazOBmea0Y/Kq8U79PuhkBkg8UQXsx4Nub1RYmy1F+k
         SnZqaJEe9X/4AdBN1IKdFBUEu4atOvlS0HgB+onM+CaUUD2OODGEPcROaPXq6mBwIE
         AeaYARnYQhmlyAQs30pU9sOeaC2o0h51YlIbT/mlhrBh15knpHDCxD8g7BpUoLQ0rY
         gq2A433m/80lBbEr3heWg/eSfjpqBd+VIZX9OgdtD181kElREhsivk9LSXPuMFeI4C
         gXp8ouwG5jTe4hpf/jDyDgYEwIcmenCUvGmAWbdWd3RJsn5KKXijjkTzKq7U1mlWIk
         J+cOzAYBLXZiA==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 40A52652FB; Thu, 28 Jan 2021 17:45:29 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 211315] [aarch64][xfstests/ext3 generic/472] swapon: Invalid
 argument
Date:   Thu, 28 Jan 2021 17:45:28 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext3
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: riteshh@linux.ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext3@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211315-13602-xj1YrRS03X@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211315-13602@https.bugzilla.kernel.org/>
References: <bug-211315-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211315

--- Comment #1 from riteshh@linux.ibm.com ---
Hello,

Thanks for reporting this.
Ok, so earlier I thought I tested this on Power (pagesize=3D64K).
But it seems I had only tested with 1K blocksize but not with 2K.
On retrying it again with ext3 with 2K blocksize, I see it could be=20
reproduced on latest kernel on Power as well (where pagesize is 64K).
(gcc version 8.4.0)

I will look more into what is causing this, but it seems it may be
coming from below path :-

static int setup_swap_map_and_extents()
<...>

        if (!nr_good_pages) {
                pr_warn("Empty swap-file\n");
                return -EINVAL;
        }
<...>


BTW, is ext3 with 2K bs some default configuration you use often on=20
arch64. Or was it mostly for testing purpose only?

-ritesh


On 1/22/21 4:19 PM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D211315
>=20
>              Bug ID: 211315
>             Summary: [aarch64][xfstests/ext3 generic/472] swapon: Invalid
>                      argument
>             Product: File System
>             Version: 2.5
>      Kernel Version: 5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarc=
h6
>                      4
>            Hardware: ARM
>                  OS: Linux
>                Tree: Mainline
>              Status: NEW
>            Severity: normal
>            Priority: P1
>           Component: ext3
>            Assignee: fs_ext3@kernel-bugs.osdl.org
>            Reporter: neolorry+bugzilla.kernel.org@googlemail.com
>          Regression: No
>=20
> xfstests generic/472 fails on ext3 on the latest kernel
> (kernel-5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 from
> https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1671933). This on=
ly
> happens on aarch64 and ext3 with 2048 block size. I can reproduce it on
> kernel-4.18 based RHEL-8 kernel as well.
>=20
> log
> ```
> # ./check -d -T generic/472
> FSTYP         -- ext3
> PLATFORM      -- Linux/aarch64 15-vm-16
> 5.11.0-0.rc4.20210120git45dfb8a5659a.131.eln108.aarch64 #1 SMP Wed Jan 20
> 23:39:54 UTC 2021
> MKFS_OPTIONS  -- -b 2048 /dev/vda3
> MOUNT_OPTIONS -- -o rw,relatime,seclabel -o
> context=3Dsystem_u:object_r:root_t:s0
> /dev/vda3 /scratch
>=20
> generic/472 103s ...    [05:31:22]QA output created by 472
> regular swap
> too long swap
> tiny swap
> swapon: Invalid argument
>   [05:32:15]- output mismatch (see
> /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad)
>      --- tests/generic/472.out   2021-01-22 01:31:23.045484313 -0500
>      +++ /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad
> 2021-01-22 05:32:15.217684365 -0500
>      @@ -2,3 +2,4 @@
>       regular swap
>       too long swap
>       tiny swap
>      +swapon: Invalid argument
>      ...
>      (Run 'diff -u /tmp/tmp.6xoJizCZKc/repo_xfstests/tests/generic/472.out
> /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.out.bad'  to see t=
he
> entire diff)
> Ran: generic/472
> Failures: generic/472
> Failed 1 of 1 tests
> ```
>=20
> 472.full
> ```
> # cat /tmp/tmp.6xoJizCZKc/repo_xfstests/results//generic/472.full
> Creating filesystem with 5767168 2k blocks and 720896 inodes
> Filesystem UUID: 97619060-f6ec-4ed0-8984-01b4aefe86f8
> Superblock backups stored on blocks:
>          16384, 49152, 81920, 114688, 147456, 409600, 442368, 802816,
>          1327104,
>          2048000, 3981312, 5619712
>=20
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (32768 blocks): done
> Writing superblocks and filesystem accounting information: done
>=20
> regular swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/=
swap
> wrote 2097152/2097152 bytes at offset 0
> 2 MiB, 512 ops; 0.1898 sec (10.534 MiB/sec and 2696.7097 ops/sec)
> too long swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/=
swap
> wrote 2097155/2097155 bytes at offset 0
> 2 MiB, 513 ops; 0.1231 sec (16.241 MiB/sec and 4165.7531 ops/sec)
> tiny swap
> /usr/bin/chattr: Operation not supported while setting flags on /scratch/=
swap
> wrote 196608/196608 bytes at offset 0
> 192 KiB, 48 ops; 0.0130 sec (14.338 MiB/sec and 3670.5666 ops/sec)
> swapoff: /scratch/swap: swapoff failed: Invalid argument
> ```
>=20
> xfstests local.config
> ```
> FSTYP=3D"ext3"
> TEST_DIR=3D"/test"
> TEST_DEV=3D"/dev/vda4"
> SCRATCH_MNT=3D"/scratch"
> SCRATCH_DEV=3D"/dev/vda3"
> LOGWRITES_MNT=3D"/logwrites"
> LOGWRITES_DEV=3D"/dev/vda6"
> MKFS_OPTIONS=3D"-b 2048"
> MOUNT_OPTIONS=3D"-o rw,relatime,seclabel"
> TEST_FS_MOUNT_OPTS=3D"-o rw,relatime,seclabel"
> ```
>=20
> 64k page size
> ```
> # getconf PAGESIZE
> 65536
> ```
>=20
> fdisk -l
> ```
> # fdisk -l /dev/vda
> Disk /dev/vda: 100 GiB, 107374182400 bytes, 209715200 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: gpt
> ```
>=20
> xfstests version
> ```
> # git rev-parse HEAD
> 4767884aff19e042ee3be51c88cf2c27a111707e
> # cat .git/config
> [core]
>          repositoryformatversion =3D 0
>          filemode =3D true
>          bare =3D false
>          logallrefupdates =3D true
> [remote "origin"]
>          url =3D git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>          fetch =3D +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>          remote =3D origin
>          merge =3D refs/heads/master
> ```
>=20
> e2fsprogs version
> ```
> # rpm -q e2fsprogs
> e2fsprogs-1.45.6-1.el8.aarch64
> ```
>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
