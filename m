Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205DF79C470
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 05:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjILDxK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjILDw4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 23:52:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC44E7
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 20:52:52 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rl8hD2GQcztSRv;
        Tue, 12 Sep 2023 11:48:44 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 11:52:49 +0800
Subject: Re: [PATCH v2] ext4: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
To:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>
References: <20230908124317.2955345-1-chengzhihao1@huawei.com>
 <2b2718a4-7d8b-e0bc-c045-59fe7562392d@huawei.com>
 <20230911161825.4ny4ynxyxabwqbee@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e74a7e44-9055-31a7-0124-812a6ae42a41@huawei.com>
Date:   Tue, 12 Sep 2023 11:52:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230911161825.4ny4ynxyxabwqbee@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2023/9/12 0:18, Jan Kara Ð´µÀ:
> Hello!
> 
> On Sat 09-09-23 11:41:11, Zhang Yi wrote:
>> On 2023/9/8 20:43, Zhihao Cheng wrote:
>>> JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
>>> however, other process could intercept the EIO information from bdev's
>>> mapping, which leads journal recovering successful even EIO occurs during
>>> data written back to fs device.
>>>
>>> We found this problem in our product, iscsi + multipath is chosen for block
>>> device of ext4. Unstable network may trigger kpartx to rescan partitions in
>>> device mapper layer. Detailed process is shown as following:
>>>
>>>    mount          kpartx          irq
>>> jbd2_journal_recover
>>>   do_one_pass
>>>    memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
>>>    mark_buffer_dirty // mark bh dirty
>>>           vfs_read
>>> 	  generic_file_read_iter // dio
>>> 	   filemap_write_and_wait_range
>>> 	    __filemap_fdatawrite_range
>>> 	     do_writepages
>>> 	      block_write_full_folio
>>> 	       submit_bh_wbc
>>> 	            >>  EIO occurs in disk  <<
>>> 	                     end_buffer_async_write
>>> 			      mark_buffer_write_io_error
>>> 			       mapping_set_error
>>> 			        set_bit(AS_EIO, &mapping->flags) // set!
>>> 	    filemap_check_errors
>>> 	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
>>>   err2 = sync_blockdev
>>>    filemap_write_and_wait
>>>     filemap_check_errors
>>>      test_and_clear_bit(AS_EIO, &mapping->flags) // false
>>>   err2 = 0
>>>
>>> Filesystem is mounted successfully even data from journal is failed written
>>> into disk, and ext4 could become corrupted.
>>>
>>> Fix it by comparing 'sbi->s_bdev_wb_err' before loading journal and after
>>> loading journal.
>>>
>>> Fetch a reproducer in [Link].
>>>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>>   v1->v2: Checks wb_err from block device only in ext4.
>>>   fs/ext4/super.c | 22 +++++++++++++++-------
>>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index 38217422f938..4dcaad2403be 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -4907,6 +4907,14 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>>>   	if (err)
>>>   		return err;
>>>   
>>> +	err = errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
>>> +				       &sbi->s_bdev_wb_err);
>>> +	if (err) {
>>> +		ext4_msg(sb, KERN_ERR, "Background error %d when loading journal",
>>> +			 err);
>>> +		goto out;
>>> +	}
>>> +
>>
>> This solution cannot solve the problem, because the journal tail is
>> still updated in journal_reset() even if we detect the writeback error
>> and refuse to mount the ext4 filesystem here. So I suppose we have to
>> check the I/O error by jbd2 module itself like v1 does.
> 
> Hum, that's a good point because next time we will try to mount the fs we
> will not try to replay the journal anymore. So let's return to v1 and I'm
> sorry for misguiding you Zhihao.
> 
> But when we are doing background IO error detection in jbd2 during journal
> replay, I'm wondering whether we shouldn't be doing something similar in
> checkpointing code - like when we are about to remove a transaction from
> the journal. And as I'm checking we already do that using
> JBD2_CHECKPOINT_IO_ERROR bit handling - maybe we could replace that with a
> more standard errseq mechanism that is available these days as a cleanup?
>  > And the ext4 handling in ext4_check_bdev_write_error() is useful only in
> nojournal mode as otherwise jbd2 is taking care of all writeback errors
> including the background ones. So maybe we can guard the
> ext4_check_bdev_write_error() by a !ext4_handle_valid(handle) check to make
> that obvious (and comment about that). >
> What do you think?
> 
> 								Honza
> 

Ok, I will try it. Thanks for suggestions.

