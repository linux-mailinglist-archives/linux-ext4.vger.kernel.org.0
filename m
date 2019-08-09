Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F20588231
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437185AbfHISSm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Aug 2019 14:18:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60959 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437115AbfHISSl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Aug 2019 14:18:41 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-107.corp.google.com [104.133.0.107] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x79IIbkJ005819
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Aug 2019 14:18:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B959C4218EE; Fri,  9 Aug 2019 14:18:36 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] ext4: add a new ioctl EXT4_IOC_CLEAR_ES_CACHE
Date:   Fri,  9 Aug 2019 14:18:30 -0400
Message-Id: <20190809181831.10618-2-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190809181831.10618-1-tytso@mit.edu>
References: <20190809181831.10618-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The new ioctl EXT4_IOC_CLEAR_ES_CACHE will force an inode's extent
status cache to be cleared out.  This is intended for use for
debugging.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h           |  2 ++
 fs/ext4/extents_status.c | 29 +++++++++++++++++++++++++++++
 fs/ext4/extents_status.h |  1 +
 fs/ext4/ioctl.c          |  9 +++++++++
 4 files changed, 41 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 36954d951dff..f6c305b43ffa 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -649,6 +649,8 @@ enum {
 #define EXT4_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define EXT4_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
 #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
+/* ioctl codes 19--2F are reserved for fscrypt */
+#define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 30)
 
 #define EXT4_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
 #define EXT4_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6611f06c6cdc..95cfd2370bb0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1390,6 +1390,35 @@ static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan)
 	return nr_shrunk;
 }
 
+/*
+ * Called to support EXT4_IOC_CLEAR_ES_CACHE.  We can only remove
+ * discretionary entries from the extent status cache.  (Some entries
+ * must be present for proper operations.)
+ */
+void ext4_clear_inode_es(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct ext4_es_tree *tree;
+	struct rb_node *node;
+
+	write_lock(&ei->i_es_lock);
+	tree = &EXT4_I(inode)->i_es_tree;
+	tree->cache_es = NULL;
+	node = rb_first(&tree->root);
+	while (node) {
+		struct extent_status *es;
+		es = rb_entry(node, struct extent_status, rb_node);
+
+		node = rb_next(node);
+		if (!ext4_es_is_delayed(es)) {
+			rb_erase(&es->rb_node, &tree->root);
+			ext4_es_free_extent(inode, es);
+		}
+	}
+	ext4_clear_inode_state(inode, EXT4_STATE_EXT_PRECACHED);
+	write_unlock(&ei->i_es_lock);
+}
+
 #ifdef ES_DEBUG__
 static void ext4_print_pending_tree(struct inode *inode)
 {
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 391b5251a891..ee7c1530f1f1 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -251,5 +251,6 @@ extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
 extern void ext4_es_remove_blks(struct inode *inode, ext4_lblk_t lblk,
 				ext4_lblk_t len);
+extern void ext4_clear_inode_es(struct inode *inode);
 
 #endif /* _EXT4_EXTENTS_STATUS_H */
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 442f7ef873fc..15b1047878ab 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1115,6 +1115,14 @@ long ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_GET_ENCRYPTION_POLICY:
 		return fscrypt_ioctl_get_policy(filp, (void __user *)arg);
 
+	case EXT4_IOC_CLEAR_ES_CACHE:
+	{
+		if (!inode_owner_or_capable(inode))
+			return -EACCES;
+		ext4_clear_inode_es(inode);
+		return 0;
+	}
+
 	case EXT4_IOC_FSGETXATTR:
 	{
 		struct fsxattr fa;
@@ -1233,6 +1241,7 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_GET_ENCRYPTION_POLICY:
 	case EXT4_IOC_SHUTDOWN:
 	case FS_IOC_GETFSMAP:
+	case EXT4_IOC_CLEAR_ES_CACHE:
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.22.0

