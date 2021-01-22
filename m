Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2CE2FFCF0
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 07:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbhAVGpm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 01:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAVGos (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 01:44:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06AC061756;
        Thu, 21 Jan 2021 22:44:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m5so3124452pjv.5;
        Thu, 21 Jan 2021 22:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=SCv9WbBLaFw12yY+K5yyRXH+JBMeFQpgNWRlefewUu0=;
        b=M8Yi1b/3CIoDJ2lvoAshqMkbyUbKArG/tcFD1js2NupB2rbQ5ltPOKjVMiLwBAuGvq
         hP41Y/odxLY9DbkiQqzqvkfCvrLzG3LbwhFaemhB80P44eIc9OgtdrPyiVxdc6qtG6Q6
         2IyOso+2qsfOWImb0WnjToZYdIZSAwltmY5UXfKrdKHFA0aDTNi1+1CWTbMXtv7160vf
         WckQgYGv1cHTIPWo5zjNfjuXt5zOVr7JGbZ68xs8fwoYI96qpuhA9e8G4Y7n0VtcOpf9
         XFHOxejPd2S3XlMu+lM92964mQQWYstTY2WAf3ak9LlX8U+ElYfVMSeyOYjUOkUkmXtl
         iTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=SCv9WbBLaFw12yY+K5yyRXH+JBMeFQpgNWRlefewUu0=;
        b=URS7FPA9mNfVHyuL7K7UTLNWQjAMFV38y3++0PC5ZxNtjwxR68EEOQhs4jUrHine6a
         UU9qHZO9CCZBK2Ixyqy721Dsg9beGcVKaFW/9CY6xZxOaEEz7i2UMpC6JoGzelW7EJjh
         Zo1fg9UH50yaS4GgDzKZzu8bD7EHV7buhvYRCQC5BxJv7ppQWGunTbVTD3fLd85BvU5e
         aL9mRDPPRRUe15zirwXjpDeHBk55LGRQW/UvU5VTrMSag0HuCKf/bs6tIu/MEyzScnWZ
         hnxqqZMc+5wBDkxcwQYyQPFkElsG+G114e4ekYyuumc5RDoori+E4Jcpir3uB/5VDsMd
         Cekw==
X-Gm-Message-State: AOAM531ZVuKE9q7XvPqHkoCEcAmhpJLkr2hCzoIh9nfZpebvTLH8Ab8R
        8/KvVZC7iH8po4z8oJNnujs=
X-Google-Smtp-Source: ABdhPJzmsnMbmibVnaPxcOy7UBIBlVJcoqzmX0Zo319cQpBAARg8WYPdMzFCoNy6HXq7nEEcpiYWoA==
X-Received: by 2002:a17:902:b203:b029:dc:973:3ad0 with SMTP id t3-20020a170902b203b02900dc09733ad0mr3483093plr.44.1611297848240;
        Thu, 21 Jan 2021 22:44:08 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t22sm8319641pgm.18.2021.01.21.22.44.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 22:44:07 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] jbd2: make jdb2_debug module parameter per device
Date:   Fri, 22 Jan 2021 14:43:19 +0800
Message-Id: <b5a6fbe941f61289f15d84d9cad42df912daee7f.1611287342.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611287342.git.brookxu@tencent.com>
References: <cover.1611287342.git.brookxu@tencent.com>
In-Reply-To: <cover.1611287342.git.brookxu@tencent.com>
References: <cover.1611287342.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

On a multi-disk machine, because jbd2's debugging switch is global,this
confuses the logs of multiple disks. It is not easy to distinguish the
logs of each disk and the amount of generated logs is very large. Or a
separate debugging switch for each disk would be better, so that you
can easily distinguish the logs of a certain disk.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/jbd2/journal.c     | 63 +++++++++++++++++++++++++++++++++++--------
 fs/jbd2/transaction.c |  2 +-
 include/linux/jbd2.h  |  7 +++++
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..ae147cc713c7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -48,14 +48,6 @@
 #include <linux/uaccess.h>
 #include <asm/page.h>
 
-#ifdef CONFIG_JBD2_DEBUG
-ushort jbd2_journal_enable_debug __read_mostly;
-EXPORT_SYMBOL(jbd2_journal_enable_debug);
-
-module_param_named(jbd2_debug, jbd2_journal_enable_debug, ushort, 0644);
-MODULE_PARM_DESC(jbd2_debug, "Debugging level for jbd2");
-#endif
-
 EXPORT_SYMBOL(jbd2_journal_extend);
 EXPORT_SYMBOL(jbd2_journal_stop);
 EXPORT_SYMBOL(jbd2_journal_lock_updates);
@@ -101,13 +93,13 @@ EXPORT_SYMBOL(jbd2_inode_cache);
 static int jbd2_journal_create_slab(size_t slab_size);
 
 #ifdef CONFIG_JBD2_DEBUG
-void __jbd2_debug(int level, const char *file, const char *func,
+void jbd2_log(int level, journal_t *j, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
 
-	if (level > jbd2_journal_enable_debug)
+	if (!j || level > j->j_debug_level)
 		return;
 	va_start(args, fmt);
 	vaf.fmt = fmt;
@@ -115,7 +107,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
 	printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
 	va_end(args);
 }
-EXPORT_SYMBOL(__jbd2_debug);
+EXPORT_SYMBOL(jbd2_log);
 #endif
 
 /* Checksumming functions */
@@ -1257,6 +1249,48 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
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
@@ -1272,12 +1306,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
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
index 9396666b7314..f25c6ff16165 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -150,7 +150,7 @@ static inline void update_t_max_wait(transaction_t *transaction,
 				     unsigned long ts)
 {
 #ifdef CONFIG_JBD2_DEBUG
-	if (jbd2_journal_enable_debug &&
+	if (transaction->t_journal->j_debug_level &&
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

