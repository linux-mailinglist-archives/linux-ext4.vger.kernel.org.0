Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A869A38C
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 02:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjBQBpC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 20:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBQBpC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 20:45:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812A33A85D;
        Thu, 16 Feb 2023 17:45:00 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PHvhs5g6JzGpdn;
        Fri, 17 Feb 2023 09:43:09 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 17 Feb 2023 09:44:58 +0800
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
 <20230216173159.zkj4qd2nmj2yjpkr@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63EEDC19.6010204@huawei.com>
Date:   Fri, 17 Feb 2023 09:44:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20230216173159.zkj4qd2nmj2yjpkr@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2023/2/17 1:31, Jan Kara wrote:
> On Tue 14-02-23 10:29:04, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Now, 'es->s_state' maybe covered by recover journal. And journal errno
>> maybe not recorded in journal sb as IO error. ext4_update_super() only
>> update error information when 'sbi->s_add_error_count' large than zero.
>> Then 'EXT4_ERROR_FS' flag maybe lost.
>> To solve above issue commit error information after recover journal.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/super.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index dc3907dff13a..b94754ba8556 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct super_block *sb,
>>   		goto err_out;
>>   	}
>>   
>> +	if (unlikely(es->s_error_count && !jbd2_journal_errno(journal) &&
>> +		     !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
>> +		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>> +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
>> +		err = ext4_commit_super(sb);
>> +		if (err) {
>> +			ext4_msg(sb, KERN_ERR,
>> +				 "Failed to commit error information, please repair fs force!");
>> +			goto err_out;
>> +		}
>> +	}
>> +
> Hum, I'm not sure I follow here. If journal replay has overwritten the
> superblock (and thus the stored error info), then I'd expect
> es->s_error_count got overwritten (possibly to 0) as well. And this is
> actually relatively realistic scenario with errors=remount-ro behavior when
> the first fs error happens.
>
> What I intended in my original suggestion was to save es->s_error_count,
> es->s_state & EXT4_ERROR_FS, es->s_first_error_*, es->s_last_error_* before
> doing journal replay in ext4_load_journal() and then after journal replay
> merge this info back to the superblock
Actually，commit 1c13d5c08728 ("ext4: Save error information to the 
superblock for analysis")
already merged error info back to the superblock after journal replay 
except 'es->s_state'.
The problem I have now is that the error flag in the journal superblock 
was not recorded,
but the error message was recorded in the superblock. So it leads to 
ext4_clear_journal_err()
does not detect errors and marks the file system as an error. Because 
ext4_update_super() is
only set error flag  when 'sbi->s_add_error_count  > 0'. Although 
'sbi->s_mount_state' is
written to the super block when umount, but it is also conditional.
So I handle the scenario "es->s_error_count && 
!jbd2_journal_errno(journal) &&
!(le16_to_cpu(es->s_state) & EXT4_ERROR_FS)". Maybe we can just store
'EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS' back to the superblock. But i
prefer to mark fs as error if it contain detail error info without 
EXT4_ERROR_FS.
> - if EXT4_ERROR_FS was set, set it
> now as well, take max of old and new s_error_count, set s_first_error_* if
> it is now unset, set s_last_error_* if stored timestamp is newer than
> current timestamp.
>
> Or am I overengineering it now? :)
>
> 								Honza

