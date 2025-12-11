Return-Path: <linux-ext4+bounces-12282-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B1CB49A5
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 04:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9718300A8C2
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43C2DCF61;
	Thu, 11 Dec 2025 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RjWxpav0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F97253F39;
	Thu, 11 Dec 2025 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765422340; cv=none; b=lRWMT7D1e9/2kxEdjDkPqZ/3+zhv4nj3Z+zJEIqSxDncE80u9jaHC/fBnsa9eqgWPCXbrZNUyJ+idjal3C45soDgN7eZ9La11ArnIj/NZHnnqSBuMeXaJdLfKfNhZayRA1Vu90G0NPCXr96WpxDUiyF+hnnJJBMypCAgL66s+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765422340; c=relaxed/simple;
	bh=FB0MLH8nlrpS+9lO5wBqKdwCZhixqQvxZQVHsvHHyyo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zxy8Gi5vdNH61TaXJ9esbRDnCzSRZrd29seItmqmNl+AZrwcFhMNp8+aaLTeinHPlULc8SuOevb+ScrnQyV4mHMQCgJVYHlqs2PZMP3fzQCBy5jK4z0b1LZaFX5Gp4+ZyhA8G4Q654vthiYq5YQtga8AmYok9Wgr69gWhJe9cog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RjWxpav0; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=HnLlcKDwKXPS87XjoBI/XX7n5vrKxckQjpqmVilsLrk=;
	b=RjWxpav0Ld1shzC36uEjLCriCLk5MBAXxCzf8Ge1dZ6y4U3FqjikbH3ijvSZ2X
	M74z2y4FPdaNBR0Mx8B5SH6vaHCTFY39svnnX8nHXnNE2NO2ylo87ll5NvgCK4zg
	5mTnA982kWKvYZcUcdc5pPRYAtqvytpqLoSMHgF6/R85o=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnoytoNDppZoYYBA--.95S2;
	Thu, 11 Dec 2025 11:03:07 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liubaolin12138@163.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v2] ext4: add sysfs attribute err_report_sec to control s_err_report timer
Date: Thu, 11 Dec 2025 11:02:56 +0800
Message-Id: <20251211030256.28613-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnoytoNDppZoYYBA--.95S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw1xKFW5JF4ruFykAw1fWFg_yoWxtr43pF
	sxJasxKrWjqa47uF43CrW8W3ZYkw1xAFyaqry3C3W3uasrtr17tFZFqFy0vF4fZrW8J34I
	qFyvgrWDCrWxG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi89NxUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgsQ2mk6NGsx+AAA3G

From: Baolin Liu <liubaolin@kylinos.cn>

Add a new sysfs attribute "err_report_sec" to control the s_err_report
timer in ext4_sb_info. Writing '0' disables the timer, while writing
a non-zero value enables the timer and sets the timeout in seconds.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
Note:
  v2:
   - Restore the original timer_setup() call location to address
   - the ‘WARNING: ODEBUG bug in ext4_update_super’ reported in v1.
---
 fs/ext4/ext4.h  |  4 +++-
 fs/ext4/super.c | 27 ++++++++++++++++++---------
 fs/ext4/sysfs.c | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..9eb5bf2a237a 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1673,6 +1673,8 @@ struct ext4_sb_info {
 
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
+	/* timeout in seconds for s_err_report; 0 disables the timer. */
+	unsigned long s_err_report_sec;
 
 	/* Lazy inode table initialization info */
 	struct ext4_li_request *s_li_request;
@@ -2349,7 +2351,6 @@ static inline int ext4_emergency_state(struct super_block *sb)
 #define EXT4_DEF_SB_UPDATE_INTERVAL_SEC (3600) /* seconds (1 hour) */
 #define EXT4_DEF_SB_UPDATE_INTERVAL_KB (16384) /* kilobytes (16MB) */
 
-
 /*
  * Minimum number of groups in a flexgroup before we separate out
  * directories into the first block group of a flexgroup
@@ -3187,6 +3188,7 @@ extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
 					     unsigned int flags);
 extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
 					      ext4_group_t block_group);
+extern void print_daily_error_info(struct timer_list *t);
 
 extern __printf(7, 8)
 void __ext4_error(struct super_block *, const char *, unsigned int, bool,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..24ffda1a0dca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3635,10 +3635,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 }
 
 /*
- * This function is called once a day if we have errors logged
- * on the file system
+ * This function is called once a day by default if we have errors logged
+ * on the file system.
+ * Use the err_report_sec sysfs attribute to disable or adjust its call
+ * freequency.
  */
-static void print_daily_error_info(struct timer_list *t)
+void print_daily_error_info(struct timer_list *t)
 {
 	struct ext4_sb_info *sbi = timer_container_of(sbi, t, s_err_report);
 	struct super_block *sb = sbi->s_sb;
@@ -3678,7 +3680,9 @@ static void print_daily_error_info(struct timer_list *t)
 			       le64_to_cpu(es->s_last_error_block));
 		printk(KERN_CONT "\n");
 	}
