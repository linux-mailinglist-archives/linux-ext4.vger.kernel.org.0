Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167F889365
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Aug 2019 21:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfHKTvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Aug 2019 15:51:31 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40221 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726053AbfHKTvb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Aug 2019 15:51:31 -0400
Received: from callcc.thunk.org (199-127-56.static.fiberhub.net [199.127.56.122] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7BJpKkk008062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Aug 2019 15:51:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 24A0D4218EF; Sun, 11 Aug 2019 15:51:14 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v2 1/3] ext4: add a new ioctl EXT4_IOC_CLEAR_ES_CACHE
Date:   Sun, 11 Aug 2019 15:51:06 -0400
Message-Id: <20190811195108.24308-1-tytso@mit.edu>
X-Mailer: git-send-email 2.22.0
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
 fs/ext4/extents_status.c | 28 ++++++++++++++++++++++++++++
 fs/ext4/extents_status.h |  1 +
 fs/ext4/ioctl.c          |  9 +++++++++
 4 files changed, 40 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa7a9e0..b22f24f1d365 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -649,6 +649,8 @@ enum {
 #define EXT4_IOC_SET_ENCRYPTION_POLICY	FS_IOC_SET_ENCRYPTION_POLICY
 #define EXT4_IOC_GET_ENCRYPTION_PWSALT	FS_IOC_GET_ENCRYPTION_PWSALT
 #define EXT4_IOC_GET_ENCRYPTION_POLICY	FS_IOC_GET_ENCRYPTION_POLICY
+/* ioctl codes 19--39 are reserved for fscrypt */
+#define EXT4_IOC_CLEAR_ES_CACHE		_IO('f', 40)
 
 #define EXT4_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
 #define EXT4_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7521de2dcf3a..02cc8eb3eb0e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1374,6 +1374,34 @@ static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan)
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
+	struct extent_status *es;
+	struct ext4_es_tree *tree;
+	struct rb_node *node;
+
+	write_lock(&ei->i_es_lock);
+	tree = &EXT4_I(inode)->i_es_tree;
+	tree->cache_es = NULL;
+	node = rb_first(&tree->root);
+	while (node) {
+		es = rb_entry(node, struct extent_status, rb_node);
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
index 131a8b7df265..e16785f431e7 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -248,5 +248,6 @@ extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
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

