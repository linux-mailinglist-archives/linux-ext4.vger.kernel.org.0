Return-Path: <linux-ext4+bounces-835-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989B8304CE
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 12:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9091F24F16
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 11:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16491DFDC;
	Wed, 17 Jan 2024 11:56:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814E1DFCF
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492566; cv=none; b=faBEaMdv/g6NgNW0ZISVEqtuUl+r7HsiRQ/iO03Zby3lM9TezP/G3EQKYQEO6oWWo33i2lIK61BaA1F51XaIXWdLPNk2N6bBu2VQcBacXMNuEIOuipMaq/xNGavSmRcKSP8wNy7GmkkLaTyA8PTXilaDbufrSe5ei7PUUfugAxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492566; c=relaxed/simple;
	bh=yta4a/lm1v9dJabha7/osqqliA6xtmI1QbzgXS7WPT4=;
	h=Received:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:Sender:X-CM-SenderInfo; b=OO7Vx1vCdckvKnRArXFxkjaH7X0rwCQ23uJQQQJ1GWtxz8wRBs/eTnTAaZI6SAeXnmjeE8R/dqheOTmfUeecElTQbANDPujdTOTdXGRqWpoZ3a7jSWAR2TRetD58Cyb0zuOQu5IGnrzbeDZQlu5Jt+eQjfGEGp8dczMfTel6RN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFPTj4jYlz4f3lVk
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 19:55:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BDB161A0171
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 19:55:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g5JwKdlTAVxBA--.18229S4;
	Wed, 17 Jan 2024 19:55:59 +0800 (CST)
From: yangerkun <yangerkun@huawei.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com
Subject: [PATCH 1/2] ext4: remove unused buddy_loaded in ext4_mb_seq_groups_show
Date: Wed, 17 Jan 2024 19:52:22 +0800
Message-Id: <20240117115223.80253-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g5JwKdlTAVxBA--.18229S4
X-Coremail-Antispam: 1UD129KBjvJXoWrtr4rZry7ZF47KF1kJF43Jrb_yoW8JrWrpF
	sxCF12kry5Wr1UCr4DC3yUWa4rKw1xu348Gr93Wr1F9Fy7Jry0gFyaqF1j9F15CFWrXF1S
	vw1Y9r15Ar4fCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU173ktUUUUU==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

We can just first call ext4_mb_unload_buddy, then copy information from
ext4_group_info. So remove this unused value.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/mballoc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f44f668e407f..139f232bdbb5 100644
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
@@ -3021,14 +3020,10 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "#%-5u: I/O error\n", group);
 			return 0;
 		}
-		buddy_loaded = 1;
+		ext4_mb_unload_buddy(&e4b);
 	}
 
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


