Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9475A664AD9
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbjAJSgm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Jan 2023 13:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbjAJSfq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Jan 2023 13:35:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E0550E4F;
        Tue, 10 Jan 2023 10:31:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B763661871;
        Tue, 10 Jan 2023 18:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A52C43396;
        Tue, 10 Jan 2023 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673375486;
        bh=/b0X2GzlIjVbb7cbPaNwsZN+/KWDEnhDlyS77vNRY7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDEWnbnv2J6exf7WH/TIiEqdikWDcjAgjzZQLRqq4SUsgNW97w9vNl+zjLBz8nlXW
         /PFbSO6tr774u0/a1KB+iIKHNrkUx+a3NjAs+1j9vmKR+8BDnRuN2YDgdJ85y/L4Sy
         wgFdRKUDPLL6UQxHHqQWCUwfTssSZdQgGCqKv4VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "linux-ext4@vger.kernel.org,
        syzbot+1a748d0007eeac3ab079@syzkaller.appspotmail.com, Theodore Tso" 
        <tytso@mit.edu>,
        syzbot+1a748d0007eeac3ab079@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.15 173/290] ext4: dont set up encryption key during jbd2 transaction
Date:   Tue, 10 Jan 2023 19:04:25 +0100
Message-Id: <20230110180037.882717895@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110180031.620810905@linuxfoundation.org>
References: <20230110180031.620810905@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@kernel.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h        |    4 ++--
 fs/ext4/fast_commit.c |    2 +-
 fs/ext4/namei.c       |   44 ++++++++++++++++++++++++--------------------
 3 files changed, 27 insertions(+), 23 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3647,8 +3647,8 @@ extern void ext4_initialize_dirent_tail(
 					unsigned int blocksize);
 extern int ext4_handle_dirty_dirblock(handle_t *handle, struct inode *inode,
 				      struct buffer_head *bh);
-extern int __ext4_unlink(handle_t *handle, struct inode *dir, const struct qstr *d_name,
-			 struct inode *inode);
+extern int __ext4_unlink(struct inode *dir, const struct qstr *d_name,
+			 struct inode *inode, struct dentry *dentry);
 extern int __ext4_link(struct inode *dir, struct inode *inode,
 		       struct dentry *dentry);
 
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1330,7 +1330,7 @@ static int ext4_fc_replay_unlink(struct
 		return 0;
 	}
 
-	ret = __ext4_unlink(NULL, old_parent, &entry, inode);
+	ret = __ext4_unlink(old_parent, &entry, inode, NULL);
 	/* -ENOENT ok coz it might not exist anymore. */
 	if (ret == -ENOENT)
 		ret = 0;
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3204,14 +3204,20 @@ end_rmdir:
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
@@ -3228,7 +3234,14 @@ int __ext4_unlink(handle_t *handle, stru
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
@@ -3237,12 +3250,12 @@ int __ext4_unlink(handle_t *handle, stru
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
@@ -3255,15 +3268,17 @@ int __ext4_unlink(handle_t *handle, stru
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
@@ -3281,16 +3296,7 @@ static int ext4_unlink(struct inode *dir
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
@@ -3301,8 +3307,6 @@ static int ext4_unlink(struct inode *dir
 	if (IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
-	if (handle)
-		ext4_journal_stop(handle);
 
 out_trace:
 	trace_ext4_unlink_exit(dentry, retval);


