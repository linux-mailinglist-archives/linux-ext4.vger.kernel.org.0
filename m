Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A23B41BDBD
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Sep 2021 05:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbhI2Drf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Sep 2021 23:47:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12967 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239845AbhI2Dre (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Sep 2021 23:47:34 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HK2LV0CvnzWVgX;
        Wed, 29 Sep 2021 11:44:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 29
 Sep 2021 11:45:52 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] jbd2: discard last transaction when commit block checksum broken in v2v3
Date:   Wed, 29 Sep 2021 11:55:28 +0800
Message-ID: <20210929035528.1990993-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now, we meet an issue that commit block has broken checksum when cold reboot
device, that lead to mount failed.
The reason maybe only some sector store on disk, and then device power off.
But we calculate checksum with whole logic block.The data stored on disk can
only ensure the atomicity of sector level.
Actually, we already replay previous transactions. We can just discard last
transaction. As now, descriptor/revocation/commit/superblock has it's own
checksum.

Fixes:80b3767fbe15("jbd2: don't wipe the journal on a failed journal checksum")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 35302bc192eb..a3dd7b757b3d 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2080,7 +2080,7 @@ int jbd2_journal_load(journal_t *journal)
 	if (jbd2_journal_recover(journal))
 		goto recovery_error;
 
-	if (journal->j_failed_commit) {
+	if (journal->j_failed_commit && !jbd2_journal_has_csum_v2or3(journal)) {
 		printk(KERN_ERR "JBD2: journal transaction %u on %s "
 		       "is corrupt.\n", journal->j_failed_commit,
 		       journal->j_devname);
-- 
2.31.1

