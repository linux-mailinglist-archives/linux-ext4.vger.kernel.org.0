Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34432956AD
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Oct 2020 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895320AbgJVDVh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 23:21:37 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:59176 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443456AbgJVDVh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Oct 2020 23:21:37 -0400
Received: from sas1-5717c3cea310.qloud-c.yandex.net (sas1-5717c3cea310.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5DEDB2E1339;
        Thu, 22 Oct 2020 06:21:34 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id DTQx7gJAjy-LXxCggEx;
        Thu, 22 Oct 2020 06:21:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603336894; bh=XMrx3HAUa/eHhShtKpORK3zZX+qSHyVanETHTRP0bGg=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=ZdnLyh8ruNWAP7S8sZCGwg/RNZhXajDyEaAaouvjOmL35AYYn2wmu2zEfSVWBAAU+
         P7tUuh20jpSdquODqL2lBd66Wnug8HlS+VRk+Rje4hxoOrZhzheU2x/9eGJEAkrnkn
         3EsTsdY9gAXd9WK6ZeosCzhE2zKhvq0PB/er2UvI=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 6d2tTe6k38-LXm4KoP3;
        Thu, 22 Oct 2020 06:21:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH v4 2/2] ext4: print quota journalling mode on (re-)mount
Date:   Thu, 22 Oct 2020 06:21:00 +0300
Message-Id: <1603336860-16153-2-git-send-email-dotdot@yandex-team.ru>
In-Reply-To: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru>
References: <1603336860-16153-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Right now, it is hard to understand which quota journalling type is enabled:
you need to be quite familiar with kernel code and trace it or really
understand what different combinations of fs flags/mount options lead to.

This patch adds printing of current quota jounalling mode on each
mount/remount, thus making it easier to check it at a glance/in autotests.
The semantics is similar to ext4 data journalling modes:

* journalled - quota configured, journalling will be enabled
* writeback  - quota configured, journalling won't be enabled
* none       - quota isn't configured
* disabled   - kernel compiled without CONFIG_QUOTA feature

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
---
 fs/ext4/super.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a988cf3..f2ddba4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3985,6 +3985,21 @@ static void ext4_set_resv_clusters(struct super_block *sb)
 	atomic64_set(&sbi->s_resv_clusters, resv_clusters);
 }
 
+static const char *ext4_quota_mode(struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	if (!ext4_quota_capable(sb))
+		return "none";
+
+	if (EXT4_SB(sb)->s_journal && ext4_is_quota_journalled(sb))
+		return "journalled";
+	else
+		return "writeback";
+#else
+	return "disabled";
+#endif
+}
+
 static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
@@ -5039,10 +5054,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 
 	if (___ratelimit(&ext4_mount_msg_ratelimit, "EXT4-fs mount"))
 		ext4_msg(sb, KERN_INFO, "mounted filesystem with%s. "
-			 "Opts: %.*s%s%s", descr,
+			 "Opts: %.*s%s%s. Quota mode: %s.", descr,
 			 (int) sizeof(sbi->s_es->s_mount_opts),
 			 sbi->s_es->s_mount_opts,
-			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data);
+			 *sbi->s_es->s_mount_opts ? "; " : "", orig_data,
+			 ext4_quota_mode(sb));
 
 	if (es->s_error_count)
 		mod_timer(&sbi->s_err_report, jiffies + 300*HZ); /* 5 minutes */
@@ -5979,7 +5995,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	 */
 	*flags = (*flags & ~vfs_flags) | (sb->s_flags & vfs_flags);
 
-	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
+	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s. Quota mode: %s.",
+		 orig_data, ext4_quota_mode(sb));
 	kfree(orig_data);
 	return 0;
 
-- 
2.7.4

