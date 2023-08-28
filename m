Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD978AE7A
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Aug 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjH1LIH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Aug 2023 07:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjH1LHk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Aug 2023 07:07:40 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403A5E3
        for <linux-ext4@vger.kernel.org>; Mon, 28 Aug 2023 04:07:37 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZ74l1tlWzVjMv;
        Mon, 28 Aug 2023 19:05:11 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 28 Aug 2023 19:07:34 +0800
Message-ID: <cee6ed10-9ec6-39c4-42c0-98a90110290c@huawei.com>
Date:   Mon, 28 Aug 2023 19:07:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2] e2fsck: delay quotas loading in
 release_orphan_inodes()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <darrick.wong@oracle.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20230825132237.2869251-1-libaokun1@huawei.com>
 <20230828095403.ypnstkl55ouxr6e4@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230828095403.ypnstkl55ouxr6e4@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/8/28 17:54, Jan Kara wrote:
> On Fri 25-08-23 21:22:37, Baokun Li wrote:
>> After 7d79b40b ("e2fsck: adjust quota counters when clearing orphaned
>> inodes"), we load all the quotas before we process the orphaned inodes,
>> and when we load the quotas, we check the checsum of the bbitmap for each
>> group. If one of the bbitmap checksums is wrong, the following error will
>> be reported:
>>
>> “Error initializing quota context in support library:
>>   Block bitmap checksum does not match bitmap”
>>
>> But loading quotas comes before checking the current superblock for the
>> EXT2_ERROR_FS flag, which makes it impossible to use e2fsck to repair any
>> image that contains orphan inodes and has the wrong bbitmap checksum. So
>> delaying quota loading until after the EXT2_ERROR_FS judgment avoids the
>> above problem. Moreover, since we don't care if the bitmap checksum is
>> wrong before Pass5, e2fsck_read_bitmaps() is called before loading the
>> quota to avoid bitmap checksum errors that would cause e2fsck to exit.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>> V1->V2:
>> 	Add e2fsck_read_bitmaps() to avoid bitmap checksum errors causing
>> 	e2fsck to exit.
> Looks good, just one nit below:
>
>> @@ -525,10 +516,18 @@ static int release_orphan_inodes(e2fsck_t ctx)
>>   	 * be running a full e2fsck run anyway... We clear orphan file contents
>>   	 * after filesystem is checked to avoid clearing someone else's data.
>>   	 */
>> -	if (fs->super->s_state & EXT2_ERROR_FS) {
>> -		if (ctx->qctx)
>> -			quota_release_context(&ctx->qctx);
>> +	if (fs->super->s_state & EXT2_ERROR_FS)
>>   		return 0;
>> +
>> +	e2fsck_read_bitmaps(ctx);
>> +
>> +	clear_problem_context(&pctx);
>> +	ino = fs->super->s_last_orphan;
>> +	pctx.ino = ino;
>> +	pctx.errcode = e2fsck_read_all_quotas(ctx);
>> +	if (pctx.errcode) {
>> +		fix_problem(ctx, PR_0_QUOTA_INIT_CTX, &pctx);
>> +		return 1;
>>   	}
>>   
>>   	if (ino && ((ino < EXT2_FIRST_INODE(fs->super)) ||
> Just a few lines below this place is another call to e2fsck_read_bitmaps()
> so you can just delete it when you are adding one here. Otherwise feel free
> to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Thank you very much for your review!
I'll remove the redundant e2fsck_read_bitmaps() in the next version.

-- 
With Best Regards,
Baokun Li
.
