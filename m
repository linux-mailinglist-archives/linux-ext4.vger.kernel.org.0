Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A647548208A
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Dec 2021 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhL3WQB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Dec 2021 17:16:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54843 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229528AbhL3WQB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Dec 2021 17:16:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BUMFwh4019814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 17:15:59 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9AE6615C33A3; Thu, 30 Dec 2021 17:15:58 -0500 (EST)
Date:   Thu, 30 Dec 2021 17:15:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.46.5
Message-ID: <Yc4vnkX72CE8m3nb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.46.5 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.5

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.46.5.tar.gz

The release notes for 1.46.5 can be found below.

Cheers,

                                        - Ted

E2fsprogs 1.46.5 (December 30, 2021)
====================================

Updates/Fixes since v1.46.4:

UI and Features
---------------

When resizing a file system and the inode count exceeds the 2**32
maximum, if resize2fs can successfully perform the resize by dropping
the last block group, resize2fs will do that in order to allow the file
system grow operation to succeed.  For example, using the default inode
ratio size of 16k, this will allow a successful resize to 64TB - 128MB
when the storage device is 64TB.


Fixes
-----

Avoid a potential infinite loop in resize2fs -P when the file system is
corrupted (introduced in e2fsprogs 1.45.5).  (Addresses github issue
https://github.com/tytso/e2fsprogs/issues/94)

E2fsck now updates the bg_checksum after fixing problems in the block
group descriptor, which eliminates some unnecessary messages printed or
asked of the system administrator.

Fixed some potential deadlock problems in the unix_io handler in the case
of I/O errors.  The fix should also improve the performance of parallel
bitmap loading.

Fixed e2fsck's fast commit handling which could result it in crashing
when trying to merge extents when there were none available to be
merged.

Fix e2fsck's support of quota limit data, which could sometimes get
dropped when the quota data needs to be regenerated, or when processing
the orphan list.

Fix tune2fs to correctly transfer the quota limits when converting quota
files to the internal quota inodes.  Also add support for tune2fs to
properly handle the older version 0 quota files.

Fix debugfs's get_quota and list_quota commands so that the header of
the report printed by these commands correctly reflect that the units of
used space is in bytes instead of blocks.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Add some additional packages to the setup-schroot script to account for
the fact that the script can be run on older Debian distributions and so
the build dependencies might omit some packages needed to build
e2fsprogs on unstable version of Debian.

Reduce resize2fs's CPU overhead when counting the number of blocks in
use which can reduce the wall clock time for very large file systems
by substantial amount.

Teach libuuid to use getrandom() or getentropy() if available in favor
of reading from /dev/[u]random.

Teach libss to use libreadline.so.8 if it is available.

Update some test expect files to fix some regression tests that were
broken in e2fsprogs 1.46.4.

If the PRINT_FAILED environment variable is set, failed tests will
display the diff output to make it easier to debug test failures on
autobuilders.

Fix various compiler warnings.

Update tst_getsize to use ext2fs_get_size2() to support testing devices
which are larger than 2**32 sectors.

Fixed spelling mistakes in the mke2fs.conf man page.

Update Chinese, Malay, Serbian, Spanish, Swedish, and Ukrainian
translations.

