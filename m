Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAF832767C
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 04:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhCADwQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Feb 2021 22:52:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41028 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231411AbhCADwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Feb 2021 22:52:15 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1213pQLl030893
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Feb 2021 22:51:27 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 64B6015C3428; Sun, 28 Feb 2021 22:51:26 -0500 (EST)
Date:   Sun, 28 Feb 2021 22:51:26 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org
Subject: [ANNOUNCE] e2fsprogs v1.46.2
Message-ID: <YDxkvpmXBqrDGmz2@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've released e2fsprogs 1.46.2 in all of the usual places; it's tagged
in the git trees on git.kernel.org, github, and sourceforge, and
available for download at:

http://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v1.46.2

and

http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.46.2.tar.gz

The release notes for 1.46.2 can be found below.

Cheers,

                                        - Ted

E2fsprogs 1.46.2 (February 28, 2021)
===================================

Updates/Fixes since v1.46.1:

UI and Features
---------------

Teach the tune2fs program to support "random" as an argument to the -c
option, which sets the maximum mount count.  (Addresses Debian Bug:
#926293)

Add support for the FS_NOCOMP_FL flag to chattr and lsattr.


Fixes
-----

When resizing a small file systems to a super-large file system size,
avoid issuing some scary bitmap operation warnings.  (Addresses Github
issue https://github.com/tytso/e2fsprogs/issues/60)

Fix the debugfs rdump and ls commands so they will work correctly for
uid's and gid's => 65536.  (Addresses Github issue issue
https://github.com/tytso/e2fsprogs/issues/63)

Fix the debugfs write and symlink commands so they support targets which
contain a pathname (instead of only working when writing a file or
creating a symlink in the current directory).  (Addresses Github issue
https://github.com/tytso/e2fsprogs/issues/61)

Fix Direct I/O support on block devices where the logical block size is
greater 1k.  (This includes Advanced Format HDD's, where the sector size
is 4k, and IBM Mainframe DASD's, where the sector size is 2k.)

Fix debugfs's logdump so it works on file systems whose block size is
greater than 8k.

Fix a where e2fsck could a crash when there is error while e2fsck is
trying to open the file system, and e2fsck calls ext2fs_mmp_stop()
before MMP has been initialized.  (Addresses Debian Bug: #696609)

Improved error checking in the fast commit replay code in e2fsck.

Updated and clarified the chattr man page.


Performance, Internal Implementation, Development Support etc.
--------------------------------------------------------------

Fix various compiler and Coverity warnings.

Update the Spanish translation from the translation project.

Update the e2fsck/iscan.c test program so that it builds again.

Fix an environmental dependency bug for the m_rootdir_acl regression
test.

Avoid the use of loff_t, which is not available for all compilers /
system include files.

Fix failure of the t_mmp_fail test when running on a device with a 4k
logical sector size.
