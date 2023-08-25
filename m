Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7371787D10
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 03:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjHYBUz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 21:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjHYBUZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 21:20:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72919A0
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 18:20:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RX28y0NlsztRbF;
        Fri, 25 Aug 2023 09:16:34 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 09:20:19 +0800
Message-ID: <23a61231-c0b7-629a-328f-898f1e1d03e1@huawei.com>
Date:   Fri, 25 Aug 2023 09:20:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] e2fsck: delay quotas loading in release_orphan_inodes()
Content-Language: en-US
To:     Andreas Dilger <adilger@dilger.ca>
CC:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Zhang Yi <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230817081828.934259-1-libaokun1@huawei.com>
 <20230823170524.xox66gceoqrigtyo@quack3>
 <c03c97b6-1a04-737f-c17b-8e35564f32df@huawei.com>
 <900CFAF0-71BE-416B-834B-576DD7B18863@dilger.ca>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <900CFAF0-71BE-416B-834B-576DD7B18863@dilger.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/25 3:49, Andreas Dilger wrote:
> On Aug 23, 2023, at 8:27 PM, Baokun Li <libaokun1@huawei.com> wrote:
>> On 2023/8/24 1:05, Jan Kara wrote:
>>> On Thu 17-08-23 16:18:28, Baokun Li wrote:
>>>> After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
>>>> inodes"), we load all the quotas before we process the orphaned inodes,
>>>> and when we load the quotas, we check the checsum of the bbitmap for each
>>>> group. If one of the bbitmap checksums is wrong, the following error will
>>>> be reported:
>>>>
>>>> “Error initializing quota context in support library:
>>>>   Block bitmap checksum does not match bitmap”
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
>> When the bitmap checksums are wrong but EXT2_ERROR_FS is not set, we must
>> have lost some data (error flag or group descriptor or bitmap), so there is
>> something wrong with the kernel at this time, so I don't think we should
>> fix the image directly, but rather let the user realize that something is
>> wrong with the filesystem logic.
>>
>> Moreover, if we don't care how this happened, but just want to fix the image,
>> we only need to run "e2fsck -a" twice. After merging in the current patch, we
>> always empty the orphan list before loading the quotas, and EXT2_ERROR_FS
>> is set when loading the quotas fails, so this will be fixed the second time
>> you run e2fsck. It will not happen that every e2fsck will fail like it did
>> before.
> I recall that Ted prefers e2fsck to fix everything in a single pass, or at
> worst if a fatal problem hit during the run it should restart itself so
> that it will fix all of the problems before exiting.
>
> Cheers, Andreas
>
>
As mentioned earlier, when a bitmap checksums error occurs but EXT2_ERROR_FS
is not set, something may be wrong, so we should stop and tell the 
developer what
may be wrong, rather than just fixing it to hide the possible problem, 
which can
make it harder to locate some of the issues.

Cheers!
-- 
With Best Regards,
Baokun Li
.
