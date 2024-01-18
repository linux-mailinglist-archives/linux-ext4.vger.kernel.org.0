Return-Path: <linux-ext4+bounces-843-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B43083121F
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 05:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A81F23168
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 04:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B25749D;
	Thu, 18 Jan 2024 04:29:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5844612E
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705552180; cv=none; b=KIYXrSIe02kxemVJrQ+Xip1tAzj3qIxJvB9zqgzUtkQdG5/D1NYepAaGVFJ7aqfM7tRChOge7emQsWFBOrbjcYLFLDgI6k/y6vJbLtEAegqwoJQsIyN29kznfBlmY4VSPbWN7lYJ6ZrZlCsP+KemrhR9pMr6Mh4DgOTtzTrRPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705552180; c=relaxed/simple;
	bh=L570oWC93W/Dw8635o+EeqVdgNf8u470U/shwkqXVV8=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:Sender:X-CM-SenderInfo; b=SjbxMw7Yr38Gge9E0fV2UTs7B8hzOkew8vIX66VNyghfQ9s0vduZIAsxFOcA/eyXCK+5EeWCnlCw3lylyebsKsAZOG7MIse9rqNQ13t0ZFlGpEv6smjfCjtr+KF8m5qAJgY1kLFSCWAJELdyP9pXQlniNzpZeWISognPh4Z78yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFqXD1THyz4f3jqd
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:29:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E9961A09E3
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:29:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXHG4pqahlA7LBBA--.32043S4;
	Thu, 18 Jan 2024 12:29:34 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2 1/2] ext4: remove unused buddy_loaded in ext4_mb_seq_groups_show
Date: Thu, 18 Jan 2024 12:25:56 +0800
Message-Id: <20240118042557.380058-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXHG4pqahlA7LBBA--.32043S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aryftr13Aw1xGw43tr1fZwb_yoW8Xry3pF
	sxCF17KrW8Gr13Cr4DC3y0ga4rKw1xu34UGr93Wr1Fvry7Jry0gF9FqF10vr18CFZ3JF1S
	vw4Y9r15Cr4fG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCF
	04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07UQVyxUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

We can just first call ext4_mb_unload_buddy, then copy information from
ext4_group_info. So remove this unused value.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

v1->v2:
Add comments before memcpy, add review tag.

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f44f668e407f..866f8f0922f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2990,8 +2990,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 {
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
-	int i;
-	int err, buddy_loaded = 0;
+	int i, err;
 	struct ext4_buddy e4b;
 	struct ext4_group_info *grinfo;
 	unsigned char blocksize_bits = min_t(unsigned char,
@@ -3021,14 +3020,14 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "#%-5u: I/O error\n", group);
 			return 0;
 		}
-		buddy_loaded = 1;
+		ext4_mb_unload_buddy(&e4b);
 	}
 
+	/*
+	 * We care only about free space counters in the group info and
+	 * these are safe to access even after the buddy has been unloaded
+	 */
 	memcpy(&sg, grinfo, i);
-
-	if (buddy_loaded)
-		ext4_mb_unload_buddy(&e4b);
-
 	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
 			sg.info.bb_fragments, sg.info.bb_first_free);
 	for (i = 0; i <= 13; i++)
-- 
2.39.2


