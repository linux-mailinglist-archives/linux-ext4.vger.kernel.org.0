Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C330C7D1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Feb 2021 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbhBBRcP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Feb 2021 12:32:15 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50385 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237560AbhBBRaE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Feb 2021 12:30:04 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 112HTFsT022179
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Feb 2021 12:29:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 70BAD15C39E2; Tue,  2 Feb 2021 12:29:15 -0500 (EST)
Date:   Tue, 2 Feb 2021 12:29:15 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.45.7
Message-ID: <YBmL619A+a+viwX7@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.45.7 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.45.7

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.45.7.tar.gz

The release notes for 1.45.7 can be found below.

Cheers,

                                        - Ted

E2fsprogs 1.45.7 (January 28, 2021)
==================================

Updates/Fixes since v1.45.6:

UI and Features
---------------

Mke2fs will now warn when creating a file system on a DAX-capable device
and the block size is incompatible with DAX.

The chattr and lsattr programs now support using the 'x' attribute to
set/get dax support on a particular file.

E2fsprogs now supports the gnu.* extended attribute namespace, which
allows mke2fs -d to import the gnu.translator extended attributes.

Add support for the simultaneous enablement of the casefold and
encryption features, which ext4 supports starting with the v5.5 Linux
kernel.


Fixes
-----

When trying to run debugfs on a mounted file system, it's possible for
the superblock to be read in an inconsistent state; debugfs will now
retry the open in the hopes that it will succeed.

Fix an off-by-one error when validating the depth of an htree which
caused e2fsck to potentially fail to notice an invalid htree.

Fix potential buffer overrun in e2fsck when scanning directory blocks in
pass 2. (Addresses Google Bug: #158564737)

Fix tune2fs so that it unlocks the MMP block if it can't perform the
requested operation.

Fix mke2fs so it can import the contents of a directory using the -d
option when it has inode numbers that are greater than 2**32.   Also fix
an ommission were the extended attributes on the top-level directory was
not getting copied to the root directory.

Fix e4crypt so that the add_key operation uses the explicitly provided
salt if it is provided.

Fix resize2fs to prevent it from overflowing the block group descriptors
from overflowing the first block group.  (This can only happen when the
block size is 1k and the file system is very large.)

Fix debugfs's set_super_value command so it can set 64-bit integer
fields, such as s_kbytes_written.

Fix filefrag so that it won't crash if the kernel returns zero for
statfs(2)'s device id or if it returns a blocksize of zero the device's
blocksize.  This only happens with kernel bugs, but filefrag shouldn't
crash when the kernel returns an unexpected value.

Fix a few bad error code returns in the unix and sparse I/O managers.
(These errors rarely happen in real life; these were find thanks to a
static code checker.)

E2fsck will no longer try to fix duplicate file names in an encrypted
directory by mutating the file name since that will cause the decrypted
file name to be gibberish, or to contain invalid characters.

Updated and clarified various man pages.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

The misc/mke2fs.conf.in script now properly escaping of double quotes
when incorporating the mke2fs.conf into the default_profile.c file.  The
upstream version of the mke2fs.conf.in file doesn't have any double
quotes, but this allows a customized distribution of e2fsprogs to have
double quotes in its default mke2fs profile.

Speeded up mkfs.ext3 by batching calls to ext2fs_zero_blocks when
zeroing the blocks for an indirect-block mapped journal inode.

Fixed portability problem for implementations of grep which don't
support extended regexp's without the -E option.

Fix various compiler and Coverity warnings.

Fixed portability issue which caused a build failure when mkdir -p is
not thread safe; in that case, the Makefiles would not find the
install_sh replacement script.

Fixed various Debian packaging issues.

Synchronized changes from Android's AOSP e2fsprogs tree.

Update the Dutch, Malay, and Serbian translations from the translation
project.
