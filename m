Return-Path: <linux-ext4+bounces-2323-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5A28BCFF2
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06AA7B271D9
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2013D8AE;
	Mon,  6 May 2024 14:18:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA613D2AD;
	Mon,  6 May 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005111; cv=none; b=dYPNhzS1kVkJPcHvJkTZvdVbrVjgXAa0kIR1r2DHJOw9ZP3HLh3zKDX+C0qy7lJHk2/JBYPGkz9YNjEmGAxBcprEKXXAAXxjpiZ5owXlch6IUwToi9BNliLFZnQxD3UaReFzivBaVs1BED0aMHUBn0+xzokzPp/fw5k8tjiVQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005111; c=relaxed/simple;
	bh=abQwQUZwav5Ixub1Gt+0LS9dsPRZkrm+0lgwfjl4dlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gf7gK/OjmBgfIP7fnXk+DzIy8bG/NbpS5mbXMEaR4dAcrLpzNdy4qiRztONqcr0npYwgOxasC4e6OEUVqT9uiQEhKPGQJGStOkJCT26ztEtYdDCUtfd6/ZGckC2e9ocM+2AWisYWysQ/5PKPPxC/eizhHTMleMCUeTP6CrWtcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RC11zGz4f3nJS;
	Mon,  6 May 2024 22:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E0E5A1A0F4C;
	Mon,  6 May 2024 22:18:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S5;
	Mon, 06 May 2024 22:18:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] jbd2: remove unnedded "need_copy_out" in jbd2_journal_write_metadata_buffer
Date: Mon,  6 May 2024 22:17:55 +0800
Message-Id: <20240506141801.1165315-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S5
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWxtw4rAryxKw1DXF4fXwb_yoWkCFX_Xa
	n3Cr45Z398XrsrAa1Fk3W8Xr93Wan5Zr1kCa1Iva4xuFyrt3WrCrnrArZ5KrnxZ3Wvgr47
	Xwn7Zw48GF9IyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8SoGPUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As we only need to copy out when we should do escape, need_copy_out
could be simply replaced by "do_escape".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 068031f35aea..9a35d0c5b38c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -327,7 +327,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 				  struct buffer_head **bh_out,
 				  sector_t blocknr)
 {
-	int need_copy_out = 0;
 	int done_copy_out = 0;
 	int do_escape = 0;
 	char *mapped_data;
@@ -382,16 +381,14 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	/*
 	 * Check for escaping
 	 */
-	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER)) {
-		need_copy_out = 1;
+	if (*((__be32 *)mapped_data) == cpu_to_be32(JBD2_MAGIC_NUMBER))
 		do_escape = 1;
-	}
 	kunmap_local(mapped_data);
 
 	/*
 	 * Do we need to do a data copy?
 	 */
-	if (need_copy_out && !done_copy_out) {
+	if (do_escape && !done_copy_out) {
 		char *tmp;
 
 		spin_unlock(&jh_in->b_state_lock);
-- 
2.30.0


