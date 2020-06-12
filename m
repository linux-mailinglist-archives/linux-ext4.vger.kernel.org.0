Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFD1F7716
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFLLNw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 07:13:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5821 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgFLLNv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Jun 2020 07:13:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 230D9A581DC6AF975B99;
        Fri, 12 Jun 2020 19:13:48 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 19:13:42 +0800
Subject: Re: [PATCH 00/10] ext4: fix inconsistency since reading old metadata
 from disk
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <zhangxiaoxu5@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
 <20200608082007.GJ13248@quack2.suse.cz>
 <cc834f50-95f0-449a-0ace-c55c41d2be1c@huawei.com>
 <20200609121920.GB12551@quack2.suse.cz>
 <45796804-07f7-2f62-b8c5-db077950d882@huawei.com>
 <20200610095739.GE12551@quack2.suse.cz> <20200610154543.GI1347934@mit.edu>
 <20200610162715.GD20677@quack2.suse.cz>
 <92c92066-472e-1f1a-6043-af59bceeb0d8@huawei.com>
 <20200611082103.GA18088@quack2.suse.cz> <20200611165523.GQ1347934@mit.edu>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <9db65a37-84e7-68c0-c6b5-418d55166a49@huawei.com>
Date:   Fri, 12 Jun 2020 19:13:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200611165523.GQ1347934@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/6/12 0:55, Theodore Y. Ts'o wrote:
> On Thu, Jun 11, 2020 at 10:21:03AM +0200, Jan Kara wrote:
>>> I have thought about this solution, we could add a hook in 'struct super_operations'
>>> and call it in blkdev_writepage() like blkdev_releasepage() does, and pick out a
>>> wrapper from block_write_full_page() to pass our endio handler in, something like
>>> this.
>>>
>>> static const struct super_operations ext4_sops = {
>>> ...
>>> 	.bdev_write_page = ext4_bdev_write_page,
>>> ...
>>> };
>>>
>>> static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
>>> {
>>> 	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
>>>
>>> 	if (super && super->s_op->bdev_write_page)
>>> 		return super->s_op->bdev_write_page(page, blkdev_get_block, wbc);
>>>
>>> 	return block_write_full_page(page, blkdev_get_block, wbc);
>>> }
>>>
>>> But I'm not sure it's a optimal ieda. So I continue to realize the "wb_err"
>>> solution now ?
>>
>> The above idea looks good to me. I'm fine with either that solution or
>> "wb_err" idea so maybe let's leave it for Ted to decide...
> 
> My preference would be to be able to get the (error from the callback
> right away.  My reasoning behind that is (a) it allows the file system
> to be notified about the problem right away, (b) in the case of a file
> system resize, we _really_ want to know about the failure ASAP, so we
> can fail the resize before we start allocating inodes and blocks to
> use the new space, and (c) over time, we might be able to add some
> more intelligence handling of some write errors.
> 
> For example, we already have a way of handling CRC errors when we are
> reading an allocation bitmap; we simply avoid allocating blocks and
> inodes from that blockgroup.  Over time, we could theoretically do
> other things to try to recover from some write errors --- for example,
> we could try allocating a new block for an extent tree block, and try
> writing it, and if that succeeds, updating its parent node to point at
> the new location.  Is it worth it to try to add that kind of
> complexity?  I'm really not sure; at the end of the day, it might be
> simpler to just call ext4_error() and abort using the entire file
> system until a system administrator can sort out the mess.  But I
> think (a) and (b) are still reasons for doing this by intercepting the
> writeback error from the buffer head.
> 

Yeah, it make sense to me, I will realize this callback solution.

Thanks,
Yi.

