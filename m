Return-Path: <linux-ext4+bounces-5845-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F32B9FBD46
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 13:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1931881A49
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2E01C174E;
	Tue, 24 Dec 2024 12:29:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5D1B85FD;
	Tue, 24 Dec 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043357; cv=none; b=bwOb33tDfuFFM1/qGVKi60decPep08l7r+CvI8C9y2iEZvolkKX4Bp1f4L3lZAeWnCnCRGlui1XSCGiv66fwKmAUkr2Jgq9zG/86UrduYTY6lrajXRjz7XE84fRCbt69VpQjbC0jydIbhCaaM1356LBosAiXtzxBqWa9sskl2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043357; c=relaxed/simple;
	bh=Bj0X2QFcEtpYuTf8EIvOv+6sAYkgT645Blxjon+pv0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBrC79rg6qJhj11vKb78Cu6bkX+7PQbeGvYZJxHoDFHGbdjbxPkcPAWh2ozm+GClVz4Zuk455CzuPLMBtGhOwK34glLT1xTXG6I5mchoa8pDw2SWswiUhNI7jgoCXIC2mK5VbV6x2X5weMM1THE5fcFEl65P7DMHw6K0vV3KmT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YHZ1v47fBz4f3lWF;
	Tue, 24 Dec 2024 20:28:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 570B01A018D;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDXs8AWqWpnruNnFQ--.3177S5;
	Tue, 24 Dec 2024 20:29:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] jbd2: remove unused return value of do_readahead
Date: Wed, 25 Dec 2024 04:27:04 +0800
Message-Id: <20241224202707.1530558-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDXs8AWqWpnruNnFQ--.3177S5
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1UWFW5WrWxCrWxCry3Arb_yoW8Xw13pr
	n8Ka90kFZ0yr1jva4kJFs8tFWIgF47tFyUCrWqkwn5tF45JFsIqa4vgF1UtFyUtF95ua18
	Zr1vv3srGw4jk3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jy0PhUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of do_readahead.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


