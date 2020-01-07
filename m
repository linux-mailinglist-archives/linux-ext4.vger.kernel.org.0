Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE69132E45
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 19:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgAGSTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 13:19:33 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37281 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbgAGSTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jan 2020 13:19:32 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 007IJREj031741
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jan 2020 13:19:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 704074207DF; Tue,  7 Jan 2020 13:19:27 -0500 (EST)
Date:   Tue, 7 Jan 2020 13:19:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.45.5
Message-ID: <20200107181927.GD3619@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.45.5 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:
 
http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.5
 
and
 
http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.45.5.tar.gz

The release notes for 1.45.5 can be found below.  Note that if your
system/distribution allows malicious users to trick the system into
running e2fsck on an untrustworthy source as root, you are strongly
recommended to take this release, or else cherry-pick the following
commits:

8dd73c14 - e2fsck: abort if there is a corrupted directory block when rehashing
71ba1375 - e2fsck: don't try to rehash a deleted directory
101e73e9 - e2fsck: fix use after free in calculate_tree()

Cheers,

					- Ted

E2fsprogs 1.45.5 (January 7, 2020)
==================================

Updates/Fixes since v1.45.4:

Fixes
-----

E2fsck will no longer force a full file system check if time-based
forced checks are disabled and the last mount time or last write time in
the superblock are in the future.

Fix a potential out of bounds write when checking a maliciously
corrupted file system.  This is probably not exploitable on 64-bit
platforms, but may be exploitable on 32-bit binaries depending on how
the compiler lays out the stack variables.  (Addresses CVE-2019-5188)

Fixed spurious weekly e-mails when e2scrub_all is run via a cron job
on non-systemd systems.  (Addresses Debian Bug: #944033)

Remove an unnecessary sleep in e2scrub which could add up to an
additional two second delay during the boot up.  Also, avoid trying
to reap aborted snapshots if it has been disabled via e2scrub.conf.
(Addresses Debian Bug: #948193)

If a mischievous system administrator mounts a pseudo-file system such
as tmpfs with a device name that duplicates another mounted file system,
this could potentially confuse resize2fs when it needs to find the mount
point of a mounted file system.  (Who would have guessed?)  Add some
sanity checking so that we can make libext2fs more robust against such
insanity, at least on Linux.  (GNU HURD doesn't support st_rdev.)

Tune2fs now prohibits enabling or disabling uninit_bg if the file system
is mounted, since this could result in the file system getting
corrupted, and there is an unfortunate AskUbuntu article suggesting this
as a way to modify a file system's UUID on a live file system.  (Ext4
now has a way to do this safely, using the metadata_csum_seed feature,
which was added in the 4.4 Linux kernel.)

Fix potential crash in e2fsck when rebuilding very large directories on
file systems which have the new large_dir feature enable.

Fix support of 32-bit uid's and gid's in fuse2fs and in mke2fs -d.

Fix mke2fs's setting bad blocks to bigalloc file systems.

Fix a bug where fuse2fs would incorrectly report the i_blocks fields for
bigalloc file systems.

Resize2fs's minimum size estimates (via resize2fs -M) estimates are now
more accurate when run on mounted file systems.

Fixed potential memory leak in read_bitmap() in libext2fs.

Fixed various UBsan failures found when fuzzing file system images.
(Addresses Google Bug: #128130353)

Updated and clarified various man pages.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Speed up e2fsck on file systems with a very large number of inodes
caused by repeated calls to gettext().

The inode_io io_manager can now support files which are greater than
2GB.

The ext2_off_t and ext2_off64_t are now signed types so that
ext2fs_file_lseek() and ext2fs_file_llseek() can work correctly.

Reserve codepoint for the fast_commit feature.

Fixed various Debian packaging issues.

Fix portability problems for Illumous and on hurd/i386 (Addresses Debian
Bug: #944649)

Always compile the ext2fs_swap_* functions even on little-endian
architectures, so that debian/libext2fs.symbols can be consistent across
architectures.

Synchronized changes from Android's AOSP e2fsprogs tree.

Updated config.guess and config.sub with newer versions from the FSF.

Update the Chinese and Malay translations from the translation project.
