Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860885B9D97
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Sep 2022 16:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIOOnJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Sep 2022 10:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOOnG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Sep 2022 10:43:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EEA626B;
        Thu, 15 Sep 2022 07:43:02 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MT0Fc2hX0z14QVP;
        Thu, 15 Sep 2022 22:39:00 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 22:42:59 +0800
Subject: Re: [PATCH -next 2/2] ext4: adjust fast commit disable judgement
 order in ext4_fc_track_inode
To:     Jan Kara <jack@suse.cz>
References: <20220915135611.3040776-1-yebin10@huawei.com>
 <20220915135611.3040776-3-yebin10@huawei.com>
 <20220915143008.27woacjur6sg32t2@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <632339F2.1000802@huawei.com>
Date:   Thu, 15 Sep 2022 22:42:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220915143008.27woacjur6sg32t2@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/9/15 22:30, Jan Kara wrote:
> On Thu 15-09-22 21:56:11, Ye Bin wrote:
>> Judge filesystem if fast commit disabled before test inode's journal mode.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Probably makes sense but is there any particular reason why you do this?
>
> 								Honza

I think the impact of fast commit on normal processes should be minimized.

>
>> ---
>>   fs/ext4/fast_commit.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
>> index eadab945b856..9217a588afd1 100644
>> --- a/fs/ext4/fast_commit.c
>> +++ b/fs/ext4/fast_commit.c
>> @@ -577,15 +577,15 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
>>   	if (S_ISDIR(inode->i_mode))
>>   		return;
>>   
>> +	if (ext4_fc_disabled(inode->i_sb))
>> +		return;
>> +
>>   	if (ext4_should_journal_data(inode)) {
>>   		ext4_fc_mark_ineligible(inode->i_sb,
>>   					EXT4_FC_REASON_INODE_JOURNAL_DATA, handle);
>>   		return;
>>   	}
>>   
>> -	if (ext4_fc_disabled(inode->i_sb))
>> -		return;
>> -
>>   	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
>>   		return;
>>   
>> -- 
>> 2.31.1
>>

