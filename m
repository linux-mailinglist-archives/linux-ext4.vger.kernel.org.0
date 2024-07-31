Return-Path: <linux-ext4+bounces-3561-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71502942A89
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 11:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26FB51F21403
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85971AB531;
	Wed, 31 Jul 2024 09:31:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47F1A8C05;
	Wed, 31 Jul 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418314; cv=none; b=hhTIxfA3AMUcf20eC3NgVg0PmwINFEIqHIRHoIz3krPQLMflkhrneV9yvQphE3bBCYhlclgsGSsdyzRNurONPa4d1xgCsZLpsFur2fA5QuKDi16QhKRCEEzdmRMdXiBgOQoJs25ajnUIjZcGcsxTUpMdIxr96PYcv2aGhcbpWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418314; c=relaxed/simple;
	bh=5Wn4WTyZNpU1evVyc6lLbhOjWfKhsTNhU1HkXjEyg0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmkyTgU7SWEHifdBWvjRNoheqMdGMQvVpnkJ6qW6gh56Y7M5iUZjNQjAVRoI/FjRlCGYrdopKLyR1fRfHNEJ5ftLqSOY/MFRWZxLEjgvPe69h6MFN0wM9sxHQZJks/h2aZfDqbzQMdl8FRhJbgNfJzdhjNdViXSDl51Di8GWLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYn0m0pVNz4f3jrw;
	Wed, 31 Jul 2024 17:31:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 08EB31A13E9;
	Wed, 31 Jul 2024 17:31:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgC3oL+CBKpm5KxyAQ--.8660S5;
	Wed, 31 Jul 2024 17:31:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] jbd2: remove unused return value of jbd2_fc_release_bufs
Date: Wed, 31 Jul 2024 17:29:05 +0800
Message-Id: <20240731092910.2383048-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
References: <20240731092910.2383048-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3oL+CBKpm5KxyAQ--.8660S5
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxXFyfAFy8Zry8Xw48Crg_yoW8Xw1rpa
	4fG340kr95uryUAw1kWFs8JFW09F4IkryUWFsF9wnYkw43GrsFqrsrtwn2yr9YyrZ5Kw4Y
	vry8Kw48C340grJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxU2ApnDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused return value of jbd2_fc_release_bufs.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c    | 4 +---
 include/linux/jbd2.h | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b5d02de1ffff..312c7575b54f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -903,7 +903,7 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 }
 EXPORT_SYMBOL(jbd2_fc_wait_bufs);
 
-int jbd2_fc_release_bufs(journal_t *journal)
+void jbd2_fc_release_bufs(journal_t *journal)
 {
 	struct buffer_head *bh;
 	int i, j_fc_off;
@@ -917,8 +917,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
 		put_bh(bh);
 		journal->j_fc_wbuf[i] = NULL;
 	}
-
-	return 0;
 }
 EXPORT_SYMBOL(jbd2_fc_release_bufs);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index b900c642210c..735229e8ad17 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1665,7 +1665,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out);
 int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
-int jbd2_fc_release_bufs(journal_t *journal);
+void jbd2_fc_release_bufs(journal_t *journal);
 
 /*
  * is_journal_abort
-- 
2.30.0


