Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88EE69A386
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Feb 2023 02:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBQBnY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 20:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBQBnX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 20:43:23 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDEC54D3A;
        Thu, 16 Feb 2023 17:43:13 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PHvhP6xpPzrS4M;
        Fri, 17 Feb 2023 09:42:45 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 17 Feb 2023 09:43:11 +0800
Message-ID: <b06afe30-e390-09fb-3ad0-3b1010bc9c61@huawei.com>
Date:   Fri, 17 Feb 2023 09:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ye Bin <yebin10@huawei.com>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
 <20230216173159.zkj4qd2nmj2yjpkr@quack3>
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230216173159.zkj4qd2nmj2yjpkr@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
> Hum, I'm not sure I follow here. If journal replay has overwritten the
> superblock (and thus the stored error info), then I'd expect
> es->s_error_count got overwritten (possibly to 0) as well. And this is
> actually relatively realistic scenario with errors=remount-ro behavior when
> the first fs error happens.
>
> What I intended in my original suggestion was to save es->s_error_count,
> es->s_state & EXT4_ERROR_FS, es->s_first_error_*, es->s_last_error_* before
> doing journal replay in ext4_load_journal() and then after journal replay
> merge this info back to the superblock - if EXT4_ERROR_FS was set, set it
> now as well, take max of old and new s_error_count, set s_first_error_* if
> it is now unset, set s_last_error_* if stored timestamp is newer than
> current timestamp.
>
> Or am I overengineering it now? :)
>
> 								Honza
This is exactly how the code is designed now！
The code has now saved all the above information except EXT4_ERROR_FS by
the following two pieces of logic, as follows：

---------------- In struct ext4_super_block ----------------
1412 #define EXT4_S_ERR_START offsetof(struct ext4_super_block, 
s_error_count)
1413         __le32  s_error_count;          /* number of fs errors */
1414         __le32  s_first_error_time;     /* first time an error 
happened */
1415         __le32  s_first_error_ino;      /* inode involved in first 
error */
1416         __le64  s_first_error_block;    /* block involved of first 
error */
1417         __u8    s_first_error_func[32] __nonstring;     /* function 
where the error happened */
1418         __le32  s_first_error_line;     /* line number where error 
happened */
1419         __le32  s_last_error_time;      /* most recent time of an 
error */
1420         __le32  s_last_error_ino;       /* inode involved in last 
error */
1421         __le32  s_last_error_line;      /* line number where error 
happened */
1422         __le64  s_last_error_block;     /* block involved of last 
error */
1423         __u8    s_last_error_func[32] __nonstring;      /* function 
where the error happened */
1424 #define EXT4_S_ERR_END offsetof(struct ext4_super_block, s_mount_opts)
-----------------------------------------------------------

---------------- In ext4_load_journal() ----------------
5929                 char *save = kmalloc(EXT4_S_ERR_LEN, GFP_KERNEL);
5930                 if (save)
5931                         memcpy(save, ((char *) es) +
5932                                EXT4_S_ERR_START, EXT4_S_ERR_LEN);
5933                 err = jbd2_journal_load(journal);
5934                 if (save)
5935                         memcpy(((char *) es) + EXT4_S_ERR_START,
5936                                save, EXT4_S_ERR_LEN);
5937                 kfree(save);
--------------------------------------------------------

As you said, we should also save EXT4_ERROR_FS to es->s_state.
But we are not saving this now, so I think we just need to add

  `es->s_state |= cpu_to_le16(EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS);`

to save the possible EXT4_ERROR_FS flag after copying the error area 
data to es.


-- 
With Best Regards,
Baokun Li
.
