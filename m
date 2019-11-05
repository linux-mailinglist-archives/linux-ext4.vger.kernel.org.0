Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8E9F033E
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390344AbfKEQoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:41518 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390334AbfKEQoj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 93D26AE61;
        Tue,  5 Nov 2019 16:44:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33A041E4AA9; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 04/25] ext4: Move marking of handle as sync to ext4_add_nondir()
Date:   Tue,  5 Nov 2019 17:44:10 +0100
Message-Id: <20191105164437.32602-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Every caller of ext4_add_nondir() marks handle as sync if directory has
DIRSYNC set. Move this marking to ext4_add_nondir() so reduce some
duplication.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/namei.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a427d2031a8d..97cf1c8b56b2 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2550,9 +2550,12 @@ static void ext4_dec_count(handle_t *handle, struct inode *inode)
 static int ext4_add_nondir(handle_t *handle,
 		struct dentry *dentry, struct inode *inode)
 {
+	struct inode *dir = d_inode(dentry->d_parent);
 	int err = ext4_add_entry(handle, dentry, inode);
 	if (!err) {
 		ext4_mark_inode_dirty(handle, inode);
+		if (IS_DIRSYNC(dir))
+			ext4_handle_sync(handle);
 		d_instantiate_new(dentry, inode);
 		return 0;
 	}
@@ -2593,8 +2596,6 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		inode->i_fop = &ext4_file_operations;
 		ext4_set_aops(inode);
 		err = ext4_add_nondir(handle, dentry, inode);
-		if (!err && IS_DIRSYNC(dir))
-			ext4_handle_sync(handle);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -2625,8 +2626,6 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 		init_special_inode(inode, inode->i_mode, rdev);
 		inode->i_op = &ext4_special_inode_operations;
 		err = ext4_add_nondir(handle, dentry, inode);
-		if (!err && IS_DIRSYNC(dir))
-			ext4_handle_sync(handle);
 	}
 	if (handle)
 		ext4_journal_stop(handle);
@@ -3329,9 +3328,6 @@ static int ext4_symlink(struct inode *dir,
 	}
 	EXT4_I(inode)->i_disksize = inode->i_size;
 	err = ext4_add_nondir(handle, dentry, inode);
-	if (!err && IS_DIRSYNC(dir))
-		ext4_handle_sync(handle);
-
 	if (handle)
 		ext4_journal_stop(handle);
 	goto out_free_encrypted_link;
-- 
2.16.4

