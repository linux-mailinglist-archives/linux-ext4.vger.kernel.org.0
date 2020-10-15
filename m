Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBD28F15E
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgJOLe0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 07:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgJOLeY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 07:34:24 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 04:34:24 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEAC061755
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 04:34:24 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id A26A32E037C;
        Thu, 15 Oct 2020 14:33:14 +0300 (MSK)
Received: from sas1-58a37b48fb94.qloud-c.yandex.net (sas1-58a37b48fb94.qloud-c.yandex.net [2a02:6b8:c08:1d1b:0:640:58a3:7b48])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id 6nXrIxENpq-XDwK2mjN;
        Thu, 15 Oct 2020 14:33:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1602761594; bh=ejDKbwUm8l9WNB7fFUSrvTLqiu0Jr68y8dUJwU1UsHQ=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=t3nc7SjuZC8LcASh6WLw/UQWWhJcwiDqseFQQHD3NDNX/I2E3VhC4T8UAzgXW/0uR
         RZiSTJELenxoWau8iZlLyU35I7YIfjbcYdhqvAkUvbV9EZUTdLBUebNjEv6lRr0DJS
         t0JsX2G0ClIl1TNkovkWoKSwovYYDAJysCe9MzUI=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-58a37b48fb94.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 5auaoVnUe2-XDmGknm4;
        Thu, 15 Oct 2020 14:33:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH 1/2] ext4: add helpers for checking whether quota is enabled/journalled
Date:   Thu, 15 Oct 2020 14:32:51 +0300
Message-Id: <1602761572-4713-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Right now, there are several places, where we check whether quota
is enabled or journalled with quite long and non-self-descriptive
condition statements.

This patch wraps these statements into helpers (with naming along
with existing ones like sb_has_quota_loaded) for better readability
and easier usage.

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
Reviewed-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 fs/ext4/ext4.h      | 15 +++++++++++++++
 fs/ext4/ext4_jbd2.h |  9 +++------
 fs/ext4/super.c     |  5 +----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 250e905..217ae7b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3251,6 +3251,21 @@ static inline void ext4_unlock_group(struct super_block *sb,
 	spin_unlock(ext4_group_lock_ptr(sb, group));
 }
 
+#ifdef CONFIG_QUOTA
+static inline bool ext4_any_quota_enabled(struct super_block *sb)
+{
+	return (test_opt(sb, QUOTA) || ext4_has_feature_quota(sb));
+}
+
+static inline bool ext4_is_quota_journalled(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	return (ext4_has_feature_quota(sb) ||
+		sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]);
+}
+#endif
+
 /*
  * Block validity checking
  */
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 00dc668..4a4eb3f 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -86,17 +86,14 @@
 #ifdef CONFIG_QUOTA
 /* Amount of blocks needed for quota update - we know that the structure was
  * allocated so we need to update only data block */
-#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ? 1 : 0)
+#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((ext4_any_quota_enabled(sb)) ? 1 : 0)
 /* Amount of blocks needed for quota insert/delete - we do some block writes
  * but inode, sb and group updates are done only once */
-#define EXT4_QUOTA_INIT_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ?\
+#define EXT4_QUOTA_INIT_BLOCKS(sb) ((ext4_any_quota_enabled(sb)) ?\
 		(DQUOT_INIT_ALLOC*(EXT4_SINGLEDATA_TRANS_BLOCKS(sb)-3)\
 		 +3+DQUOT_INIT_REWRITE) : 0)
 
-#define EXT4_QUOTA_DEL_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ?\
+#define EXT4_QUOTA_DEL_BLOCKS(sb) ((ext4_any_quota_enabled(sb)) ?\
 		(DQUOT_DEL_ALLOC*(EXT4_SINGLEDATA_TRANS_BLOCKS(sb)-3)\
 		 +3+DQUOT_DEL_REWRITE) : 0)
 #else
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9d01318..a988cf3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6158,11 +6158,8 @@ static int ext4_release_dquot(struct dquot *dquot)
 static int ext4_mark_dquot_dirty(struct dquot *dquot)
 {
 	struct super_block *sb = dquot->dq_sb;
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	/* Are we journaling quotas? */
-	if (ext4_has_feature_quota(sb) ||
-	    sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
+	if (ext4_is_quota_journalled(sb)) {
 		dquot_mark_dquot_dirty(dquot);
 		return ext4_write_dquot(dquot);
 	} else {
-- 
2.7.4

