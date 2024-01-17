Return-Path: <linux-ext4+bounces-834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F58304CD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A041F23F14
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F531DFC8;
	Wed, 17 Jan 2024 11:56:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781821DFD7
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492565; cv=none; b=hsQIqPAy8uclb7qwiPmyztfih1+1Naj2rvOfv14IfQfP9iTffAfsceeZLF4N1ai/cdlXXi5oO4D8u0K7Qga0u0y9S6xPxzucILl9EH1zi3HyXLQ843P9aFzRZrJvw9OrCA87i28l3vGFXSLey4jBjw4R9xP6NfdiMbJ7N9BIpyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492565; c=relaxed/simple;
	bh=fO+CdmqzzLBkKSbF5xikZu01+uPD2hJYat4Dz596Bqk=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo; b=AT+4lkohjsUA6oUaDhfF8Ma0Zf1ya6lY+XT/SXf6SMJiqq2WAX1TmEjCe3Y7Hpq4bnvA2wTVsak1hOSFTPIDcc5BCG/cWyUZRo0VyB1mB/LNwIg9KY3z2dO9zoG0+xZAOTXDe4waZE8vBGhL2QVcut9RKNI/Jky8u0g7EDxDMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFPTj6rPPz4f3lg6
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 19:55:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 156391A0171
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 19:56:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5JwKdlTAVxBA--.18229S5;
	Wed, 17 Jan 2024 19:55:59 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH 2/2] ext4: distinguish different error in ext4_mb_seq_groups_show
Date: Wed, 17 Jan 2024 19:52:23 +0800
Message-Id: <20240117115223.80253-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117115223.80253-1-yangerkun@huawei.com>
References: <20240117115223.80253-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g5JwKdlTAVxBA--.18229S5
X-Coremail-Antispam: 1UD129KBjvJXoW7GF43JryDJrW3XF13Gr1UAwb_yoW8JrW3pF
	sxAFnrGr4agr1UCr48ua4jgasaq34xu34xG3sxWw1rZFy7XryxWFnrtF1j9F18CFWrX3Wa
	v3s09r15Jr1xGw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20x
	vY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07U_ucNUUUUU=
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

While cat mb_groups for a mounted ext4 image which has some corrupted
group, the string return to userspace was just "I/O error" which confuse
me a lot. Use ext4_decode_error to help distinguish different error.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/mballoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 139f232bdbb5..77d6113e2822 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2991,6 +2991,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	struct super_block *sb = pde_data(file_inode(seq->file));
 	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
 	int i, err;
+	char nbuf[16];
 	struct ext4_buddy e4b;
 	struct ext4_group_info *grinfo;
 	unsigned char blocksize_bits = min_t(unsigned char,
@@ -3017,7 +3018,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
 		err = ext4_mb_load_buddy(sb, group, &e4b);
 		if (err) {
-			seq_printf(seq, "#%-5u: I/O error\n", group);
+			seq_printf(seq, "#%-5u: %s\n", group, ext4_decode_error(NULL, err, nbuf));
 			return 0;
 		}
 		ext4_mb_unload_buddy(&e4b);
-- 
2.39.2


