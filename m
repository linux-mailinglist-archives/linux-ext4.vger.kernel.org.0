Return-Path: <linux-ext4+bounces-3586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9817944125
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E46BB2BA3D
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950D1B580C;
	Thu,  1 Aug 2024 01:41:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F65D1A720A;
	Thu,  1 Aug 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476461; cv=none; b=jYSk9ZCM8nr5Mm102KBCAd1UQV+SfXT0PUiIXlISXipNgdO7MexZ5MQlhCPiqhD/Hj63zq2bgaIhnVQelSbcCDSTr5ScVgeu5HEEakU6I6dvwMSG/X5yiObXDaTtY7/Q/tLPPmcVIq7KU+BgEqZ3jrhBXVP4SsTw5orHHrJEpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476461; c=relaxed/simple;
	bh=xJzroJOtN/D/YoEKkSUZGUEBMAQNBevv3BIQWdMAJl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XoLfKX43rrbNpqquVJFk7UoWGm4Og+n7QXLhGaJSo/crzucgoEc17K0iGDo7ClJguvH+ocwwA6Dr0aUbASQV3WHfN73p/BtFC1WgMQv9NKF3GcKkd7W6/rfzbbr6jSmgW5K3pkSgmGnb1FwUZwd2lqcEVVTK4d7GAmiM+mo++yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBW24MgRz4f3jYx;
	Thu,  1 Aug 2024 09:40:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5141D1A018D;
	Thu,  1 Aug 2024 09:40:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S4;
	Thu, 01 Aug 2024 09:40:55 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] jbd2: remove dead check in journal_alloc_journal_head
Date: Thu,  1 Aug 2024 09:38:09 +0800
Message-Id: <20240801013815.2393869-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S4
X-Coremail-Antispam: 1UD129KBjvdXoW7XrW3Xw45Ar17KFyUtrW7CFg_yoW3Wrg_uF
	1Ivrs3X3y3Jr4fArWrCa4S9r1Sgrn7Zrn5u3WftwnrKryUXF95JFnru395trZxu3WIkFW7
	Ka1qk3y8tr9rJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UEQ6JUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We will alloc journal_head with __GFP_NOFAIL anyway, test for failure
is pointless.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index da5a56d700f1..b5d02de1ffff 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2866,8 +2866,7 @@ static struct journal_head *journal_alloc_journal_head(void)
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
 				GFP_NOFS | __GFP_NOFAIL);
 	}
-	if (ret)
-		spin_lock_init(&ret->b_state_lock);
+	spin_lock_init(&ret->b_state_lock);
 	return ret;
 }
 
-- 
2.30.0


