Return-Path: <linux-ext4+bounces-4371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A239898B1
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3F3B228F4
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0385A4A0A;
	Mon, 30 Sep 2024 00:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F037BA53
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 00:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727657438; cv=none; b=kmKuVRCTAUbYe4o92yJNMIB1xoJ3D6hQ5YzyQiBEhKlOCyo6jf82tHq/PJcd9WHH27NKzGYAqdUV4YPtb6OD5kXrPgHhDBiEy5rtHQSfYXRK+rjbgp328KNmrpYrKcFDhv0rBfgD64rlkRAMpWtyNlfPGR0r+jdDg2UHGI79BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727657438; c=relaxed/simple;
	bh=HNQpzOT0aZu4BesanhmvephaMnNSdT/9bfr4IhktcQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rlpSnNltf4Bp9zyiFyvnzW3Y4L/YPwoxyLLQ6bi3CJeu/MRJbZkkHg0k2cygk8AM/xqemAz3zSqf3/7gkX8lgek4wel6dUO1FOfZpwOyab1+TfB/XnDX5hEVc0GV6o5S5ouz4tJFOBw06LLYnvzgBHxvJWR2zt9GYCT+pMmFpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XH2Y36tCnz4f3kvm
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 225991A0359
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 08:50:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
	by APP4 (Coremail) with SMTP id gCh0CgD3LMnW9flmLxfsCg--.51013S5;
	Mon, 30 Sep 2024 08:50:32 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz,
	zhangxiaoxu5@huawei.com
Subject: [PATCH v2 1/6] jbd2: remove redundant judgments for check v1 checksum
Date: Mon, 30 Sep 2024 08:59:37 +0800
Message-Id: <20240930005942.626942-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240930005942.626942-1-yebin@huaweicloud.com>
References: <20240930005942.626942-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3LMnW9flmLxfsCg--.51013S5
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1UKryfJFyrWFy8CFy8Zrb_yoW3ArcEgw
	40yrZYvw1xZFnFya45Jw1YgF1S9rsxur1fCwn2y34aga4UX3WkXFWDW34kXryDu39a9FWr
	ArZrWFWxtFZ3tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwksgUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

'need_check_commit_time' is only used by v2/v3 checksum, so there isn't
need to add 'need_check_commit_time' judegement for v1 checksum logic.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


