Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D827A687FD6
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Feb 2023 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjBBOWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Feb 2023 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjBBOWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Feb 2023 09:22:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888368E4A9
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 06:22:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P71Fy4cDHz4f3p1d
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 22:22:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7Mgx9tjTJV+Cw--.129S6;
        Thu, 02 Feb 2023 22:22:32 +0800 (CST)
From:   Zhang Yi <yi.zhang@huawei.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [RFC PATCH v2 2/2] ext4: add journal cycled recording support
Date:   Thu,  2 Feb 2023 22:22:24 +0800
Message-Id: <20230202142224.3679549-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230202142224.3679549-1-yi.zhang@huawei.com>
References: <20230202142224.3679549-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7Mgx9tjTJV+Cw--.129S6
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1fXFy5WFW5GF4xZr4ktFb_yoW5KFyUpr
        yDJFy3Cr1jvryUurWxXFs3XrWjvryFkFy7ur92kw1a9a9Fyr1xtFW2qF15ta4jqFWrX34k
        WFyrJ347Ga42kFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20x
        vY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07jb2-5UUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Introduce a new mount option names 'journal_cycle_record' to let jbd2
continue record journal log from the recovered head transaction block
or checkpointed/cleaned transactions on the previous mount.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

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
index 260c1b3e3ef2..d9eeda327539 100644
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
@@ -2772,6 +2776,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 			    !(sbi->s_mount_opt2 & EXT4_MOUNT2_DAX_INODE))) {
 			goto fail_dax_change_remount;
 		}
+
+		if (ctx_test_mount_opt2(ctx, EXT4_MOUNT2_JOURNAL_CYCLE_RECORD) &&
+		    !test_opt2(sb, JOURNAL_CYCLE_RECORD)) {
+			ext4_msg(NULL, KERN_ERR,
+				 "can't change journal_cycle_record on remount");
+			return -EINVAL;
+		}
 	}
 
 	return ext4_check_quota_consistency(fc, sb);
@@ -5293,6 +5304,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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
@@ -5698,6 +5714,8 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 		journal->j_flags |= JBD2_ABORT_ON_SYNCDATA_ERR;
 	else
 		journal->j_flags &= ~JBD2_ABORT_ON_SYNCDATA_ERR;
+	if (test_opt2(sb, JOURNAL_CYCLE_RECORD))
+		journal->j_flags |= JBD2_CYCLE_RECORD;
 	write_unlock(&journal->j_state_lock);
 }
 
-- 
2.31.1

