Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708E769646
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 14:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGaM0V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjGaM0I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 08:26:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEE61BEA
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 05:25:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so726452666b.2
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690806331; x=1691411131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZTfz0c1Ae4nad6Y+ptJKEYAcyxM+pzG7dcw+xKZv3U=;
        b=dh/BtGKzCRJLao1E3Dqjxscp91oVqJkhI2F5XAqK7t34Fqzw0bp53c4ZvIUHVkiOAj
         0glCstkOXHA04cBiM1SwDP9tIsFPvNjwqg2smG/BbLBydPrnozouLAp/ubDCXbkagcsw
         FZd9WpMJYX39V9MZAv2yhFk6qwETdKC9XN+f2X3T+lK23OPHlyofT6u6DaPeY6AA/q/q
         jDGhWPZn6q6+0MRXtLNIMr+rbUjcT6ekqnrH5riPD2Wju4GeDD06rAZ+o0GtzC91RjQt
         E7/asVxS6LxGQtoeRCAaTHIeEfkk/XbfLfH6CivL0vMc+1KKmeEj0dOVYKtEZnpLzAGs
         mxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690806331; x=1691411131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZTfz0c1Ae4nad6Y+ptJKEYAcyxM+pzG7dcw+xKZv3U=;
        b=dtrud9EfH9rHdEqvmUYFkOuXrhNgGPpz3IQ29XzHUdRpHwD1ao5c6BF/SUCcfM+g4n
         1GnsW8B1pv+39U6xFECEfYvk9FfMxsDgi5+R2ZcgkFhotHKZOnOt0oxKaV27TMy9K+ZU
         aNOQVOtGTLZAKCtasV8dpiTsfCFwI4/1bc2xmPda1QcsY+RpU1tIkqlL7Kl+xsFqSXX8
         QBGbeAPoRU7qZcbiT6+gbMol+apQZLFDO0qZUJrq8f23nmsmIPFwTkecoPh7mcEsF1DX
         /FurZATBXM8+CuodnIif6w9lWDX9s8/4QxmtSpkbeq3K58bA/ElAsa2amlgPdIW+FBtS
         tJcQ==
X-Gm-Message-State: ABy/qLYcb7sORRlFGxDJPbKnd+FswHdVWom5dyfkrytjfqPPk5tmsHyN
        PWn9NBgUOQa5vLuokkFWYyzgDTH8kZVeQ1KP
X-Google-Smtp-Source: APBJJlF7kkWZ3U4x3PQ/tCcgmIpgX4RQwXPnJxcLuwgSTSZeM1nNwp7RXoqn/7KdW1JAX12aMEcwVA==
X-Received: by 2002:a17:907:2c4d:b0:99b:d2a9:99f5 with SMTP id hf13-20020a1709072c4d00b0099bd2a999f5mr6973403ejc.6.1690806330816;
        Mon, 31 Jul 2023 05:25:30 -0700 (PDT)
Received: from localhost.localdomain (94-43-162-68.dsl.utg.ge. [94.43.162.68])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906841600b009934707378fsm6055955ejx.87.2023.07.31.05.25.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Jul 2023 05:25:30 -0700 (PDT)
From:   Vitaliy Kuznetsov <vk.en.mail@gmail.com>
To:     linux-ext4@vger.kernel.org, adilger@dilger.ca
Cc:     Vitaliy Kuznetsov <vk.en.mail@gmail.com>
Subject: [PATCH] ext4: Add periodic superblock update check
Date:   Mon, 31 Jul 2023 16:25:26 +0400
Message-Id: <20230731122526.30158-1-vk.en.mail@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch introduces a mechanism to periodically check and update
the superblock within the ext4 file system. The main purpose of this
patch is to keep the disk superblock up to date. The update will be
performed if more than one hour has passed since the last update, and
if more than 16MB of data have been written to disk.

This check and update is performed within the ext4_journal_commit_callback
function, ensuring that the superblock is written while the disk is
active, rather than based on a timer that may trigger during disk idle
periods.

Discussion https://www.spinics.net/lists/linux-ext4/msg85865.html

Signed-off-by: Vitaliy Kuznetsov <vk.en.mail@gmail.com>
---
 fs/ext4/super.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/sysfs.c |  4 ++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..2159e9705404 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -433,6 +433,57 @@ static time64_t __ext4_get_tstamp(__le32 *lo, __u8 *hi)
 #define ext4_get_tstamp(es, tstamp) \
 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)

+#define EXT4_SB_REFRESH_INTERVAL_SEC (3600) /* seconds (1 hour) */
+#define EXT4_SB_REFRESH_INTERVAL_KB (16384) /* kilobytes (16MB) */
+
+/*
+ * The ext4_maybe_update_superblock() function checks and updates the
+ * superblock if needed.
+ *
+ * This function is designed to update the on-disk superblock only under
+ * certain conditions to prevent excessive disk writes and unnecessary
+ * waking of the disk from sleep. The superblock will be updated if:
+ * 1. More than an hour has passed since the last superblock update, and
+ * 2. More than 16MB have been written since the last superblock update.
+ *
+ * @sb: The superblock
+ */
+static void ext4_maybe_update_superblock(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_super_block *es = sbi->s_es;
+	journal_t *journal = sbi->s_journal;
+	time64_t now;
+	__u64 last_update;
+	__u64 lifetime_write_kbytes;
+	__u64 diff_size;
+
+	if (sb_rdonly(sb) || !(sb->s_flags & SB_ACTIVE) ||
+	    !journal || (journal->j_flags & JBD2_UNMOUNT))
+		return;
+
+	now = ktime_get_real_seconds();
+	last_update = ext4_get_tstamp(es, s_wtime);
+
+	if (likely(now - last_update < EXT4_SB_REFRESH_INTERVAL_SEC))
+		return;
+
+	lifetime_write_kbytes = sbi->s_kbytes_written +
+		((part_stat_read(sb->s_bdev, sectors[STAT_WRITE]) -
+		  sbi->s_sectors_written_start) >> 1);
+
+	/* Get the number of kilobytes not written to disk to account
+	 * for statistics and compare with a multiple of 16 MB. This
+	 * is used to determine when the next superblock commit should
+	 * occur (i.e. not more often than once per 16MB if there was
+	 * less written in an hour).
+	 */
+	diff_size = lifetime_write_kbytes - le64_to_cpu(es->s_kbytes_written);
+
+	if (diff_size > EXT4_SB_REFRESH_INTERVAL_KB)
+		schedule_work(&EXT4_SB(sb)->s_error_work);
+}
+
 /*
  * The del_gendisk() function uninitializes the disk-specific data
  * structures, including the bdi structure, without telling anyone
@@ -459,6 +510,7 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	BUG_ON(txn->t_state == T_FINISHED);

 	ext4_process_freed_data(sb, txn->t_tid);
+	ext4_maybe_update_superblock(sb);

 	spin_lock(&sbi->s_md_lock);
 	while (!list_empty(&txn->t_private_list)) {
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6d332dff79dd..9f334de4f636 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -515,7 +515,8 @@ static const struct kobj_type ext4_feat_ktype = {

 void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
 {
-	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
+	if (sbi->s_add_error_count > 0)
+		sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
 }

 static struct kobject *ext4_root;
@@ -605,4 +606,3 @@ void ext4_exit_sysfs(void)
 	remove_proc_entry(proc_dirname, NULL);
 	ext4_proc_root = NULL;
 }
-
--
