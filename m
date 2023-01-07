Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855766611A4
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 21:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAGUhx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 15:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjAGUht (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 15:37:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573543B907;
        Sat,  7 Jan 2023 12:37:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6974CE0AC8;
        Sat,  7 Jan 2023 20:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0BBC433F1;
        Sat,  7 Jan 2023 20:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673123864;
        bh=VSzHJfYKKrxC07hwQNVj/0slDjdR/S4juXYQrZhQd4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OW/brwgyWD9znGhMDZCEy+hbuDmWy0s4riViQcpyDc2PtTjYD12IZfQfeK8r9JPe0
         tUNzsAw+oh5rWFSSLe+iLV/3S2em4Mi5bn/pnHWafpj2NGc5LSq+GqogVyeeDDBmJ+
         9D7OC9uW/BsUaA8v6A+dfyjcVJ7x1cD6kvGUQ280qe5WRjerMtHg+Dh766VGCxnk3h
         NCbf2y6XoMT/5M6zOg0PBusWxo8o5tzFWifLiCIan3bbpSHYU55q1fKC/p2X1EjyOh
         A2UifectQRIkdibkcT3sl46If2a8ZiZZJOD6HZ7HAd3/awXWfnAwKZ4N/sv59jPEGp
         8mpn8lmUG9RLw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org,
        syzbot+1a748d0007eeac3ab079@syzkaller.appspotmail.com,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.10 2/2] ext4: don't set up encryption key during jbd2 transaction
Date:   Sat,  7 Jan 2023 12:37:13 -0800
Message-Id: <20230107203713.158042-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107203713.158042-1-ebiggers@kernel.org>
References: <20230107203713.158042-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 4c0d5778385cb3618ff26a561ce41de2b7d9de70 upstream.

Commit a80f7fcf1867 ("ext4: fixup ext4_fc_track_* functions' signature")
extended the scope of the transaction in ext4_unlink() too far, making
it include the call to ext4_find_entry().  However, ext4_find_entry()
can deadlock when called from within a transaction because it may need
to set up the directory's encryption key.

Fix this by restoring the transaction to its original scope.

Reported-by: syzbot+1a748d0007eeac3ab079@syzkaller.appspotmail.com
Fixes: a80f7fcf1867 ("ext4: fixup ext4_fc_track_* functions' signature")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20221106224841.279231-3-ebiggers@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h        |  4 ++--
 fs/ext4/fast_commit.c |  2 +-
 fs/ext4/namei.c       | 44 +++++++++++++++++++++++--------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb9c9e1813bc5..81dc61f1c557f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3486,8 +3486,8 @@ extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 extern int ext4_ci_compare(const struct inode *parent,
 			   const struct qstr *fname,
 			   const struct qstr *entry, bool quick);
-extern int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
-			 struct inode *inode);
+extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+			 struct inode *inode, struct dentry *dentry);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
 		       struct dentry *dentry);
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e26020598e194..be96f5ccc55dd 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1295,7 +1295,7 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl,
 		return 0;
 	}
 
-	ret = __ext4_unlink(NULL, old_parent, &entry, inode);
+	ret = __ext4_unlink(old_parent, &entry, inode, NULL);
 	/* -ENOENT ok coz it might not exist anymore. */
 	if (ret == -ENOENT)
 		ret = 0;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c17d5f399f9ea..e296b3587bb38 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3244,14 +3244,20 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
-		  struct inode *inode)
+int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+		  struct inode *inode,
+		  struct dentry *dentry /* NULL during fast_commit recovery */)
 {
 	int retval = -ENOENT;
 	struct buffer_head *bh;
 	struct ext4_dir_entry_2 *de;
+	handle_t *handle;
 	int skip_remove_dentry = 0;
 
+	/*
+	 * Keep this outside the transaction; it may have to set up the
+	 * directory's encryption key, which isn't GFP_NOFS-safe.
+	 */
 	bh = ext4_find_entry(dir, d_name, &de, NULL);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
@@ -3268,7 +3274,14 @@ int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name
 		if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 			skip_remove_dentry = 1;
 		else
-			goto out;
+			goto out_bh;
+	}
+
+	handle = ext4_journal_start(dir, EXT4_HT_DIR,
+				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
+	if (IS_ERR(handle)) {
+		retval = PTR_ERR(handle);
+		goto out_bh;
 	}
 
 	if (IS_DIRSYNC(dir))
@@ -3277,12 +3290,12 @@ int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name
 	if (!skip_remove_dentry) {
 		retval = ext4_delete_entry(handle, dir, de, bh);
 		if (retval)
-			goto out;
+			goto out_handle;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		ext4_update_dx_flag(dir);
 		retval = ext4_mark_inode_dirty(handle, dir);
 		if (retval)
-			goto out;
+			goto out_handle;
 	} else {
 		retval = 0;
 	}
@@ -3295,15 +3308,17 @@ int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name
 		ext4_orphan_add(handle, inode);
 	inode->i_ctime = current_time(inode);
 	retval = ext4_mark_inode_dirty(handle, inode);
-
-out:
+	if (dentry && !retval)
+		ext4_fc_track_unlink(handle, dentry);
+out_handle:
+	ext4_journal_stop(handle);
+out_bh:
 	brelse(bh);
 	return retval;
 }
 
 static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 {
-	handle_t *handle;
 	int retval;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
@@ -3321,16 +3336,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (retval)
 		goto out_trace;
 
-	handle = ext4_journal_start(dir, EXT4_HT_DIR,
-				    EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
-	if (IS_ERR(handle)) {
-		retval = PTR_ERR(handle);
-		goto out_trace;
-	}
-
-	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
-	if (!retval)
-		ext4_fc_track_unlink(handle, dentry);
+	retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry), dentry);
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3341,8 +3347,6 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
-	if (handle)
-		ext4_journal_stop(handle);
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);
-- 
2.39.0

