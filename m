Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F6608D35
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Oct 2022 14:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJVMpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Oct 2022 08:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVMpp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Oct 2022 08:45:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7099398
        for <linux-ext4@vger.kernel.org>; Sat, 22 Oct 2022 05:45:43 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MvgtN2xSLzVhkZ;
        Sat, 22 Oct 2022 20:41:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 22 Oct
 2022 20:45:41 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ext4: fix wrong return err in ext4_load_and_init_journal()
Date:   Sat, 22 Oct 2022 21:07:39 +0800
Message-ID: <20221022130739.2515834-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The return value is wrong in ext4_load_and_init_journal(). The local
variable 'err' need to be initialized before goto out. The original code
in __ext4_fill_super() is fine because it has two return values 'ret'
and 'err' and 'ret' is initialized as -EINVAL. After we factor out
ext4_load_and_init_journal(), this code is broken. So fix it by directly
returning -EINVAL in the error handler path.

Fixes: 9c1dd22d7422 (ext4: factor out ext4_load_and_init_journal())
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 989365b878a6..89c6bad28a8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4885,7 +4885,7 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	flush_work(&sbi->s_error_work);
 	jbd2_journal_destroy(sbi->s_journal);
 	sbi->s_journal = NULL;
-	return err;
+	return -EINVAL;
 }
 
 static int ext4_journal_data_mode_check(struct super_block *sb)
-- 
2.31.1

