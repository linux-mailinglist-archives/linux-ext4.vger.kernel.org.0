Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C059E7C62AF
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 04:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJLCVi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 22:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbjJLCVh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 22:21:37 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F82A9
        for <linux-ext4@vger.kernel.org>; Wed, 11 Oct 2023 19:21:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vtygutf_1697077290;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vtygutf_1697077290)
          by smtp.aliyun-inc.com;
          Thu, 12 Oct 2023 10:21:32 +0800
Message-ID: <51b6383e-7bb0-1e63-86ef-0ef8835583f6@linux.alibaba.com>
Date:   Thu, 12 Oct 2023 10:21:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct
 IO
To:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20231011142155.19328-1-jack@suse.cz>
 <ZSc9J9zFChyxl1U2@dread.disaster.area>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZSc9J9zFChyxl1U2@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Dave,

On 2023/10/12 08:26, Dave Chinner wrote:
> On Wed, Oct 11, 2023 at 04:21:55PM +0200, Jan Kara wrote:
>> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
>> sync file size update and thus if we crash at unfortunate moment, the
>> file can have smaller size although O_SYNC IO has reported successful
>> completion. The problem happens because update of on-disk inode size is
>> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
>> dio_complete() in particular) has returned and generic_file_sync() gets
>> called by dio_complete(). Fix the problem by handling on-disk inode size
>> update directly in our ->end_io completion handler.
>>
>> References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
>> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Signed-off-by: Jan Kara <jack@suse.cz>
>> ---
>>   fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
>>   1 file changed, 52 insertions(+), 87 deletions(-)
> .....
>> @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>>   		 */
>>   		if (inode->i_nlink)
>>   			ext4_orphan_del(NULL, inode);
>> +		return;
>>   	}
>> +	/*
>> +	 * If i_disksize got extended due to writeback of delalloc blocks while
>> +	 * the DIO was running we could fail to cleanup the orphan list in
>> +	 * ext4_handle_inode_extension(). Do it now.
>> +	 */
>> +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
>> +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> 
> So this has to be called after the DIO write completes and calls
> ext4_handle_inode_extension()?
> 
> ....
> 
>> @@ -606,9 +570,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   			   dio_flags, NULL, 0);
>>   	if (ret == -ENOTBLK)
>>   		ret = 0;
>> -
>>   	if (extend)
>> -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
>> +		ext4_inode_extension_cleanup(inode, ret);
> 
> Because this doesn't wait for AIO DIO to complete and actually
> extend the file before running the cleanup code...

As far as I know, for ext4 AIO DIO extension cases,
IOMAP_DIO_FORCE_WAIT will be set, thus no async DIO here.

So the timing for this case will be strictly:
   - ext4_handle_inode_extension()   --- record i_disksize in .end_io

   - generic_write_sync()            --- forcely do fsync()

   - ext4_inode_extension_cleanup()  --- drop orphan in another transaction
                                         as mentioned in [1]

Anyway, that is my current limited thoughts.

[1] https://lore.kernel.org/linux-ext4/20230920152005.7iowrlukd5zbvp43@quack3/

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Dave.
