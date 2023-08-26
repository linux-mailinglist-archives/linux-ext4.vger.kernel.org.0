Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18147898DE
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Aug 2023 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHZT73 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Aug 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjHZT7R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Aug 2023 15:59:17 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D053D8
        for <linux-ext4@vger.kernel.org>; Sat, 26 Aug 2023 12:59:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500aed06ffcso1508723e87.0
        for <linux-ext4@vger.kernel.org>; Sat, 26 Aug 2023 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693079953; x=1693684753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnOZE00pB2nwztisFXMJukO46jcAlky4I2vTrBMI9LA=;
        b=a0i5W/ymRa63AVlvqYlfJbcgQ6oNSlKyKBS4/4ljOcG+cqnhzJpg5rWefB4mpUPQJ0
         9kOw/DEU94M6tpAzFwquCg/KjEghJpK85J/3T4W01OTg6HLWUxoT98N+lAcb6ffOK6Zq
         9Z/wvlIIFXoQGtKa+bKcDhLEn4ziJRLEjyRmQp8xzZFTzTI51eDptNn5qlxndC2g7mdl
         vreLGGOtz0XDmB6LkOt/kJHuZ8MNy5tCHh90uShzAaXALyy7sIKXRQYJybJ6/LopajyB
         GqFKTOLsCiDKvYBEOllL5XMhP+5HF77NbB0HF2VbseSF6jdHL3j3HMGgkjaNM/xBPtgB
         Rquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693079953; x=1693684753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnOZE00pB2nwztisFXMJukO46jcAlky4I2vTrBMI9LA=;
        b=WW/s5Wd9816cgs7GC3UUZSoSI3CxX94GZ3CVZJ1MI/TGIbMsn+pbsMz17EVPDM+Hpv
         ibtByx9UPvth4DVpaHn3ONKb3oAxepX4F0S/Qlu3WTP4uL8ZpmnRtGN3BxW2HbfdYM7O
         jObOxY2S7e3AOcp1wX2n95HriXqikaeoaxEifdPDNk8uLqnEP6pN7iAJwRfsmyem24kt
         26h5Fk8fFsrrLKOcQDrpKS+qcsYY9z+ZMdYwgXFY0e6fJ0nxGeDjqgcFgB+7XNMUMCV1
         D7jlnZHqo+/TKRNUUP4dl2BYEYh0yiA5d7t6Rprncke41hREl6vttK1msTN6nToFyOGB
         NXHQ==
X-Gm-Message-State: AOJu0YzQHpdGF15BQf1XLeQOPVhjzkzMCZfZaI5PB6n0xrzxSK58wO17
        odmbJ5iYBAr9GA3jRl7gZL0rlmrkuGy6irhG
X-Google-Smtp-Source: AGHT+IFFIgwpRh4aAeWAHWFPxuNdWaJ9D+5wEzjC0VYwCCYe19K0FX/UiQnPFbY2k2uZ8wwDjREfoA==
X-Received: by 2002:a05:6512:1296:b0:4fe:993:2218 with SMTP id u22-20020a056512129600b004fe09932218mr18857250lfs.31.1693079952801;
        Sat, 26 Aug 2023 12:59:12 -0700 (PDT)
Received: from localhost.localdomain ([188.123.154.217])
        by smtp.gmail.com with ESMTPSA id k6-20020aa7c386000000b0052889d090bfsm2511713edq.79.2023.08.26.12.59.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Aug 2023 12:59:12 -0700 (PDT)
From:   vk.en.mail@gmail.com
To:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Cc:     adilger@dilger.ca, Vitaliy Kuznetsov <vk.en.mail@gmail.com>
Subject: [PATCH v3] ext4: Add periodic superblock update check
Date:   Sat, 26 Aug 2023 23:58:41 +0400
Message-Id: <20230826195841.12496-1-vk.en.mail@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
References: <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Vitaliy Kuznetsov <vk.en.mail@gmail.com>

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
 fs/ext4/super.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..8bee05118c7a 100644
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
@@ -715,6 +767,7 @@ static void flush_stashed_error_work(struct work_struct *work)
 	 */
 	if (!sb_rdonly(sbi->s_sb) && journal) {
 		struct buffer_head *sbh = sbi->s_sbh;
+		bool call_notify_err = false;
 		handle = jbd2_journal_start(journal, 1);
 		if (IS_ERR(handle))
 			goto write_directly;
@@ -722,6 +775,10 @@ static void flush_stashed_error_work(struct work_struct *work)
 			jbd2_journal_stop(handle);
 			goto write_directly;
 		}
+
+		if (sbi->s_add_error_count > 0)
+			call_notify_err = true;
+
 		ext4_update_super(sbi->s_sb);
 		if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
 			ext4_msg(sbi->s_sb, KERN_ERR, "previous I/O error to "
@@ -735,7 +792,10 @@ static void flush_stashed_error_work(struct work_struct *work)
 			goto write_directly;
 		}
 		jbd2_journal_stop(handle);
-		ext4_notify_error_sysfs(sbi);
+
+		if (call_notify_err)
+			ext4_notify_error_sysfs(sbi);
+
 		return;
 	}
 write_directly:
--
2.39.2
