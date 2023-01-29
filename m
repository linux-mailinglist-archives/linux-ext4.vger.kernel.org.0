Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C967FCAF
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Jan 2023 04:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjA2Dt6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 22:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjA2Dt5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 22:49:57 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170421A39
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 19:49:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P4HPn0FJFz4f3lKT
        for <linux-ext4@vger.kernel.org>; Sun, 29 Jan 2023 11:49:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgBXwLPT7NVjWfRpCg--.6314S4;
        Sun, 29 Jan 2023 11:49:51 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH] ext4: fix incorrect options show of original mount_opt and extend mount_opt2
Date:   Sun, 29 Jan 2023 11:49:39 +0800
Message-Id: <20230129034939.3702550-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBXwLPT7NVjWfRpCg--.6314S4
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7AF45ZrW8Kw47JF4rGrg_yoWrGr13pF
        nxXF15Ar409F1j9F47X3Z5Jr1ag3W0ya17Gr929w13Kr90v3W2qas7tF15XFy3XFWxGr1f
        X348tr1UWFW2y37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
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

Current _ext4_show_options() do not distinguish MOPT_2 flag, so it mixed
extend sbi->s_mount_opt2 options with sbi->s_mount_opt, it could lead to
show incorrect options, e.g. show fc_debug_force if we mount with
errors=continue mode and miss it if we set.

  $ mkfs.ext4 /dev/pmem0
  $ mount -o errors=remount-ro /dev/pmem0 /mnt
  $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
    #empty
  $ mount -o remount,errors=continue /mnt
  $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
    fc_debug_force
  $ mount -o remount,errors=remount-ro,fc_debug_force /mnt
  $ cat /proc/fs/ext4/pmem0/options | grep fc_debug_force
    #empty

Fixes: 995a3ed67fc8 ("ext4: add fast_commit feature and handling for extended mount options")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 28 +++++++++++++++++++++-------
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 140e1eb300d1..6479146140d2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1529,6 +1529,7 @@ struct ext4_sb_info {
 	unsigned int s_mount_opt2;
 	unsigned long s_mount_flags;
 	unsigned int s_def_mount_opt;
+	unsigned int s_def_mount_opt2;
 	ext4_fsblk_t s_sb_block;
 	atomic64_t s_resv_clusters;
 	kuid_t s_resuid;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..e6fe416a65a3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2894,7 +2894,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	int def_errors, def_mount_opt = sbi->s_def_mount_opt;
+	int def_errors;
 	const struct mount_opts *m;
 	char sep = nodefs ? '\n' : ',';
 
@@ -2906,15 +2906,28 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 
 	for (m = ext4_mount_opts; m->token != Opt_err; m++) {
 		int want_set = m->flags & MOPT_SET;
+		int opt_2 = m->flags & MOPT_2;
+		unsigned int mount_opt, def_mount_opt;
+
 		if (((m->flags & (MOPT_SET|MOPT_CLEAR)) == 0) ||
 		    m->flags & MOPT_SKIP)
 			continue;
-		if (!nodefs && !(m->mount_opt & (sbi->s_mount_opt ^ def_mount_opt)))
-			continue; /* skip if same as the default */
+
+		if (opt_2) {
+			mount_opt = sbi->s_mount_opt2;
+			def_mount_opt = sbi->s_def_mount_opt2;
+		} else {
+			mount_opt = sbi->s_mount_opt;
+			def_mount_opt = sbi->s_def_mount_opt;
+		}
+		/* skip if same as the default */
+		if (!nodefs && !(m->mount_opt & (mount_opt ^ def_mount_opt)))
+			continue;
+		/* select Opt_noFoo vs Opt_Foo */
 		if ((want_set &&
-		     (sbi->s_mount_opt & m->mount_opt) != m->mount_opt) ||
-		    (!want_set && (sbi->s_mount_opt & m->mount_opt)))
-			continue; /* select Opt_noFoo vs Opt_Foo */
+		     (mount_opt & m->mount_opt) != m->mount_opt) ||
+		    (!want_set && (mount_opt & m->mount_opt)))
+			continue;
 		SEQ_OPTS_PRINT("%s", token2str(m->token));
 	}
 
@@ -2942,7 +2955,7 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	if (nodefs || sbi->s_stripe)
 		SEQ_OPTS_PRINT("stripe=%lu", sbi->s_stripe);
 	if (nodefs || EXT4_MOUNT_DATA_FLAGS &
-			(sbi->s_mount_opt ^ def_mount_opt)) {
+			(sbi->s_mount_opt ^ sbi->s_def_mount_opt)) {
 		if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
 			SEQ_OPTS_PUTS("data=journal");
 		else if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
@@ -5086,6 +5099,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		goto failed_mount;
 
 	sbi->s_def_mount_opt = sbi->s_mount_opt;
+	sbi->s_def_mount_opt2 = sbi->s_mount_opt2;
 
 	err = ext4_check_opt_consistency(fc, sb);
 	if (err < 0)
-- 
2.31.1

