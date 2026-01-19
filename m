Return-Path: <linux-ext4+bounces-12995-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D521D3AA08
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 14:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE995305E45D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4B35CBAE;
	Mon, 19 Jan 2026 13:13:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CCB366540
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768828403; cv=none; b=bAdmoQUBfL8zARBuSrWpdQRkteeLPcJzvuxDcHOG7ek7FddFf/nQOyX7kbf8nyOZDLAaY4F9xJ4uMKxV5RrqfCx6aiX8TOr9JcYjGTvWdNPu8hbDP9hNZ/J6zM7+srfdJNo1nAcSvLcp+uQL5Rvjjr5fyltOV4pEl3mCAgaNLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768828403; c=relaxed/simple;
	bh=jdMg3kbRui3Geq1Fb1T2fG8NkQfYr9HrVqLMPV17KvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pi69ZGw+bdqZ6XkM7eimtzr+lZAx3/ZjXE8fD4BegzvBp7WjxlcyPynvh6Xkyqml+Z8vyHa/cukPq8AZzc9694jq1aZ1Yee19CcwAksUTfbjPPT16SuJSY09hhE47K+qyafWlS2zjXimhzLm/hEhOLiVTpTeWXrLwxnXtm9Vank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dvrTP6RSFzKHMg1
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 21:12:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A953E4058A
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 21:13:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgBXuPjkLW5p_f51EQ--.18518S4;
	Mon, 19 Jan 2026 21:13:09 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH] ext4: fix mballoc-test.c is not compiled when EXT4_KUNIT_TESTS=M
Date: Mon, 19 Jan 2026 21:12:57 +0800
Message-Id: <20260119131257.306564-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXuPjkLW5p_f51EQ--.18518S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWUZr1kJry3ZFy8CrW7urg_yoWfAFb_Ka
	s5WF4kXryrJryS9r18Aw4F9r1UKFWrJr4UJr4ftr13ZF1UXF4UCw1Dt3yfCF48uF1qkay3
	Za98WryxJayIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbo8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.

EXT4_FS      KUNIT    EXT4_KUNIT_TESTS
Y              Y         Y
Y              Y         M
Y              M         M // This case will lead to link error
M              Y         M
M              M         M

Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/mballoc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e817a758801d..0fbd2dfae497 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -7191,6 +7191,10 @@ ext4_mballoc_query_range(
 	return error;
 }
 
-#ifdef CONFIG_EXT4_KUNIT_TESTS
+#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
+#if IS_BUILTIN(CONFIG_EXT4_FS) && IS_MODULE(CONFIG_KUNIT)
+/* This case will lead to link error. */
+#else
 #include "mballoc-test.c"
 #endif
+#endif
-- 
2.34.1


