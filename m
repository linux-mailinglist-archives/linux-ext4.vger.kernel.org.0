Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD6517D988
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 08:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCIHGD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 03:06:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37920 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIHGD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Mar 2020 03:06:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21so4402321pfb.5
        for <linux-ext4@vger.kernel.org>; Mon, 09 Mar 2020 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7zCqNuvh/Mk5DnHQi8dh7Fher3M1FCZQaWL0YryFvY=;
        b=J+GHfYdjYahtxa2uZcBNjCVozqGtOSBSgeGUpAknpsezREigsCGuljkaTu6XG4V+eB
         efFappMtHWqOGl4Qnu94fbQkqb6azXU/IzEfQzv8tuv+6aT8aLx4rzGNZnENIjnWKRc8
         xjh3RPuHp77ti5yZrWtIJcom9NVcGvh1SRKhaYLw8BY3seD/NrGzBGdFRcSTxA3OWvsi
         Rp7X/POPOuZsB+IFimXIma8lg5cxTzWn6Dr8h/0P6HT/SAEUJHMcggOmG9jHL4KErijF
         hlL21PljBMTCn45A8wgu/2+YCxwxFYv1+nFAkqoQvm7UlCBcaJWONl0FiTKTh3sD8kD/
         Q+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7zCqNuvh/Mk5DnHQi8dh7Fher3M1FCZQaWL0YryFvY=;
        b=M3pyeQgwVZLUzwbuSmEgqHLaPIx/1BOWaxPfJHbPvaFQY0IiGZ8lRHEm8RBT8o/GdE
         KIg+1d9D0Y4wKgARO773Y+Hd6mDmEcPGTwoCIvwSAvnmK5p26he5OJwzj+qyoTobFRo3
         Oa57XisPj+PMABlnXDSZGc7HDK17lMAklWBFGMLL8phqnQao5IZltfDUsF1nwUq1QMYM
         cK6UsrF8xtxZS4Q0gV31AswJ1p/3vaGlb3dJfXJDvlw/ad9lfTSeH1k9nepeZfQw/1US
         rWwld0O4+hgpnL/hmSep2swOmtGJY/49lsPHw7Jg5uhQagI6HgFbanNQnKJtBnOaHUYx
         ROVw==
X-Gm-Message-State: ANhLgQ0mpfvNlSJlHpKJREez6fMkVeXCZPAJPCCmsBGiS5MYYdrLcVk0
        XlyQEpzBpJEcr5A/2MMP6a8xIp75
X-Google-Smtp-Source: ADFU+vvnI0rn/9DWKexz0FpvOiEWLa8p2ZHX0Czbgw+7UBUxAAlt2t83Ac6vX+fLF3fjDya2zmbZ6A==
X-Received: by 2002:a62:25c3:: with SMTP id l186mr15521251pfl.52.1583737561833;
        Mon, 09 Mar 2020 00:06:01 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id 8sm3692593pfp.67.2020.03.09.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 00:06:01 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v5 08/20] ext4: add directory entry tracking routines
Date:   Mon,  9 Mar 2020 00:05:14 -0700
Message-Id: <20200309070526.218202-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200309070526.218202-1-harshadshirwadkar@gmail.com>
References: <tytso@mit.edu>
 <20200309070526.218202-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Adds directory entry change tracking routines for fast commits. Use an
in-memory list of directory updates to track directory entry updates.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |  26 +++++++++
 fs/ext4/ext4_jbd2.c         | 102 ++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h         |   4 ++
 fs/ext4/super.c             |   7 +++
 include/trace/events/ext4.h |  28 ++++++++++
 5 files changed, 167 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 286d031a8635..1d4fb7b949a5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -951,6 +951,26 @@ enum {
 };
 
 
