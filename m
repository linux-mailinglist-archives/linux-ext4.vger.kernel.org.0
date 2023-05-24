Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9270EC19
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbjEXDuX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 23:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239290AbjEXDuP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 23:50:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2819E8
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 20:50:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O3nv3b023546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 23:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684900199; bh=Wz9Y2fZsqsMtKHCtbx2Up2waOXlgqywjsko2hKpHRNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RQe8hq2QUxWh6U5V/qYCCleddcWtVNhJsla4GvAYZ7vCEmaTNQkc7dEsOLNcjmwR2
         ZtscV2+lJfN52SFGObi4uXBrCY8vcaJudF6w4FeBV8ybyEdswrWzlsXqoXIjtiYjTR
         Zb6OCLa+9NLmkKuA1wlD2coTzXprbTL2NrfuCgWXN7ruH+lG82IKHG4sYKwDKpqte0
         5vZMfIrPNYfPmRLsTW2HBGJA6hHz6H8B5mW2tcGkYG3ZQvi4KoetxFfxtmb2dxH4Kt
         XAa1SUSZIcHlu2z2a9SeDNDLkOlB6qWvlUNno51x0VwuS8pwQzcm8CTk2HH2xDreq3
         5ge+QlXL0D2Ig==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8881415C052C; Tue, 23 May 2023 23:49:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com,
        syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com,
        syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: [PATCH 1/4] ext4: add EA_INODE checking to ext4_iget()
Date:   Tue, 23 May 2023 23:49:48 -0400
Message-Id: <20230524034951.779531-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230524034951.779531-1-tytso@mit.edu>
References: <20230524034951.779531-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a new flag, EXT4_IGET_EA_INODE which indicates whether the inode
is expected to have the EA_INODE flag or not.  If the flag is not
set/clear as expected, then fail the iget() operation and mark the
file system as corrupted.

This commit also makes the ext4_iget() always perform the
is_bad_inode() check even when the inode is already inode cache.  This
allows us to remove the is_bad_inode() check from the callers of
ext4_iget() in the ea_inode code.

Reported-by: syzbot+cbb68193bdb95af4340a@syzkaller.appspotmail.com
Reported-by: syzbot+62120febbd1ee3c3c860@syzkaller.appspotmail.com
Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
---
 fs/ext4/ext4.h  |  3 ++-
 fs/ext4/inode.c | 31 ++++++++++++++++++++++++++-----
 fs/ext4/xattr.c | 36 +++++++-----------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6948d673bba2..9525c52b78dc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2901,7 +2901,8 @@ typedef enum {
 	EXT4_IGET_NORMAL =	0,
 	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
 	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
-	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
+	EXT4_IGET_BAD =		0x0004, /* Allow to iget a bad inode */
+	EXT4_IGET_EA_INODE =	0x0008	/* Inode should contain an EA value */
 } ext4_iget_flags;
 
 extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce5f21b6c2b3..258f3cbed347 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4641,6 +4641,21 @@ static inline void ext4_inode_set_iversion_queried(struct inode *inode, u64 val)
 		inode_set_iversion_queried(inode, val);
 }
 
+static const char *check_igot_inode(struct inode *inode, ext4_iget_flags flags)
+
+{
+	if (flags & EXT4_IGET_EA_INODE) {
+		if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "missing EA_INODE flag";
+	} else {
+		if ((EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL))
+			return "unexpected EA_INODE flag";
+	}
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD))
+		return "unexpected bad inode w/o EXT4_IGET_BAD";
+	return NULL;
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -4650,6 +4665,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	struct ext4_inode_info *ei;
 	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
 	struct inode *inode;
+	const char *err_str;
 	journal_t *journal = EXT4_SB(sb)->s_journal;
 	long ret;
 	loff_t size;
@@ -4677,8 +4693,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	inode = iget_locked(sb, ino);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
-	if (!(inode->i_state & I_NEW))
+	if (!(inode->i_state & I_NEW)) {
+		if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+			ext4_error_inode(inode, function, line, 0, err_str);
+			iput(inode);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
 		return inode;
+	}
 
 	ei = EXT4_I(inode);
 	iloc.bh = NULL;
@@ -4944,10 +4966,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
-	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
-		ext4_error_inode(inode, function, line, 0,
-				 "bad inode without EXT4_IGET_BAD flag");
-		ret = -EUCLEAN;
+	if ((err_str = check_igot_inode(inode, flags)) != NULL) {
+		ext4_error_inode(inode, function, line, 0, err_str);
+		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index dfc2e223bd10..a27208129a80 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -433,7 +433,7 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 		return -EFSCORRUPTED;
 	}
 
-	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_NORMAL);
+	inode = ext4_iget(parent->i_sb, ea_ino, EXT4_IGET_EA_INODE);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
 		ext4_error(parent->i_sb,
@@ -441,23 +441,6 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 			   err);
 		return err;
 	}
-
-	if (is_bad_inode(inode)) {
-		ext4_error(parent->i_sb,
-			   "error while reading EA inode %lu is_bad_inode",
-			   ea_ino);
-		err = -EIO;
-		goto error;
-	}
-
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
-		ext4_error(parent->i_sb,
-			   "EA inode %lu does not have EXT4_EA_INODE_FL flag",
-			    ea_ino);
-		err = -EINVAL;
-		goto error;
-	}
-
 	ext4_xattr_inode_set_class(inode);
 
 	/*
@@ -478,9 +461,6 @@ static int ext4_xattr_inode_iget(struct inode *parent, unsigned long ea_ino,
 
 	*ea_inode = inode;
 	return 0;
-error:
-	iput(inode);
-	return err;
 }
 
 /* Remove entry from mbcache when EA inode is getting evicted */
@@ -1556,11 +1536,10 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 
 	while (ce) {
 		ea_inode = ext4_iget(inode->i_sb, ce->e_value,
-				     EXT4_IGET_NORMAL);
-		if (!IS_ERR(ea_inode) &&
-		    !is_bad_inode(ea_inode) &&
-		    (EXT4_I(ea_inode)->i_flags & EXT4_EA_INODE_FL) &&
-		    i_size_read(ea_inode) == value_len &&
+				     EXT4_IGET_EA_INODE);
+		if (IS_ERR(ea_inode))
+			goto next_entry;
+		if (i_size_read(ea_inode) == value_len &&
 		    !ext4_xattr_inode_read(ea_inode, ea_data, value_len) &&
 		    !ext4_xattr_inode_verify_hashes(ea_inode, NULL, ea_data,
 						    value_len) &&
@@ -1570,9 +1549,8 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 			kvfree(ea_data);
 			return ea_inode;
 		}
-
-		if (!IS_ERR(ea_inode))
-			iput(ea_inode);
+		iput(ea_inode);
+	next_entry:
 		ce = mb_cache_entry_find_next(ea_inode_cache, ce);
 	}
 	kvfree(ea_data);
-- 
2.31.0

