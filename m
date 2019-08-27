Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA19C9E3DA
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 11:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfH0JUu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 05:20:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0JUt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 27 Aug 2019 05:20:49 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B349910FF19798F531BF;
        Tue, 27 Aug 2019 17:20:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 17:20:41 +0800
Subject: Re: [PATCH v5] ext4: fix potential use after free in system zone via
 remount with noblock_validity
To:     Jan Kara <jack@suse.cz>
References: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
 <20190825034000.GE5163@mit.edu> <20190826025612.GB4918@mit.edu>
 <33767946-1e6f-5165-94b3-46e2da15172f@huawei.com>
 <20190826150350.GH10614@quack2.suse.cz>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <adilger.kernel@dilger.ca>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <6874efe7-17e9-6651-0b38-22b8b8946599@huawei.com>
Date:   Tue, 27 Aug 2019 17:20:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190826150350.GH10614@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/8/26 23:03, Jan Kara Wrote:
> On Mon 26-08-19 16:31:41, zhangyi (F) wrote:
>> On 2019/8/26 10:56, Theodore Y. Ts'o Wrote:
>>> I added a missing rcu_read_lock() to prevent a suspicious RCU
>>> warning when CONFIG_PROVE_RCU is enabled:
>>>
>>> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
>>> index 003dc1dc2da3..f7bc914a74df 100644
>>> --- a/fs/ext4/block_validity.c
>>> +++ b/fs/ext4/block_validity.c
>>> @@ -330,11 +330,13 @@ void ext4_release_system_zone(struct super_block *sb)
>>>  {
>>>  	struct ext4_system_blocks *system_blks;
>>>  
>>> +	rcu_read_lock();
>>>  	system_blks = rcu_dereference(EXT4_SB(sb)->system_blks);
>>>  	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
>>>  
>>>  	if (system_blks)
>>>  		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
>>> +	rcu_read_unlock();
>>>  }
>>>  
>>>  int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>>>
>>
>> Hi Ted，
>> Sorry about missing this warning, I think switch to use:
>>   system_blks = rcu_dereference_raw(EXT4_SB(sb)->system_blks);
>> or
>>   system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks, true);
>> is enough to fix this waring, am I missing something?
> 
> Proper fix for this is actually using:
> 
>  system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
> 					 lockdep_is_held(&sb->s_umount));
> 
Totally agree, will resend the patch.

Thanks,
Yi.

