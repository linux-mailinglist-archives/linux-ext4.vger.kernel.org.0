Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C9D17CF83
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2020 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCGRnu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 12:43:50 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43437 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbgCGRnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 12:43:50 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 027Hhk56011289
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 12:43:46 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2DFE642045B; Sat,  7 Mar 2020 12:43:46 -0500 (EST)
Date:   Sat, 7 Mar 2020 12:43:46 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Robert Yang <liezhi.yang@windriver.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH][e2fsprogs] misc/create_inode.c: set dir's mode correctly
Message-ID: <20200307174346.GB99899@mit.edu>
References: <1582542522-97508-1-git-send-email-liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582542522-97508-1-git-send-email-liezhi.yang@windriver.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 24, 2020 at 07:08:42PM +0800, Robert Yang wrote:
> The dir's mode has been set by ext2fs_mkdir() with umask, so
> reset it to the source's mode in set_inode_extra().
> 
> Fixed when source dir's mode is 521, but dst dir's mode is 721 which was
> incorrect.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>

Thanks for the report.  I've fixed in a slightly different way:

commit f106b01c98d7abc12af39aad4024f17ffa14dc06
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Mar 7 12:35:48 2020 -0500

    mke2fs: fix permissions setting with "mke2fs -d /path/files"
    
    Set the directory for directories in cases where the owner permissions
    is not rwx.  This was reported[1] by Robert Yang but we are using a
    different approach to fixing the issue.
    
    [1] https://lore.kernel.org/r/1582542522-97508-1-git-send-email-liezhi.yang@windriver.com
    
    Also set the permissions in a more portable way by making a
    distinction between the host OS's permissions stats and Linux's
    permissions.  We still assume the low 12 bits are the historical Unix
    assignments, but we don't assume ST_IFMT bits are the same as Linux's.
    
    Reported-by: Robert Yang <liezhi.yang@windriver.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/misc/create_inode.c b/misc/create_inode.c
index 1d9a596e..e8d1df6b 100644
--- a/misc/create_inode.c
+++ b/misc/create_inode.c
@@ -124,7 +124,7 @@ static errcode_t set_inode_extra(ext2_filsys fs, ext2_ino_t ino,
 	ext2fs_set_i_uid_high(inode, st->st_uid >> 16);
 	inode.i_gid = st->st_gid;
 	ext2fs_set_i_gid_high(inode, st->st_gid >> 16);
-	inode.i_mode |= st->st_mode;
+	inode.i_mode = (LINUX_S_IFMT & inode.i_mode) | (~S_IFMT & st->st_mode);
 	inode.i_atime = st->st_atime;
 	inode.i_mtime = st->st_mtime;
 	inode.i_ctime = st->st_ctime;
@@ -662,7 +662,7 @@ errcode_t do_write_internal(ext2_filsys fs, ext2_ino_t cwd, const char *src,
 		com_err(__func__, 0, "Warning: inode already set");
 	ext2fs_inode_alloc_stats2(fs, newfile, +1, 0);
 	memset(&inode, 0, sizeof(inode));
-	inode.i_mode = (statbuf.st_mode & ~LINUX_S_IFMT) | LINUX_S_IFREG;
+	inode.i_mode = (statbuf.st_mode & ~S_IFMT) | LINUX_S_IFREG;
 	inode.i_atime = inode.i_ctime = inode.i_mtime =
 		fs->now ? fs->now : time(0);
 	inode.i_links_count = 1;


