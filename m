Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2DD6B9733
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjCNOFy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCNOFx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 10:05:53 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777CA56A8
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 07:05:33 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PbZzr09gsz4f40vG
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 22:05:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7IifxBkMdZxFQ--.62446S6;
        Tue, 14 Mar 2023 22:05:29 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 2/2] ext4: add journal cycled recording support
Date:   Tue, 14 Mar 2023 22:05:22 +0800
Message-Id: <20230314140522.3266591-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230314140522.3266591-1-yi.zhang@huaweicloud.com>
References: <20230314140522.3266591-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7IifxBkMdZxFQ--.62446S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4Duw47Cry8Kr48WF17ZFb_yoW5Kw1kpr
        yDAFy3Cryjvry8uFWxXFs3XrWjvryFka9rur95Cw129a9Fyr1xtFW2qF1rJa4UtFWrX348
        WFyrJ347Ga42ka7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUI4E_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new mount option 'journal_cycle_record', let jbd2 continue
to record new journal transactions from the recovered journal head or
the checkpointed transactions in the previous mount.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4eeb02d456a9..1106a4a3c341 100644
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
index 88f7b8a88c76..6e071aeea44a 100644
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
+	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -2761,6 +2765,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
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
@@ -5291,6 +5302,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
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
@@ -5691,6 +5707,8 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 		journal->j_flags |= JBD2_ABORT_ON_SYNCDATA_ERR;
 	else
 		journal->j_flags &= ~JBD2_ABORT_ON_SYNCDATA_ERR;
+	if (test_opt2(sb, JOURNAL_CYCLE_RECORD))
+		journal->j_flags |= JBD2_CYCLE_RECORD;
 	write_unlock(&journal->j_state_lock);
 }
 
-- 
2.31.1

