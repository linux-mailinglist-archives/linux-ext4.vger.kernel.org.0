Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D862158A15
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Feb 2020 07:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBKGvY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Feb 2020 01:51:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbgBKGvY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 11 Feb 2020 01:51:24 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58F6949E3826EAFD3628;
        Tue, 11 Feb 2020 14:51:21 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 11 Feb 2020
 14:51:11 +0800
Subject: Re: [PATCH 2/2] jbd2: do not clear the BH_Mapped flag when forgetting
 a metadata buffer
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <luoshijie1@huawei.com>, <zhangxiaoxu5@huawei.com>
References: <20200203140458.37397-1-yi.zhang@huawei.com>
 <20200203140458.37397-3-yi.zhang@huawei.com>
 <20200206114647.GB3994@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <bc3e2187-b1a7-b21e-db9f-c8c01b97368f@huawei.com>
Date:   Tue, 11 Feb 2020 14:51:10 +0800
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

On 2020/2/6 19:46, Jan Kara wrote:
> On Mon 03-02-20 22:04:58, zhangyi (F) wrote:
>> Commit 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from
>> an older transaction") set the BH_Freed flag when forgetting a metadata
>> buffer which belongs to the committing transaction, it indicate the
>> committing process clear dirty bits when it is done with the buffer. But
>> it also clear the BH_Mapped flag at the same time, which may trigger
>> below NULL pointer oops when block_size < PAGE_SIZE.
>>
>> rmdir 1             kjournald2                 mkdir 2
>>                     jbd2_journal_commit_transaction
>> 		    commit transaction N
>> jbd2_journal_forget
>> set_buffer_freed(bh1)
>>                     jbd2_journal_commit_transaction
>>                      commit transaction N+1
>>                      ...
>>                      clear_buffer_mapped(bh1)
>>                                                ext4_getblk(bh2 ummapped)
>>                                                ...
>>                                                grow_dev_page
>>                                                 init_page_buffers
>>                                                  bh1->b_private=NULL
>>                                                  bh2->b_private=NULL
>>                      jbd2_journal_put_journal_head(jh1)
>>                       __journal_remove_journal_head(hb1)
>> 		       jh1 is NULL and trigger oops
>>
>> *) Dir entry block bh1 and bh2 belongs to one page, and the bh2 has
>>    already been unmapped.
>>
>> For the metadata buffer we forgetting, clear the dirty flags is enough,
>> so this patch add BH_Unmap flag for the journal_unmap_buffer() case and
>> keep the mapped flag for the metadata buffer.
>>
>> Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
[..]
> 
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

Think about it again, it may missing clearing of mapped flag if 'mapping'
of journalled data page was cleared, and finally trigger exception if
we reuse the buffer again. So I think it should be:

		if (!(mapping && sb_is_blkdev_sb(mapping->host->i_sb))) {
			...
		}

Thanks,
Yi.

