Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787F2720DAE
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Jun 2023 05:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFCDtn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jun 2023 23:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjFCDtm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jun 2023 23:49:42 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A7E52
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jun 2023 20:49:40 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QY5NS6Hypz18Lst;
        Sat,  3 Jun 2023 11:44:56 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 11:49:38 +0800
Message-ID: <3b0c9923-e12f-abc7-b0d9-ac96b52ec88b@huawei.com>
Date:   Sat, 3 Jun 2023 11:49:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] e2fsck: restore sb->s_state before journal recover
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <linfeilong@huawei.com>, <louhongxiang@huawei.com>
References: <20230602082759.4062633-1-zhanchengbin1@huawei.com>
 <20230602151858.GA16844@frogsfrogsfrogs>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230602151858.GA16844@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100015.china.huawei.com (7.185.36.168) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/6/2 23:18, Darrick J. Wong wrote:
> On Fri, Jun 02, 2023 at 04:27:59PM +0800, zhanchengbin wrote:
>> ext4_handle_error
>>      EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>>      if remount-ro
>>          ext4_commit_super(sb);
>> As you can see, when the filesystem error in the kernel, the last sb commit
>> not record the journal, So sb->s_state will be overwritten by journal recover.
>> In some cases , modifying metadata and superblock data are placed in two
>> transactions, if the previous transaction is already in the journal, and
>> ext4_handle_error occurs when updating sb, the filesystem is still error even
>> if the journal is recovered(I know that this situation should not occur in
>> theory, but I encountered this error when testing quota. Therefore, I think
>> we cannot fully rely on the kernel).
>> So when the filesystem is error before the journal recover, keep the error
>> state and perform deep check later.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> ---
>>   e2fsck/journal.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
>> index c7868d89..6f49321d 100644
>> --- a/e2fsck/journal.c
>> +++ b/e2fsck/journal.c
>> @@ -1683,6 +1683,7 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>>   	errcode_t	retval, recover_retval;
>>   	io_stats	stats = 0;
>>   	unsigned long long kbytes_written = 0;
>> +	__u16 state = ctx->fs->super->s_state;
>>   
>>   	printf(_("%s: recovering journal\n"), ctx->device_name);
>>   	if (ctx->options & E2F_OPT_READONLY) {
>> @@ -1722,6 +1723,9 @@ errcode_t e2fsck_run_ext3_journal(e2fsck_t ctx)
>>   	ctx->fs->flags |= EXT2_FLAG_MASTER_SB_ONLY;
>>   	ctx->fs->super->s_kbytes_written += kbytes_written;
>>   
>> +	if (EXT2_ERROR_FS | state)
> 
> Isn't this  ^^^^^^^^^^^^^^^^^^^^^ expression always nonzero? >
>> +		ctx->fs->super->s_state = state | EXT2_ERROR_FS;
> 
> /me doesn't understand this bit logic at all.

You can check this stack:
ext4_handle_error
     ext4_commit_super
         ext4_update_super
             if (sbi->s_add_error_count > 0) {
                 es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
  - bin.

> 
> --D
> 
>> +
>>   	/* Set the superblock flags */
>>   	e2fsck_clear_recover(ctx, recover_retval != 0);
>>   
>> -- 
>> 2.31.1
>>
> .
> 
