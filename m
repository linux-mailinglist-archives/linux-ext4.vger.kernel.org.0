Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8554D62164A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 15:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKHO0p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Nov 2022 09:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiKHO0L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Nov 2022 09:26:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1B5C771
        for <linux-ext4@vger.kernel.org>; Tue,  8 Nov 2022 06:24:51 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N69J53yrXzpWCP;
        Tue,  8 Nov 2022 22:21:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:24:48 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 02/12] ext4: introduce fault injection facility
Date:   Tue, 8 Nov 2022 22:46:07 +0800
Message-ID: <20221108144617.4159381-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108144617.4159381-1-yi.zhang@huawei.com>
References: <20221108144617.4159381-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce fault injection feature for ext4, it depends on the standard
fault-injection (CONFIG_FAULT_INJECTION) facility. User could test and
reinforce ext4 by introduce errors like checksum error, metadata I/O
error, journal error, etc. We could also inject precision fault by set
filters, such as group, inode, logical block of an inode, physical
block of filesystem, and so on.

This patch just add fault injection frame and 6 debugfs interfaces, does
not introduce any concrete faults, later patch will do this
step-by-step. Lists of debugfs interfaces:

 - available_faults: show available faults that we can inject.
 - inject_faults: set faults, can set multiple at one time.
 - inject_inode: set the inode filter, matches all inodes if not set.
 - inject_group: set the block group filter, similar to inject_inode.
 - inject_logical_block: set the logical block filter for one inode.
 - inject_physical_block: set the physical block filter for the fs.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/Kconfig |   9 +++
 fs/ext4/ext4.h  |  98 ++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 86699c8cab28..2c01c9b335c3 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -101,6 +101,15 @@ config EXT4_DEBUG
 	  If you select Y here, then you will be able to turn on debugging
 	  using dynamic debug control for mb_debug() / ext_debug() msgs.
 
+config EXT4_FAULT_INJECTION
+	bool "Ext4 fault injection support"
+	depends on EXT4_DEBUG && FAULT_INJECTION_DEBUG_FS
+	help
+	  Enables fault injecton facility. Allow test ext4 by injecting
+	  failures like checksum error, EIO, etc. The injection could be
+	  filtered by block group, inode, logical block of file, pyhsical
+	  block, and so on.
+
 config EXT4_KUNIT_TESTS
 	tristate "KUnit tests for ext4" if !KUNIT_ALL_TESTS
 	depends on EXT4_FS && KUNIT
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 53099ffe307f..7a030b0b51c7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -37,6 +37,7 @@
 #include <linux/falloc.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/fiemap.h>
+#include <linux/fault-inject.h>
 #ifdef __KERNEL__
 #include <linux/compat.h>
 #endif
@@ -1504,6 +1505,100 @@ struct ext4_orphan_info {
 						 * file blocks */
 };
 
