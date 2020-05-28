Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0C1E621D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 15:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390370AbgE1NXd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 09:23:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5303 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390295AbgE1NXa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 28 May 2020 09:23:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D23ECE5D4564FEC6464;
        Thu, 28 May 2020 21:23:26 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 21:23:17 +0800
Subject: Re: [PATCH 02/10] fs: pick out ll_rw_one_block() helper function
To:     Christoph Hellwig <hch@infradead.org>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>,
        <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200526071754.33819-3-yi.zhang@huawei.com>
 <20200528050757.GA14198@infradead.org>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <d65650b2-05b2-1fd0-54d6-76e9e1e40786@huawei.com>
Date:   Thu, 28 May 2020 21:23:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200528050757.GA14198@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Christoph

On 2020/5/28 13:07, Christoph Hellwig wrote:
> On Tue, May 26, 2020 at 03:17:46PM +0800, zhangyi (F) wrote:
>> Pick out ll_rw_one_block() helper function from ll_rw_block() for
>> submitting one locked buffer for reading/writing.
> 
> That should probably read factor out instead of pick out.
> 
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>>  fs/buffer.c                 | 41 ++++++++++++++++++++++---------------
>>  include/linux/buffer_head.h |  1 +
>>  2 files changed, 26 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index a60f60396cfa..3a2226f88b2d 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -3081,6 +3081,29 @@ int submit_bh(int op, int op_flags, struct buffer_head *bh)
>>  }
>>  EXPORT_SYMBOL(submit_bh);
>>  
>> +void ll_rw_one_block(int op, int op_flags, struct buffer_head *bh)
>> +{
>> +	BUG_ON(!buffer_locked(bh));
>> +
>> +	if (op == WRITE) {
>> +		if (test_clear_buffer_dirty(bh)) {
>> +			bh->b_end_io = end_buffer_write_sync;
>> +			get_bh(bh);
>> +			submit_bh(op, op_flags, bh);
>> +			return;
>> +		}
>> +	} else {
>> +		if (!buffer_uptodate(bh)) {
>> +			bh->b_end_io = end_buffer_read_sync;
>> +			get_bh(bh);
>> +			submit_bh(op, op_flags, bh);
>> +			return;
>> +		}
>> +	}
>> +	unlock_buffer(bh);
>> +}
>> +EXPORT_SYMBOL(ll_rw_one_block);
> 
> I don't think you want separate read and write sides.  In fact I'm not
> sure you want the helper at all.  At this point just open coding it
> rather than adding more overhead to core code might be a better idea.
> 

Yeah, what I want is only the read side, it's fine by me to open coding it.
Thanks,
Yi.

