Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16642D7133
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405447AbgLKIFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Dec 2020 03:05:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9159 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405495AbgLKIEw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Dec 2020 03:04:52 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Csjw8240Tz15bZ6;
        Fri, 11 Dec 2020 16:03:36 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:04:01 +0800
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <tytso@alum.mit.edu>
From:   Haotian Li <lihaotian9@huawei.com>
Subject: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
Message-ID: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
Date:   Fri, 11 Dec 2020 16:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_revocer() may fail when some error occers
such as ENOMEM. However, jsb->s_start is still cleared
by func e2fsck_journal_release(). This may break
consistency between metadata and data in disk. Sometimes,
failure in jbd2_journal_revocer() is temporary but retry
e2fsck will skip the journal recovery when the temporary
problem is fixed.

To fix this case, we use "fatal_error" instead "goto errout"
when recover journal failed. We think if journal recovery
fails, we need send error message to user and reserve the
recovery flags to recover the journal when try e2fsck again.

Reported-by: Liangyun <liangyun2@huawei.com>
Signed-off-by: Haotian Li <lihaotian9@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 e2fsck/journal.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 7d9f1b40..546beafd 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -952,8 +952,13 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 		goto errout;

 	retval = -jbd2_journal_recover(journal);
-	if (retval)
-		goto errout;
+	if (retval && retval != EFSBADCRC && retval != EFSCORRUPTED) {
+		ctx->fs->flags &= ~EXT2_FLAG_VALID;
+		com_err(ctx->program_name, 0,
+					_("Journal recovery failed "
+					  "on %s\n"), ctx->device_name);
+		fatal_error(ctx, 0);
+	}

 	if (journal->j_failed_commit) {
 		pctx.ino = journal->j_failed_commit;
-- 
2.19.1

