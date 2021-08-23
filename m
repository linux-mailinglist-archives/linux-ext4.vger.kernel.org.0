Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9812B3F4DAB
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhHWPmf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57870 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F2CB22001;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou52MhRcB/VYgIbLJ9OdaPUENb5pJ36GeqZ6y8cs4pw=;
        b=mHFD7wG431QodM6SrPc68oA3l3yaUO8XEJ4Q7PGg+9zJHtApoIOFSDZ4AFNOuY0Fy7fp5y
        CkrE5cZqSLxLzmJMPblOD6PpPPW2cMb9QAfImvRbn8MAoioFVII8CzJJ2B5p+l0B9eJv5E
        Ba333b+vmWefmlV3V2J9grzHA3auJn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou52MhRcB/VYgIbLJ9OdaPUENb5pJ36GeqZ6y8cs4pw=;
        b=8oCNv60QiCYa40zMnpqhItABpFJ1G24kXQC/haNLm/Zb666HCFtVmzSGRMwOMrL7ilfsE7
        Uoxpog6Z89/xRQAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 02E4AA3BB4;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C36FF1F2BA4; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/8] quota: Fold quota_read_all_dquots() into quota_update_limits()
Date:   Mon, 23 Aug 2021 17:41:22 +0200
Message-Id: <20210823154128.16615-3-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; h=from:subject; bh=P7jQb3ZXNuPWs0M0khNUm88nO2ChkOKzT3PGfFt2YNE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GihdgOLrTUGvgyKLo/9lHgsSXNpuX+TjVHdW+m 661Y0fGJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBogAKCRCcnaoHP2RA2aEPB/ 9zdPkcMlJKxGzpEO0BmaBNu0c3VbFZR72otTj64Pm1AWxyU9PL288d+VnPov7WSeduPBKtXxmevxAw tR0TYFt4ui8Gr7HLMoTvP7EJ3YX/KZ2mnXnz9JJ5DB2fG07VBbKmcfPKzsxYTUd0Xe5RJU0PYPI62W j8W17jQelcHCNhAJk6oJFP7hPE+dsGUzGthbeQhWrb5zmboB/Ui55mfM1mLaloebpJkg1eqEZzX1jE 6T9iEfBSgv5WowKIfJInnXkI+l4UED+Ri1pjuFgBtpWjJEP8ixpFhlo0ULZxfK/OX9sFWQU+Z+opoM Qi0W7Fbb7hR7YZP84xnIbF1FUgHa+l
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There's just one caller of quota_read_all_dquots(), fold it into its
caller quota_update_limits(). No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/support/mkquota.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index fbc3833aee98..8e5c61a601cc 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -564,23 +564,6 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
 	return 0;
 }
 
-/*
- * Read all dquots from quota file into memory
- */
-static errcode_t quota_read_all_dquots(struct quota_handle *qh,
-                                       quota_ctx_t qctx,
-				       int update_limits EXT2FS_ATTR((unused)))
-{
-	struct scan_dquots_data scan_data;
-
-	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
-	scan_data.check_consistency = 0;
-	scan_data.update_limits = 0;
-	scan_data.update_usage = 1;
-
-	return qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
-}
-
 /*
  * Write all memory dquots into quota file
  */
@@ -607,6 +590,7 @@ static errcode_t quota_write_all_dquots(struct quota_handle *qh,
 errcode_t quota_update_limits(quota_ctx_t qctx, ext2_ino_t qf_ino,
 			      enum quota_type qtype)
 {
+	struct scan_dquots_data scan_data;
 	struct quota_handle *qh;
 	errcode_t err;
 
@@ -625,7 +609,11 @@ errcode_t quota_update_limits(quota_ctx_t qctx, ext2_ino_t qf_ino,
 		goto out;
 	}
 
-	quota_read_all_dquots(qh, qctx, 1);
+	scan_data.quota_dict = qctx->quota_dict[qh->qh_type];
+	scan_data.check_consistency = 0;
+	scan_data.update_limits = 0;
+	scan_data.update_usage = 1;
+	qh->qh_ops->scan_dquots(qh, scan_dquots_callback, &scan_data);
 
 	err = quota_file_close(qctx, qh);
 	if (err) {
-- 
2.26.2

