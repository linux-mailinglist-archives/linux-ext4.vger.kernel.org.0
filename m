Return-Path: <linux-ext4+bounces-5762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5D69F7318
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CF81893291
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743701547D2;
	Thu, 19 Dec 2024 03:02:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286977080C;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577350; cv=none; b=KL4guDol13I8Gvc9DsYJqp7lL7/JLhYlWY5InZEFNBhoswH2MZ7V/iAi9CIGcamVxBjwkBMdAoWjPtOW4Qt4NQeKuKjDVBP2hrXVj8kyrRHbLvzSQSM4Io/SS8jny3VTzM/kvDyPUtlJfc93Fcvg/RKXIjQTuCOiDTeg64/s2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577350; c=relaxed/simple;
	bh=wshM5qvFK71l+sonYWvX9REVawk0v+hdKgD/3nCzDjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqyiOkaQVEetvCoyXfPKzrz+JSCq+4jkGdVVzXkijLi1GAoki9BlavjSCCrjX07kgVzjpfk9LtpJ8QjYp5Qq7FO5HNPq6M8LMfD0xqdO21+ZRxMLWj6L5jDO6K+GqRYKFL7vGqCcL2bRF84mw2KHVnvFv7u/G3KiC16Xji4DdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDFhC0bzdz4f3lWD;
	Thu, 19 Dec 2024 11:02:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A2D871A018C;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S6;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ext4: remove unneeded check in get_dx_countlimit
Date: Thu, 19 Dec 2024 19:00:25 +0800
Message-Id: <20241219110027.1440876-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S6
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYA7kC6x804xWl14x267AKxVWrJVCq3wAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62
	vIxIIY0VWUZVW8XwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E
	14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	JVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUnr9NDUU
	UUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

The "offset" is always non-NULL, remove unneeded NULL check of "offset".

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 33670cebdedc..07a1bb570deb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -434,8 +434,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
 	} else
 		return NULL;
 
-	if (offset)
-		*offset = count_offset;
+	*offset = count_offset;
 	return (struct dx_countlimit *)(((void *)dirent) + count_offset);
 }
 
-- 
2.30.0


