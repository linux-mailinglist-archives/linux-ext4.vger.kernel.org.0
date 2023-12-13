Return-Path: <linux-ext4+bounces-416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B58107D6
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C13282460
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF520F2;
	Wed, 13 Dec 2023 01:50:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
X-Greylist: delayed 988 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Dec 2023 17:50:28 PST
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A2CAD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:50:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqdLB1qHmz1wnhW;
	Wed, 13 Dec 2023 09:33:54 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id DEC9A1800DD;
	Wed, 13 Dec 2023 09:34:00 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:59 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 4/5] jbd2: Abort journal when detecting metadata writeback error of fs dev
Date: Wed, 13 Dec 2023 09:32:23 +0800
Message-ID: <20231213013224.2100050-5-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

This is a replacement solution of commit bc71726c725767 ("ext4: abort
the filesystem if failed to async write metadata buffer"), JBD2 can
detect metadata writeback error of fs dev by 'j_fs_dev_wb_err'.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5f08b5fd105a..cb0b8d6fc0c6 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1231,11 +1231,25 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
 int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 {
 	struct journal_head *jh;
+	journal_t *journal;
 	int rc;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
 
+	journal = handle->h_transaction->t_journal;
+	if (jbd2_check_fs_dev_write_error(journal)) {
+		/*
+		 * If the fs dev has writeback errors, it may have failed
+		 * to async write out metadata buffers in the background.
+		 * In this case, we could read old data from disk and write
+		 * it out again, which may lead to on-disk filesystem
+		 * inconsistency. Aborting journal can avoid it happen.
+		 */
+		jbd2_journal_abort(journal, -EIO);
+		return -EIO;
+	}
+
 	if (jbd2_write_access_granted(handle, bh, false))
 		return 0;
 
-- 
2.39.2