-	mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);  /* Once a day */
+
+	if (sbi->s_err_report_sec)
+		mod_timer(&sbi->s_err_report, jiffies + secs_to_jiffies(sbi->s_err_report_sec));
 }
 
 /* Find next suitable group and run ext4_init_inode_table */
@@ -5637,8 +5641,12 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		clear_opt(sb, DISCARD);
 	}
 
-	if (es->s_error_count)
-		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
+	if (es->s_error_count) {
+		sbi->s_err_report_sec = 5*60;	/* first time  5 minutes */
+		mod_timer(&sbi->s_err_report,
+				  jiffies + secs_to_jiffies(sbi->s_err_report_sec));
+	}
+	sbi->s_err_report_sec = 24*60*60; /* Once a day */
 
 	/* Enable message ratelimiting. Default is 10 messages per 5 secs. */
 	ratelimit_state_init(&sbi->s_err_ratelimit_state, 5 * HZ, 10);
@@ -6184,10 +6192,11 @@ static void ext4_update_super(struct super_block *sb)
 				ext4_errno_to_code(sbi->s_last_error_code);
 		/*
 		 * Start the daily error reporting function if it hasn't been
-		 * started already
+		 * started already and sbi->s_err_report_sec is not zero
 		 */
-		if (!es->s_error_count)
-			mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
+		if (!es->s_error_count && !sbi->s_err_report_sec)
+			mod_timer(&sbi->s_err_report,
+					  jiffies + secs_to_jiffies(sbi->s_err_report_sec));
 		le32_add_cpu(&es->s_error_count, sbi->s_add_error_count);
 		sbi->s_add_error_count = 0;
 	}
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 987bd00f916a..ce9c18f6ba26 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -40,6 +40,7 @@ typedef enum {
 	attr_pointer_string,
 	attr_pointer_atomic,
 	attr_journal_task,
+	attr_err_report_sec,
 } attr_id_t;
 
 typedef enum {
@@ -130,6 +131,36 @@ static ssize_t trigger_test_error(struct ext4_sb_info *sbi,
 	return count;
 }
 
+static ssize_t err_report_sec_store(struct ext4_sb_info *sbi,
+				    const char *buf, size_t count)
+{
+	unsigned long t;
+	int ret;
+
+	ret = kstrtoul(skip_spaces(buf), 0, &t);
+	if (ret)
+		return ret;
+
+	/*the maximum time interval must not exceed one year.*/
+	if (t > (365*24*60*60))
+		return -EINVAL;
+
+	if (sbi->s_err_report_sec == t)		/*nothing to do*/
+		goto out;
+	else if (!sbi->s_err_report_sec && t) {
+		timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
+	} else if (sbi->s_err_report_sec && !t) {
+		timer_delete_sync(&sbi->s_err_report);
+		goto out;
+	}
+
+	sbi->s_err_report_sec = t;
+	mod_timer(&sbi->s_err_report, jiffies + secs_to_jiffies(sbi->s_err_report_sec));
+
+out:
+	return count;
+}
+
 static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 {
 	if (!sbi->s_journal)
@@ -217,6 +248,7 @@ EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
 		 ext4_sb_info, s_mb_group_prealloc);
 EXT4_ATTR_OFFSET(mb_best_avail_max_trim_order, 0644, mb_order,
 		 ext4_sb_info, s_mb_best_avail_max_trim_order);
+EXT4_ATTR_OFFSET(err_report_sec, 0644, err_report_sec, ext4_sb_info, s_err_report_sec);
 EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
 EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
 EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
@@ -309,6 +341,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(last_trim_minblks),
 	ATTR_LIST(sb_update_sec),
 	ATTR_LIST(sb_update_kb),
+	ATTR_LIST(err_report_sec),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
@@ -396,6 +429,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
 			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
 		return sysfs_emit(buf, "%u\n", *((unsigned int *) ptr));
 	case attr_pointer_ul:
+	case attr_err_report_sec:
 		return sysfs_emit(buf, "%lu\n", *((unsigned long *) ptr));
 	case attr_pointer_u8:
 		return sysfs_emit(buf, "%u\n", *((unsigned char *) ptr));
@@ -519,6 +553,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 		return inode_readahead_blks_store(sbi, buf, len);
 	case attr_trigger_test_error:
 		return trigger_test_error(sbi, buf, len);
+	case attr_err_report_sec:
+		return err_report_sec_store(sbi, buf, len);
 	default:
 		return ext4_generic_attr_store(a, sbi, buf, len);
 	}
-- 
2.39.2


