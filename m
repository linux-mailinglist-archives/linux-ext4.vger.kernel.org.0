Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE20F12C2B4
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Dec 2019 15:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfL2OhN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Dec 2019 09:37:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44605 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726189AbfL2OhN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Dec 2019 09:37:13 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBTEb7Co021984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Dec 2019 09:37:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C5051420485; Sun, 29 Dec 2019 09:37:06 -0500 (EST)
Date:   Sun, 29 Dec 2019 09:37:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: the side effect of enlarger max mount count in ext4 superblock
Message-ID: <20191229143706.GA7177@mit.edu>
References: <CAAJeciUWm9W-AyFwJdUqC3W6n4bBDHMrzBF=V2d_iMywDW2+uQ@mail.gmail.com>
 <20191226130935.GA3158@mit.edu>
 <CAAJeciX4oG9MU9tHEccF3ZTu+G4KFOdssa6bGRNgh6mNX+B5Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAJeciX4oG9MU9tHEccF3ZTu+G4KFOdssa6bGRNgh6mNX+B5Lg@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 29, 2019 at 02:58:21PM +0800, xiaohui li wrote:
> 
> shall the e2fsck tool can be divided into two parts ?
> one part only do the full data consistency check work, focus on
> checking if data has inconsistency just when ext4 filesystem has been
> frozen or very few IO activities are going on.
> and the other part can be doing the actual repair work if data
> inconsistent  has encountered.

Alas, that's not really practical.  In order to repair a particular
part of the file system, you need to know what the correct value
should be.  And calculating the correct value sometimes requires
global knowledge of the entire file system state.

For example, consider the inode field i_links_count.  For regular
files, the value of this field is the number of references from
directory entries (in other words, links) that point at a particular
inode.  If the correct value is 2 (there are two directory entries
which reference this inode), but it is incorrectly set to 1, then when
the first directory entry is removed with an unlink system call, the
i_links_count will go to zero, and the kernel will free the inode and
its blocks, leaving those blocks to be used by other inodes.  But
there still is a valid reference to that inode, and the potential
result is that the one or more files will get corrupted, because
blocks can end up being claimed by different inodes.

So there are a couple of things to learn from this.  First, the
determine whether or not the field is corrupted is 99.999% of the
effort.  Once you know the correct value, the repair part is trivial.
So separating the consistency check and repair efforts don't make much
sense.

Second, when we are considering the i_links_count for a particular
inode, we have no idea where in the directory tree structure the
directory entries which reference that inode might be located.  So we
have to examine all of the blocks of all directories in order to
determine the value of each inodes i_links_count.  And of course, if
the contents of the directory blocks are changing while you are trying
calculate the i_links_count for all of the inodes in the directory,
this makes the job incredibly difficult.  Effectively, it also
requires reading all of the metadata blocks, and making sure that they
are consistent with each other and this requires a lot of memory and a
lot of I/O bandwidth.

> but i wonder if some problems will happen if doing the full data
> consistency checking online, without ext4 filesystem umount.
> so even if very few io activities are going on,  the data checking
> can't be implemented. just because some file data may be in memory,
> not in disk.
> so the data consistency checking only can be started when ext4
> filesystem has been frozen from my viewpoint, at least at this moment,
> file data can be returned back to disk as much as possible.

So we can do this already.  It's called e2scrub[1].  It requires using
dm_snapshot, so we can create a frozen copy of the file system, and
then we check that frozen file system.

[1] https://manpages.debian.org/testing/e2fsprogs/e2scrub.8.en.html

This has tradeoffs.  The first, and most important, is that if any
problems are found, you need to unmount the file system, and then
rerun e2fsck on the actual file system (as opposed to the frozen copy)
to actually effectuate the repair.

So if you have a large 100TB RAID array, which takes hours to run
fsck, first of all, you need to reserve enough space in the snapshot
partition to save an original copy of all blocks written to the file
system while the e2fsck is running.  This could potentially be a large
amount of storage.  Secondly, if a problem is found, now what?
Current e2scrub sends an e-mail to the system administrator,
requesting that the sysadmin schedule downtime so the system can be
rebooted, and e2fsck run on the unmounted file system so it can be
fixed.  If it took hours to detect that the file system was corrupted,
it will take hours to repair the file system, and the system will be
out of service during that time.

I'm not convinced this would work terribly well on an Android device.
E2scrub was designed for enterprise servers that might be running for
years without a reboot, and the goal was to allow a periodic sanity
check (say, every few months) to make sure there weren't any problems
that had accumulated due to cosmic rays flipping bigs in the DRAM
(although hopefully all enterprise servers are using ECC memory), etc.

One thing that we could do to optimize things a bit is to enhance
dm_snapshot so that it only makes copies of the original block if the
I/O indicates that it is a metadata block.  This would reduce the
amount of space needed to be reserved for the snapshot volume, and it
would reduce the overhead of dm_snapshot while the fsck is running.
This isn't something that has been done, because e2scrub is all that
commonly used, and most uses of dm_snapshot want the snapshot to have
the data blocks snapshotted as well as the metadata blocks.

So if you are looking for a project, one thing you could perhaps do is
to approach the device mapper developers at dm-devel@vger.kernel.org,
and try to add this feature to dm_snapshot.  It might be, though, that
getting your Android devices to use the latest kernels and using the
highest quality flash might be a better approach in the long run.

Cheers,

					- Ted