+#ifdef CONFIG_EXT4_FAULT_INJECTION
+#define FAULT_NOTSET	(U64_MAX)
+
+enum ext4_fault_bits {
+	EXT4_FAULT_MAX
+};
+
+struct ext4_fault_attr {
+	struct fault_attr fa_attr;
+	struct dentry *fa_dir;
+	/* filter config */
+	u64 fa_group;			/* group number */
+	u64 fa_ino;			/* inode number */
+	u64 fa_lblock;			/* logical block number */
+	u64 fa_pblock;			/* pyhsical block number */
+	/* inject fault operations bitmap */
+	DECLARE_BITMAP(fail_ops, EXT4_FAULT_MAX);
+};
+
+extern void ext4_init_fault_inject(struct super_block *sb);
+extern bool ext4_should_fail(struct super_block *sb, unsigned int bit,
+			     u64 group, u64 ino, u64 lblock, u64 pblock);
+
+#define EXT4_FAULT_FN(bit, name, errno)						\
+static inline int ext4_fault_##name(struct super_block *sb)			\
+{										\
+	bool ret = ext4_should_fail(sb, EXT4_FAULT_##bit, FAULT_NOTSET,		\
+				    FAULT_NOTSET, FAULT_NOTSET, FAULT_NOTSET);	\
+	return (ret && errno) ? (int)errno : (int)ret;				\
+}
+#define EXT4_FAULT_GRP_FN(bit, name, errno)					\
+static inline int ext4_fault_##name(struct super_block *sb, ext4_group_t group)	\
+{										\
+	bool ret = ext4_should_fail(sb, EXT4_FAULT_##bit, group,		\
+				    FAULT_NOTSET, FAULT_NOTSET, FAULT_NOTSET);	\
+	return (ret && errno) ? (int)errno : (int)ret;				\
+}
+#define EXT4_FAULT_INODE_FN(bit, name, errno)					\
+static inline int ext4_fault_##name(struct super_block *sb, unsigned long ino)	\
+{										\
+	bool ret = ext4_should_fail(sb, EXT4_FAULT_##bit, FAULT_NOTSET,		\
+				    ino ? : FAULT_NOTSET, FAULT_NOTSET,		\
+				    FAULT_NOTSET);				\
+	return (ret && errno) ? (int)errno : (int)ret;				\
+}
+#define EXT4_FAULT_INODE_LBLOCK_FN(bit, name, errno)				\
+static inline int ext4_fault_##name(struct inode *inode, ext4_lblk_t lblock)	\
+{										\
+	bool ret = ext4_should_fail(inode->i_sb, EXT4_FAULT_##bit, FAULT_NOTSET,\
+				    inode->i_ino, lblock, FAULT_NOTSET);	\
+	return (ret && errno) ? (int)errno : (int)ret;				\
+}
+#define EXT4_FAULT_INODE_PBLOCK_FN(bit, name, errno)				\
+static inline int ext4_fault_##name(struct super_block *sb, unsigned long ino,	\
+				    ext4_fsblk_t pblock)			\
+{										\
+	bool ret = ext4_should_fail(sb, EXT4_FAULT_##bit, FAULT_NOTSET,		\
+				    ino ? : FAULT_NOTSET, FAULT_NOTSET, pblock);\
+	return (ret && errno) ? (int)errno : (int)ret;				\
+}
+
+#else
+static inline void ext4_init_fault_inject(struct super_block *sb)
+{
+}
+#define EXT4_FAULT_FN(bit, name, errno)						\
+static inline int ext4_fault_##name(struct super_block *sb)			\
+{										\
+	return 0;								\
+}
+#define EXT4_FAULT_GRP_FN(bit, name, errno)					\
+static inline int ext4_fault_##name(struct super_block *sb, ext4_group_t group)	\
+{										\
+	return 0;								\
+}
+#define EXT4_FAULT_INODE_FN(bit, name, errno)					\
+static inline int ext4_fault_##name(struct super_block *sb, unsigned long ino)	\
+{										\
+	return 0;								\
+}
+#define EXT4_FAULT_INODE_LBLOCK_FN(bit, name, errno)				\
+static inline int ext4_fault_##name(struct inode *inode, ext4_lblk_t lblock)	\
+{										\
+	return 0;								\
+}
+#define EXT4_FAULT_INODE_PBLOCK_FN(bit, name, errno)				\
+static inline int ext4_fault_##name(struct super_block *sb, unsigned long ino,	\
+				    ext4_fsblk_t pblock)			\
+{										\
+	return 0;								\
+}
+
+#endif /* CONFIG_EXT4_FAULT_INJECTION */
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1710,6 +1805,9 @@ struct ext4_sb_info {
 	u64 s_dax_part_off;
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
+#endif
+#ifdef CONFIG_EXT4_FAULT_INJECTION
+	struct ext4_fault_attr s_fault_attr;
 #endif
 	/* Record the errseq of the backing block device */
 	errseq_t s_bdev_wb_err;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index f3e4049ec50e..634768ebea2c 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -553,6 +553,8 @@ int ext4_register_sysfs(struct super_block *sb)
 	}
 	if (ext4_debugfs_root)
 		sbi->s_debug = debugfs_create_dir(sb->s_id, ext4_debugfs_root);
+	if (sbi->s_debug)
+		ext4_init_fault_inject(sb);
 	return 0;
 }
 
@@ -566,6 +568,152 @@ void ext4_unregister_sysfs(struct super_block *sb)
 	kobject_del(&sbi->s_kobj);
 }
 
