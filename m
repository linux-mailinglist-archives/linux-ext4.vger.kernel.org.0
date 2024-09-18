Return-Path: <linux-ext4+bounces-4205-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFD97BB9A
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 13:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73D728864B
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2024 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDC188A13;
	Wed, 18 Sep 2024 11:26:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DB175D4C
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658804; cv=none; b=VVLqX0v1SO/7RNQMWqgNmp47cam8n6N2tsFuif3K3WrOBfbQJvMmh465gQLRXeLJSMJZ6RUbY+Qi9Tu2yMZWQQzUDFp1IrsC9wSvbJ3T6VVPgUKd+WyF6TWLPF3PYG8qlWLKY4/V3ZhnprQfjjYBpbEzy840rw0OKDYAays+hsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658804; c=relaxed/simple;
	bh=YtwPVE+l3Cf1+TcdBlZASDxTQn3uFS/nBp8vI4qU9PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmlWjhm5bhcpPLC3ZTxbBdBd12Jo4BqoZ1QCMBExLSejU3QXHyQKKSwSljjtadeAAsi2EfYUo4+HHkBTt7SehVMdUMGP/RVsSNuIAbNXiaYGeBBDy5+HYmg8D4Z9RWd5rSF3SU7CLFJdXqs/Gam2ZPcz0sPkuiNpPkheYB7yEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X7xDg45j9z4f3jZQ
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7D7951A018D
	for <linux-ext4@vger.kernel.org>; Wed, 18 Sep 2024 19:26:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnsuOpmuiKqBg--.12650S5;
	Wed, 18 Sep 2024 19:26:38 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH 1/5] jbd2: remove redundant judgments for check v1 checksum
Date: Wed, 18 Sep 2024 19:36:00 +0800
Message-Id: <20240918113604.660640-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240918113604.660640-1-yebin@huaweicloud.com>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnsuOpmuiKqBg--.12650S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1UKryfJFyrWFy8CFy8Zrb_yoW3JwbEgw
	40krZYvw1xXFnFya45Jw15WF1a9rsxur1fCwn2y34a9a4UXF1kXrWDX34DXryDu39I9FWr
	CrZrWFWxtFZ3tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrw
	CF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1m0
	PDUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

'need_check_commit_time' is only used by v2/v3 checksum, so there isn't
need to add 'need_check_commit_time' judegement for v1 checksum logic.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/recovery.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 667f67342c52..5efbca6a98c4 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -619,7 +619,6 @@ static int do_one_pass(journal_t *journal,
 			if (pass != PASS_REPLAY) {
 				if (pass == PASS_SCAN &&
 				    jbd2_has_feature_checksum(journal) &&
-				    !need_check_commit_time &&
 				    !info->end_transaction) {
 					if (calc_chksums(journal, bh,
 							&next_log_block,
-- 
2.31.1


