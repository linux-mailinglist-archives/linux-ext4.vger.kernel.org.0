Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C738B129EDB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLXIO6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:14:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38754 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfLXIO4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:14:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so10419837pfc.5
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pLiWFaT+zyT888ljJF32mWlI/cTv7cmk0BQ6/SUoM0w=;
        b=pWOgp1kGrxrP+iE+6IgoYn6EXBvxFpolEQB1MeJ0uqTnu1lcqY5WW0H0Oyz6JSS7sd
         gaucHhUkIay8woGDGdDE8gFuvnXgPVV5LzpD4wRVDPetF6gkWskwEwye/oaynYM5oFb0
         vV6XWNmY+M8PiK0N1fqaJ2kXPwTFZSRAltL/32qQ9SB28u9UK/0HTAGyH9jmR9+FFniV
         fj/hdLnDLaddbFeFZph/daneAr1AVHNg7EN6C1cq/LTLmeRTiN073YQy2mMN4QKFoX+0
         15TLvT0myuK8CifLlP/4uaEfsu6eBOVHmma8fbXYj+GrRLq9xf+w8aCcfo6Uo/sHK2zO
         fspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pLiWFaT+zyT888ljJF32mWlI/cTv7cmk0BQ6/SUoM0w=;
        b=rEjX+Cx2AwnjhqoRmgYzom1eThy1swdGV8m54ECuz65hoHJvURRHAy9ZlPToibw2AR
         JlBYcD+aWXIqmiIvhhVTloTLWnuJ+lLOTl8j8klx9a4BHmas0DVMmMN6a2CB6I5i6xFX
         5/ssTWtD3Oytjdch2LixHk2+eqttFrrqxQxXY2gpPBudRix/QDr2sTxwLjENitcd34Ty
         OVVQp0QM3OKn4Z+mjJwOi2HOjgwgE4MiGkr7VE1bkLstYlVCHMUtvNRjzqFSIsAV8P25
         HY5fr+e/9y5qiEFNuHC4ynJoMcrUdHo2bvv7Z8m1IhzqKeQbdT0FU0QnrB5nmpMxL+cx
         tZ6w==
X-Gm-Message-State: APjAAAU5OFAbMUBa5yTvhw6RA3OtAbDwGUMZTydg1Cj5F2/ODU8jXo9Y
        CDuDaDadrGgCewfBNm5HhyalJrCb
X-Google-Smtp-Source: APXvYqwe0Rd5su4IQOulXKoNKwk7vybQ6K2qhMbHOFuH1ZIdSNUO+/Ni+n3FlAhjZXTA8PSQ+uctUw==
X-Received: by 2002:aa7:87cf:: with SMTP id i15mr33255045pfo.114.1577175295324;
        Tue, 24 Dec 2019 00:14:55 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:14:54 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 08/20] ext4: add directory entry tracking routines
Date:   Tue, 24 Dec 2019 00:13:12 -0800
Message-Id: <20191224081324.95807-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
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
index 5c40fa4b593c..6b08c4e2a08c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -946,6 +946,26 @@ enum {
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
@@ -1005,6 +1025,11 @@ struct ext4_inode_info {
 
 	rwlock_t i_fc_lock;
 
+	/*
+	 * Last mdata / dirent update that happened on this inode.
+	 */
+	struct ext4_fc_dentry_update *i_fc_mdata_update;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1590,6 +1615,7 @@ struct ext4_sb_info {
 	struct list_head s_fc_q;	/* Inodes staged for fast commit
 					 * that have data changes in them.
 					 */
+	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0907b1b91301..f3daa941cba5 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -331,6 +331,8 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	return err;
 }
 
+static struct kmem_cache *ext4_fc_dentry_cachep;
+
 static inline
 void ext4_reset_inode_fc_info(struct inode *inode)
 {
@@ -339,6 +341,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_tid = 0;
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
+	ei->i_fc_mdata_update = NULL;
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -407,6 +410,94 @@ static int __ext4_fc_track_template(
 
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
@@ -457,3 +548,14 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
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
index d7eca4b9a935..1539e672aec6 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -475,4 +475,8 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 void ext4_init_inode_fc_info(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end);
+void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
+int __init ext4_init_fc_dentry_cache(void);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 2f922ef522a3..71ecca296fe4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4334,6 +4334,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->s_orphan_lock);
 
 	INIT_LIST_HEAD(&sbi->s_fc_q);
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
@@ -6176,6 +6177,11 @@ static int __init ext4_init_fs(void)
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
@@ -6186,6 +6192,7 @@ static int __init ext4_init_fs(void)
 out:
 	unregister_as_ext2();
 	unregister_as_ext3();
+out05:
 	destroy_inodecache();
 out1:
 	ext4_exit_mballoc();
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 0f6d43dfd4b2..02f9fd718d37 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2703,6 +2703,34 @@ TRACE_EVENT(ext4_error,
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
2.24.1.735.g03f4e72817-goog

