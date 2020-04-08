Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E691A2B83
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDHVzz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:55:55 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52782 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgDHVzw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:52 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so402685pjb.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dr8n2yn6EsOkSCTVHEoi4j033Jna0CorAOaC29kYXiY=;
        b=pGS90TMNR8dT7aGyiqnzvPStg7bShXeFnoexEVQlmw44USrlaiCCAFXmYu+ZzJFP+p
         06gvGp42O5GVmWr5ZV2UBBwh81cp7Ic5WFe2T04aHeQuiZqC2PPuM61V8L4skWH/x+xt
         XV1jgtlkF0GowJ1F848ZB0z2sIeJLfwq01+xsOIU3LuNN++HkL0l5hM2WvTGNhvXupOl
         ZQm1DfzXKWs6xDr304t9ORl2ktck0l6GPVtBCFLUBAvayl0HnmRzynog1PRfuQWQiIuE
         i+8hTNLu1pJDTju2pAhZA896V/Yvtygx8K5o/BMRRCw52g1xW5dvzSeRCS++dGmAkPIQ
         pdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dr8n2yn6EsOkSCTVHEoi4j033Jna0CorAOaC29kYXiY=;
        b=Ov9NVLUs8/vkB7Yzz1rdasMxGiPeVGE6PABcVQHa0cPRvTtAoBuK2YuhixYiD62G5f
         2NjGEPZ5+J+mSk5uJ7rzj0kLUNuDI93jl6/9wHd4GRDs0j4mxHbev6Syy2hz2BZCLhxN
         gb3lRzDHB+B9dqLM3owukgygVv5vpT6VCBDEx/h8gZi1mYsV0KfBMPpMD4+7bMNIr9w6
         Ug8ZHzWi/A8vz82S0v0KiOr2yV2S7qYjyz/CcE78H/7n8rAG0G69/AkhiT4dFkdo0tm3
         NEdpkcjKl6It+wuF+hGiqlT63R9pC3midSRN0W6u/szJ6vXL5QURyzcZIVkVLqblWCHj
         OJ7Q==
X-Gm-Message-State: AGi0Pubt1sYNcE5vh9/Zz8s6x8TT5FXVrulQaqqLTuG2UiqaRUDe1xXF
        HKUh65o7wG2T9ovlDcmyDuaZTj/K
X-Google-Smtp-Source: APiQypLnCMarMLM7QZmzqykWNAJpkSiMtNmszW8HeYmri7j7Vmoh6G+uhPPBJzZa3psv/b9B4NhQZg==
X-Received: by 2002:a17:90a:ba09:: with SMTP id s9mr7927495pjr.20.1586382950492;
        Wed, 08 Apr 2020 14:55:50 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:50 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 08/20] ext4: add directory entry tracking routines
Date:   Wed,  8 Apr 2020 14:55:18 -0700
Message-Id: <20200408215530.25649-8-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
index c07ab844c335..669ecf12d392 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -950,6 +950,26 @@ enum {
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
@@ -1009,6 +1029,11 @@ struct ext4_inode_info {
 
 	rwlock_t i_fc_lock;
 
+	/*
+	 * Last mdata / dirent update that happened on this inode.
+	 */
+	struct ext4_fc_dentry_update *i_fc_mdata_update;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
@@ -1598,6 +1623,7 @@ struct ext4_sb_info {
 	struct list_head s_fc_q;	/* Inodes staged for fast commit
 					 * that have data changes in them.
 					 */
+	struct list_head s_fc_dentry_q;
 	spinlock_t s_fc_lock;
 };
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 151a4558c338..ccaaf1c09ba6 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -368,6 +368,8 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	return err;
 }
 
+static struct kmem_cache *ext4_fc_dentry_cachep;
+
 static inline
 void ext4_reset_inode_fc_info(struct inode *inode)
 {
@@ -376,6 +378,7 @@ void ext4_reset_inode_fc_info(struct inode *inode)
 	ei->i_fc_tid = 0;
 	ei->i_fc_lblk_start = 0;
 	ei->i_fc_lblk_end = 0;
+	ei->i_fc_mdata_update = NULL;
 }
 
 void ext4_init_inode_fc_info(struct inode *inode)
@@ -444,6 +447,94 @@ static int __ext4_fc_track_template(
 
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
@@ -494,3 +585,14 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
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
index 06d1e4a885b7..8fbd09dbfeca 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -534,4 +534,8 @@ void ext4_init_fast_commit(struct super_block *sb, journal_t *journal);
 void ext4_init_inode_fc_info(struct inode *inode);
 void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end);
+void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
+void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
+int __init ext4_init_fc_dentry_cache(void);
 #endif	/* _EXT4_JBD2_H */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 99b24156933a..a93dada07623 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4421,6 +4421,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	mutex_init(&sbi->s_orphan_lock);
 
 	INIT_LIST_HEAD(&sbi->s_fc_q);
+	INIT_LIST_HEAD(&sbi->s_fc_dentry_q);
 	spin_lock_init(&sbi->s_fc_lock);
 	sb->s_root = NULL;
 
@@ -6249,6 +6250,11 @@ static int __init ext4_init_fs(void)
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
@@ -6259,6 +6265,7 @@ static int __init ext4_init_fs(void)
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
2.26.0.110.g2183baf09c-goog

