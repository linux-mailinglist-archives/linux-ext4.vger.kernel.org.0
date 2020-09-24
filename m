Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7394A277434
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgIXOmk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 10:42:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727889AbgIXOmk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 10:42:40 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F4506427D0E2EF3E382;
        Thu, 24 Sep 2020 22:42:37 +0800 (CST)
Received: from [10.174.179.224] (10.174.179.224) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 22:42:30 +0800
Subject: Re: [PATCH] ext4: Fix bdev write error check failed when mount fs
 with ro
To:     Jan Kara <jack@suse.cz>
CC:     <yi.zhang@huawei.com>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>
References: <20200924011149.1624846-1-zhangxiaoxu5@huawei.com>
 <20200924080613.GC27019@quack2.suse.cz>
From:   "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>
Message-ID: <e4d35bb9-e83f-343f-10ff-7b19be6cb86b@huawei.com>
Date:   Thu, 24 Sep 2020 22:42:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200924080613.GC27019@quack2.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.224]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2020/9/24 16:06, Jan Kara Ð´µÀ:
> On Wed 23-09-20 21:11:49, Zhang Xiaoxu wrote:
>> If some errors has occurred on the device, and the orphan list not empty,
>> then mount the device with 'ro', the bdev write error check will failed:
>>    ext4_check_bdev_write_error:193: comm mount: Error while async write back metadata
>>
>> Since the sbi->s_bdev_wb_err wouldn't be initialized when mount file system
>> with 'ro', when clean up the orphan list and access the iloc buffer, bdev
>> write error check will failed.
>>
>> So we should always initialize the sbi->s_bdev_wb_err even if mount the
>> file system with 'ro'.
>>
>> Fixes: bc71726c7257 ("ext4: abort the filesystem if failed to async write metadata buffer")
>> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> 
> Thanks for the patch! Good catch! I just think you should now remove the
> errseq_check_and_advance() call in ext4_remount() because it isn't needed
> anymore.

Thanks for your suggesstion.
I will send the v2 to remove the errseq_check_and_advance in ext4_remount.

Xiaoxu.
> 
> 
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index ea425b49b345..086439889869 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -4814,9 +4814,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>>   	 * used to detect the metadata async write error.
>>   	 */
>>   	spin_lock_init(&sbi->s_bdev_wb_lock);
>> -	if (!sb_rdonly(sb))
>> -		errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
>> -					 &sbi->s_bdev_wb_err);
>> +	errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
>> +				 &sbi->s_bdev_wb_err);
>>   	sb->s_bdev->bd_super = sb;
>>   	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
>>   	ext4_orphan_cleanup(sb, es);
>> -- 
>> 2.25.4
>>
