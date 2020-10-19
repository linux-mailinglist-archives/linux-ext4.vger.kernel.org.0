Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C40292488
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgJSJVS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgJSJVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:21:18 -0400
X-Greylist: delayed 95 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Oct 2020 02:21:17 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADADC0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:21:17 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 85DA82E1331;
        Mon, 19 Oct 2020 12:19:39 +0300 (MSK)
Received: from sas1-b105e6591dac.qloud-c.yandex.net (sas1-b105e6591dac.qloud-c.yandex.net [2a02:6b8:c08:4790:0:640:b105:e659])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id PrUb6TSJiE-JdwaL55B;
        Mon, 19 Oct 2020 12:19:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603099179; bh=0ncGomd2/ibTdjU2fwtXSigkNuXB/VRkvBfDY1jCJV8=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=FY/7gLxyt+Ez8gEmcKmId1I6/mynv4ejtIt2QjbM9YJPHl/V23rcRM1VwsIoqGL7I
         g6zLVXhjmOvEsvXU8lLws+4jzAT1syZdNUUgVHLfxJw+4wGl2U7RDSouUBSS7+lS1N
         yI4OfVc6p4Qu9EY38gBPu6U1G0BSi2E0MrN9qVUE=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-b105e6591dac.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ERkL33auN0-JdnCNBUX;
        Mon, 19 Oct 2020 12:19:39 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH v3 2/2] ext4: print quota journalling mode on (re-)mount
Date:   Mon, 19 Oct 2020 12:19:22 +0300
Message-Id: <1603099162-25028-2-git-send-email-dotdot@yandex-team.ru>
In-Reply-To: <1603099162-25028-1-git-send-email-dotdot@yandex-team.ru>
References: <1603099162-25028-1-git-send-email-dotdot@yandex-team.ru>
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
Changes in v3:
  - Fix missing semicolon
Changes in v2:
  - Print quota journalling mode instead of exporting it via sysfs.

 fs/ext4/super.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a988cf3..01815d3 100644
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

