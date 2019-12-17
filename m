Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5118122F21
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 15:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfLQOrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 09:47:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8138 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728573AbfLQOrE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Dec 2019 09:47:04 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B53CFE0FA289D2C1F80;
        Tue, 17 Dec 2019 22:47:02 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 17 Dec 2019
 22:46:56 +0800
Subject: Re: [PATCH] ext4: fix Wunused-but-set-variable warning in
 ext4_add_entry()
To:     Ritesh Harjani <riteshh@linux.ibm.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <c351e548-f094-aa90-bf8e-b267284c493e@huawei.com>
 <20191217143807.E8F1D4C058@d06av22.portsmouth.uk.ibm.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <4e0f0042-0c4a-3b36-d83a-147e55507338@huawei.com>
Date:   Tue, 17 Dec 2019 22:46:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191217143807.E8F1D4C058@d06av22.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2019/12/17 22:38, Ritesh Harjani wrote:
> 
> 
> On 12/17/19 5:41 PM, Yunfeng Ye wrote:
>> Warning is found when compile with "-Wunused-but-set-variable":
>>
>> fs/ext4/namei.c: In function ‘ext4_add_entry’:
>> fs/ext4/namei.c:2167:23: warning: variable ‘sbi’ set but not used
>> [-Wunused-but-set-variable]
>>    struct ext4_sb_info *sbi;
>>                         ^~~
>> Fix this by moving the variable @sbi under CONFIG_UNICODE.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> 
> Looks good to me. You may add:
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> 
ok, thanks.

> 
> 
>> ---
>>   fs/ext4/namei.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
>> index a856997d87b5..617349be460f 100644
>> --- a/fs/ext4/namei.c
>> +++ b/fs/ext4/namei.c
>> @@ -2164,7 +2164,9 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>>       struct buffer_head *bh = NULL;
>>       struct ext4_dir_entry_2 *de;
>>       struct super_block *sb;
>> +#ifdef CONFIG_UNICODE
>>       struct ext4_sb_info *sbi;
>> +#endif
>>       struct ext4_filename fname;
>>       int    retval;
>>       int    dx_fallback=0;
>> @@ -2176,12 +2178,12 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>>           csum_size = sizeof(struct ext4_dir_entry_tail);
>>
>>       sb = dir->i_sb;
>> -    sbi = EXT4_SB(sb);
>>       blocksize = sb->s_blocksize;
>>       if (!dentry->d_name.len)
>>           return -EINVAL;
>>
>>   #ifdef CONFIG_UNICODE
>> +    sbi = EXT4_SB(sb);
>>       if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
>>           sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
>>           return -EINVAL;
>>
> 
> 
> .
> 

