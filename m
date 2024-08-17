Return-Path: <linux-ext4+bounces-3752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B35955689
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB769B215ED
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2024 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24751145B26;
	Sat, 17 Aug 2024 08:59:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9612FB37
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885182; cv=none; b=D8khLX/cD9lvsjlJDUv+utMXQh94k6Ja9/ka0ELDtycfldLFXELb/lbqUPfxBOjNRfjQ48Kd+YHBmgWTK9qdA0oo3EEoFxYJNAy9xm9RyZEBuU6epqNHlcEgBXBTa4S8qDWxU2pAtBN3puFB6mQL0MZpsEu3onwb3YZxsAxWOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885182; c=relaxed/simple;
	bh=Gg3L9pJZvWrMMgn+fW7NuhpTEFcY9z5fFQbvuZWfkvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvVw6ADcFTeAEiKBRL3/ispDnUDzjtifI8+BbUUr1o5VnogANxvk0NCp/N14iAL7EptznxAU4uJWsQL3GObz/fXMIcpUzVBp3EZx2RYcxbdtpXhGA5VNE8GLKtkFe9HQS8nrwQ2oNKvE4nDWxstFGvJA7wR+7jLwznLIvb60kBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WmCTk0xYJz4f3kw2
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 16:59:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 05D771A0359
	for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 16:59:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4V0ZsBm9NO6Bw--.37200S4;
	Sat, 17 Aug 2024 16:59:36 +0800 (CST)
From: yangerkun <yangerkun@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount with discard
Date: Sat, 17 Aug 2024 16:55:10 +0800
Message-Id: <20240817085510.2084444-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4V0ZsBm9NO6Bw--.37200S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5GFyxCF4kCryrCrW5trb_yoW8Kw17pr
	ZxKr1jyrWqgr1I9anFg3W0qayfJw48Cw1UGrWrur48ArWfKFyS9FnIy3W5AFyjqFZ7CFs0
	vFn8u345CFy8u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0PhUUU
	UU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: yangerkun <yangerkun@huawei.com>

Commit 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in
ext4_group_info") speed up fstrim by skipping trim trimmed group. We
also has the chance to clear trimmed once there exists some block free
for this group(mount without discard), and the next trim for this group
will work well too.

For mount with discard, we will issue dicard when we free blocks, so
leave trimmed flag keep alive to skip useless trim trigger from
userspace seems reasonable. But for some case like ext4 build on
dm-thinpool(ext4 blocksize 4K, pool blocksize 128K), discard from ext4
maybe unaligned for dm thinpool, and thinpool will just finish this
discard(see process_discard_bio when begein equals to end) without
actually process discard. For this case, trim from userspace can really
help us to free some thinpool block.

So convert to clear trimmed flag for all case no matter mounted with
discard or not.

Fixes: 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in ext4_group_info")
Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

v1->v2:

- Add review tag
- resend this patch because the huawei email address was used to send the
  last email, I am worried that Ted did not seen this patch...

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..dfecd25cee4e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3887,11 +3887,8 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	/*
 	 * Clear the trimmed flag for the group so that the next
 	 * ext4_trim_fs can trim it.
-	 * If the volume is mounted with -o discard, online discard
-	 * is supported and the free blocks will be trimmed online.
 	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GRP_CLEAR_TRIMMED(db);
+	EXT4_MB_GRP_CLEAR_TRIMMED(db);
 
 	if (!db->bb_free_root.rb_node) {
 		/* No more items in the per group rb tree
@@ -6515,8 +6512,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 					 " group:%u block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
+
+		EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
 
 		ext4_lock_group(sb, block_group);
 		mb_free_blocks(inode, &e4b, bit, count_clusters);
-- 
2.39.2


