Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB682535D24
	for <lists+linux-ext4@lfdr.de>; Fri, 27 May 2022 11:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiE0JQr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 May 2022 05:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242737AbiE0JQq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 May 2022 05:16:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE36AA6B;
        Fri, 27 May 2022 02:16:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L8fHT1mF3zRhS6;
        Fri, 27 May 2022 17:13:41 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 27 May 2022 17:16:42 +0800
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after
 mount
To:     Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
References: <20220525012904.1604737-1-yebin10@huawei.com>
 <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
 <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <629096FA.6030801@huawei.com>
Date:   Fri, 27 May 2022 17:16:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/5/25 19:54, Jan Kara wrote:
> On Wed 25-05-22 13:21:23, Ritesh Harjani wrote:
>> On 22/05/25 09:29AM, Ye Bin wrote:
>>> We got issue as follows:
>>> [home]# mount  /dev/sda  test
>>> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
>>> [home]# dmesg
>>> EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
>>> EXT4-fs (sda): Errors on filesystem, clearing orphan list.
>>> EXT4-fs (sda): recovery complete
>>> EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
>>> [home]# debugfs /dev/sda
>>> debugfs 1.46.5 (30-Dec-2021)
>>> Checksum errors in superblock!  Retrying...
>>>
>>> Reason is ext4_orphan_cleanup will reset ‘s_last_orphan’ but not update
>>> super block checksum.
>>> To solve above issue, defer update super block checksum after ext4_orphan_cleanup.
>> I agree with the analysis. However after [1], I think all updates to superblock
>> (including checksum computation) should be done within buffer lock.
>> (lock_buffer(), unlock_buffer()).
>>
>> [1]: https://lore.kernel.org/all/20201216101844.22917-4-jack@suse.cz/
> So technically you're right that we should hold buffer lock all the time
> from before we modify superblock buffer until we recompute the checksum (so
> that we avoid writing superblock with mismatched checksum). To do this we'd
> have to put checksum recomputations and superblock buffer locking into
> ext4_orphan_cleanup() around setting of es->s_last_orphan (in three places
> there AFAICS). A bit tedious but it would actually also fix a (theoretical)
> race that someone decides to write out superblock after we set
> s_last_orphan but before we set the checksum.
>
> Overall I'm not convinced this is really necessary so I'd be OK even with
> what Ye suggested. That is IMHO better than mostly pointless locking just
> around checksum computation because that just makes reader wonder why is it
> needed...
>
> 								Honza
Thanks for your reply.
Does my patch need to be adjusted?
>> With lock changes added, feel free to add -
>>
>> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
>>
>>
>>>
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> ---
>>>   fs/ext4/super.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>>> index f9a3ad683b4a..c47204029429 100644
>>> --- a/fs/ext4/super.c
>>> +++ b/fs/ext4/super.c
>>> @@ -5300,14 +5300,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>>   		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
>>>   					  GFP_KERNEL);
>>>   	}
>>> -	/*
>>> -	 * Update the checksum after updating free space/inode
>>> -	 * counters.  Otherwise the superblock can have an incorrect
>>> -	 * checksum in the buffer cache until it is written out and
>>> -	 * e2fsprogs programs trying to open a file system immediately
>>> -	 * after it is mounted can fail.
>>> -	 */
>>> -	ext4_superblock_csum_set(sb);
>>>   	if (!err)
>>>   		err = percpu_counter_init(&sbi->s_dirs_counter,
>>>   					  ext4_count_dirs(sb), GFP_KERNEL);
>>> @@ -5365,6 +5357,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>>>   	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
>>>   	ext4_orphan_cleanup(sb, es);
>>>   	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
>>> +	/*
>>> +	 * Update the checksum after updating free space/inode counters and
>>> +	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
>>> +	 * checksum in the buffer cache until it is written out and
>>> +	 * e2fsprogs programs trying to open a file system immediately
>>> +	 * after it is mounted can fail.
>>> +	 */
>>> +	ext4_superblock_csum_set(sb);
>>>   	if (needs_recovery) {
>>>   		ext4_msg(sb, KERN_INFO, "recovery complete");
>>>   		err = ext4_mark_recovery_complete(sb, es);
>>> --
>>> 2.31.1
>>>

