Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052E73014F1
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbhAWMCS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Jan 2021 07:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbhAWMCO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Jan 2021 07:02:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A536C0613D6;
        Sat, 23 Jan 2021 04:01:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lw17so7535927pjb.0;
        Sat, 23 Jan 2021 04:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N0g/6W67weZKE/emQois+mhBzpCT5sQWIDqOWot6Dus=;
        b=MpdXzdY8Hhqak6kSW1qFyRR1kf98GQC5avTXMg+AyQiF89Kxtfx2S3JShUPuN9In5s
         xnBFrONQjzJsxEn+lEWmpxAdHwB+pu2luT/V39p1xM0tUtikNWmvIbRkzyHB1t+6OS7L
         F/Eh4LEl7I9wJcIupGu4pgWn6oi0BdCU1GlkrRF0MnApYrGRow/vAHgne/X0FLh6EoRU
         vLDiPI/qfCn2NoErUMBGrTQLxYYN6Z01LPrRFdrlrR44UFkf3lZiPF3HzVmpCUUlaqto
         chVDxXK3bu3HYEHdMY2n9sGip/QfQ6NbE71j4wuRKU/akgfGjBa41FRtf4z72vus6+RN
         fZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N0g/6W67weZKE/emQois+mhBzpCT5sQWIDqOWot6Dus=;
        b=Y2JqsNe7Utx3M/SumBAeUah9lijBrt/VZ3j6X3FEtvEP8HuHpuEqxbNwoB4Mwisvgq
         FT8tIjY83antBOr5jYex+2r7B+mx+6iRawYGl+N/DWwa2baLhWItGcJeqKGmJawPPA5n
         +a7R4jyehBYQbOesY6hoBW9HVkAQhmRoy6QEO+CfLPOYqaE2X2QccmKjZ2Xs+NPLvI3x
         iFw1gOjx1ZrxVe/3Sh31+xGBp5WfjzQ0JtQOcIIVJb3XqPjHWJtiuVmPqOYUeblgCeBu
         zEVc0oXu4a9JKunZK8a6nwn9IB728WCUZD1H6gMsqPqrfXWtDZaPO7Y1EAWigLjNE/mr
         2XjQ==
X-Gm-Message-State: AOAM533euhrtpKAbKhPia3cK2LSnkafM9xDm72goBncwKjKws7Jz2f3O
        alXc3zoR13oc3EgeuwbUbr3wJtZvP1w=
X-Google-Smtp-Source: ABdhPJwzZZyK654XHL0E3V4B21GfqrW3hPXH8WuwWGF4fBT2Y4uHBL2LAoTmf2Yk+cRf13cLoF12zg==
X-Received: by 2002:a17:902:9009:b029:dc:52a6:575 with SMTP id a9-20020a1709029009b02900dc52a60575mr9114420plp.57.1611403293712;
        Sat, 23 Jan 2021 04:01:33 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x19sm11854648pfp.207.2021.01.23.04.01.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 04:01:33 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/4] jbd2: make jdb2_debug module parameter per device
Date:   Sat, 23 Jan 2021 20:00:43 +0800
Message-Id: <2364f54ebe6b03d4d12802531175f0b4cd2857ae.1611402263.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

On a multi-disk machine, because jbd2's debugging switch is global,this
confuses the logs of multiple disks. It is not easy to distinguish the
logs of each disk and the amount of generated logs is very large. Maybe
a separate debugging switch for each disk would be better, so that we
can easily distinguish the logs of a certain disk.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/jbd2/journal.c     | 55 ++++++++++++++++++++++++++++++++++++++++---
 fs/jbd2/transaction.c |  2 +-
 include/linux/jbd2.h  |  7 ++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..1f32b854ea28 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -101,13 +101,13 @@ EXPORT_SYMBOL(jbd2_inode_cache);
 static int jbd2_journal_create_slab(size_t slab_size);
 
 #ifdef CONFIG_JBD2_DEBUG
-void __jbd2_debug(int level, const char *file, const char *func,
+void jbd2_log(int level, journal_t *j, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
 
-	if (level > jbd2_journal_enable_debug)
+	if (!j || (level > jbd2_journal_enable_debug && level > j->j_debug_level))
 		return;
 	va_start(args, fmt);
 	vaf.fmt = fmt;
@@ -115,7 +115,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
 	printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
 	va_end(args);
 }
-EXPORT_SYMBOL(__jbd2_debug);
+EXPORT_SYMBOL(jbd2_log);
 #endif
 
 /* Checksumming functions */
@@ -1257,6 +1257,48 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
 	return seq_release(inode, file);
 }
 
+#ifdef CONFIG_JBD2_DEBUG
+static int jbd2_proc_debug_show(struct seq_file *m, void *v)
+{
+	journal_t *j = m->private;
+
+	seq_printf(m, "%d\n", j->j_debug_level);
+	return 0;
+}
+
+static int jbd2_proc_debug_open(struct inode *inode, struct file *file)
+{
+	journal_t *journal = PDE_DATA(inode);
+
+	return single_open(file, jbd2_proc_debug_show, journal);
+}
+
+static ssize_t jbd2_proc_debug_write(struct file *file,
+		const char __user *buffer, size_t count, loff_t *ppos)
+{
+	struct seq_file *seq = file->private_data;
+	journal_t *j = seq->private;
+	char c;
+
+	if (get_user(c, buffer))
+		return -EFAULT;
+
+	if (c < '0' || c > '5')
+		return -EINVAL;
+
+	j->j_debug_level = c - '0';
+	return count;
+}
+
+static const struct proc_ops jbd2_debug_proc_ops = {
+	.proc_open	= jbd2_proc_debug_open,
+	.proc_read	= seq_read,
+	.proc_write	= jbd2_proc_debug_write,
+	.proc_release	= single_release,
+	.proc_lseek	= seq_lseek,
+};
+#endif
+
 static const struct proc_ops jbd2_info_proc_ops = {
 	.proc_open	= jbd2_seq_info_open,
 	.proc_read	= seq_read,
@@ -1272,12 +1314,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
 	if (journal->j_proc_entry) {
 		proc_create_data("info", S_IRUGO, journal->j_proc_entry,
 				 &jbd2_info_proc_ops, journal);
+#ifdef CONFIG_JBD2_DEBUG
+		proc_create_data("jbd2_debug", S_IRUGO, journal->j_proc_entry,
+				 &jbd2_debug_proc_ops, journal);
+#endif
 	}
 }
 
 static void jbd2_stats_proc_exit(journal_t *journal)
 {
 	remove_proc_entry("info", journal->j_proc_entry);
+#ifdef CONFIG_JBD2_DEBUG
+	remove_proc_entry("jbd2_debug", journal->j_proc_entry);
+#endif
 	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
 }
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 9396666b7314..71787e826788 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -150,7 +150,7 @@ static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
 #ifdef CONFIG_JBD2_DEBUG
-	if (jbd2_journal_enable_debug &&
+	if ((jbd2_journal_enable_debug || transaction->t_journal->j_debug_level) &&
 	    time_after(transaction->t_start, ts)) {
 		ts = jbd2_time_diff(ts, transaction->t_start);
 		spin_lock(&transaction->t_handle_lock);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..600a2ea8324a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1211,6 +1211,13 @@ struct journal_s
 	 */
 	struct transaction_stats_s j_stats;
 
+#ifdef CONFIG_JBD2_DEBUG
+	/**
+	 * @j_debug_level: debugging level for jbd2.
+	 */
+	unsigned int j_debug_level;
+#endif
+
 	/**
 	 * @j_failed_commit: Failed journal commit ID.
 	 */
-- 
2.30.0

