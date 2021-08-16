Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C243ECC5D
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 03:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhHPB0d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Aug 2021 21:26:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58419 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229726AbhHPB0d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Aug 2021 21:26:33 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17G1PxSh018785
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Aug 2021 21:26:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6C25F15C3DB9; Sun, 15 Aug 2021 21:25:59 -0400 (EDT)
Date:   Sun, 15 Aug 2021 21:25:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: E2fsprogs 1.46.4-rc1 in git --- please test!
Message-ID: <YRm+p5N6P6E8VXoK@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've assembled the release notes for what will hopefully be e2fsprogs
1.46.4.  I've pushed out this out to the e2fsprogs git tree; please
take a look in the next few days.

Thanks,

					- Ted

E2fsprogs 1.46.4 (August 15, 2021)
==================================

Updates/Fixes since v1.46.3:

UI and Features
---------------

The defaults for mke2fs now call for 256 byte inodes for all file
systems (with the exception of file systems for the GNU Hurd, which only
supports 128 byte inodes).  Creating non-Hurd file systems with 128 byte
inodes will trigger a warning message to make sure users are aware of
the potential problems of using small/legacy inode sizes.

The bigalloc feature is now considered supported if the cluster size no
more than 16 times the block size.  So the mke2fs program has been
changes to only warn if the cluster size is larger than that.


Fixes
-----

E2fsck now checks to make sure directory entries do not reference
internal quota inodes.

E2image now includes the quota inodes when creating file system image,
since they are part of the file system metadata.

E2fsck now properly accounts the quota usage of the project quota file.

Fix a regression introduced in 1.64.3 where attempting to create a file
system image using mke2fs into a non-existent file would fail.
(Addresses Debian Bug: #992094)

Fix mke2fs to correctly create Posix ACL's on big-endian systems when
copying files from a directory hierarchy.

Updated and clarified the resize2fs man pages.  (Addresses Debian Bug:
#979411)



Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Improve various regression tests to be more portable and to reflect the
new default inode size of 256 byte inodes, even for small file systems.

Fixed a GNU Hurd portability problem which was causing tests to fail.

Fixed a test failure in f_baddotdir on big-endian systems.  This wasn't
necessarily a bug per se in e2fsck, but rather e2fsck having different
behaviour on big-endian systems.  (Addresses Debian Bug: #991922)

Use WantedBy=multi-user.target in e2scrub_reap.service.  (Addresses
Debian Bug: #991349)

Synchronize e2fsck/recovery.c with the kernel's fs/jbd2/recovery.c

Fix various Coverity and compiler warnings.

Fix various error pathes to make sure we don't leak resources or
potentially use or try to free uninitialized pointers.

Added a setup-schroot command for use on Debian porter boxes.

Updated config.guess and config.sub with newer versions from the FSF.

Update Czech, Dutch, French, Polish, Portuguese, and Swedish translations.

