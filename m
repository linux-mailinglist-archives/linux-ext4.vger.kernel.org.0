Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922D81F5FDA
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFKCM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 22:12:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5876 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbgFKCM5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 22:12:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D922F61A59FADC89566F;
        Thu, 11 Jun 2020 10:12:55 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 11 Jun 2020
 10:12:45 +0800
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
To:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <zhangxiaoxu5@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200608082007.GJ13248@quack2.suse.cz>
 <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
 <20200609121920.GB12551@quack2.suse.cz>
 <45796804-07f7-2f62-b8c5-db077950d882@huawei.com>
 <20200610095739.GE12551@quack2.suse.cz> <20200610154543.GI1347934@mit.edu>
 <20200610162715.GD20677@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <92c92066-472e-1f1a-6043-af59bceeb0d8@huawei.com>
Date:   Thu, 11 Jun 2020 10:12:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200610162715.GD20677@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/6/11 0:27, Jan Kara wrote:
> On Wed 10-06-20 11:45:43, Theodore Y. Ts'o wrote:
>> On Wed, Jun 10, 2020 at 11:57:39AM +0200, Jan Kara wrote:
>>>> So I guess it may still lead to inconsistency. How about add this checking
>>>> into ext4_journal_get_write_access() ?
>>>
>>> Yes, this also occured to me later. Adding the check to
>>> ext4_journal_get_write_access() should be safer.
>>
>> There's another thing which we could do.  One of the issues is that we
>> allow buffered writeback for block devices once the change to the
>> block has been committed.  What if we add a change to block device
>> writeback code and in fs/buffer.c so that optionally, the file system
>> can specify a callback function can get called when an I/O error has
>> been reflected back up from the block layer?
>>
>> It seems unfortunate that currently, we can immediately report the I/O
>> error for buffered writes to *files*, but for metadata blocks, we
>> would only be able to report the problem when we next try to modify
>> it.
>>
>> Making changes to fs/buffer.c might be controversial, but I think it
>> might be result in a better solution.
> 
> Yeah, what you propose certainly makes sence could be relatively easily
> done by blkdev_writepage() using __block_write_full_page() with appropriate
> endio handler which calls fs callback. I'm just not sure how propagate the
> callback function from the fs to the blkdev...
>

I have thought about this solution, we could add a hook in 'struct super_operations'
and call it in blkdev_writepage() like blkdev_releasepage() does, and pick out a
wrapper from block_write_full_page() to pass our endio handler in, something like
this.

static const struct super_operations ext4_sops = {
...
	.bdev_write_page = ext4_bdev_write_page,
...
};

static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
{
	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;

	if (super && super->s_op->bdev_write_page)
		return super->s_op->bdev_write_page(page, blkdev_get_block, wbc);

	return block_write_full_page(page, blkdev_get_block, wbc);
}

But I'm not sure it's a optimal ieda. So I continue to realize the "wb_err"
solution now ?

Thanks,
Yi.

