Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE47F68E2
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2019 13:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfKJMPb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Nov 2019 07:15:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36444 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbfKJMPb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Nov 2019 07:15:31 -0500
Received: from callcc.thunk.org ([199.116.115.139])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAACFBDE016823
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Nov 2019 07:15:12 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ED77A4202FD; Sun, 10 Nov 2019 07:15:10 -0500 (EST)
Date:   Sun, 10 Nov 2019 07:15:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: [PATCH -v2] ext4: add more paranoia checking in
 ext4_expand_extra_isize handling
Message-ID: <20191110121510.GH23325@mit.edu>
References: <20191108024841.9668-1-tytso@mit.edu>
 <201911101835.qg5bu1Me%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911101835.qg5bu1Me%lkp@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I hadn't gotten around to resending the patch.  The original version
had a number of last-minute typos that had crept in...

      	     		    	       	   - Ted

From a67ad537964d10f94a4b990c084365e75316cde8 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 7 Nov 2019 21:43:41 -0500
Subject: [PATCH] ext4: add more paranoia checking in ext4_expand_extra_isize
 handling


It's possible to specify a non-zero s_want_extra_isize via debugging
option, and this can cause bad things(tm) to happen when using a file
system with an inode size of 128 bytes.

Add better checking when the file system is mounted, as well as when
we are actually doing the trying to do the inode expansion.

Reported-by: syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/inode.c | 15 +++++++++++++++
 fs/ext4/super.c | 21 ++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 381813205f99..c6e3fe287b50 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5569,8 +5569,23 @@ static int __ext4_expand_extra_isize(struct inode *inode,
 {
 	struct ext4_inode *raw_inode;
 	struct ext4_xattr_ibody_header *header;
+	unsigned int inode_size = EXT4_INODE_SIZE(inode->i_sb);
+	struct ext4_inode_info *ei = EXT4_I(inode);
 	int error;
 
+	/* this was checked at iget time, but double check for good measure */
+	if ((EXT4_GOOD_OLD_INODE_SIZE + ei->i_extra_isize > inode_size) ||
+	    (ei->i_extra_isize & 3)) {
+		EXT4_ERROR_INODE(inode, "bad extra_isize %u (inode size %u)",
+				 ei->i_extra_isize,
+				 EXT4_INODE_SIZE(inode->i_sb));
+		return -EFSCORRUPTED;
+	}
+	if ((new_extra_isize < ei->i_extra_isize) ||
+	    (new_extra_isize < 4) ||
+	    (new_extra_isize > inode_size - EXT4_GOOD_OLD_INODE_SIZE))
+		return -EINVAL;	/* Should never happen */
+
 	raw_inode = ext4_raw_inode(iloc);
 
 	header = IHDR(inode, raw_inode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7796e2ffc294..71af8780d4ee 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3545,12 +3545,15 @@ static void ext4_clamp_want_extra_isize(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
+	unsigned def_extra_isize = sizeof(struct ext4_inode) -
+						EXT4_GOOD_OLD_INODE_SIZE;
 
-	/* determine the minimum size of new large inodes, if present */
-	if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE &&
-	    sbi->s_want_extra_isize == 0) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						     EXT4_GOOD_OLD_INODE_SIZE;
+	if (sbi->s_inode_size == EXT4_GOOD_OLD_INODE_SIZE) {
+		sbi->s_want_extra_isize = 0;
+		return;
+	}
+	if (sbi->s_want_extra_isize < 4) {
+		sbi->s_want_extra_isize = def_extra_isize;
 		if (ext4_has_feature_extra_isize(sb)) {
 			if (sbi->s_want_extra_isize <
 			    le16_to_cpu(es->s_want_extra_isize))
@@ -3563,10 +3566,10 @@ static void ext4_clamp_want_extra_isize(struct super_block *sb)
 		}
 	}
 	/* Check if enough inode space is available */
-	if (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
-							sbi->s_inode_size) {
-		sbi->s_want_extra_isize = sizeof(struct ext4_inode) -
-						       EXT4_GOOD_OLD_INODE_SIZE;
+	if ((sbi->s_want_extra_isize > sbi->s_inode_size) ||
+	    (EXT4_GOOD_OLD_INODE_SIZE + sbi->s_want_extra_isize >
+							sbi->s_inode_size)) {
+		sbi->s_want_extra_isize = def_extra_isize;
 		ext4_msg(sb, KERN_INFO,
 			 "required extra inode space not available");
 	}
-- 
2.23.0

