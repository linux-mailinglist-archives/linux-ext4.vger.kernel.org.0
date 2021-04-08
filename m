Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4EC357CE3
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 09:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhDHHAt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 03:00:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16402 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHHAs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 03:00:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGBtx2XnlzkjCs;
        Thu,  8 Apr 2021 14:58:49 +0800 (CST)
Received: from vm-Yoda-Ubuntu1804.huawei.com (10.67.174.59) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 15:00:29 +0800
From:   Xu Yihang <xuyihang@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <harshadshirwadkar@gmail.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <xuyihang@huawei.com>
Subject: [PATCH -next] ext4: fix error return code in ext4_fc_perform_commit()
Date:   Thu, 8 Apr 2021 15:00:33 +0800
Message-ID: <20210408070033.123047-1-xuyihang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.59]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In case of if not ext4_fc_add_tlv branch, an error return code is missing.

Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Xu Yihang <xuyihang@huawei.com>
---
 fs/ext4/fast_commit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7541d0b5d706..312273ed8a9f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1088,8 +1088,10 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		head.fc_tid = cpu_to_le32(
 			sbi->s_journal->j_running_transaction->t_tid);
 		if (!ext4_fc_add_tlv(sb, EXT4_FC_TAG_HEAD, sizeof(head),
-			(u8 *)&head, &crc))
+			(u8 *)&head, &crc)) {
+			ret = -ENOSPC;
 			goto out;
+		}
 	}
 
 	spin_lock(&sbi->s_fc_lock);
-- 
2.17.1

