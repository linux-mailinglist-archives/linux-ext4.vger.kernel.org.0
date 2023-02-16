Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46349698F88
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBPJR7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 04:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBPJR7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 04:17:59 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C4EC6E;
        Thu, 16 Feb 2023 01:17:56 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PHTnK0wF9z16NSw;
        Thu, 16 Feb 2023 17:15:33 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 16 Feb 2023 17:17:25 +0800
Message-ID: <add8f2da-e220-61ad-76ae-1590e9d2c715@huawei.com>
Date:   Thu, 16 Feb 2023 17:17:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
To:     "yebin (H)" <yebin10@huawei.com>, Ye Bin <yebin@huaweicloud.com>,
        <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
 <501b98e2-9345-d57f-bc70-432ae342b1e8@huawei.com> <63EDDED7.90406@huawei.com>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <63EDDED7.90406@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/2/16 15:44, yebin (H) wrote:
>
>
> On 2023/2/16 15:17, Baokun Li wrote:
>> On 2023/2/14 10:29, Ye Bin wrote:
>>> From: Ye Bin <yebin10@huawei.com>
>>>
>>> Now, 'es->s_state' maybe covered by recover journal. And journal errno
>>> maybe not recorded in journal sb as IO error. ext4_update_super() only
>>> update error information when 'sbi->s_add_error_count' large than zero.
>>> Then 'EXT4_ERROR_FS' flag maybe lost.
>>> To solve above issue commit error information after recover journal.
>>>
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>   fs/ext4/super.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index dc3907dff13a..b94754ba8556 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct 
>>> super_block *sb,
>>>           goto err_out;
>>>       }
>>>   +    if (unlikely(es->s_error_count && 
>>> !jbd2_journal_errno(journal) &&
>>> +             !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
>>> +        EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>>> +        es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
>>> +        err = ext4_commit_super(sb);
>>> +        if (err) {
>>> +            ext4_msg(sb, KERN_ERR,
>>> +                 "Failed to commit error information, please repair 
>>> fs force!");
>>> +            goto err_out;
>>> +        }
>>> +    }
>>> +
>>>       EXT4_SB(sb)->s_journal = journal;
>>>       err = ext4_clear_journal_err(sb, es);
>>>       if (err) {
>> I think we don't need such a complicated judgment, after the journal 
>> replay and saving the error info,
>> if there is EXT4_ERROR_FS flag in ext4_sb_info->s_mount_state, just 
>> add this flag directly to es->s_state.
>> This way the EXT4_ERROR_FS flag and the error message will be written 
>> to disk the next time
>
> Thanks for your suggestion. There are two reasons for this:
> 1. We want to write the error mark to the disk as soon as possible.
> 2. Here we deal with the case where there is no error mark bit but 
> there is an error record.
> In this case, the file system should be marked with an error and the 
> user should be prompted.
The EXT4_ERROR_FS flag is always written to disk at the same time as the 
error info,
except when the journal is replayed. During journal replay the error 
info is additionally
copied to disk first, and the EXT4_ERROR_FS flag in the sbi is not 
written to disk until
the ext4_put_super() is called. It is only when a failure occurs during 
this time that
there is an error info but no EXT4_ERROR_FS flag. So we just need to 
make sure that
the EXT4_ERROR_FS flag is also written to disk at the same time as the 
error info
after the journal replay.
>> ext4_commit_super() is executed. The code change is as follows:
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 260c1b3e3ef2..341b11c589b3 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5935,6 +5935,7 @@ static int ext4_load_journal(struct super_block 
>> *sb,
>>                         memcpy(((char *) es) + EXT4_S_ERR_START,
>>                                save, EXT4_S_ERR_LEN);
>>                 kfree(save);
>> +               es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state 
>> & EXT4_ERROR_FS);
>>         }
>>
>>         if (err) {
>>
>
>
>
-- 
With Best Regards,
Baokun Li
.
