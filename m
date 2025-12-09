Return-Path: <linux-ext4+bounces-12240-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C5CAF991
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 11:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 986CD3081D49
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C46301474;
	Tue,  9 Dec 2025 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qL+cRQrU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC62D662D;
	Tue,  9 Dec 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765275259; cv=none; b=ewLiE5zEEFvaOe3sgGwRfWckzhmenMtNXTdWpeahhwoefusIVJitLoqcxuKhY9Lh8GyNMK6+8GuQdM1hqTwJqnUQMD9PkLYVmxuAbgke/D9H18SeLuAYNoQrpPOmNMJJ1cZVW51ak3Zsk4YaBk/6hdjy+frNupKbaK/rOeFwO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765275259; c=relaxed/simple;
	bh=9MViNjxv+xJuzPDg0eDsyixCXZOYgs3iTH27X2mbjVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1a+42PPSaUNWz9CKLRKjO9LvfoE45RF2al0cjumExHMDKzF3mBjGkEvQAOpCwsXx8KXvibSK15fA1C5rl/pFz1ht+z87D2GIlRpR4U1w8I+TE/Kma3ftfTiym3voPNAI8Sd98ZZ0fNW+EFy6a46LTBLHhI1vQwI8iPHBrsomG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qL+cRQrU; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Ngnr8gfSFX9684SuULcIgp19g6NevHWia+sjrje6x1Q=;
	b=qL+cRQrUgjMxYe1pgr/luK1mSZwocglgy0HhKu4BJVH/EI0vJ2vWxbPyuXerBs
	NmU7S4mSy7XJRyq8IDGTFoNermRv/8TG07ra6MzuoltkRKdXUgoIXfjOUJ6lJrSg
	EuktDkok8PxJ3UIolf5752GfeZv3t1hLorbv4uam5qj6Y=
Received: from [192.168.18.185] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHH51i9jdp2WM4Gw--.133S2;
	Tue, 09 Dec 2025 18:13:59 +0800 (CST)
Message-ID: <315cf6c2-cc00-4496-8eed-9429f918a96f@163.com>
Date: Tue, 9 Dec 2025 18:13:54 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ext4: add sysfs attribute err_report_sec to control
 s_err_report timer
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20251209095254.11569-1-liubaolin12138@163.com>
 <21af8d64.9c77.19b0296bb66.Coremail.liubaolin12138@163.com>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <21af8d64.9c77.19b0296bb66.Coremail.liubaolin12138@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHH51i9jdp2WM4Gw--.133S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww1fKrW8Xr45JrW5XryxXwb_yoWfuw4fpa
	98Ja9rGrWjqa4Uuw43Ar4Fg3ZYvw1IkFyagr1fC3W3ZasFyr1xJFy2qF109F4rZrW8G34I
	qF1vgrnrCrWUGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2D7-UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwgf+yWk39me54AAA3k

> Dear maintainers,	
> Several customers have requested the ability to disable or adjust the frequency of the print_daily_error_info messages. 
> The fields s_error_count, s_first_error_time, and s_last_error_time being non-zero only indicate that the filesystem has experienced errors in the past.
> They do not mean an error is currently happening or has just occurred. 
> However, the presence of the word “error” in logs can confuse customers and trigger false alerts in their log monitoring systems.
> 
> To address this, customers asked for a way to disable or tune the reporting interval. 
> Based on this requirement, I implemented this patch and verified its behavior. 
> Initially, the timer for s_err_report was set to five minutes during fill_super, and then adjusted to a default of one day.
> The new sysfs attribute err_report_sec allows users to disable the timer, enable it, or set a custom timeout value.



