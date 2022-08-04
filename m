Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A09589A7B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 12:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiHDKdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 06:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiHDKdu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 06:33:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2E41AD94
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 03:33:42 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Lz4kN4jmwz1M8b0;
        Thu,  4 Aug 2022 18:30:36 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 18:33:40 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 4 Aug 2022 18:33:39 +0800
Message-ID: <3f55f3ad-ba78-e590-65b7-07ff95c78ed1@huawei.com>
Date:   Thu, 4 Aug 2022 18:33:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH] tune2fs: do not change j_tail_sequence in journal superblock
From:   zhanchengbin <zhanchengbin1@huawei.com>
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>,
        Alexey Lyahkov <alexey.lyashkov@gmail.com>
References: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
In-Reply-To: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500015.china.huawei.com (7.185.36.226) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The function recover_ext3_journal in debugfs/journal.c, if the log 
replay is over,
the j_tail_sequence in journal superblock is not changed to the value of 
the last
transaction sequence, this will cause subsequent log commitids to count 
from the
commitid in last time.
After tune2fs -e, the log commitid is counted from the commitid in last 
time, if
the log ID of the current operation overlaps with that of the last 
operation, this
will cause logs that were previously replayed by tune2fs to be replayed 
here.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: liangyun <liangyun2@huawei.com>
---
  debugfs/journal.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 095fff00..5bac0d3b 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -769,6 +769,8 @@ static errcode_t recover_ext3_journal(ext2_filsys fs)
  		mark_buffer_dirty(journal->j_sb_buffer);
  	}

+	journal->j_tail_sequence = journal->j_transaction_sequence;
+
  errout:
  	jbd2_journal_destroy_revoke(journal);
  	jbd2_journal_destroy_revoke_record_cache();
-- 
2.27.0
