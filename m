Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCC15480C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Feb 2020 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBFP2P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Feb 2020 10:28:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10164 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgBFP2P (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 6 Feb 2020 10:28:15 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C940644224E036578578;
        Thu,  6 Feb 2020 23:28:09 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 23:28:01 +0800
Subject: Re: [PATCH 2/2] jbd2: do not clear the BH_Mapped flag when forgetting
 a metadata buffer
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <luoshijie1@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
 <20200203140458.37397-3-yi.zhang@huawei.com>
 <20200206114647.GB3994@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <6c03b515-d128-06be-2e38-56a01ee63263@huawei.com>
Date:   Thu, 6 Feb 2020 23:28:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200206114647.GB3994@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the comments.

On 2020/2/6 19:46, Jan Kara wrote:
> On Mon 03-02-20 22:04:58, zhangyi (F) wrote:
[..]
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index 6396fe70085b..a649cdd1c5e5 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -987,10 +987,13 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>  		if (buffer_freed(bh) && !jh->b_next_transaction) {
>>  			clear_buffer_freed(bh);
>>  			clear_buffer_jbddirty(bh);
>> -			clear_buffer_mapped(bh);
>> -			clear_buffer_new(bh);
>> -			clear_buffer_req(bh);
>> -			bh->b_bdev = NULL;
>> +			if (buffer_unmap(bh)) {
>> +				clear_buffer_unmap(bh);
>> +				clear_buffer_mapped(bh);
>> +				clear_buffer_new(bh);
>> +				clear_buffer_req(bh);
>> +				bh->b_bdev = NULL;
>> +			}
> 
> Any reason why you don't want to clear buffer_req and buffer_new flags for
> all buffers as well? I agree that b_bdev setting and buffer_mapped need
> special treatment.
> 
IIUC, for the buffer coming from jbd2_journal_forget() is always 'block
device backed' metadata buffer (not pretty sure), and for these metadata
buffer, buffer_new flag will not be set. At the same time, since it's
always mapped, so it's fine to keep the buffer_req flag even it's freed
by the filesystem now, because it means the block device has committed
this buffer, and it seems that it does not affect we reuse this buffer.
Am I missing something ?

> Also rather than introducing this new buffer_unmap bit, I'd use the fact
> this special treatment is needed only for buffers coming from the block device
> mapping. And we can check for that like:
> 
> 		/*
> 		 * We can (and need to) unmap buffer only for normal mappings.
> 		 * Block device buffers need to stay mapped all the time.
> 		 * We need to be careful about the check because the page
> 		 * mapping can get cleared under our hands.
> 		 */
> 		mapping = READ_ONCE(bh->b_page->mapping);
> 		if (mapping && !sb_is_blkdev_sb(mapping->host->i_sb)) {
> 			...
> 		}
> 
It looks better, I will use this checking in the next iteration.

> Longer term, we might want to rework how the handling of truncated buffers
> works with JDB2. There's lots of duplication between jbd2_journal_forget()
> and jbd2_journal_unmap_buffer(), the dirtiness is tracked in jh->b_modified
> as well as buffer_jbddirty() and it is further redundant with the journal
> list the buffer is currently on. So I suspect it could all be simplified if
> we took a fresh look at things.
> 
Indeed, it is tricky and not pretty easy to understand now, refactoring
these is awesome int the future.

Thanks,
Yi.

