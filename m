Return-Path: <linux-ext4+bounces-6217-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4942A19F63
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA525188C17C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE920B81F;
	Thu, 23 Jan 2025 07:53:11 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7F2F2A;
	Thu, 23 Jan 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618791; cv=none; b=pzv1NUKwvwXOpHiSNMAl9Ata1OpYpi9YfXhSiSkStD0sZUNyPyWF1X+83anpIUALj9siHeXyieASeXsX93GQltpcZB/9IbEY8lzOM21Ta8w4UxwHELJyDpT/nEgrKAZ6reqfwGBlwPC92ciV6KkJ23+lFHA2U1YzmNmtc7GtSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618791; c=relaxed/simple;
	bh=k0Dqr/KbOram04og3gxH64mY5dRbnQOTVegx5ly/cVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ya4joy7qKh0BkhS7tSgQcR/jb0H6SLftmdJfW+oe517wA1ULj+2FHCpwPbBPTVDF9KZlkbRCEX9ipyUwmRqz0x0eA145JNbjxabH2YouMwBMO8q8RabQ3Mfa0oOQq4TRjXKXS4r5NI4fdYi/FgUi4PSFTG6+1O70fasLUj/gIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdtTS2dLZz4f3lVp;
	Thu, 23 Jan 2025 15:52:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4A9D31A018C;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnR8Jf9ZFnizDkBg--.43540S5;
	Thu, 23 Jan 2025 15:53:06 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] jbd2: remove unused return value of do_readahead
Date: Thu, 23 Jan 2025 23:50:11 +0800
Message-Id: <20250123155014.2097920-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
References: <20250123155014.2097920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnR8Jf9ZFnizDkBg--.43540S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1UWFW5WrWxCrWxCry3Arb_yoW8WF4kpr
	n8GayYkFWqyF1jva4kJFs8tFWIga17tFyUGrWqkwn5tF45JrsIqa4vgF1jqryUtFZ5ua18
	Zr1vy3srGw4jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRvYLyUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of do_readahead.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/recovery.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 9192be7c19d8..a671f8ee7dd2 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -65,9 +65,8 @@ static void journal_brelse_array(struct buffer_head *b[], int n)
  */
 
 #define MAXBUF 8
-static int do_readahead(journal_t *journal, unsigned int start)
+static void do_readahead(journal_t *journal, unsigned int start)
 {
-	int err;
 	unsigned int max, nbufs, next;
 	unsigned long long blocknr;
 	struct buffer_head *bh;
@@ -85,7 +84,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 	nbufs = 0;
 
 	for (next = start; next < max; next++) {
-		err = jbd2_journal_bmap(journal, next, &blocknr);
+		int err = jbd2_journal_bmap(journal, next, &blocknr);
 
 		if (err) {
 			printk(KERN_ERR "JBD2: bad block at offset %u\n",
@@ -94,10 +93,8 @@ static int do_readahead(journal_t *journal, unsigned int start)
 		}
 
 		bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
-		if (!bh) {
-			err = -ENOMEM;
+		if (!bh)
 			goto failed;
-		}
 
 		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
 			bufs[nbufs++] = bh;
@@ -112,12 +109,10 @@ static int do_readahead(journal_t *journal, unsigned int start)
 
 	if (nbufs)
 		bh_readahead_batch(nbufs, bufs, 0);
-	err = 0;
 
 failed:
 	if (nbufs)
 		journal_brelse_array(bufs, nbufs);
-	return err;
 }
 
 #endif /* __KERNEL__ */
-- 
2.30.0


