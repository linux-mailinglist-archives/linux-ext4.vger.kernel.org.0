Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B819D587B83
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiHBLXx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiHBLXw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 07:23:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9BC4A836
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 04:23:50 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LxsyT0Fc5zmVcq;
        Tue,  2 Aug 2022 19:21:53 +0800 (CST)
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 19:23:48 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml100016.china.huawei.com (7.185.36.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 2 Aug 2022 19:23:48 +0800
Message-ID: <3d484b33-410a-c912-a776-28767b381f7a@huawei.com>
Date:   Tue, 2 Aug 2022 19:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>, <liangyun2@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [BUG] Tune2fs and fuse2fs do not change j_tail_sequence in journal
 superblock
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100001.china.huawei.com (7.185.36.47) To
 dggpeml100016.china.huawei.com (7.185.36.216)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are two recover_ext3_journal functions in e2fsprogs, the 
recover_ext3_journal
function in debugfs/journal.c is called when the programs tune2fs and 
fuse2fs do
log replay, but in this recover_ext3_journal function, after the log 
replay is over,
the j_tail_sequence in journal superblock is not changed to the value of 
the last
transaction sequence, this will cause subsequent log commitids to count 
from the
commitid in last time.
```
e2fsck/journal.c
static errcode_t recover_ext3_journal(e2fsck_t ctx)
{
     ... ...
         journal->j_superblock->s_errno = -EINVAL;
         mark_buffer_dirty(journal->j_sb_buffer);
     }

     journal->j_tail_sequence = journal->j_transaction_sequence;

errout:
     journal_destroy_revoke(journal);
     ... ...
}
```
```
debugfs/journal.c
static errcode_t recover_ext3_journal(ext2_filsys fs)
{
     ... ...
         journal->j_superblock->s_errno = -EINVAL;
         mark_buffer_dirty(journal->j_sb_buffer);
     }

errout:
     journal_destroy_revoke(journal);
     ... ...
}
```
result:
After tune2fs -e, the log commitid is counted from the commitid in last 
time, if
the log ID of the current operation overlaps with that of the last 
operation, this
will cause logs that were previously replayed by tune2fs to be replayed 
here. The
code used by tune2fs to determine whether to replay the transaction is 
as follows:
```
static int do_one_pass(journal_t *journal,
             struct recovery_info *info, enum passtype pass)
{
     ... ...
     while (1) {
         ... ...
         if (sequence != next_commit_ID) {
             brelse(bh);
             break;
         }
         ... ...
         next_commit_ID++;
     }
     ... ...
}
```
     This moment, commitid is "34 c7", commit time stamp is "62 e0 f7 a5"
     004aa000  c0 3b 39 98 00 00 00 02  00 00 34 c7 00 00 00 00 
|.;9.......4.....|
     004aa010  4e 93 2f fb 00 00 00 00  00 00 00 00 00 00 00 00 
|N./.............|
     004aa020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
     004aa030  00 00 00 00 62 e0 f7 a5  0a 16 56 20 00 00 00 00 
|....b.....V ....|
     --
     This moment, commitid is "34 c8", commit time stamp is "62 e0 e7 1e"
     004ad000  c0 3b 39 98 00 00 00 02  00 00 34 c8 00 00 00 00 
|.;9.......4.....|
     004ad010  75 a6 12 01 00 00 00 00  00 00 00 00 00 00 00 00 
|u...............|
     004ad020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 
|................|
     004ad030  00 00 00 00 62 e0 e7 1e  18 32 cf 18 00 00 00 00 
|....b....2......|
     --
The probability of this happening is very small, but we do, and I think 
it's a problem.

There are two existing solutions:
1) Add "journal->j_tail_sequence = journal->j_transaction_sequence" in 
to the
recover_ext3_journal in debugfs/journal.c.
2) There is a timestamp in the commit block, so we can add timestamp 
check when
the log is replayed.
