Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18959660D46
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAGJ27 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 04:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGJ26 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 04:28:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA23DBFF;
        Sat,  7 Jan 2023 01:28:57 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NpvxM3W22zRqgj;
        Sat,  7 Jan 2023 17:27:19 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 17:28:54 +0800
Subject: Re: [PATCH] [RFC] Fix data missing when reusing bh which is ready to
 be checkpointed
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <libaokun1@huawei.com>, <zhanchengbin1@huawei.com>,
        <yangerkun@huawei.com>
References: <20221220150551.653925-1-chengzhihao1@huawei.com>
 <20221221101344.mup3mmrlt5c7yjfv@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <94cab214-3581-ff53-97bb-9382a7c599ea@huawei.com>
Date:   Sat, 7 Jan 2023 17:28:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20221221101344.mup3mmrlt5c7yjfv@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2022/12/21 18:13, Jan Kara Ð´µÀ:
> On Tue 20-12-22 23:05:51, Zhihao Cheng wrote:
>> From: zhanchengbin <zhanchengbin1@huawei.com>
>>
>> Following process will make data lost and could lead to a filesystem
>> corrupted problem:
>>
>> 1. jh(bh) is inserted into T1->t_checkpoint_list, bh is dirty, and
>>     jh->b_transaction = NULL
>> 2. T1 is added into journal->j_checkpoint_transactions.
>> 3. Get bh prepare to write while doing checkpoing:
>>             PA				    PB
>>     do_get_write_access             jbd2_log_do_checkpoint
>>      spin_lock(&jh->b_state_lock)
>>       if (buffer_dirty(bh))
>>        clear_buffer_dirty(bh)   // clear buffer dirty
>>         set_buffer_jbddirty(bh)
>> 				    transaction =
>> 				    journal->j_checkpoint_transactions
>> 				    jh = transaction->t_checkpoint_list
>> 				    if (!buffer_dirty(bh))
>> 		                      __jbd2_journal_remove_checkpoint(jh)
>> 				      // bh won't be flushed
>> 		                    jbd2_cleanup_journal_tail
>>      __jbd2_journal_file_buffer(jh, transaction, BJ_Reserved)
>> 4. Aborting journal/Power-cut before writing latest bh on journal area.

[...]
>>
>>   fs/jbd2/transaction.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> Good catch! Did you find it by code inspection or were you able to actually
> trigger this problem?

By code inspection.
Reproducer: https://bugzilla.kernel.org/show_bug.cgi?id=216898


