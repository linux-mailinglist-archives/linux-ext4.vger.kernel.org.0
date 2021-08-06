Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235FA3E27ED
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 11:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbhHFJ64 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 05:58:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244771AbhHFJ6v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 05:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628243915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gyfKEgbT5BTjyNZs/aGzasGPnzV93pjDH6vDUCPUck=;
        b=PQ+8H0tvT9QE75aFD2CtV4t7wD6+aLQnkeAwb38Tyn081B00TIHvTZB9spT8x+G3AmbT5W
        hedz+pP899uTqs8MnNi5TWmK9Ijyt7BoOFl1YZn3ynt2lt8o5Av8cjSv8/b8ji8gHGa+BE
        /wzSsQvJ/UYk9QxIAFtBngEkkibi3Iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-RuLOoc0LMt-X-7SK0tjnKw-1; Fri, 06 Aug 2021 05:58:33 -0400
X-MC-Unique: RuLOoc0LMt-X-7SK0tjnKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8B66802929;
        Fri,  6 Aug 2021 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AE7E81F76;
        Fri,  6 Aug 2021 09:58:32 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 7/7] mkquota: Fix potental NULL pointer dereference
Date:   Fri,  6 Aug 2021 11:58:20 +0200
Message-Id: <20210806095820.83731-7-lczerner@redhat.com>
In-Reply-To: <20210806095820.83731-1-lczerner@redhat.com>
References: <20210806095820.83731-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

get_dq() function can fail when the memory allocation fails and so we
could end up dereferencing NULL pointer. Fix it.

Also, we should really return -ENOMEM instead of -1, or even 0 from
various functions in quotaio_tree.c when memory allocation fails.
Fix it as well.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 lib/support/mkquota.c      | 8 ++++++--
 lib/support/quotaio_tree.c | 8 ++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index dce077e6..420ba503 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -433,7 +433,8 @@ void quota_data_sub(quota_ctx_t qctx, struct ext2_inode_large *inode,
 		dict = qctx->quota_dict[qtype];
 		if (dict) {
 			dq = get_dq(dict, get_qid(inode, qtype));
-			dq->dq_dqb.dqb_curspace -= space;
+			if (dq)
+				dq->dq_dqb.dqb_curspace -= space;
 		}
 	}
 }
@@ -460,7 +461,8 @@ void quota_data_inodes(quota_ctx_t qctx, struct ext2_inode_large *inode,
 		dict = qctx->quota_dict[qtype];
 		if (dict) {
 			dq = get_dq(dict, get_qid(inode, qtype));
-			dq->dq_dqb.dqb_curinodes += adjust;
+			if (dq)
+				dq->dq_dqb.dqb_curinodes += adjust;
 		}
 	}
 }
@@ -533,6 +535,8 @@ static int scan_dquots_callback(struct dquot *dquot, void *cb_data)
 	struct dquot *dq;
 
 	dq = get_dq(quota_dict, dquot->dq_id);
+	if (!dq)
+		return -ENOMEM;
 	dq->dq_id = dquot->dq_id;
 	dq->dq_flags |= DQF_SEEN;
 
diff --git a/lib/support/quotaio_tree.c b/lib/support/quotaio_tree.c
index 6cc4fb5b..65e68792 100644
--- a/lib/support/quotaio_tree.c
+++ b/lib/support/quotaio_tree.c
@@ -569,7 +569,7 @@ static int report_block(struct dquot *dquot, unsigned int blk, char *bitmap,
 	int entries, i;
 
 	if (!buf)
-		return -1;
+		return -ENOMEM;
 
 	set_bit(bitmap, blk);
 	read_blk(dquot->dq_h, blk, buf);
@@ -601,7 +601,7 @@ static int report_tree(struct dquot *dquot, unsigned int blk, int depth,
 	__le32 *ref = (__le32 *) buf;
 
 	if (!buf)
-		return 0;
+		return -ENOMEM;
 
 	read_blk(dquot->dq_h, blk, buf);
 	if (depth == QT_TREEDEPTH - 1) {
@@ -667,12 +667,12 @@ int qtree_scan_dquots(struct quota_handle *h,
 	struct dquot *dquot = get_empty_dquot();
 
 	if (!dquot)
-		return -1;
+		return -ENOMEM;
 
 	dquot->dq_h = h;
 	if (ext2fs_get_memzero((info->dqi_blocks + 7) >> 3, &bitmap)) {
 		ext2fs_free_mem(&dquot);
-		return -1;
+		return -ENOMEM;
 	}
 	ret = report_tree(dquot, QT_TREEOFF, 0, bitmap, process_dquot, data);
 	if (ret < 0)
-- 
2.31.1