在 2025/12/9 18:09, Baolin Liu 写道:
> Add .
> 
> 
> 
> 
> 
> 
> At 2025-12-09 17:52:54, "Baolin Liu" <liubaolin12138@163.com> wrote:
>>From: Baolin Liu <liubaolin@kylinos.cn>
>>
>>Add a new sysfs attribute "err_report_sec" to control the s_err_report
>>timer in ext4_sb_info. Writing '0' disables the timer, while writing
>>a non-zero value enables the timer and sets the timeout in seconds.
>>
>>Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>---
>> fs/ext4/ext4.h  |  4 +++-
>> fs/ext4/super.c | 31 ++++++++++++++++++++-----------
>> fs/ext4/sysfs.c | 36 ++++++++++++++++++++++++++++++++++++
>> 3 files changed, 59 insertions(+), 12 deletions(-)
>>
>>diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>index 57087da6c7be..9eb5bf2a237a 100644
>>--- a/fs/ext4/ext4.h
>>+++ b/fs/ext4/ext4.h
>>@@ -1673,6 +1673,8 @@ struct ext4_sb_info {
>> 
>> 	/* timer for periodic error stats printing */
>> 	struct timer_list s_err_report;
>>+	/* timeout in seconds for s_err_report; 0 disables the timer. */
>>+	unsigned long s_err_report_sec;
>> 
>> 	/* Lazy inode table initialization info */
>> 	struct ext4_li_request *s_li_request;
>>@@ -2349,7 +2351,6 @@ static inline int ext4_emergency_state(struct super_block *sb)
>> #define EXT4_DEF_SB_UPDATE_INTERVAL_SEC (3600) /* seconds (1 hour) */
>> #define EXT4_DEF_SB_UPDATE_INTERVAL_KB (16384) /* kilobytes (16MB) */
>> 
>>-
>> /*
>>  * Minimum number of groups in a flexgroup before we separate out
>>  * directories into the first block group of a flexgroup
>>@@ -3187,6 +3188,7 @@ extern void ext4_mark_group_bitmap_corrupted(struct super_block *sb,
>> 					     unsigned int flags);
>> extern unsigned int ext4_num_base_meta_blocks(struct super_block *sb,
>> 					      ext4_group_t block_group);
>>+extern void print_daily_error_info(struct timer_list *t);
>> 
>> extern __printf(7, 8)
>> void __ext4_error(struct super_block *, const char *, unsigned int, bool,
>>diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>index 33e7c08c9529..a692fe2be1de 100644
>>--- a/fs/ext4/super.c
>>+++ b/fs/ext4/super.c
>>@@ -3635,10 +3635,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
>> }
>> 
>> /*
>>- * This function is called once a day if we have errors logged
>>- * on the file system
>>+ * This function is called once a day by default if we have errors logged
>>+ * on the file system.
>>+ * Use the err_report_sec sysfs attribute to disable or adjust its call
>>+ * freequency.
>>  */
>>-static void print_daily_error_info(struct timer_list *t)
>>+void print_daily_error_info(struct timer_list *t)
>> {
>> 	struct ext4_sb_info *sbi = timer_container_of(sbi, t, s_err_report);
>> 	struct super_block *sb = sbi->s_sb;
>>@@ -3678,7 +3680,9 @@ static void print_daily_error_info(struct timer_list *t)
>> 			       le64_to_cpu(es->s_last_error_block));
>> 		printk(KERN_CONT "\n");
>> 	}
>>-	mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);  /* Once a day */
>>+
>>+	if (sbi->s_err_report_sec)
>>+		mod_timer(&sbi->s_err_report, jiffies + secs_to_jiffies(sbi->s_err_report_sec));
>> }
>> 
>> /* Find next suitable group and run ext4_init_inode_table */
>>@@ -5350,7 +5354,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> 	if (err)
>> 		goto failed_mount;
>> 
>>-	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
>> 	spin_lock_init(&sbi->s_error_lock);
>> 	INIT_WORK(&sbi->s_sb_upd_work, update_super_work);
>> 
>>@@ -5637,8 +5640,13 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> 		clear_opt(sb, DISCARD);
>> 	}
>> 
>>-	if (es->s_error_count)
>>-		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
>>+	timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
>>+	if (es->s_error_count) {
>>+		sbi->s_err_report_sec = 5*60;	/* first time  5 minutes */
>>+		mod_timer(&sbi->s_err_report,
>>+				  jiffies + secs_to_jiffies(sbi->s_err_report_sec));
>>+	}
>>+	sbi->s_err_report_sec = 24*60*60; /* Once a day */
>> 
>> 	/* Enable message ratelimiting. Default is 10 messages per 5 secs. */
>> 	ratelimit_state_init(&sbi->s_err_ratelimit_state, 5 * HZ, 10);
>>@@ -5656,6 +5664,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>> 
>> failed_mount9:
>> 	ext4_quotas_off(sb, EXT4_MAXQUOTAS);
>>+	timer_delete_sync(&sbi->s_err_report);
>> failed_mount8: __maybe_unused
>> 	ext4_release_orphan_info(sb);
>> failed_mount7:
>>@@ -5690,7 +5699,6 @@ failed_mount8: __maybe_unused
>> 	/* flush s_sb_upd_work before sbi destroy */
>> 	flush_work(&sbi->s_sb_upd_work);
>> 	ext4_stop_mmpd(sbi);
>>-	timer_delete_sync(&sbi->s_err_report);
>> 	ext4_group_desc_free(sbi);
>> failed_mount:
>> #if IS_ENABLED(CONFIG_UNICODE)
>>@@ -6184,10 +6192,11 @@ static void ext4_update_super(struct super_block *sb)
>> 				ext4_errno_to_code(sbi->s_last_error_code);
>> 		/*
>> 		 * Start the daily error reporting function if it hasn't been
>>-		 * started already
>>+		 * started already and sbi->s_err_report_sec is not zero
>> 		 */
>>-		if (!es->s_error_count)
>>-			mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
>>+		if (!es->s_error_count && !sbi->s_err_report_sec)
>>+			mod_timer(&sbi->s_err_report,
>>+					  jiffies + secs_to_jiffies(sbi->s_err_report_sec));
>> 		le32_add_cpu(&es->s_error_count, sbi->s_add_error_count);
>> 		sbi->s_add_error_count = 0;
>> 	}
>>diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
>>index 987bd00f916a..ce9c18f6ba26 100644
>>--- a/fs/ext4/sysfs.c
>>+++ b/fs/ext4/sysfs.c
>>@@ -40,6 +40,7 @@ typedef enum {
>> 	attr_pointer_string,
>> 	attr_pointer_atomic,
>> 	attr_journal_task,
>>+	attr_err_report_sec,
>> } attr_id_t;
>> 
>> typedef enum {
>>@@ -130,6 +131,36 @@ static ssize_t trigger_test_error(struct ext4_sb_info *sbi,
>> 	return count;
>> }
>> 
>>+static ssize_t err_report_sec_store(struct ext4_sb_info *sbi,
>>+				    const char *buf, size_t count)
>>+{
>>+	unsigned long t;
>>+	int ret;
>>+
>>+	ret = kstrtoul(skip_spaces(buf), 0, &t);
>>+	if (ret)
>>+		return ret;
>>+
>>+	/*the maximum time interval must not exceed one year.*/
>>+	if (t > (365*24*60*60))
>>+		return -EINVAL;
>>+
>>+	if (sbi->s_err_report_sec == t)		/*nothing to do*/
>>+		goto out;
>>+	else if (!sbi->s_err_report_sec && t) {
>>+		timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
>>+	} else if (sbi->s_err_report_sec && !t) {
>>+		timer_delete_sync(&sbi->s_err_report);
>>+		goto out;
>>+	}
>>+
>>+	sbi->s_err_report_sec = t;
>>+	mod_timer(&sbi->s_err_report, jiffies + secs_to_jiffies(sbi->s_err_report_sec));
>>+
>>+out:
>>+	return count;
>>+}
>>+
>> static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
>> {
>> 	if (!sbi->s_journal)
>>@@ -217,6 +248,7 @@ EXT4_ATTR_OFFSET(mb_group_prealloc, 0644, clusters_in_group,
>> 		 ext4_sb_info, s_mb_group_prealloc);
>> EXT4_ATTR_OFFSET(mb_best_avail_max_trim_order, 0644, mb_order,
>> 		 ext4_sb_info, s_mb_best_avail_max_trim_order);
>>+EXT4_ATTR_OFFSET(err_report_sec, 0644, err_report_sec, ext4_sb_info, s_err_report_sec);
>> EXT4_RW_ATTR_SBI_UI(inode_goal, s_inode_goal);
>> EXT4_RW_ATTR_SBI_UI(mb_stats, s_mb_stats);
>> EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>>@@ -309,6 +341,7 @@ static struct attribute *ext4_attrs[] = {
>> 	ATTR_LIST(last_trim_minblks),
>> 	ATTR_LIST(sb_update_sec),
>> 	ATTR_LIST(sb_update_kb),
>>+	ATTR_LIST(err_report_sec),
>> 	NULL,
>> };
>> ATTRIBUTE_GROUPS(ext4);
>>@@ -396,6 +429,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>> 			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
>> 		return sysfs_emit(buf, "%u\n", *((unsigned int *) ptr));
>> 	case attr_pointer_ul:
>>+	case attr_err_report_sec:
>> 		return sysfs_emit(buf, "%lu\n", *((unsigned long *) ptr));
>> 	case attr_pointer_u8:
>> 		return sysfs_emit(buf, "%u\n", *((unsigned char *) ptr));
>>@@ -519,6 +553,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>> 		return inode_readahead_blks_store(sbi, buf, len);
>> 	case attr_trigger_test_error:
>> 		return trigger_test_error(sbi, buf, len);
>>+	case attr_err_report_sec:
>>+		return err_report_sec_store(sbi, buf, len);
>> 	default:
>> 		return ext4_generic_attr_store(a, sbi, buf, len);
>> 	}
>>-- 
>>2.39.2


