Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A6F6730F6
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 06:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjASFHy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 00:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjASFG4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 00:06:56 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE43527D
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 21:01:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ny7pF3qGQz4f3xbg
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 11:46:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7P4vMhj97D1Bw--.22527S6;
        Thu, 19 Jan 2023 11:46:15 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [RFC PATCH 2/2] ext4: add journal cycled recording support
Date:   Thu, 19 Jan 2023 11:46:00 +0800
Message-Id: <20230119034600.3431194-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
References: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7P4vMhj97D1Bw--.22527S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4DCry3WFWDJw1UCrW5Awb_yoW5KF47pr
        yDAFy7Cr1jvr1UurWxXFs3XrW0v34FkFy7ur9akw129a9Fyr1xJFW2qF15Ja4jqFWrX348
        WFy5J347Ga42kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj1lk7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new mount option names 'journal_cycle_record' to let jbd2
continue record journal log from the recovered head transaction block
or checkpointed/cleaned transactions on the previous mount.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..b62e7886fc2c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1267,6 +1267,8 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
 						    * scanning in mballoc
 						    */
+#define EXT4_MOUNT2_JOURNAL_CYCLE_RECORD	0x00000100 /* Journal cycled record
+							    * log on empty logging area */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..8260019830dc 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1591,6 +1591,7 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
+	Opt_journal_cycle_record,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1670,6 +1671,7 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("journal_checksum",	Opt_journal_checksum),
 	fsparam_flag	("nojournal_checksum",	Opt_nojournal_checksum),
 	fsparam_flag	("journal_async_commit",Opt_journal_async_commit),
+	fsparam_flag	("journal_cycle_record",Opt_journal_cycle_record),
 	fsparam_flag	("abort",		Opt_abort),
 	fsparam_enum	("data",		Opt_data, ext4_param_data),
 	fsparam_enum	("data_err",		Opt_data_err,
@@ -1826,6 +1828,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_journal_cycle_record, EXT4_MOUNT2_JOURNAL_CYCLE_RECORD,
+	 MOPT_SET | MOPT_2 | MOPT_NO_EXT2},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -2772,6 +2776,12 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 			    !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE))) {
 			goto fail_dax_change_remount;
 		}
+
+		if (ctx_test_mount_opt2(ctx, EXT4_MOUNT2_JOURNAL_CYCLE_RECORD)) {
+			ext4_msg(NULL, KERN_ERR,
+				 "can't change journal_cycle_record on remount");
+			return -EINVAL;
+		}
 	}
 
 	return ext4_check_quota_consistency(fc, sb);
@@ -5293,6 +5303,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			goto failed_mount3a;
 		}
 
+		if (test_opt2(sb, JOURNAL_CYCLE_RECORD)) {
+			ext4_msg(sb, KERN_ERR, "can't mount with "
+				 "journal_cycle_record, fs mounted w/o journal");
+			goto failed_mount3a;
+		}
 		if (test_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM)) {
 			ext4_msg(sb, KERN_ERR, "can't mount with "
 				 "journal_checksum, fs mounted w/o journal");
@@ -5698,6 +5713,8 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 		journal->j_flags |= JBD2_ABORT_ON_SYNCDATA_ERR;
 	else
 		journal->j_flags &= ~JBD2_ABORT_ON_SYNCDATA_ERR;
+	if (test_opt2(sb, JOURNAL_CYCLE_RECORD))
+		journal->j_flags |= JBD2_CYCLE_RECORD;
 	write_unlock(&journal->j_state_lock);
 }
 
-- 
2.31.1

