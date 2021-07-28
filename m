Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275E3D8613
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jul 2021 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhG1DXw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 23:23:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52143 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233481AbhG1DXv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 23:23:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16S3NlJi021060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 23:23:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 55A7515C3DBC; Tue, 27 Jul 2021 23:23:47 -0400 (EDT)
Date:   Tue, 27 Jul 2021 23:23:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.46.3
Message-ID: <YQDNw26sFwyNofVY@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.46.3 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.3

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.46.3.tar.gz

The release notes for 1.46.3 can be found below.

Cheers,

                                        - Ted

E2fsprogs 1.46.3 (July 27, 2021)
================================

Updates/Fixes since v1.46.2:

UI and Features
---------------

Teach the filefrag program the -V option, which will print the version
of the tool, or if -V option is specified twice, will print the list of
supported FIEMAP flags.


Fixes
-----

Fix bug in resize2fs where growing a file system with MMP enabled and
there aren't any (or sufficient) reserved block group descriptors,
resize2fs could potentially overwrite the MMP block, leading to file
system corruption.  (Addresses Debian Bug: #984472)

Fix fast_commit portability problems on sparc64 and arm64 architectures
(the latter when running e2fsprogs compiled for arm32).   (Addresses
Debian Bug: #987641)

Fix missing mutex unlock in an error path in the Unix I/O manager.

Fix Direct I/O support in the Unix I/O manager (this was a regression
that was introduced in v1.46.2).

Fix mke2fs to avoid discarding blocks beyond the end of the file system
to be created when creating a file system which is smaller than 16MB and
the file system size was explicitly specified and smaller than the size
of the block device.  (Addresses Debian Bug: #989630)

Teach mke2fs to avoid giving a spurious warning about a pre-existing
partition table and it is creating a file system at a non-zero offset
(so the partition table wouldn't be overwritten in any case).
(Addresses Debian Bug: #989612)

Fix e2image -Q to prevent a multiplcation overflow could corrupt the
generated QCOW2 output file for very large file systems.

When e2fsck repairs '.' and '..' entries in corrupted directories, set
the file type in the directory entry to be EXT2_FT_DIR and do not leave
the file type as EXT2_FT_UNKNOWN.

Fix e2fsck so that the if the s_interval is zero, and the last mount or
write time is in the future, it will fix invalid last mount/write
timestamps in the superblock.  (This was a regression introduced in
v1.45.5.)

Fix potential memory leaks and seg faults when memory allocations fail.

Fix lsattr and chattr to avoid opening or calling EXT2_IOC_[GS]ETFLAGS
on devices, since this can cause some devices to react badly as a
result.  (Thix fixes a regression introduced in v1.46.2 and addresses
Debian Bug: #986332)

Updated and clarified the e2image and filefrag man pages.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Avoid forking an unnecessary thread in ext2fs_rw_bitmaps().

Avoid unnecessary stat(2) calls on mountpoints when checking if a file
system is mounted.

Add more modern support for Windows I/O.

Fix various compiler and valgrind warnings.

Synchronized changes from Android's AOSP e2fsprogs tree.

Update Dutch, Malay, and Serbian translations.