+#ifdef CONFIG_EXT4_FAULT_INJECTION
+char *ext4_fault_names[EXT4_FAULT_MAX] = {
+	/* empty */
+};
+
+static int ext4_fault_available_show(struct seq_file *m, void *v)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ext4_fault_names); i++)
+		seq_printf(m, "%s\n", ext4_fault_names[i]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ext4_fault_available);
+
+static int ext4_fault_ops_show(struct seq_file *m, void *v)
+{
+	struct super_block *sb = m->private;
+	struct ext4_fault_attr *attr = &EXT4_SB(sb)->s_fault_attr;
+	int bit = 0;
+
+	for_each_set_bit(bit, attr->fail_ops, EXT4_FAULT_MAX)
+		seq_printf(m, "%s\n", ext4_fault_names[bit]);
+
+	return 0;
+}
+
+static int ext4_fault_ops_open(struct inode *inode, struct file *file)
+{
+	struct super_block *sb = inode->i_private;
+	struct ext4_fault_attr *attr = &EXT4_SB(sb)->s_fault_attr;
+	int ret;
+
+	ret = single_open(file, ext4_fault_ops_show, sb);
+	if (ret)
+		return ret;
+
+	if (file->f_flags & O_TRUNC)
+		bitmap_zero(attr->fail_ops, EXT4_FAULT_MAX);
+	return ret;
+}
+
+static int ext4_fault_ops_release(struct inode *inode, struct file *file)
+{
+	return single_release(inode, file);
+}
+
+static ssize_t ext4_fault_ops_write(struct file *file, const char __user *buffer,
+				    size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct super_block *sb = m->private;
+	struct ext4_fault_attr *attr = &EXT4_SB(sb)->s_fault_attr;
+	char fault_buf[32] = { };
+	char *fault_op;
+	int i;
+
+	if (count >= sizeof(fault_buf)) {
+		ext4_msg(sb, KERN_ERR, "fault operation too long %lu", count);
+		return -EINVAL;
+	}
+	if (copy_from_user(fault_buf, buffer, count))
+		return -EFAULT;
+
+	fault_op = strstrip(fault_buf);
+	for (i = 0; i < ARRAY_SIZE(ext4_fault_names); i++) {
+		if (!strcmp(fault_op, ext4_fault_names[i])) {
+			__set_bit(i, attr->fail_ops);
+			break;
+		}
+	}
+	*ppos += count;
+	return count;
+}
+
+static const struct file_operations ext4_fault_ops_fops = {
+	.open = ext4_fault_ops_open,
+	.read = seq_read,
+	.write = ext4_fault_ops_write,
+	.llseek = seq_lseek,
+	.release = ext4_fault_ops_release,
+};
+
+
+/*
+ * Inject fault injection for one operation, it could be filtered by the
+ * group, inode, logical block and physical block. Return true if we should
+ * inject fault.
+ */
+bool ext4_should_fail(struct super_block *sb, unsigned int bit,
+		      u64 group, u64 ino, u64 lblock, u64 pblock)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fault_attr *attr = &sbi->s_fault_attr;
+
+	if (!test_bit(bit, attr->fail_ops))
+		return false;
+
+#define EXT4_FAIL_FILTER_MATCH(conf, check)		\
+	((conf == FAULT_NOTSET) || (check == FAULT_NOTSET) || (conf == check))
+
+	if (!EXT4_FAIL_FILTER_MATCH(attr->fa_group, group))
+		return false;
+	if (!EXT4_FAIL_FILTER_MATCH(attr->fa_ino, ino))
+		return false;
+	if (!EXT4_FAIL_FILTER_MATCH(attr->fa_lblock, lblock))
+		return false;
+	if (!EXT4_FAIL_FILTER_MATCH(attr->fa_pblock, pblock))
+		return false;
+
+	return should_fail(&attr->fa_attr, 1);
+}
+
+void ext4_init_fault_inject(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fault_attr *attr = &sbi->s_fault_attr;
+	struct dentry *parent = sbi->s_debug;
+	struct dentry *dir;
+
+	attr->fa_attr = (struct fault_attr) FAULT_ATTR_INITIALIZER;
+	attr->fa_ino = FAULT_NOTSET;
+	attr->fa_group = FAULT_NOTSET;
+	attr->fa_lblock = FAULT_NOTSET;
+	attr->fa_pblock = FAULT_NOTSET;
+	memset(attr->fail_ops, 0, sizeof(attr->fail_ops));
+
+	dir = fault_create_debugfs_attr("fault_inject", parent, &attr->fa_attr);
+	if (IS_ERR(dir)) {
+		ext4_msg(sb, KERN_ERR, "failed to initialize fault_injection %ld",
+			 PTR_ERR(dir));
+		return;
+	}
+	attr->fa_dir = dir;
+	debugfs_create_file("available_faults", 0400, dir, sb,
+			    &ext4_fault_available_fops);
+	debugfs_create_file("inject_faults", 0600, dir, sb,
+			    &ext4_fault_ops_fops);
+	debugfs_create_x64("inject_inode", 0600, dir, &attr->fa_ino);
+	debugfs_create_x64("inject_group", 0600, dir, &attr->fa_group);
+	debugfs_create_x64("inject_logical_block", 0600, dir, &attr->fa_lblock);
+	debugfs_create_x64("inject_physical_block", 0600, dir, &attr->fa_pblock);
+}
+#endif /* CONFIG_EXT4_FAULT_INJECTION */
+
 int __init ext4_init_sysfs(void)
 {
 	int ret;
-- 
2.31.1

