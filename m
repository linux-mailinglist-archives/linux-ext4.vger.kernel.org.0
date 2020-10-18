Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885E2291542
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Oct 2020 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439912AbgJRCCn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Oct 2020 22:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439903AbgJRCCn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Oct 2020 22:02:43 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46CC061755
        for <linux-ext4@vger.kernel.org>; Sat, 17 Oct 2020 19:02:42 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 862572E129E;
        Sun, 18 Oct 2020 05:02:38 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id K7ckr3Ocm5-2bw8t9UF;
        Sun, 18 Oct 2020 05:02:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602986558; bh=lkzqzi6rQXAtjEsRU5FvEiDdoRAF98NktoBNISfi0Sg=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=kEMfndBPGEatwhqaFt8ZJRK407v4rtWvkpzUpljBteZ/zsDTyUoVq1sDp2MSdptxv
         LYU9LLPVIZV8bQyakDt+evbQhBeQ4ZkHGkWo/uwqg0elAAdUs6ON2TQQxe9HJJCmhf
         lv+eRGDhA+1lopKaCurwUg+10OHWlNZXF1QXmZLk=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id y7TVDq6VSC-2bm4V9Uu;
        Sun, 18 Oct 2020 05:02:37 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH v2 2/2] ext4: print quota journalling mode on (re-)mount
Date:   Sun, 18 Oct 2020 05:02:27 +0300
Message-Id: <1602986547-15886-2-git-send-email-dotdot@yandex-team.ru>
In-Reply-To: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru>
References: <1602986547-15886-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Right now, it is hard to understand what quota journalling type is enabled:
you need to be quite familiar with kernel code and trace it or really
understand what different combinations of fs flags/mount options lead to.

This patch adds printing of current quota jounalling mode on each
mount/remount, thus making it easier to check it at a glance/in autotests.
The semantics is similar to ext4 data journalling modes:

* journalled - quota accounting and journaling are enabled
* writeback  - quota accounting is enabled, but journalling is disabled
* none       - quota accounting is disabled
* disabled   - kernel compiled without CONFIG_QUOTA feature

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
---
Changes in v2:
  - Print quota journalling mode instead of exporting it via sysfs.

 fs/ext4/super.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a988cf3..09b5645 100644
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
+	if (ext4_is_quota_journalled(sb))
+		return "journalled";
+	else
+		return "writeback";
+#else
+	return "disabled"
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

