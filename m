Return-Path: <linux-ext4+bounces-5760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B919F7317
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E01893264
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110415252D;
	Thu, 19 Dec 2024 03:02:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED314C6C;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577350; cv=none; b=lA3QUEuzwjGxSjcndR88UJ4bWltrkyr6lTJ4hk+rDkmG4fQsuxSYVhUTSsgWhzS11R6fgaCPtIcmjcjLU1SghKE0t8nRuBOuYo4UA4osqRJF2uCDPFdc6ZW36dL4SqpMRfabrzml8TtjAwWx61c3bmND/A5TiR3pNeE9UKQVp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577350; c=relaxed/simple;
	bh=f77/BUhvVUMSp4EMYuMM8mhFo/d1naob8C7Z+9LksYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B5aNhL9D56jyqvlENU94L1uJBHHDuHhzGEP7j/YPah921KXy0nSG/ZY5JHs2iWgHz/XOjMB+exlEi0IElprmkWRZ7L7Z/smhwZKHNO9CzWYp+rDGqZf9p+hNRdNKiqUAGi5GfgluWvNHl9S+plkEXLdWeF3Nmen5B/EDxQxG4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDFhC2ZNvz4f3kFP;
	Thu, 19 Dec 2024 11:02:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D9ADC1A06D7;
	Thu, 19 Dec 2024 11:02:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S3;
	Thu, 19 Dec 2024 11:02:22 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ext4: add missing brelse for bh2 in ext4_dx_add_entry
Date: Thu, 19 Dec 2024 19:00:22 +0800
Message-Id: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr47Xr1UGFWfGrW8WryxAFb_yoW8Cw1xpr
	W5KF97ZFyxuFnF9FsxA3WUXF13uw1xCry7W3y7GrySk347Xrn3Wasrtw1FkF4UJay8u3W5
	XF4UKryUua1IyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07js2-5UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Add missing brelse for bh2 in ext4_dx_add_entry.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/namei.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 1012781ae9b4..adec145b6f7d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		BUFFER_TRACE(frame->bh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, sb, frame->bh,
 						    EXT4_JTR_NONE);
-		if (err)
+		if (err) {
+			brelse(bh2);
 			goto journal_error;
+		}
 		if (!add_level) {
 			unsigned icount1 = icount/2, icount2 = icount - icount1;
 			unsigned hash2 = dx_get_hash(entries + icount1);
@@ -2592,8 +2594,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			err = ext4_journal_get_write_access(handle, sb,
 							    (frame - 1)->bh,
 							    EXT4_JTR_NONE);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 
 			memcpy((char *) entries2, (char *) (entries + icount1),
 			       icount2 * sizeof(struct dx_entry));
@@ -2612,8 +2616,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			dxtrace(dx_show_index("node",
 			       ((struct dx_node *) bh2->b_data)->entries));
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 			brelse (bh2);
 			err = ext4_handle_dirty_dx_node(handle, dir,
 						   (frame - 1)->bh);
@@ -2638,8 +2644,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				       "Creating %d level index...\n",
 				       dxroot->info.indirect_levels));
 			err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
-			if (err)
+			if (err) {
+				brelse(bh2);
 				goto journal_error;
+			}
 			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
 			brelse(bh2);
 			restart = 1;
-- 
2.30.0


