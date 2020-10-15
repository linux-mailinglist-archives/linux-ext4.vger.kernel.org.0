Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD4F28F161
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgJOLea (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgJOLe2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 07:34:28 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 04:34:27 PDT
Received: from forwardcorp1o.mail.yandex.net (forwardcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBFC061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 04:34:27 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 6858A2E126C;
        Thu, 15 Oct 2020 14:33:18 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id QoMHH0ecuw-XIwmmqpH;
        Thu, 15 Oct 2020 14:33:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602761598; bh=wzlVYHmMsgv3eR/Cb2uagafTpDCSyF8dvlbUEmVutA4=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=YYZtkOW8meqYglwC1UZina7124K7bhzBZJkFBEFF3h6Gq/5f4BPWzaIwpZ/HasTYq
         5ZwurZeUT0ldPzW6cm9ivud6o3Ur1giKuehwMos5qnKBhjyOlqSbvqkoHFVg6NSm5Q
         WZWIRCv7tJRxG+oWOsnTV5nhFUUCA03u1Ha71Dzc=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5auaoVnUe2-XHmGoLPj;
        Thu, 15 Oct 2020 14:33:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH 2/2] ext4: export quota journalling mode via sysfs attr quota_mode
Date:   Thu, 15 Oct 2020 14:32:52 +0300
Message-Id: <1602761572-4713-2-git-send-email-dotdot@yandex-team.ru>
In-Reply-To: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru>
References: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Right now, it is hard to understand what quota journalling type is enabled:
you need to be quite familiar with kernel code and trace it or really
understand what different combinations of fs flags/mount options lead to.

This patch exports via sysfs attr /sys/fs/ext4/<disk>/quota_mode current
quota jounalling mode, making it easier to check at a glance/in autotests.
The semantics is similar to ext4 data journalling modes:

* journalled - quota accounting and journaling are enabled
* writeback  - quota accounting is enabled, but journalling is disabled
* none       - quota accounting is disabled
* disabled   - kernel compiled without CONFIG_QUOTA feature

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 fs/ext4/sysfs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index bfabb79..a46487f 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -36,6 +36,7 @@ typedef enum {
 	attr_pointer_string,
 	attr_pointer_atomic,
 	attr_journal_task,
+	attr_quota_mode,
 } attr_id_t;
 
 typedef enum {
@@ -140,6 +141,23 @@ static ssize_t journal_task_show(struct ext4_sb_info *sbi, char *buf)
 			task_pid_vnr(sbi->s_journal->j_task));
 }
 
+static ssize_t quota_mode_show(struct ext4_sb_info *sbi, char *buf)
+{
+#ifdef CONFIG_QUOTA
+	struct super_block *sb = sbi->s_buddy_cache->i_sb;
+
+	if (!ext4_any_quota_enabled(sb))
+		return snprintf(buf, PAGE_SIZE, "none\n");
+
+	if (ext4_is_quota_journalled(sb))
+		return snprintf(buf, PAGE_SIZE, "journalled\n");
+	else
+		return snprintf(buf, PAGE_SIZE, "writeback\n");
+#else
+	return snprintf(buf, PAGE_SIZE, "disabled\n");
+#endif
+}
+
 #define EXT4_ATTR(_name,_mode,_id)					\
 static struct ext4_attr ext4_attr_##_name = {				\
 	.attr = {.name = __stringify(_name), .mode = _mode },		\
@@ -248,6 +266,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
 EXT4_ATTR(journal_task, 0444, journal_task);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
 EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
+EXT4_ATTR_FUNC(quota_mode, 0444);
 
 static unsigned int old_bump_val = 128;
 EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
@@ -296,6 +315,7 @@ static struct attribute *ext4_attrs[] = {
 #endif
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
+	ATTR_LIST(quota_mode),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4);
@@ -425,6 +445,8 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
 		return print_tstamp(buf, sbi->s_es, s_last_error_time);
 	case attr_journal_task:
 		return journal_task_show(sbi, buf);
+	case attr_quota_mode:
+		return quota_mode_show(sbi, buf);
 	}
 
 	return 0;
-- 
2.7.4