+/* Fast commit tags */
+#define EXT4_FC_TAG_ADD_RANGE		0x1
+#define EXT4_FC_TAG_DEL_RANGE		0x2
+#define EXT4_FC_TAG_CREAT_DENTRY	0x3
+#define EXT4_FC_TAG_ADD_DENTRY		0x4
+#define EXT4_FC_TAG_DEL_DENTRY		0x5
+
+/*
+ * In memory list of dentry updates that are performed on the file
+ * system used by fast commit code.
+ */
+struct ext4_fc_dentry_update {
+	int fcd_op;		/* Type of update create / add / del */
+	int fcd_parent;		/* Parent inode number */
+	int fcd_ino;		/* Inode number */
+	struct qstr fcd_name;	/* Dirent name qstr */
+	unsigned char fcd_iname[DNAME_INLINE_LEN];	/* Dirent name string */
+	struct list_head fcd_list;
+};
+
 /*
  * fourth extended file system inode data in memory
  */
@@ -1010,6 +1030,11 @@ struct ext4_inode_info {
 
 	rwlock_t i_fc_lock;
 
+	/*
+	 * Last mdata / dirent update that happened on this inode.
+	 */
+	struct ext4_fc_dentry_update *i_fc_mdata_update;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1599,6 +1624,7 @@ struct ext4_sb_info {
 	struct list_head s_fc_q;	/* Inodes staged for fast commit
 					 * that have data changes in them.
 					 */
+	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 57905ff75545..85ba3dc7a3b6 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -372,6 +372,8 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	return err;
 }
 
+static struct kmem_cache *ext4_fc_dentry_cachep;
+
 static inline
 void ext4_reset_inode_fc_info(struct inode *inode)
 {
@@ -380,6 +382,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_tid = 0;
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
+	ei->i_fc_mdata_update = NULL;
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -448,6 +451,94 @@ static int __ext4_fc_track_template(
 
 	return ret;
 }
+
+struct __ext4_dentry_update_args {
+	struct dentry *dentry;
+	int op;
+};
+
+static int __ext4_dentry_update(struct inode *inode, void *arg, bool update)
+{
+	struct ext4_fc_dentry_update *node;
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct __ext4_dentry_update_args *dentry_update =
+		(struct __ext4_dentry_update_args *)arg;
+	struct dentry *dentry = dentry_update->dentry;
+
+	write_unlock(&ei->i_fc_lock);
+	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
+	if (!node) {
+		write_lock(&ei->i_fc_lock);
+		return -ENOMEM;
+	}
+
+	node->fcd_op = dentry_update->op;
+	node->fcd_parent = dentry->d_parent->d_inode->i_ino;
+	node->fcd_ino = inode->i_ino;
+	if (dentry->d_name.len > DNAME_INLINE_LEN) {
+		node->fcd_name.name = kmalloc(dentry->d_name.len + 1,
+						GFP_KERNEL);
+		if (!node->fcd_iname) {
+			kmem_cache_free(ext4_fc_dentry_cachep, node);
+			return -ENOMEM;
+		}
+		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
+			dentry->d_name.len);
+	} else {
+		memcpy(node->fcd_iname, dentry->d_name.name,
+			dentry->d_name.len);
+		node->fcd_name.name = node->fcd_iname;
+	}
+	node->fcd_name.len = dentry->d_name.len;
+
+	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	list_add_tail(&node->fcd_list, &EXT4_SB(inode->i_sb)->s_fc_dentry_q);
+	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	write_lock(&ei->i_fc_lock);
+	EXT4_I(inode)->i_fc_mdata_update = node;
+
+	return 0;
+}
+
+void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry)
+{
+	struct __ext4_dentry_update_args args;
+	int ret;
+
+	args.dentry = dentry;
+	args.op = EXT4_FC_TAG_DEL_DENTRY;
+
+	ret = __ext4_fc_track_template(inode, __ext4_dentry_update,
+				       (void *)&args);
+	trace_ext4_fc_track_unlink(inode, dentry, ret);
+}
+
+void ext4_fc_track_link(struct inode *inode, struct dentry *dentry)
+{
+	struct __ext4_dentry_update_args args;
+	int ret;
+
+	args.dentry = dentry;
+	args.op = EXT4_FC_TAG_ADD_DENTRY;
+
+	ret = __ext4_fc_track_template(inode, __ext4_dentry_update,
+				       (void *)&args);
+	trace_ext4_fc_track_link(inode, dentry, ret);
+}
+
+void ext4_fc_track_create(struct inode *inode, struct dentry *dentry)
+{
+	struct __ext4_dentry_update_args args;
+	int ret;
+
+	args.dentry = dentry;
+	args.op = EXT4_FC_TAG_CREAT_DENTRY;
+
+	ret = __ext4_fc_track_template(inode, __ext4_dentry_update,
+				       (void *)&args);
+	trace_ext4_fc_track_create(inode, dentry, ret);
+}
+
 struct __ext4_fc_track_range_args {
 	ext4_lblk_t start, end;
 };
