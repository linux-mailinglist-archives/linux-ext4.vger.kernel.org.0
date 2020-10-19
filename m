Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A31292484
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgJSJTn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbgJSJTn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:19:43 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5416C0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:19:42 -0700 (PDT)
Received: from sas1-5717c3cea310.qloud-c.yandex.net (sas1-5717c3cea310.qloud-c.yandex.net [IPv6:2a02:6b8:c14:3616:0:640:5717:c3ce])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 007392E1506;
        Mon, 19 Oct 2020 12:19:39 +0300 (MSK)
Received: from sas1-b105e6591dac.qloud-c.yandex.net (sas1-b105e6591dac.qloud-c.yandex.net [2a02:6b8:c08:4790:0:640:b105:e659])
        by sas1-5717c3cea310.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id KHEb6MJY1i-JcwSrOcV;
        Mon, 19 Oct 2020 12:19:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1603099178; bh=i8oomb8oUwmf+KwyyjzdOFrinF919+lxGWX/QmQP7AY=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=kFPjXzQ3PTWYwaUWZI2XvgbIAfJ1bsXadzHgL3Rmfft2u5Ehe1FGwJSBwdSfa8Vht
         mP+QPX9LTX/eRWjKx2L9yGzFa8ZhEG9snnBRLIVxKDCzxJBm0CfhFzpp7xDVRxygvn
         xOShYuLMlpqsav8CcPEyDJ5LrAcwUGAqOM/ZcYcA=
Authentication-Results: sas1-5717c3cea310.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-b105e6591dac.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id ERkL33auN0-JcnCl4Pd;
        Mon, 19 Oct 2020 12:19:38 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Roman Anufriev <dotdot@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, dmtrmonakhov@yandex-team.ru,
        dotdot@yandex-team.ru
Subject: [PATCH v3 1/2] ext4: add helpers for checking whether quota can be enabled/is journalled
Date:   Mon, 19 Oct 2020 12:19:21 +0300
Message-Id: <1603099162-25028-1-git-send-email-dotdot@yandex-team.ru>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Right now, there are several places, where we check whether fs is
capable of enabling quota or if quota is journalled with quite long
and non-self-descriptive condition statements.

This patch wraps these statements into helpers for better readability
and easier usage.

Signed-off-by: Roman Anufriev <dotdot@yandex-team.ru>
---
Changes in v3:
  - nothing
Changes in v2:
  - Fix misleading helper name 'ext4_any_quota_enabled()' ->
    'ext4_quota_capable()'.

 fs/ext4/ext4.h      | 15 +++++++++++++++
 fs/ext4/ext4_jbd2.h |  9 +++------
 fs/ext4/super.c     |  5 +----
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 250e905..897df24 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3251,6 +3251,21 @@ static inline void ext4_unlock_group(struct super_block *sb,
 	spin_unlock(ext4_group_lock_ptr(sb, group));
 }
 
+#ifdef CONFIG_QUOTA
+static inline bool ext4_quota_capable(struct super_block *sb)
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
index 00dc668..a124c68 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -86,17 +86,14 @@
 #ifdef CONFIG_QUOTA
 /* Amount of blocks needed for quota update - we know that the structure was
  * allocated so we need to update only data block */
-#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ? 1 : 0)
+#define EXT4_QUOTA_TRANS_BLOCKS(sb) ((ext4_quota_capable(sb)) ? 1 : 0)
 /* Amount of blocks needed for quota insert/delete - we do some block writes
  * but inode, sb and group updates are done only once */
-#define EXT4_QUOTA_INIT_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ?\
+#define EXT4_QUOTA_INIT_BLOCKS(sb) ((ext4_quota_capable(sb)) ?\
 		(DQUOT_INIT_ALLOC*(EXT4_SINGLEDATA_TRANS_BLOCKS(sb)-3)\
 		 +3+DQUOT_INIT_REWRITE) : 0)
 
-#define EXT4_QUOTA_DEL_BLOCKS(sb) ((test_opt(sb, QUOTA) ||\
-		ext4_has_feature_quota(sb)) ?\
+#define EXT4_QUOTA_DEL_BLOCKS(sb) ((ext4_quota_capable(sb)) ?\
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

