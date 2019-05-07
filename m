Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EECB16DE9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 01:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfEGXml (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 May 2019 19:42:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44619 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbfEGXml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 May 2019 19:42:41 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x47NgaPe016919
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 May 2019 19:42:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AA43E420024; Tue,  7 May 2019 19:42:36 -0400 (EDT)
Date:   Tue, 7 May 2019 19:42:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.45.1-rc1
Message-ID: <20190507234236.GA29445@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

PTAL.  I hope to release v1.45.1 in a few days.  This is pushed out to
the usual git repos, as well at:

https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/testing/v1.45.1-rc1/

       	      	 	 	    - Ted

E2fsprogs 1.45.1-rc1 (May 6, 2019)
==================================

Updates/Fixes since v1.45.0:

UI and Features
---------------

Teach the e2scrub and e2scub_all commands the -n option, which prints
what these commands would do.

Finalize the casefold support so it is synchronized with what we
actually shipped in the kernel.  This includes updating to Unicode 12.1,
dropping ASCII casefolding support, and switching from NFKD to NFD.  The
the ext4 feature name also changed from fname_encoding to casefold.
Add support for casefold to dumpe2fs and debugfs.

Debugfs now prints non-printable characters using C-style hex escape
sequences (e.g., "\xc1" instead of M-A).  The old scheme printed
filenames in an ambiguous way, which complicated using debugfs for ext4
encryption regression tests.

E2fsck now checks to make sure that all unused bits in the block
allocation bitmaps are set; if there are some unset bits in the block
bitmaps for file systems where the blocks_per_group is less than
8*blocksize (not the default), this can confuse the kernel's multi-block
allocator and return a bogus free extent.  E2fsprogs guarantees this
when it writes out the bitmap blocks, but it's possible that file system
blocks could have gotten corrupted since the last time e2fsprogs wrote
out the bitmap blocks.

E2fsck now has support write out a problem code log which can provide
more debugging and monitoring information.  This can be configured using
/etc/e2fsck.conf.


Fixes
-----

Teach e2scrub and e2scrub to give more intelligible error messages when
the lvm2 and util-linux packages are not installed, or if the commands
are not run as root.

Teach e2scrub_all to skip trying to run e2scrub on a logical volume if
its volume group did not have enough space to create a snapshot.
(Addresses Debian Bug: #924301)

E2scrub will tag its snapshots with UDISK_IGNORE so they do not show up
in GUI's.   (Addresses Debian Bug: #926112)

Mark the e2scrub service files to indicate that CAP_SYS_ADMIN and
CAP_SYS_RAWIO are required.  This avoids errors when e2scrub is run an
container where root does not have these capabilities.  (Addresses
Debian Bug: #926138)

Fix mke2fs's check for absurdly large disks.  Previously check was 2^10
too small, so mke2fs would fail when trying to format a 900TB file
system.

Fixed debugfs so it correctly prints ea_in_inode xattr values.

Fixed various casefold bugs.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Synchronized changes from Android's AOSP e2fsprogs tree.

Fix autoheader warnings caused by a missing template in AC_CHECK_LIB.

Fix the the "make install-strip" command.

Dropped utf8_* and nls_* symbols from the libext2fs shared library, to
avoid namespace contamination.

Fix the f_valid_ea_in_inode test so actually tests the ea_in_inode
feature.

Fixed various debian packaging issues.  (Addresses Debian Bug: #924275)

