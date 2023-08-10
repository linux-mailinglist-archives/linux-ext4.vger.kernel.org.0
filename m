Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4562C777AEC
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjHJOjH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjHJOjG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 10:39:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F322268D
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 07:39:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so5872165e9.0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678343; x=1692283143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYJmtQscWhkMuVvmRx/sHZnDTTUu99GWMi9TCV+Sz04=;
        b=l0V9MbsMNaPTZjyVRzQAA5MqssZpHScBW9AhqH7ZSM2145cb5fOpv7XrqPnSTNuKNE
         23yqtjVOcc4z3sS9CmeWUONM09UFgPL3FT2WP8WT/lQEPcldY7/zpy5rQHYgHj5MXp2E
         PrmAJOZwBVVxdo/6kHrZw1XNxdOoMVtRi68D9RQnlOYFpJFQUCB4x5H+BAB4HoO04owz
         OPWD1iIs68ZDlAdnDRpbloylBMdfdGVNMo1VhiLWdMtn4X2GFgkQ0G3sXkAT9eGhteFt
         2I7TQ/FTrAEvz4EtF5KNT06Buo9YnEuPbU/JlOJASIJArb0WyWVMZU8zMURl0WMWvURI
         wE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678343; x=1692283143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYJmtQscWhkMuVvmRx/sHZnDTTUu99GWMi9TCV+Sz04=;
        b=WWe02/OSAegZpiN2/2OILI4ETZib0ivJ+GilRH4eoVFepjffLcJhg+4LiskrOn8vF6
         vKy96MYorDX9kxURC6rxB4G/IQzK5PFW4TcxHQj99QlVdMpNZllhxdFtvIku+s5RnHnC
         qjl9IohoXkKXCM3VgvhndJ4cJ2bdtCV/Z3OYXFN/fyWRPja0iX74m53GOmZVBo0UXAi6
         MlsSCPnkFDzXX7l035JSDx2NRR51rrN0ipu3+ycfs+SroM/aa/UESqgh6H3oX5TfqtN4
         5JRqFk8SAP+KdOBh9lDC4BED/1uoY5d+zcjNdizY86ymMjz/pi8UzDkt3m7U1CdTGXsp
         hdFg==
X-Gm-Message-State: AOJu0YxhXAhn4ufTSQgg/9JiAl/bem7oUwXHAEkJf95DWk9etrDjZL7U
        0F/cIBSzY3XcU0NkKc78OX16ovNr5NctLtMQ
X-Google-Smtp-Source: AGHT+IFlUpz5irTBnBHFm/f3Py4PlVnK/NfuEmSygzDDz9SgKu3/Kz2SSu6txNNDCC7DGWENdkF3Rg==
X-Received: by 2002:a05:600c:2109:b0:3fe:18e0:2fc6 with SMTP id u9-20020a05600c210900b003fe18e02fc6mr1881399wml.3.1691678343000;
        Thu, 10 Aug 2023 07:39:03 -0700 (PDT)
Received: from localhost.localdomain (94-43-162-68.dsl.utg.ge. [94.43.162.68])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003fe2120ad0bsm5228495wmc.41.2023.08.10.07.39.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Aug 2023 07:39:02 -0700 (PDT)
From:   Vitaliy Kuznetsov <vk.en.mail@gmail.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger@dilger.ca, Vitaliy Kuznetsov <vk.en.mail@gmail.com>
Subject: [PATCH v2] ext4: Add periodic superblock update check
Date:   Thu, 10 Aug 2023 18:38:52 +0400
Message-Id: <20230810143852.40228-1-vk.en.mail@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230731122526.30158-1-vk.en.mail@gmail.com>
References: <20230731122526.30158-1-vk.en.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
+		bool call_notify_err;
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
