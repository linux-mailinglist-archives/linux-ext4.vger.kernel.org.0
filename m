Return-Path: <linux-ext4+bounces-2321-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A98E8BCFED
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCB8B26F56
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48313D617;
	Mon,  6 May 2024 14:18:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5213CF8F;
	Mon,  6 May 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005110; cv=none; b=CvL2A0M/ZRa1KGHZ9WOkA1KEi/ntsuzK8xTtNSbrB6+JkF/0ueuxEMoN4z6XhRPKOeQMhSToAqLOfLWH0Due7XhT1N8j9phUELuEDrNGDlGUvpj56hhZjFpv8VB32jFiRBHOsW/HYAImVRFMRN2JYb4TQrsDZJCbbrDbRHRvTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005110; c=relaxed/simple;
	bh=mJ0mXUrw702bJ8AQmrcjMPYih6FagdMGzfMHqeler9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGcZwWpKaeQh4WwPDI6+E7ZG6mqONT/JbMc9UvDwyclO9MZKzQlQ81hSB+h9vOGzn8cp1RAcgI5WnJqL7Cq3vGEu5gmJxN93GbCPitxme5ZNP7YKuuwWwmlj72XhobZGGwH96taS44ZlSBL6B1h30hYU0YibYBFCSE8T7d7gRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RJ1PXZz4f3lXH;
	Mon,  6 May 2024 22:18:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 70AEF1A0568;
	Mon,  6 May 2024 22:18:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S7;
	Mon, 06 May 2024 22:18:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] jbd2: remove unneeded kmap to do escape in jbd2_journal_write_metadata_buffer
Date: Mon,  6 May 2024 22:17:57 +0800
Message-Id: <20240506141801.1165315-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1DXr4kXr4rKF47KF47XFb_yoWfArX_Xa
	1kJ3ykursxXrnrXr4rG3W5Xr9Ygw1rAr1ku3W0q3W7Cr1Fq3W8GrnxKr4ktrnrua1Ikr45
	X34q9r4rtasIyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU8SfO7UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The data to do escape could be accessed directly from b_frozen_data,
just remove unneeded kmap.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 77fcdc76fdfd..87f558bd2e8a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -423,11 +423,8 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 * Did we need to do an escaping?  Now we've done all the
 	 * copying, we can finally do so.
 	 */
-	if (do_escape) {
-		mapped_data = kmap_local_folio(new_folio, new_offset);
-		*((unsigned int *)mapped_data) = 0;
-		kunmap_local(mapped_data);
-	}
+	if (do_escape)
+		*((unsigned int *)jh_in->b_frozen_data) = 0;
 
 	folio_set_bh(new_bh, new_folio, new_offset);
 	new_bh->b_size = bh_in->b_size;
-- 
2.30.0


