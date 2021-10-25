Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21F43A3EE
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Oct 2021 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhJYUKr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Oct 2021 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbhJYUKR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Oct 2021 16:10:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DDC03AFF7;
        Mon, 25 Oct 2021 12:28:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1002])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F0FF01F430E8;
        Mon, 25 Oct 2021 20:28:15 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, jack@suse.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, kernel@collabora.com,
        Jan Kara <jack@suse.cz>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v9 03/31] fsnotify: clarify contract for create event hooks
Date:   Mon, 25 Oct 2021 16:27:18 -0300
Message-Id: <20211025192746.66445-4-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211025192746.66445-1-krisman@collabora.com>
References: <20211025192746.66445-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

Clarify argument names and contract for fsnotify_create() and
fsnotify_mkdir() to reflect the anomaly of kernfs, which leaves dentries
negavite after mkdir/create.

Remove the WARN_ON(!inode) in audit code that were added by the Fixes
commit under the wrong assumption that dentries cannot be negative after
mkdir/create.

Fixes: aa93bdc5500c ("fsnotify: use helpers to access data by data_type")
Link: https://lore.kernel.org/linux-fsdevel/87mtp5yz0q.fsf@collabora.com/
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 include/linux/fsnotify.h | 22 ++++++++++++++++------
 kernel/audit_fsnotify.c  |  3 +--
 kernel/audit_watch.c     |  3 +--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index df0fa4687a18..1e5f7435a4b5 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -192,16 +192,22 @@ static inline void fsnotify_inoderemove(struct inode *inode)
 
 /*
  * fsnotify_create - 'name' was linked in
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
+ * ->d_inode later
  */
-static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
+static inline void fsnotify_create(struct inode *dir, struct dentry *dentry)
 {
-	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+	audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify_dirent(inode, dentry, FS_CREATE);
+	fsnotify_dirent(dir, dentry, FS_CREATE);
 }
 
 /*
  * fsnotify_link - new hardlink in 'inode' directory
+ *
+ * Caller must make sure that new_dentry->d_name is stable.
  * Note: We have to pass also the linked inode ptr as some filesystems leave
  *   new_dentry->d_inode NULL and instantiate inode pointer later
  */
@@ -230,12 +236,16 @@ static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
 
 /*
  * fsnotify_mkdir - directory 'name' was created
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
+ * ->d_inode later
  */
-static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
+static inline void fsnotify_mkdir(struct inode *dir, struct dentry *dentry)
 {
-	audit_inode_child(inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+	audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
+	fsnotify_dirent(dir, dentry, FS_CREATE | FS_ISDIR);
 }
 
 /*
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 60739d5e3373..02348b48447c 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -160,8 +160,7 @@ static int audit_mark_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 
 	audit_mark = container_of(inode_mark, struct audit_fsnotify_mark, mark);
 
-	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group) ||
-	    WARN_ON_ONCE(!inode))
+	if (WARN_ON_ONCE(inode_mark->group != audit_fsnotify_group))
 		return 0;
 
 	if (mask & (FS_CREATE|FS_MOVED_TO|FS_DELETE|FS_MOVED_FROM)) {
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 2acf7ca49154..223eed7b39cd 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -472,8 +472,7 @@ static int audit_watch_handle_event(struct fsnotify_mark *inode_mark, u32 mask,
 
 	parent = container_of(inode_mark, struct audit_parent, mark);
 
-	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group) ||
-	    WARN_ON_ONCE(!inode))
+	if (WARN_ON_ONCE(inode_mark->group != audit_watch_group))
 		return 0;
 
 	if (mask & (FS_CREATE|FS_MOVED_TO) && inode)
-- 
2.33.0

