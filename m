Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003DE79336A
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 03:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjIFBeR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 21:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjIFBeR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 21:34:17 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194EBF;
        Tue,  5 Sep 2023 18:34:10 -0700 (PDT)
X-QQ-mid: bizesmtp65t1693964025tuxkgbaa
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Sep 2023 09:33:44 +0800 (CST)
X-QQ-SSF: 01400000000000D0I000000A0000000
X-QQ-FEAT: ttAhR/+4RmkwQcBXx0/bYmPrTS4OCK09iM3T8Ufy+yqkvDtY8ELPLFanT9jfd
        8SK2AVVa0XGH29e/aquu6Tx+/L2vaCYoQimoODap+VqDnznHrO9hx9IH4dcXc4u9lliF7wf
        l2Ugv8SsBpFgfvadxkzUkxFsIuiIsBXCAIfat8d/03dHc1Ld4/O0TPzNn82fj9SIMIL6/Sv
        fLxX5a04GpLuOPyp3ndvyvyioIYgfNCF3IEgTtKrgVaqAXIJgRsdC7dAyjV0s1XB193TVc4
        4SmSmjac4hmYxntYgb17Uf2tkssJ3dc3DiPHEEG+RFMbBAOp6ERVvyrdBwx8TwDnlUlzvYG
        e0k4ejBYUBck0Mh96MdR7TJeWQHQ/wj9rcyd+uM6mDxx4LvZAFw6aWbJ3FoeYGLceaGYEHV
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7777711094741804466
From:   gouhao@uniontech.com
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     egouriou@google.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: move 'ix' sanity check to corrent position
Date:   Wed,  6 Sep 2023 09:33:41 +0800
Message-Id: <20230906013341.7199-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

'ix' check should be before using it.

Fixes: 80e675f906db ("ext4: optimize memmmove lengths in extent/index insertions")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/ext4/extents.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..4d8496d1a8ac 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1010,6 +1010,11 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		ix = curp->p_idx;
 	}
 
+	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
+		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
+		return -EFSCORRUPTED;
+	}
+
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
@@ -1019,11 +1024,6 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
 	}
 
-	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
-		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
-		return -EFSCORRUPTED;
-	}
-
 	ix->ei_block = cpu_to_le32(logical);
 	ext4_idx_store_pblock(ix, ptr);
 	le16_add_cpu(&curp->p_hdr->eh_entries, 1);
-- 
2.20.1

