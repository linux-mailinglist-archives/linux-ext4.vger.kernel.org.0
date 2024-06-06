Return-Path: <linux-ext4+bounces-2802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EC08FE6EA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 14:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8DD1F25638
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2024 12:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83392195FE9;
	Thu,  6 Jun 2024 12:56:26 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819C195B15;
	Thu,  6 Jun 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678586; cv=none; b=uBoYpmNbUqveXfcDLKBKrHefGy/o2ydXBWMwxDTbd7NEc9aZ2ZkBaiIx+V9ooyYlaYgGDFgepLn+Fr/JbifSeO50oEgkgr5Wv7V3DngGtmHBINABS1HdqyHxcVZSEk2h8PxyMoWbfWgF3E1rlHqzttlc4fbCH1TT6RcFkq0ZKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678586; c=relaxed/simple;
	bh=wWQR91GyzQ8LtjW7BPD8lPt8ysKLhWWGz1HclzBWO1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OyhtIIEJb9zsORk8gpk09j1AEri8WsOtME95XuZMfsZLGeJfI/oH2RU2pFt1N7vuvbHCLrToV7yzkt02CqaZWMjaugiigtP14siAeqFwgbcmSKIPgQL0cBwG8y1jtwLb5UU7Pnp3mpLNevBbQYrBAoPrBZ5+srCS2fFRPwF2hgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vw48F19gtz4f3kjY;
	Thu,  6 Jun 2024 20:56:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 84A021A0189;
	Thu,  6 Jun 2024 20:56:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgC31A3xsWFmlILsOg--.39039S4;
	Thu, 06 Jun 2024 20:56:19 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ext4: correct comment of ext4_xattr_block_cache_insert
Date: Thu,  6 Jun 2024 20:55:07 +0800
Message-Id: <20240606125508.1459893-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
References: <20240606125508.1459893-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgC31A3xsWFmlILsOg--.39039S4
X-Coremail-Antispam: 1UD129KBjvdXoWrury3Zw43WFy3Gr1xWF18AFb_yoW3Xwc_Ka
	4kJr4xGrWYqrnY9Fs7AFyftayFga18CrnxWry8tF47uw15tayj934vvr98Zr9xWa18W3Z8
	C3Z7Jr4akFy0gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
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

There is no return value from ext4_xattr_block_cache_insert, just correct
it's comment about return value.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index c3db1abe9d77..1d4023715952 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3021,8 +3021,6 @@ void ext4_xattr_inode_array_free(struct ext4_xattr_inode_array *ea_inode_array)
  *
  * Create a new entry in the extended attribute block cache, and insert
  * it unless such an entry is already in the cache.
- *
- * Returns 0, or a negative error number on failure.
  */
 static void
 ext4_xattr_block_cache_insert(struct mb_cache *ea_block_cache,
-- 
2.30.0


