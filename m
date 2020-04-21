Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C561B1D54
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 06:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDUEUt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 21 Apr 2020 00:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgDUEUt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 21 Apr 2020 00:20:49 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-ext4@vger.kernel.org
Subject: [Bug 207367] Accraid / aptec / Microsemi / ext4 / larger then 16TB
Date:   Tue, 21 Apr 2020 04:20:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: riteshh@linux.ibm.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-207367-13602-yZEGpWpy6p@https.bugzilla.kernel.org/>
In-Reply-To: <bug-207367-13602@https.bugzilla.kernel.org/>
References: <bug-207367-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=207367

--- Comment #5 from riteshh@linux.ibm.com ---
Hello All,

On 4/21/20 5:21 AM, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=207367
> 
> --- Comment #3 from Christian Kujau (lists@nerdbynature.de) ---
> On Mon, 20 Apr 2020, bugzilla-daemon@bugzilla.kernel.org wrote:
>> with kernel 5.7 only volumes under 16TB can be mount.
> 
> While this bug report is still missing details, I was able to reproduce
> this issue. Contrary to the subject line, it is not hardware related at
> all.
> 
> Linux 5.5 (Debian), creating a 17 TB sparse device (4 GB backing device):
> 
>   $ echo "0 36507222016 zero" | dmsetup create zero0
>   $ echo "0 36507222016 snapshot /dev/mapper/zero0 /dev/vdb p 128" | \
>     dmsetup create sparse0
> 
>   $ mkfs.ext4 -F /dev/mapper/sparse0
>   Creating filesystem with 4563402752 4k blocks and 285212672 inodes
>   Creating journal (262144 blocks): done
> 
>   $ mount -t ext4 /dev/mapper/sparse0 /mnt/disk/
>   $ df -h /mnt/disk/
>   Filesystem      Size  Used Avail Use% Mounted on
>   /dev/mapper/sparse0   17T   24K   17T   1% /mnt/disk
> 
> 
> The same fails on 5.7-rc2 (vanilla) with:
> 
> 
> ------------[ cut here ]------------
> would truncate bmap result
> WARNING: CPU: 0 PID: 640 at fs/iomap/fiemap.c:121
> iomap_bmap_actor+0x3a/0x40

Sorry about not seeing this through in the first place.

So the problem really is that the iomap_bmap() API
gives WARNING and does't return the physical block address in case
if the addr is > INT_MAX. (I guess this could be mostly since
the ioctl_fibmap() passes a user integer pointer and users of
iomap_bmap() may mostly be coming from ioctl path till now).

FYI - I do see that bmap() is also used by below APIs/subsystem.
Not sure if any of subsystems mentioned below may still fail later
if the underlying FS moved to iomap_bmap() interface or for
any existing callers of iomap_bmap() :-

1. mm/page-io.c (generic_swapfile_activate() func)
2. fs/cachefiles/rdwr.c
3. fs/ecryptfs/mmap.c
4. fs/jbd2/journal.c


But the changes done in ext4 to move to iomap_bmap() interface
resulted in this issue since jbd2 tries to find the block mapping
of on disk journal inode of ext4 and on a larger filesystem
this may fail given the design of iomap_bmap() to not
return addr if > INT_MAX.

So as I see it there are 3 options from here. Wanted to put this
on mailing list for discussion.

1. Make changes in iomap_bmap() to return the block address mapping.
But I still would like to mention that iomap designers may not agree
with this here Since the direction in general is to get rid of bmap()
interface anyways.

2. Revert the patch series of "bmap & fiemap to move to iomap interface"
(why fiemap too? - since if we decide to revert bmap anyways,
then we better fix the performance numbers report too coming from
fiemap. Also due to 3rd option below since if iomap_bmap() is
not changed, then we better keep both of this interface as is until
we get the solution like 3 below.)

3. To move to a new internal API like fiemap. But we need to change
fiemap in a way that it should also be allowed to used by internal
kernel APIs. Since as of now fiemap_extent struct is assumed to be
a user pointer.

(But the 3rd option as I see, won't be possible given the time frame to
fix this issue. Also note if we decide to revert the changes, then the
long term path would be to work on making fiemap used by internal kernel
APIs too).

struct fiemap_extent_info {
        unsigned int fi_flags;          /* Flags as passed from user */
        unsigned int fi_extents_mapped; /* Number of mapped extents */
        unsigned int fi_extents_max;    /* Size of fiemap_extent array */
        struct fiemap_extent __user *fi_extents_start; /* Start of
                                                        fiemap_extent array */
};


-ritesh

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
