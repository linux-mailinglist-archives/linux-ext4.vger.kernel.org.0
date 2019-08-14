Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE98D30D
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 14:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNM2d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 08:28:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbfHNM2c (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Aug 2019 08:28:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 94A8B55B3EA1EC18648C;
        Wed, 14 Aug 2019 20:28:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 20:28:29 +0800
Subject: Re: [PATCH v3] ext4: fix potential use after free in system zone via
 remount with noblock_validity
To:     Jan Kara <jack@suse.cz>
References: <1565701547-146508-1-git-send-email-yi.zhang@huawei.com>
 <20190814111408.GC26273@quack2.suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <6fb8e4b5-e0e6-6dbc-c11b-a3a76754ce72@huawei.com>
Date:   Wed, 14 Aug 2019 20:28:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190814111408.GC26273@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/8/14 19:14, Jan Kara Wrote:
> On Tue 13-08-19 21:05:47, zhangyi (F) wrote:
>> Remount process will release system zone which was allocated before if
>> "noblock_validity" is specified. If we mount an ext4 file system to two
>> mountpoints with default mount options, and then remount one of them
>> with "noblock_validity", it may trigger a use after free problem when
>> someone accessing the other one.
>>
>>  # mount /dev/sda foo
>>  # mount /dev/sda bar
>>
>> User access mountpoint "foo"   |   Remount mountpoint "bar"
>>                                |
>> ext4_map_blocks()              |   ext4_remount()
>> check_block_validity()         |   ext4_setup_system_zone()
>> ext4_data_block_valid()        |   ext4_release_system_zone()
>>                                |   free system_blks rb nodes
>> access system_blks rb nodes    |
>> trigger use after free         |
>>
>> This problem can also be reproduced by one mountpint, At the same time,
>> add_system_zone() can get called during remount as well so there can be
>> racing ext4_data_block_valid() reading the rbtree at the same time.
>>
>> This patch add RCU to protect system zone from releasing or building
>> when doing a remount which inverse current "noblock_validity" mount
>> option. It assign the rbtree after the whole tree was complete and
>> do actual freeing after rcu grace period, avoid any intermediate state.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> ---
>> Changes since v2:
>>  - Remove seqlock, and assign the whole rbtree when finished assembling.
>>  - Fix the sparse warning.
> 
> Thanks for the patch! It looks great to me. Just one nit below and with
> that applied feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>>  int ext4_setup_system_zone(struct super_block *sb)
> ...
>>  /* Called when the filesystem is unmounted */
>>  void ext4_release_system_zone(struct super_block *sb)
> 
> Can you perhaps add a comment before ext4_setup_system_zone() and
> ext4_release_system_zone() explaining that these two functions are called
> under sb->s_umount semaphore protection which also serializes updates of
> sb->system_blks pointer? Thanks!
> 
Thanks for your suggestions. Yes, I will add these two comments.

BTW, I realize that one thing is not correct in this patch,
ext4_data_block_valid() should do the below check as before even
system_blks pointer is NULL.

>	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
>	    (start_blk + count < start_blk) ||
>	    (start_blk + count > ext4_blocks_count(sbi->s_es))) {
>		sbi->s_es->s_last_error_block = cpu_to_le64(start_blk);
>		return 0;
>	}

I will fix this by move "system_blks == NULL" checking into
ext4_data_block_valid_rcu() in next iteration at the same time.

Thanks,
Yi.

