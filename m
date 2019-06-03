Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A900C32FE8
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfFCMm7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 08:42:59 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:53075 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfFCMm7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 08:42:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TTLJ7SR_1559565768;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0TTLJ7SR_1559565768)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Jun 2019 20:42:56 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: [RFC] jbd2: add new "stats" proc file
Date:   Mon,  3 Jun 2019 20:42:38 +0800
Message-Id: <20190603124238.9050-1-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

/proc/fs/jbd2/${device}/info only shows whole average statistical
info about jbd2's life cycle, but it can not show jbd2 info in
specified time interval and sometimes this capability is very useful
for trouble shooting. For example, we can not see how rs_locked and
rs_flushing grows in specified time interval, but these two indexes
can explain some reasons for app's behaviours.

Here we add a new "stats" proc file like /proc/diskstats, then we can
implement a simple tool jbd2_stats which'll display detailed jbd2 info
in specified time interval. Like below(time interval 5s):

[lege@localhost ~]$ cat /proc/fs/jbd2/vdb1-8/stats
1838 1838 4096 0 1154 19367 21258 342 6309 2 618349 228193 230207

[lege@localhost ~]$ gcc -o jbd2_stat jbd2_stat.c ; ./jbd2_stat

Device              tid     trans   handles    locked  flushing   logging
vdb1-8             1861       158       359     13.00      0.00      2.00

Device              tid     trans   handles    locked  flushing   logging
vdb1-8             1974       113       389     26.00      0.00      5.00

Device              tid     trans   handles    locked  flushing   logging
vdb1-8             2188       214       308     10.00      0.00      7.00

Device              tid     trans   handles    locked  flushing   logging
vdb1-8             2344       156       332     19.00      0.00      4.00

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/jbd2/journal.c | 104 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 99 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 43df0c943229..5a2a87a38718 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1035,25 +1035,80 @@ static const struct seq_operations jbd2_seq_info_ops = {
 	.show   = jbd2_seq_info_show,
 };
 
-static int jbd2_seq_info_open(struct inode *inode, struct file *file)
+static void *jbd2_seq_stats_start(struct seq_file *seq, loff_t *pos)
+{
+	return *pos ? NULL : SEQ_START_TOKEN;
+}
+
+static void *jbd2_seq_stats_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	return NULL;
+}
+
+static int jbd2_seq_stats_show(struct seq_file *seq, void *v)
+{
+	struct jbd2_stats_proc_session *s = seq->private;
+
+	if (v != SEQ_START_TOKEN)
+		return 0;
+
+	seq_printf(seq, "%lu %lu %d %llu %llu %llu %llu %llu %llu %llu %u %u %u\n",
+		s->stats->ts_tid, s->stats->ts_requested,
+		s->journal->j_max_transaction_buffers,
+		jiffies64_to_msecs(s->stats->run.rs_wait),
+		jiffies64_to_msecs(s->stats->run.rs_request_delay),
+		jiffies64_to_msecs(s->stats->run.rs_running),
+		jiffies64_to_msecs(s->stats->run.rs_locked),
+		jiffies64_to_msecs(s->stats->run.rs_flushing),
+		jiffies64_to_msecs(s->stats->run.rs_logging),
+		s->journal->j_average_commit_time / NSEC_PER_MSEC,
+		s->stats->run.rs_handle_count, s->stats->run.rs_blocks,
+		s->stats->run.rs_blocks_logged);
+	return 0;
+}
+
+static void jbd2_seq_stats_stop(struct seq_file *seq, void *v)
+{
+}
+
+static const struct seq_operations jbd2_seq_stats_ops = {
+	.start  = jbd2_seq_stats_start,
+	.next   = jbd2_seq_stats_next,
+	.stop   = jbd2_seq_stats_stop,
+	.show   = jbd2_seq_stats_show,
+};
+
+static struct jbd2_stats_proc_session *__jbd2_seq_open(struct inode *inode,
+			struct file *file)
 {
 	journal_t *journal = PDE_DATA(inode);
 	struct jbd2_stats_proc_session *s;
-	int rc, size;
+	int size;
 
 	s = kmalloc(sizeof(*s), GFP_KERNEL);
 	if (s == NULL)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	size = sizeof(struct transaction_stats_s);
 	s->stats = kmalloc(size, GFP_KERNEL);
 	if (s->stats == NULL) {
 		kfree(s);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 	spin_lock(&journal->j_history_lock);
 	memcpy(s->stats, &journal->j_stats, size);
 	s->journal = journal;
 	spin_unlock(&journal->j_history_lock);
+	return s;
+}
+
+static int jbd2_seq_info_open(struct inode *inode, struct file *file)
+{
+	struct jbd2_stats_proc_session *s;
+	int rc;
+
+	s = __jbd2_seq_open(inode, file);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
 
 	rc = seq_open(file, &jbd2_seq_info_ops);
 	if (rc == 0) {
@@ -1064,7 +1119,6 @@ static int jbd2_seq_info_open(struct inode *inode, struct file *file)
 		kfree(s);
 	}
 	return rc;
-
 }
 
 static int jbd2_seq_info_release(struct inode *inode, struct file *file)
@@ -1084,6 +1138,43 @@ static const struct file_operations jbd2_seq_info_fops = {
 	.release        = jbd2_seq_info_release,
 };
 
+static int jbd2_seq_stats_open(struct inode *inode, struct file *file)
+{
+	struct jbd2_stats_proc_session *s;
+	int rc;
+
+	s = __jbd2_seq_open(inode, file);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	rc = seq_open(file, &jbd2_seq_stats_ops);
+	if (rc == 0) {
+		struct seq_file *m = file->private_data;
+		m->private = s;
+	} else {
+		kfree(s->stats);
+		kfree(s);
+	}
+	return rc;
+}
+
+static int jbd2_seq_stats_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = file->private_data;
+	struct jbd2_stats_proc_session *s = seq->private;
+	kfree(s->stats);
+	kfree(s);
+	return seq_release(inode, file);
+}
+
+static const struct file_operations jbd2_seq_stats_fops = {
+	.owner		= THIS_MODULE,
+	.open           = jbd2_seq_stats_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = jbd2_seq_stats_release,
+};
+
 static struct proc_dir_entry *proc_jbd2_stats;
 
 static void jbd2_stats_proc_init(journal_t *journal)
@@ -1092,12 +1183,15 @@ static void jbd2_stats_proc_init(journal_t *journal)
 	if (journal->j_proc_entry) {
 		proc_create_data("info", S_IRUGO, journal->j_proc_entry,
 				 &jbd2_seq_info_fops, journal);
+		proc_create_data("stats", S_IRUGO, journal->j_proc_entry,
+				 &jbd2_seq_stats_fops, journal);
 	}
 }
 
 static void jbd2_stats_proc_exit(journal_t *journal)
 {
 	remove_proc_entry("info", journal->j_proc_entry);
+	remove_proc_entry("stats", journal->j_proc_entry);
 	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
 }
 
-- 
2.17.2

