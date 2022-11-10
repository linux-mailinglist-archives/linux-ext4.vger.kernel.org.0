Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862A662397D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiKJCE7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbiKJCEf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:04:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455EBE5
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:04:33 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N74s13cxjzRp7B;
        Thu, 10 Nov 2022 10:04:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:04:31 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 01/12] ext4: add debugfs interface
Date:   Thu, 10 Nov 2022 10:25:47 +0800
Message-ID: <20221110022558.7844-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110022558.7844-1-yi.zhang@huawei.com>
References: <20221110022558.7844-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add debugfs interface support, preparing to introduce fault injection
facility.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/sysfs.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5453852f98..53099ffe307f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1551,6 +1551,7 @@ struct ext4_sb_info {
 	struct percpu_counter s_sra_exceeded_retry_limit;
 	struct blockgroup_lock *s_blockgroup_lock;
 	struct proc_dir_entry *s_proc;
+	struct dentry *s_debug;
 	struct kobject s_kobj;
 	struct completion s_kobj_unregister;
 	struct super_block *s_sb;
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..f3e4049ec50e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
 #include <linux/part_stat.h>
+#include <linux/debugfs.h>
 
 #include "ext4.h"
 #include "ext4_jbd2.h"
@@ -59,6 +60,8 @@ struct ext4_attr {
 	} u;
 };
 
+static struct dentry *ext4_debugfs_root;
+
 static ssize_t session_write_kbytes_show(struct ext4_sb_info *sbi, char *buf)
 {
 	struct super_block *sb = sbi->s_buddy_cache->i_sb;
@@ -548,6 +551,8 @@ int ext4_register_sysfs(struct super_block *sb)
 		proc_create_seq_data("mb_structs_summary", 0444, sbi->s_proc,
 				&ext4_mb_seq_structs_summary_ops, sb);
 	}
+	if (ext4_debugfs_root)
+		sbi->s_debug = debugfs_create_dir(sb->s_id, ext4_debugfs_root);
 	return 0;
 }
 
@@ -555,6 +560,7 @@ void ext4_unregister_sysfs(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
+	debugfs_remove_recursive(sbi->s_debug);
 	if (sbi->s_proc)
 		remove_proc_subtree(sb->s_id, ext4_proc_root);
 	kobject_del(&sbi->s_kobj);
@@ -580,6 +586,7 @@ int __init ext4_init_sysfs(void)
 		goto feat_err;
 
 	ext4_proc_root = proc_mkdir(proc_dirname, NULL);
+	ext4_debugfs_root = debugfs_create_dir("ext4", NULL);
 	return ret;
 
 feat_err:
@@ -599,5 +606,6 @@ void ext4_exit_sysfs(void)
 	ext4_root = NULL;
 	remove_proc_entry(proc_dirname, NULL);
 	ext4_proc_root = NULL;
+	debugfs_remove_recursive(ext4_debugfs_root);
+	ext4_debugfs_root = NULL;
 }
-
-- 
2.31.1

