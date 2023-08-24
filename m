Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18418786FC5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 14:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHXM4c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 08:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjHXM4W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 08:56:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5181700
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 05:56:19 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RWjg92M2nzJrXZ;
        Thu, 24 Aug 2023 20:53:09 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 20:56:14 +0800
Message-ID: <b922a960-fc17-5595-17b3-06b8348f7fb1@huawei.com>
Date:   Thu, 24 Aug 2023 20:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <darrick.wong@oracle.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230817081828.934259-1-libaokun1@huawei.com>
 <20230823170524.xox66gceoqrigtyo@quack3>
 <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
 <20230824100804.l6dxfdztigdrw7m7@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230824100804.l6dxfdztigdrw7m7@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/24 18:08, Jan Kara wrote:
> On Thu 24-08-23 10:27:46, Baokun Li wrote:
>> Hello, Jan!
>>
>> On 2023/8/24 1:05, Jan Kara wrote:
>>> On Thu 17-08-23 16:18:28, Baokun Li wrote:
>>>> After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
>>>> inodes"), we load all the quotas before we process the orphaned inodes,
>>>> and when we load the quotas, we check the checsum of the bbitmap for each
>>>> group. If one of the bbitmap checksums is wrong, the following error will
>>>> be reported:
>>>>
>>>> “Error initializing quota context in support library:
>>>>    Block bitmap checksum does not match bitmap”
>>>>
>>>> But loading quotas comes before checking the current superblock for the
>>>> EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
>>>> image that contains orphan inodes and has the wrong bbitmap checksum.
>>>> So delaying quota loading until after the EXT2_ERROR_FS judgment avoids
>>>> the above problem.
>>>>
>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>> This certainly looks better but I wonder if there still isn't a problem if
>>> the bitmap checksums are wrong but EXT2_ERROR_FS is not set. Shouldn't we
>>> rather move the initialization of the quota files after the call to
>>> e2fsck_read_bitmaps()?
>>>
>>> 								Honza
>> When the bitmap checksums are wrong but EXT2_ERROR_FS is not set, we must
>> have lost some data (error flag or group descriptor or bitmap), so there
>> is something wrong with the kernel at this time, so I don't think we
>> should fix the image directly, but rather let the user realize that
>> something is wrong with the filesystem logic.
> I agree it means there is a problem somewhere (the storage, the kernel, or
> similar). But just ignoring bitmap checksums in release_orphan_inodes() is
> exactly how e2fsck behaves on filesystems without quota feature so I see no
> reason for quota feature to change that because the inconsistency has
> nothing to do with quotas...
>
>> Moreover, if we don't care how this happened, but just want to fix the
>> image, we only need to run "e2fsck -a" twice. After merging in the
>> current patch, we always empty the orphan list before loading the quotas,
>> and EXT2_ERROR_FS is set when loading the quotas fails, so this will be
>> fixed the second time you run e2fsck. It will not happen that every
>> e2fsck will fail like it did before.
> I see, you're right so it isn't as bad as I originally thought but still my
> argument above holds - IMO e2fsck should treat wrong bitmap checksums the
> same way with and without the quota feature.
>
> 								Honza
The original flow that went wrong here is as follows：
e2fsck
  e2fsck_run_ext3_journal
  check_super_block
   release_orphan_inodes
    e2fsck_read_all_quotas
     quota_read_all_dquots
      quota_file_open
       ext2fs_read_bitmaps
        ext2fs_rw_bitmaps
         read_bitmaps_range
          read_bitmaps_range_start
           ext2fs_block_bitmap_csum_verify
            !!! error
  e2fsck_run

Yes, the inconsistency has nothing to do with quota, but quota is loaded 
here to
keep track of space changes during the normal processing of orphan list. 
If quota
was not loaded, we would not have read and check bitmaps until Pass5, and we
had already done a lot of checking and tweaking of inodes, blocks, and 
dirs before
Pass5, and the bitmaps inconsistency may have been fixed during that time.

So even though the inconsistency has nothing to do with the quota, it is 
the loading
of the quota that reveals the inconsistency and causes the program to 
exit. It is also
unnecessary to read the bitmaps ahead of time alone, since the bitmaps 
inconsistency
could be caused by orphan inodes in the orphan list not being handled.

So in my opinion, there has to be a distinction between the two cases of 
enabling and
disabling quota. Unless we don't read the quotas on disk just log the 
quota changes in
memory and then update the quota in memory to disk when all the checking 
and fixing
is done (like the quota handling before and after e2fsck_run()).

Thanks!
-- 
With Best Regards,
Baokun Li
.
