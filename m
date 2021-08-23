Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02513F4DAA
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhHWPmi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 11:42:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57902 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhHWPmf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 11:42:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 315FF22006;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629733312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIWf+MhVGGixUD+aJClvE3eVqVHHq7gtFlKhILicz2M=;
        b=ze6UV4sWvHatWEMi3vPaHM58zC0QvVCw9H5JvxyZwvbT/QbrQvH0Th+UIwLi8ufm6tRFJN
        8m8YtHevgyXudXbEFOYvURoquPMRn/S555LbZtIpcvTaWw8Rt9+E5YUiJSjS2WNFQIyIMb
        9AQCLf5ZGDQcPJiyvkZtB8AE57NsunI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629733312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIWf+MhVGGixUD+aJClvE3eVqVHHq7gtFlKhILicz2M=;
        b=E3e/aVZohO824UfOPotRaZ5Vc1DxgwG0stVMaOa9ZEhVcQ4ZD+OjhRr2V9Q/U8ZFyY+eSu
        4v6e7co83C6at4Ag==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 28665A3BBC;
        Mon, 23 Aug 2021 15:41:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBADE1F2CD5; Mon, 23 Aug 2021 17:41:51 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] quota: Drop dead code
Date:   Mon, 23 Aug 2021 17:41:28 +0200
Message-Id: <20210823154128.16615-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210823154128.16615-1-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; h=from:subject; bh=61dKtjVKi3diCfHpa1/d4uDj1elmJCEY1fKv83UzzKA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhI8GnVlsRAgEc7AzGwJddaA7LDt33ZX+Yj9rady7y 42St04GJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYSPBpwAKCRCcnaoHP2RA2aBMCA COK2Z3O7gobEnW9GHL1bd1MlJOqsYxPxnOp3rFCkB4Kb6V770XUoCCnyeD7NwNxooWZSNOB7JCuyGQ Yl945dec75Yv8zw49bulfVe496hHFX4O4UzAgZKG0vZYAjHpwaEk9Txf3MLpSHxSFlvbH8LE4sT7yD M4wEEznUZokwwRoj+ds12+Rm+P1Sj/AhghUTaPFpuA5RjplBAg728b9f6Ia2JMsNzxoBRksVdOONjU 2gtjwbR7Ne2GlN722u71YHItAL0sBAVPIHZQznZEKAZFwEnOHSRWlvwLItLdMfpoMcYXjDJIWz+mXx QbpFU9jSQfiJBn+wba2yVZKohLP403
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Drop unused function from quota support code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/support/mkquota.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index 0fefca90c843..a4401b7f77af 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -564,26 +564,6 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
 	return 0;
 }
 
-/*
- * Write all memory dquots into quota file
- */
-#if 0 /* currently unused, but may be useful in the future? */
-static errcode_t quota_write_all_dquots(struct quota_handle *qh,
-                                        quota_ctx_t qctx)
-{
-	errcode_t err;
-
-	err = ext2fs_read_bitmaps(qctx->fs);
-	if (err)
-		return err;
-	write_dquots(qctx->quota_dict[qh->qh_type], qh);
-	ext2fs_mark_bb_dirty(qctx->fs);
-	qctx->fs->flags &= ~EXT2_FLAG_SUPER_ONLY;
-	ext2fs_write_bitmaps(qctx->fs);
-	return 0;
-}
-#endif
-
 /*
  * Read quotas from disk and updates the in-memory information determined by
  * 'flags' from the on-disk data.
-- 
2.26.2

