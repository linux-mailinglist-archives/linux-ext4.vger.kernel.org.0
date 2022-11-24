Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB09E637A1A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Nov 2022 14:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKXNn3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Nov 2022 08:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKXNn3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Nov 2022 08:43:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44769827F4
        for <linux-ext4@vger.kernel.org>; Thu, 24 Nov 2022 05:43:27 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHzhY5r73zRpQC;
        Thu, 24 Nov 2022 21:42:53 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 24 Nov
 2022 21:43:25 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext4: add barrier info if journal device write cache is not enabled
Date:   Thu, 24 Nov 2022 21:57:44 +0800
Message-ID: <20221124135744.1488959-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The block layer will check and suppress flush bio if the device write
cache is not enabled, so the journal barrier will not go into effect
even if uer specify 'barrier=1' mount option. It's dangerous if the
write cache state is false negative, and we cannot distinguish such
case easily. So just give an info and an inquire interface to let
sysadmin know the barrier is suppressed for the case of write cache is
not enabled.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c |  3 +++
 fs/ext4/sysfs.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7cdd2138c897..916f756ebbca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5920,6 +5920,9 @@ static int ext4_load_journal(struct super_block *sb,
 
 	if (!(journal->j_flags & JBD2_BARRIER))
 		ext4_msg(sb, KERN_INFO, "barriers disabled");
+	else if (!bdev_write_cache(journal->j_dev))
+		ext4_msg(sb, KERN_INFO, "journal device write cache disabled, "
+					"barriers suppressed");
 
 	if (!ext4_has_feature_journal_needs_recovery(sb))
 		err = jbd2_journal_wipe(journal, !really_read_only);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index d233c24ea342..67f619c1202e 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -37,6 +37,7 @@ typedef enum {
 	attr_pointer_string,
 	attr_pointer_atomic,
 	attr_journal_task,
+	attr_journal_barrier,
 } attr_id_t;
 
 typedef enum {
@@ -135,6 +136,20 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 			task_pid_vnr(sbi->s_journal->j_task));
 }
 
+static ssize_t journal_barrier_show(struct ext4_sb_info *sbi, char *buf)
+{
+	journal_t *journal = sbi->s_journal;
+
+	if (!journal)
+		return sysfs_emit(buf, "none\n");
+
+	if (!(journal->j_flags & JBD2_BARRIER))
+		return sysfs_emit(buf, "disabled\n");
+	if (!bdev_write_cache(sbi->s_journal->j_dev))
+		return sysfs_emit(buf, "suppressed\n");
+	return sysfs_emit(buf, "enabled\n");
+}
+
 #define EXT4_ATTR(_name,_mode,_id)					\
 static struct ext4_attr ext4_attr_##_name = {				\
 	.attr = {.name = __stringify(_name), .mode = _mode },		\
@@ -243,6 +258,7 @@ EXT4_RO_ATTR_ES_STRING(last_error_func, s_last_error_func, 32);
 EXT4_ATTR(first_error_time, 0444, first_error_time);
 EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
+EXT4_ATTR(journal_barrier, 0444, journal_barrier);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
 EXT4_RW_ATTR_SBI_UL(last_trim_minblks, s_last_trim_minblks);
@@ -291,6 +307,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(first_error_time),
 	ATTR_LIST(last_error_time),
 	ATTR_LIST(journal_task),
+	ATTR_LIST(journal_barrier),
 #ifdef CONFIG_EXT4_DEBUG
 	ATTR_LIST(simulate_fail),
 #endif
@@ -438,6 +455,8 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return print_tstamp(buf, sbi->s_es, s_last_error_time);
 	case attr_journal_task:
 		return journal_task_show(sbi, buf);
+	case attr_journal_barrier:
+		return journal_barrier_show(sbi, buf);
 	}
 
 	return 0;
-- 
2.31.1

