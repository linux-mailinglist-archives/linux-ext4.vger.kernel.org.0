Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFD93F4DA7
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhHWPmg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57882 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A5EE22004;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIepCJmThtOU41qoHki1egV+lv3kDvDSRl02Q1EWXEc=;
        b=Ae5js1KzmToDMUuVt1WcCEmtgGBWDBw9sgecvHYZ6y9zPzszd6BwdRY9DwMmlhOshpThbe
        Ux4wyEzNdppF8k16bQp0TwYWWmYOPLZY2SOFiYfyApaO4Hr8SpmA9jq1v9L5kTlCns606G
        zNXvwFXslI9cVCdXFZvV5mSzdDaxMow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kIepCJmThtOU41qoHki1egV+lv3kDvDSRl02Q1EWXEc=;
        b=dnPT6zxIsEuxmQBq+ULhUv8HBuQbJpbuXbyGHiQipvbpZWNlXSqmUFdnmNugPaew2dKP3w
        Jag363UwhiX8fwDQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0B957A3BBB;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C9D831F2CD0; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 3/8] quota: Rename quota_update_limits() to quota_read_all_dquots()
Date:   Mon, 23 Aug 2021 17:41:23 +0200
Message-Id: <20210823154128.16615-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3796; h=from:subject; bh=EWzfurjfbAs2HTtmIoM8glu+EY0nvkRwYkafyLH0vAw=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GjQ7OLyPGH5e21pa5vzRbAJrBUX2fqN9Cishyr zRhheaOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBowAKCRCcnaoHP2RA2fqAB/ 99OFSOi1posHQs9IivQagLwUAxytNoe9VWRoUqypcx5DFtbSItNlcyRCRxmouxUdpTyWR3BoYfDz97 /R2KsPNu9XU6oA2NiC7WcmNdSJ0ay+sRuXy2EF5FxCvXjB4xN7pUu7QEEjcQXOYOwIsdEDQru+eajq NK05uq6j0Zb/zelJ9VkTA0iKkiCkKGNYZlCUkn3x+E8wTb4RCbywnAynC6RXFlmt+EnaxxHoGCsJGv TLIe+yhPDECdjW39RZWYV87fRRGDRiVnuDFR0uj0QRFY1unELcy+Z72lySrH9X3SZl9VB72WKvofFb Ar8ofkj4dd4g8RTr9WRC+h9b1kwnNk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

quota_update_limits() is a misnomer because what it actually does is
that it updates 'usage' counters and leaves 'limit' counters intact.
Rename quota_update_limits() to quota_read_all_dquots() and while
changing prototype also add a flags argument so that callers can control
which quota information is actually updated from the disk.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 e2fsck/super.c        |  3 ++-
 lib/support/mkquota.c | 11 ++++++-----
 lib/support/quotaio.h |  7 +++++--
 misc/tune2fs.c        |  5 +++--
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/e2fsck/super.c b/e2fsck/super.c
index e1c3f93572f4..75b7b8ffa9b6 100644
--- a/e2fsck/super.c
+++ b/e2fsck/super.c
@@ -281,7 +281,8 @@ static errcode_t e2fsck_read_all_quotas(e2fsck_t ctx)
 		if (qf_ino == 0)
 			continue;
 
-		retval = quota_update_limits(ctx->qctx, qf_ino, qtype);
+		retval = quota_read_all_dquots(ctx->qctx, qf_ino, qtype,
+					       QREAD_USAGE);
 		if (retval)
 			break;
 	}
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 8e5c61a601cc..0fefca90c843 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -585,10 +585,11 @@ static errcode_t quota_write_all_dquots(struct quota_handle *qh,
 #endif
 
 /*
- * Updates the in-memory quota limits from the given quota inode.
+ * Read quotas from disk and updates the in-memory information determined by
+ * 'flags' from the on-disk data.
  */
-errcode_t quota_update_limits(quota_ctx_t qctx, ext2_ino_t qf_ino,
-			      enum quota_type qtype)
+errcode_t quota_read_all_dquots(quota_ctx_t qctx, ext2_ino_t qf_ino,
+				enum quota_type qtype, unsigned int flags)
 {
 	struct scan_dquots_data scan_data;
 	struct quota_handle *qh;
@@ -611,8 +612,8 @@ errcode_t quota_update_limits(quota_ctx_t qctx, ext2_ino_t qf_ino,
 
 	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
 	scan_data.check_consistency = 0;
-	scan_data.update_limits = 0;
-	scan_data.update_usage = 1;
+	scan_data.update_limits = !!(flags & QREAD_LIMITS);
+	scan_data.update_usage = !!(flags & QREAD_USAGE);
 	qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
 
 	err = quota_file_close(qctx, qh);
diff --git a/lib/support/quotaio.h b/lib/support/quotaio.h
index 6068970009f5..84fac35dda20 100644
--- a/lib/support/quotaio.h
+++ b/lib/support/quotaio.h
@@ -224,8 +224,11 @@ void quota_data_add(quota_ctx_t qctx, struct ext2_inode_large *inode,
 void quota_data_sub(quota_ctx_t qctx, struct ext2_inode_large *inode,
 		    ext2_ino_t ino, qsize_t space);
 errcode_t quota_write_inode(quota_ctx_t qctx, enum quota_type qtype);
-errcode_t quota_update_limits(quota_ctx_t qctx, ext2_ino_t qf_ino,
-			      enum quota_type type);
+/* Flags for quota_read_all_dquots() */
+#define QREAD_USAGE  0x01
+#define QREAD_LIMITS 0x02
+errcode_t quota_read_all_dquots(quota_ctx_t qctx, ext2_ino_t qf_ino,
+				enum quota_type type, unsigned int flags);
 errcode_t quota_compute_usage(quota_ctx_t qctx);
 void quota_release_context(quota_ctx_t *qctx);
 errcode_t quota_remove_inode(ext2_filsys fs, enum quota_type qtype);
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f739f16cd62b..bb08f8026918 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1671,8 +1671,9 @@ static int handle_quota_options(ext2_filsys fs)
 		if (quota_enable[qtype] == QOPT_ENABLE &&
 		    *quota_sb_inump(fs->super, qtype) == 0) {
 			if ((qf_ino = quota_file_exists(fs, qtype)) > 0) {
-				retval = quota_update_limits(qctx, qf_ino,
-							     qtype);
+				retval = quota_read_all_dquots(qctx, qf_ino,
+							       qtype,
+							       QREAD_USAGE);
 				if (retval) {
 					com_err(program_name, retval,
 						_("while updating quota limits (%d)"),
-- 
2.26.2

