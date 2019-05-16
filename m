Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEE59202ED
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 11:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEPJzL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 05:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfEPJzL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 May 2019 05:55:11 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945E520848;
        Thu, 16 May 2019 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558000509;
        bh=bAHBuoximqb7Vdxd8uq1bPw7lnipewcOX12pYgi9WLc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FGZ3YS7IjcYcBwpXdpBuEExqv1Edyi1jEuTTM4UmdVbEsDFY/UxJ2V3pfsNuyiD68
         ZwgcA9eJ0JlJ11d0TquB4XFXv7pwX/Cj6U3XQi0wyVd3aIMAvBw9EYF+AzLuuTKD5S
         1u/wfLNO6RiQV6lelIPT0sJJiQyapeG+t2eNLV5c=
Received: by mail-vs1-f46.google.com with SMTP id j184so1890150vsd.11;
        Thu, 16 May 2019 02:55:09 -0700 (PDT)
X-Gm-Message-State: APjAAAV0hMl3Sj3HQ37gMjqKFbBfYOwjSivdtxGxuSrbVF35/ewP5jY1
        R3yFAk41tJPXW+bUJcaav6DM2SOZsOl5igQ3RqA=
X-Google-Smtp-Source: APXvYqwarzpA5EPqd1rFX7kiRRhXFSR2lruchLSRG6dJSloPCAN6OFRVKlnBkQuIa9W0fE4pBlDXspDvd68lwRoLxYg=
X-Received: by 2002:a67:db88:: with SMTP id f8mr19958354vsk.14.1558000508695;
 Thu, 16 May 2019 02:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190515150221.16647-1-fdmanana@kernel.org> <20190516092848.GA6975@mit.edu>
In-Reply-To: <20190516092848.GA6975@mit.edu>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 May 2019 10:54:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
Message-ID: <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 16, 2019 at 10:30 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, May 15, 2019 at 04:02:21PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Run fsstress, fsync every file and directory, simulate a power failure and
> > then verify the all files and directories exist, with the same data and
> > metadata they had before the power failure.
> >
> > This tes has found already 2 bugs in btrfs, that caused mtime and ctime of
> > directories not being preserved after replaying the log/journal and loss
> > of a directory's attributes (such a UID and GID) after replaying the log.
> > The patches that fix the btrfs issues are titled:
> >
> >   "Btrfs: fix wrong ctime and mtime of a directory after log replay"
> >   "Btrfs: fix fsync not persisting changed attributes of a directory"
> >
> > Running this test 1000 times:
> >
> > - on ext4 it has resulted in about a dozen journal checksum errors (on a
> >   5.0 kernel) that resulted in failure to mount the filesystem after the
> >   simulated power failure with dmflakey, which produces the following
> >   error in dmesg/syslog:
> >
> >     [Mon May 13 12:51:37 2019] JBD2: journal checksum error
> >     [Mon May 13 12:51:37 2019] EXT4-fs (dm-0): error loading journal
>
> I'm curious what configuration you used when you ran the test.  I

Default configuration, MKFS_OPTIONS="" and MOUNT_OPTIONS="", 5.0 kernel.

I have logs with all the fsstress seed values kept around.

From one of the failures, the .full file:

Discarding device blocks: done
Creating filesystem with 5242880 4k blocks and 1310720 inodes
Filesystem UUID: 4bb2559c-12ea-45fa-810e-00c513b00dee
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000

Allocating group tables: done
Writing inode tables: done
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done

Running fsstress with arguments: -p 4 -n 100 -d
/home/fdmanana/btrfs-tests/scratch_1/test -f mknod=0 -f symlink=0
seed = 1558078129
_check_generic_filesystem: filesystem on /dev/sdc is inconsistent
*** fsck.ext4 output ***
fsck from util-linux 2.29.2
e2fsck 1.43.4 (31-Jan-2017)
Journal superblock is corrupt.
Fix? no

fsck.ext4: The journal superblock is corrupt while checking journal for /dev/sdc
e2fsck: Cannot proceed with file system check

/dev/sdc: ********** WARNING: Filesystem still has errors **********

*** end fsck.ext4 output
*** mount output ***
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs (rw,nosuid,relatime,mode=755)
devpts on /dev/pts type devpts
(rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,noexec,relatime,size=788996k,mode=755)
/dev/sda1 on / type ext4 (rw,relatime,discard,errors=remount-ro)
securityfs on /sys/kernel/security type securityfs
(rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup
(rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup/devices type cgroup
(rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup
(rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup
(rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/perf_event type cgroup
(rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/memory type cgroup
(rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup
(rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/cpuset type cgroup
(rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/blkio type cgroup
(rw,nosuid,nodev,noexec,relatime,blkio)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs
(rw,relatime,fd=40,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=1624)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
mqueue on /dev/mqueue type mqueue (rw,relatime)
tmpfs on /run/user/1000 type tmpfs
(rw,nosuid,nodev,relatime,size=788992k,mode=700,uid=1000,gid=1000)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime)
*** end mount output


Haven't tried ext4 with 1 process only (instead of 4), but I can try
to see if it happens without concurrency as well.

> tried to reproduce it, and had no luck:
>
> TESTRUNID: tytso-20190516042341
> KERNEL:    kernel 5.1.0-rc3-xfstests-00034-g0c72924ef346 #999 SMP Wed May 15 00:56:08 EDT 2019 x86_64
> CMDLINE:   -c 4k -C 1000 generic/547
> CPUS:      2
> MEM:       7680
>
> ext4/4k: 1000 tests, 1855 seconds
> Totals: 1000 tests, 0 skipped, 0 failures, 0 errors, 1855s
>
> FSTESTPRJ: gce-xfstests
> FSTESTVER: blktests baccddc (Wed, 13 Mar 2019 00:06:50 -0700)
> FSTESTVER: fio  fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
> FSTESTVER: fsverity bdebc45 (Wed, 5 Sep 2018 21:32:22 -0700)
> FSTESTVER: ima-evm-utils 0267fa1 (Mon, 3 Dec 2018 06:11:35 -0500)
> FSTESTVER: nvme-cli v1.7-35-g669d759 (Tue, 12 Mar 2019 11:22:16 -0600)
> FSTESTVER: quota  62661bd (Tue, 2 Apr 2019 17:04:37 +0200)
> FSTESTVER: stress-ng 7d0353cf (Sun, 20 Jan 2019 03:30:03 +0000)
> FSTESTVER: syzkaller bab43553 (Fri, 15 Mar 2019 09:08:49 +0100)
> FSTESTVER: xfsprogs v5.0.0 (Fri, 3 May 2019 12:14:36 -0500)
> FSTESTVER: xfstests-bld 9582562 (Sun, 12 May 2019 00:38:51 -0400)
> FSTESTVER: xfstests linux-v3.8-2390-g64233614 (Thu, 16 May 2019 00:12:52 -0400)
> FSTESTCFG: 4k
> FSTESTSET: generic/547
> FSTESTOPT: count 1000 aex
> GCE ID:    8592267165157073108
