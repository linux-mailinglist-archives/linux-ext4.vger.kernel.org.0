Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2733C305598
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhA0IZk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 03:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbhA0IXd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 03:23:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF12C061574;
        Wed, 27 Jan 2021 00:22:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e9so633124plh.3;
        Wed, 27 Jan 2021 00:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=GZvliHHek5U3Z4pfNOvcCkKJ1G2YyneWLWW1QKh7i0o=;
        b=vA4+TyM4geuMuGO/+5RsXewIlR2lLULE1Q+m0ZyCFaF3SJQpGKV+QVJFpJVsF2M1TX
         A9HJ7M1oJ5Jgf5bvHHSm4ikzHR7v3RAXwK8xPWFTlsShOKAKZCyQzHJxAhDkDR+7NRIm
         S+LgbBFBZGU5sFWO81G3EHD0Vz0UenuXYZZFAuA0RCu1EvpkaHdZ5Ce/aqofhYeTvLKx
         31awmO030BIwJobQ+QTIxCQz67J8OrcdpqMAGgKuFg+pPshyeBaDzw3ZEv3eoud4xaAh
         UhFHP6u83PXPWEzO2riaYxxd46w7xGIw6koqsAQAfsqCf4v5f6j/5U7f21/aP3i1+0lN
         oLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=GZvliHHek5U3Z4pfNOvcCkKJ1G2YyneWLWW1QKh7i0o=;
        b=HCa0j/fvl2WVSjtJo1x6WXBL7Uk7yxjTiyFn5wJKgOYF0VY/rkn6vygWhIwDg1nWij
         2Xk8VUGwC1qd11vqVB4gXZyF1mqdRmOzzVNko58DLcHG72aMXZW63NfVTOMPOvKQDP2i
         WarVWl1hnaJ2MuW5lBSG4mULSqPytjHCAyL7G6dwvTBfoGG2WZ+Lt1uq1xtdyTnSaDfP
         TAFlBLY2d1rQRTCTKc+6HABTVNY+iBAz367oN8KI6tIEIuXVptHmyjk34yy1Q/7RGZZ4
         3pReBODvMbJtdpF3nROwvKBbHyg9eAnl6gia8e0q9tyjpgT3tCn+3JW6O89OrbcBFhSj
         ZZvQ==
X-Gm-Message-State: AOAM532FzYh4R6ZeNAlJshzNRaZV2fk4hRdCK7PYu6DPwyEvxT9xfe6s
        4bzs0Lm66lyvnzkrJwxWVxA=
X-Google-Smtp-Source: ABdhPJxkOsqwFlOLOqzlT5aQyKyyPqkr+tDb0LzEuj1snmUaDvb3I95oZmwCv5/RPTaXOe8Ke+yipA==
X-Received: by 2002:a17:90a:701:: with SMTP id l1mr4540336pjl.154.1611735772798;
        Wed, 27 Jan 2021 00:22:52 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id q17sm1499902pfl.143.2021.01.27.00.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:22:52 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/3] jbd2: make jdb2_debug module parameter per device
Date:   Wed, 27 Jan 2021 16:22:04 +0800
Message-Id: <204ebe8cabdb99bd1a156181262e9d8810a1e465.1611733806.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
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
 fs/jbd2/journal.c     | 64 +++++++++++++++++++++++++++++++++++++++++--
 fs/jbd2/transaction.c |  2 +-
 include/linux/jbd2.h  | 41 +++++++++++++++------------
 3 files changed, 86 insertions(+), 21 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..5aca2aee96e5 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -101,18 +101,19 @@ EXPORT_SYMBOL(jbd2_inode_cache);
 static int jbd2_journal_create_slab(size_t slab_size);
 
 #ifdef CONFIG_JBD2_DEBUG
-void __jbd2_debug(int level, const char *file, const char *func,
+void __jbd2_debug(journal_t *j, int level, const char *file, const char *func,
 		  unsigned int line, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
 
-	if (level > jbd2_journal_enable_debug)
+	if (!j || (level > jbd2_journal_enable_debug && level > j->j_debug_level))
 		return;
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
+	printk(KERN_DEBUG "%s: (%s, %u): (%s): %pV", file, func, line,
+	       j->j_devname, &vaf);
 	va_end(args);
 }
 EXPORT_SYMBOL(__jbd2_debug);
@@ -1257,6 +1258,56 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
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
+	char value[6];
+	long level;
+
+	if (count > sizeof(value))
+		return -EINVAL;
+
+	if (copy_from_user(value, buffer, count))
+		return -EFAULT;
+
+	value[count] = 0;
+	if (kstrtol(value, 10, &level) < 0)
+		return -EINVAL;
+
+	if (level < 0 || level > USHRT_MAX)
+		return -EINVAL;
+
+	j->j_debug_level = level;
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
@@ -1272,12 +1323,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
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
index 9396666b7314..3956fbc97fc4 100644
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
index 99d3cd051ac3..c0bc96d4cc0a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -47,23 +47,6 @@
  */
 #define JBD2_DEFAULT_MAX_COMMIT_AGE 5
 
-#ifdef CONFIG_JBD2_DEBUG
-/*
- * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
- * consistency checks.  By default we don't do this unless
- * CONFIG_JBD2_DEBUG is on.
- */
-#define JBD2_EXPENSIVE_CHECKING
-extern ushort jbd2_journal_enable_debug;
-void __jbd2_debug(int level, const char *file, const char *func,
-		  unsigned int line, const char *fmt, ...);
-
-#define jbd_debug(n, fmt, a...) \
-	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
-#else
-#define jbd_debug(n, fmt, a...)    /**/
-#endif
-
 extern void *jbd2_alloc(size_t size, gfp_t flags);
 extern void jbd2_free(void *ptr, size_t size);
 
@@ -106,6 +89,23 @@ typedef struct jbd2_journal_handle handle_t;	/* Atomic operation type */
 typedef struct journal_s	journal_t;	/* Journal control structure */
 #endif
 
+#ifdef CONFIG_JBD2_DEBUG
+/*
+ * Define JBD2_EXPENSIVE_CHECKING to enable more expensive internal
+ * consistency checks.  By default we don't do this unless
+ * CONFIG_JBD2_DEBUG is on.
+ */
+#define JBD2_EXPENSIVE_CHECKING
+extern ushort jbd2_journal_enable_debug;
+void __jbd2_debug(journal_t *j, int level, const char *file, const char *func,
+		  unsigned int line, const char *fmt, ...);
+
+#define jbd_debug(j, n, fmt, a...)					\
+	__jbd2_debug((j), (n), __FILE__, __func__, __LINE__, (fmt), ##a)
+#else
+#define jbd_debug(j, n, fmt, a...)    /**/
+#endif
+
 /*
  * Internal structures used by the logging mechanism:
  */
@@ -1211,6 +1211,13 @@ struct journal_s
 	 */
 	struct transaction_stats_s j_stats;
 
+#ifdef CONFIG_JBD2_DEBUG
+	/**
+	 * @j_debug_level: debugging level for jbd2.
+	 */
+	unsigned short j_debug_level;
+#endif
+
 	/**
 	 * @j_failed_commit: Failed journal commit ID.
 	 */
-- 
2.30.0

