Return-Path: <linux-ext4+bounces-4573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4190D99B22B
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Oct 2024 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71CC1F22938
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Oct 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132FE1487E5;
	Sat, 12 Oct 2024 08:41:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75CC33F7;
	Sat, 12 Oct 2024 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728722478; cv=none; b=J7IyixTDWUGrg4i/0kjFjI92c8nj4a75Z6fcrCxJ2A93i223URBulKYGtnL5TI92/wRzSV9/KM+IUXpWr/xQmWkreamjuENeLiZWsr48m3ouo3P3fdNNMCVaDd4sCARISjyKQpqwtySAUvsE4Y3QIWvKmopPcR+GLCnOHgPQcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728722478; c=relaxed/simple;
	bh=wg9NKRUSgcM2qaQewMVrRt8Ul2i0AVVF99KlyEqzPfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZehAF830z06hK0W5g3Q5W6EMDvATTL/krBKyMuN57HDtgUFtPVfioDJpWSoPbnwIO1BthrrP7HF8Rh6v/3vAhaJYmHgCNxCtawwlzhJ7pC3Qh9v4QrTrjvgOVYIPxhpWc1zNOSHLXZp8P7T6LOTUdN7nJtTaL2QaCk4l4UdjBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQcQh26yKz4f3k5x;
	Sat, 12 Oct 2024 16:41:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E9361A08DC;
	Sat, 12 Oct 2024 16:41:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3KscZNgpnaJF_Dw--.43374S4;
	Sat, 12 Oct 2024 16:41:12 +0800 (CST)
From: Zhihao Cheng <chengzhihao@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com
Subject: [PATCH] jbd2: Make b_frozen_data allocation always succeed
Date: Sat, 12 Oct 2024 16:55:30 +0800
Message-Id: <20241012085530.2147846-1-chengzhihao@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KscZNgpnaJF_Dw--.43374S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7WrW5Cr4kuryUuF45ZFb_yoW8ur43pr
	93Ga48AryvvryjyF1kXa1DXFyUuayDurW7Kr1jgwn5Zw4UJwnagr42yr909ryYyF92kayr
	XrW8Wa97Gw4Y93JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: xfkh0wx2klxt3r6k3tpzhluzxrxghudrp/

From: Zhihao Cheng <chengzhihao1@huawei.com>

The b_frozen_data allocation should not be failed during journal
committing process, otherwise jbd2 will abort.
Since commit 490c1b444ce653d("jbd2: do not fail journal because of
frozen_buffer allocation failure") already added '__GFP_NOFAIL' flag
in do_get_write_access(), just add '__GFP_NOFAIL' flag for all allocations
in jbd2_journal_write_metadata_buffer(), like 'new_bh' allocation does.
Besides, remove all error handling branches for do_get_write_access().

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/commit.c  | 4 ----
 fs/jbd2/journal.c | 8 +-------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 4305a1ac808a..9153ff3a08e7 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -662,10 +662,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		JBUFFER_TRACE(jh, "ph3: write metadata");
 		escape = jbd2_journal_write_metadata_buffer(commit_transaction,
 						jh, &wbuf[bufs], blocknr);
-		if (escape < 0) {
-			jbd2_journal_abort(journal, escape);
-			continue;
-		}
 		jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
 
 		/* Record the new block's tag in the current descriptor
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..29d30eddf727 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -318,7 +318,6 @@ static inline void jbd2_data_do_escape(char *data)
  *
  *
  * Return value:
- *  <0: Error
  *  =0: Finished OK without escape
  *  =1: Finished OK with escape
  */
@@ -386,12 +385,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 			goto escape_done;
 
 		spin_unlock(&jh_in->b_state_lock);
-		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
-		if (!tmp) {
-			brelse(new_bh);
-			free_buffer_head(new_bh);
-			return -ENOMEM;
-		}
+		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS | __GFP_NOFAIL);
 		spin_lock(&jh_in->b_state_lock);
 		if (jh_in->b_frozen_data) {
 			jbd2_free(tmp, bh_in->b_size);
-- 
2.39.2


