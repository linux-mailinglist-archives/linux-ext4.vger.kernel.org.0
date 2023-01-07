Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63E660D25
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjAGJQS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Jan 2023 04:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAGJQR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Jan 2023 04:16:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F984098;
        Sat,  7 Jan 2023 01:16:15 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Npvg51rfMzJrF7;
        Sat,  7 Jan 2023 17:14:57 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 17:16:11 +0800
Subject: Re: [PATCH v2] jbd2: Fix data missing when reusing bh which is ready
 to be checkpointed
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <libaokun1@huawei.com>, <zhanchengbin1@huawei.com>
References: <20230106115603.2624644-1-chengzhihao1@huawei.com>
 <20230106142255.fqnzgw5tqr77mdzj@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <09622c2f-6cf7-79c9-2624-c0c0835d125d@huawei.com>
Date:   Sat, 7 Jan 2023 17:16:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230106142255.fqnzgw5tqr77mdzj@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

ÔÚ 2023/1/6 22:22, Jan Kara Ð´µÀ:

Hi Jan, thanks for reviewing.Some discussions below:


>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index 6a404ac1c178..06a5e7961ef2 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -1010,36 +1010,37 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
>>   	 * ie. locked but not dirty) or tune2fs (which may actually have
>>   	 * the buffer dirtied, ugh.)  */
>>   
>> -	if (buffer_dirty(bh)) {
>> +	if (buffer_dirty(bh) && jh->b_transaction) {
>>   		/*
>>   		 * First question: is this buffer already part of the current
>>   		 * transaction or the existing committing transaction?
>>   		 */
>> -		if (jh->b_transaction) {
>> -			J_ASSERT_JH(jh,
>> -				jh->b_transaction == transaction ||
>> -				jh->b_transaction ==
>> -					journal->j_committing_transaction);
>> -			if (jh->b_next_transaction)
>> -				J_ASSERT_JH(jh, jh->b_next_transaction ==
>> -							transaction);
>> -			warn_dirty_buffer(bh);
>> -		}
>> +		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
>> +			jh->b_transaction == journal->j_committing_transaction);
>> +		if (jh->b_next_transaction)
>> +			J_ASSERT_JH(jh, jh->b_next_transaction == transaction);
>> +		warn_dirty_buffer(bh);
>>   		/*
>> -		 * In any case we need to clean the dirty flag and we must
>> -		 * do it under the buffer lock to be sure we don't race
>> -		 * with running write-out.
>> +		 * We need to clean the dirty flag and we must do it under the
>> +		 * buffer lock to be sure we don't race with running write-out.
>>   		 */
>>   		JBUFFER_TRACE(jh, "Journalling dirty buffer");
>>   		clear_buffer_dirty(bh);
>> +		/*
>> +		 * Setting jbddirty after clearing buffer dirty is necessary.
>> +		 * Function jbd2_journal_restart() could keep buffer on
>> +		 * BJ_Reserved list until the transaction committing, then the
>> +		 * buffer won't be dirtied by jbd2_journal_refile_buffer()
>> +		 * after committing, the buffer couldn't fall on disk even
>> +		 * last checkpoint finished, which may corrupt filesystem.
>> +		 */
>>   		set_buffer_jbddirty(bh);
>>   	}
> 
> So I think the sequence:
> 
> 	if (buffer_dirty(bh)) {
> 		warn_dirty_buffer(bh);
> 		JBUFFER_TRACE(jh, "Journalling dirty buffer");
> 		clear_buffer_dirty(bh);
> 		set_buffer_jbddirty(bh);
> 	}
> 
> can be moved into the branch
> 
>    	if (jh->b_transaction == transaction ||
> 	    jh->b_next_transaction == transaction) {
> 
> below. That way you can drop the assertions as well because they happen
> later in do_get_write_access() again anyway.

1. If we move the squence:
  	if (buffer_dirty(bh)) {
  		warn_dirty_buffer(bh);
  		JBUFFER_TRACE(jh, "Journalling dirty buffer");
  		clear_buffer_dirty(bh);
  		set_buffer_jbddirty(bh);
  	}

into the branch

         if (jh->b_transaction == transaction ||
  	    jh->b_next_transaction == transaction) {

, then we have a new situation(jh->b_transaction == 
journal->j_committing_transaction) to clear buffer dirty, so we need to 
add an else-branch like(based on v2 patch):
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1092,6 +1092,10 @@ do_get_write_access(handle_t *handle, struct 
journal_head *jh,
                 spin_unlock(&journal->j_list_lock);
                 unlock_buffer(bh);
                 goto done;
+       } else if (test_clear_buffer_dirty(bh)) {
+               warn_dirty_buffer(bh);
+               JBUFFER_TRACE(jh, "Journalling dirty buffer");
+               set_buffer_jbddirty(bh);
         }
         unlock_buffer(bh);

I think we'd better not to move the sequence?

2. I agree that the assertions in branch 'if (jh->b_transaction)' are 
redundant, I will remove them in v3. Thanks for pointing that.

> Also I don't quite understand the new comment you have added. Do you mean
> we need to not only clear BH_Dirty bit but also set BH_JBDdirty as dirtying
> (through jbd2_journal_dirty_metadata()) does not have to follow after
> do_get_write_access()?
> 

Yes.
I think one reason we have non-empty commit_transaction->t_reserved_list 
is that: jbd2_journal_restart() could let jh attach to transaction_1 and 
dirty jh in transaction_2.

buffer is dirty after trans_0 committed
do_get_write_access() =>  jh->trans = old_handle->trans_1, clear buffer 
dirty & set jbddirty, BJ_Reserved
jbd2_journal_restart()  => stop old_handle && may jbd2_log_start_commit 
&& start new_handle with trans_2
jbd2_journal_commit_transaction() => clear jbddirty & set buffer dirty & 
set jh->b_transaction = NULL
do_checkpoint  => buffer is fell on disk. If do_get_write_access() not 
mark jbddirty, buffer won't be fell on disk after checkpoint, which 
could corrupt filesystem.

I'm not sure whether we have the above path in realworld. I guess it 
exists in theory according to the comments:
        /* 

         * First thing we are allowed to do is to discard any remaining 

         * BJ_Reserved buffers.  Note, it is _not_ permissible to assume 

         * that there are no such buffers: if a large filesystem 

         * operation like a truncate needs to split itself over multiple 

         * transactions, then it may try to do a jbd2_journal_restart() 
while
          * there are still BJ_Reserved buffers outstanding.  These must 

          * be released cleanly from the current transaction. 

          * 

          * In this case, the filesystem must still reserve write access 

          * again before modifying the buffer in the new transaction, 
but
          * we do not require it to remember exactly which old buffers 
it
          * has reserved.  This is consistent with the existing 
behaviour
          * that multiple jbd2_journal_get_write_access() calls to the 
same
          * buffer are perfectly permissible. 

          * We use journal->j_state_lock here to serialize processing of 

          * t_reserved_list with eviction of buffers from 
journal_unmap_buffer().
          */ 

         while (commit_transaction->t_reserved_list) {  [...]
