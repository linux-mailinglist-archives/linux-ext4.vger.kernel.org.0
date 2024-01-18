Return-Path: <linux-ext4+bounces-844-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F7831220
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 05:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2FB1F23336
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jan 2024 04:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEA8C0C;
	Thu, 18 Jan 2024 04:29:41 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017906FD2
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 04:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705552181; cv=none; b=T/mBOy8vdKH7UhnYSFQHxDIa3+RjLS+U0d6cIGAwf7DipBW6B+yWZjx1CilKkb2WE0HGJZQvboEqOOeY8J6JSbRA+Nx/z5hJKsJIdSgg1MiPyDdksrdKoXSqgLGvnFLsgITGQwmhsMkAQDMMMVnQ26BrB2orW00gKGhhKZbiqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705552181; c=relaxed/simple;
	bh=Ur+gqchWAV1ZvySvaZK/hwTgZgc5EuSXq4DHdxiGdhA=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo; b=Zw4Ou98tQhQy2ZjdejXDvr68At4ChSRernrcLsx/7ybFr1GSDwHuQ27M5jyKpeOoEIXdG3hBCQTqJkznRQd+TK4lo+xGnBvC8R1wKeC+DNZ+SSiocwuIx8EIVLwGmhiRTGt04Ltg7x51HiNxAXwuvFdnAKX92aujNROj5GcMIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFqXD3gJBz4f3jqy
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:29:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ABF8D1A0171
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jan 2024 12:29:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXHG4pqahlA7LBBA--.32043S5;
	Thu, 18 Jan 2024 12:29:34 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH v2 2/2] ext4: improve error msg for ext4_mb_seq_groups_show
Date: Thu, 18 Jan 2024 12:25:57 +0800
Message-Id: <20240118042557.380058-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118042557.380058-1-yangerkun@huawei.com>
References: <20240118042557.380058-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXHG4pqahlA7LBBA--.32043S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr18ArWfXr4rAryrJr17GFg_yoW8Jw1fpF
	sxA3ZrCrW3Wr1qkr48uFyjgasYg3yIk34xWr9xWw1FvFy7Jry2kF47tF1YvF1UAFWrX3ZI
	vwn0vr15Cr1fC3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28Icx
	kI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU1rgA5UUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

While cat mb_groups for a mounted ext4 image which has some corrupted
group, the string return to userspace was just "I/O error" which confuse
me a lot. Improve it with ext4_decode_error.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

v1-v2:
improve the commit msg, add review tag.

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 866f8f0922f1..f0c79c9d35e1 100644
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