@@ -498,3 +589,14 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 		return;
 	jbd2_init_fast_commit(journal, EXT4_NUM_FC_BLKS);
 }
+
+int __init ext4_init_fc_dentry_cache(void)
+{
+	ext4_fc_dentry_cachep = KMEM_CACHE(ext4_fc_dentry_update,
+					   SLAB_RECLAIM_ACCOUNT);
+
+	if (ext4_fc_dentry_cachep == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 940a04a71637..883f715df71d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -531,4 +531,8 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 void ext4_init_inode_fc_info(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end);
+void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
+int __init ext4_init_fc_dentry_cache(void);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 86ec800baadf..24f975aa5967 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4412,6 +4412,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->s_orphan_lock);
 
 	INIT_LIST_HEAD(&sbi->s_fc_q);
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
@@ -6245,6 +6246,11 @@ static int __init ext4_init_fs(void)
 	err = init_inodecache();
 	if (err)
 		goto out1;
+
+	err = ext4_init_fc_dentry_cache();
+	if (err)
+		goto out05;
+
 	register_as_ext3();
 	register_as_ext2();
 	err = register_filesystem(&ext4_fs_type);
@@ -6255,6 +6261,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
+out05:
 	destroy_inodecache();
 out1:
 	ext4_exit_mballoc();
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 9424ffb2a54b..577c6230b23a 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2723,6 +2723,34 @@ TRACE_EVENT(ext4_error,
 		  __entry->function, __entry->line)
 );
 
+#define DEFINE_TRACE_DENTRY_EVENT(__type)				\
+	TRACE_EVENT(ext4_fc_track_##__type,				\
+	    TP_PROTO(struct inode *inode, struct dentry *dentry, int ret), \
+									\
+	    TP_ARGS(inode, dentry, ret),				\
+									\
+	    TP_STRUCT__entry(						\
+		    __field(dev_t, dev)					\
+		    __field(int, ino)					\
+		    __field(int, error)					\
+		    ),							\
+									\
+	    TP_fast_assign(						\
+		    __entry->dev = inode->i_sb->s_dev;			\
+		    __entry->ino = inode->i_ino;			\
+		    __entry->error = ret;				\
+		    ),							\
+									\
+	    TP_printk("dev %d:%d, inode %d, error %d, fc_%s",		\
+		      MAJOR(__entry->dev), MINOR(__entry->dev),		\
+		      __entry->ino, __entry->error,			\
+		      #__type)						\
+	)
+
+DEFINE_TRACE_DENTRY_EVENT(create);
+DEFINE_TRACE_DENTRY_EVENT(link);
+DEFINE_TRACE_DENTRY_EVENT(unlink);
+
 TRACE_EVENT(ext4_fc_track_range,
 	    TP_PROTO(struct inode *inode, long start, long end, int ret),
 
-- 
2.25.1.481.gfbce0eb801-goog

