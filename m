Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9EE30C7EC
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 18:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbhBBRgA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 12:36:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50928 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237515AbhBBRcy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 12:32:54 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 112HW7kg023393
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 12:32:08 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5CA9215C39E2; Tue,  2 Feb 2021 12:32:07 -0500 (EST)
Date:   Tue, 2 Feb 2021 12:32:07 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.46.0
Message-ID: <YBmMlwBaoC58CARb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.46.0 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.0

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.46.0.tar.gz

The release notes for 1.46.0 can be found below.  Note that there is a
know build failulre if the Fuse libraries are not available (which is
fixed in git), and a regression test failure (j_recover_fast_commit)
on Big Endian systems which we are still investigating.  So there will
probably be a v1.46.1 release relatively soon....

Cheers,

                                        - Ted

E2fsprogs 1.46.0 (January 29, 2021)
===================================

Updates/Fixes since v1.45.7:

UI and Features
---------------

E2fsprogs now supports the fast_commit (COMPAT_FAST_COMMIT) feature.
This feature, first available in Linux version 5.10, adds a fine-grained
journalling which improves the latency of the fsync(2) system call.  It
should also improve the performance of ext4 file systems exported via
NFS.

E2fsprogs now supports the stable_inodes (COMPAT_STABLE_INODES) feature.
This needed to support the siphash file system encryption algorithm,
which calculates the initial vector (IV) for encryption based on the
UUID and the inode number.  This means that we can't renumber inodes
(for example, when shrinking a file system) and the UUID can't be
changed without breaking the ability to decrypt the encryption.

E2fsprogs now supports file systems which have both file system
encryption and the casefold feature enabled.  This requires Linux
version 5.10.

E2fsck now will check file names on file systems with case folding
enabled to make sure the characters are valid UTF-8 characters.  This is
done for file systems which enforce strict encodings, and optionally if
the extended "check_encoding" option is requested.

The fuse2fs program now supports the "-o norecovery" option, which will
suppress any journal replay that might be necessary, and mounts the file
system read-only.

E2fsck will now find and fix file system corruptions when the encrypted
files have a different policy from their containing directory.

The "htree" command in debugfs now displays the metadata checksums for
hash tree index blocks.

Dumpe2fs will print the error code that Linux kernels newer than v5.6
will save to indicate the class of error which triggered the ext4_error
event.

E2fsprogs programs (in particular, fuse2fs) can now update htree
directories without clearing the htree index.

Mke2fs now sets the s_overhead_cluster field, so that the kernel doesn't
need to calculate it at mount time.  This speeds up mounting very large
file systems.


Fixes
-----

E2fsck will properly handle checking for duplicated file names when case
folding is enabled.

Fix various bugs where a maliciously corrupted file systems could case
e2fsck and other e2fsprogs programs to crash.

Tune2fs will properly recalculate directory block checksums when
clearing the dir_index feature.

Fix a bug in e2fsck directory rehashing which could fail with ENOSPC
because it doesn't take into account the space needed for the metadata
checksum, and doesn't create a sufficiently deep index tree.

Clarify the e2fsck messages when it resets the directory link count when
it is set to the overflow value but it is no longer needed.

The filefrag program can now request the kernel to display the extent
status cache by using "filefrag -E".  (This requires Linux version 5.4
or newer.)


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Speed up mke2fs when creating large bigalloc file systems by optimizing
ext2fs_convert_subcluster_bitmap().

Bitmap blocks are now read using multiple threads (for systems with
pthread support).  This speeds up dumpe2fs, e2fsck, and debugfs for very
large file systems.

The dumpe2fs and tune2fs will now avoiding to read the block group
descriptors when they are not needed, which speeds up these program when
operating on very large file systems.

Drop use of the sysctl(2) system call, which is deprecated in Linux.

Add support for "configure --enable-developer-features" which enables
features only meant for developer.  The first such feature is "e2fsck -E
clear_all_uninit_bits", which clears the uninitialized bit on all
extents for all inodes.  Note that this can end up exposing uninitialized
data to userspace, and should only used in very specialized situations.

The e2fsck/revoke.c and e2fsck/recovery.c files are now kept idential
with the fs/jbd2 versions of these files in the kernel.

Fix various compiler and Coverity warnings.

Update to use gettext 0.19.8.  This also removes the built-in "intl"
directory as this is now considered deprecated by gettext.  This means
that if the system doesn't have gettext installed on the build system,
we will simply disable NLS support.

