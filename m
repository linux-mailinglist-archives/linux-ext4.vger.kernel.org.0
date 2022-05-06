Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6830351D830
	for <lists+linux-ext4@lfdr.de>; Fri,  6 May 2022 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392143AbiEFMwd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 May 2022 08:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiEFMwc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 May 2022 08:52:32 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58571409B;
        Fri,  6 May 2022 05:48:47 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kvqxt625BzXdjX;
        Fri,  6 May 2022 20:44:02 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 20:48:44 +0800
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_writepages
To:     Jan Kara <jack@suse.cz>
References: <20220505135708.2629657-1-yebin10@huawei.com>
 <20220505154713.nig6rj76p2gl5mm7@quack3.lan> <6274797D.6050303@huawei.com>
 <20220506085034.akzobmffzosg7rem@quack3.lan>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lczerner@redhat.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <6275192C.5080300@huawei.com>
Date:   Fri, 6 May 2022 20:48:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20220506085034.akzobmffzosg7rem@quack3.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/5/6 16:50, Jan Kara wrote:
> On Fri 06-05-22 09:27:25, yebin wrote:
>> On 2022/5/5 23:47, Jan Kara wrote:
>>> On Thu 05-05-22 21:57:08, Ye Bin wrote:
>>>> we got issue as follows:
>>>> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
>>>> ------------[ cut here ]------------
>>>> kernel BUG at fs/ext4/inode.c:2708!
>>>> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>>>> CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
>>>> RIP: 0010:ext4_writepages+0x1977/0x1c10
>>>> RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
>>>> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
>>>> RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
>>>> RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
>>>> R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
>>>> R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
>>>> FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> Call Trace:
>>>>    <TASK>
>>>>    do_writepages+0x130/0x3a0
>>>>    filemap_fdatawrite_wbc+0x83/0xa0
>>>>    filemap_flush+0xab/0xe0
>>>>    ext4_alloc_da_blocks+0x51/0x120
>>>>    __ext4_ioctl+0x1534/0x3210
>>>>    __x64_sys_ioctl+0x12c/0x170
>>>>    do_syscall_64+0x3b/0x90
>>>>
>>>> It may happen as follows:
>>>> 1. write inline_data inode
>>>> vfs_write
>>>>     new_sync_write
>>>>       ext4_file_write_iter
>>>>         ext4_buffered_write_iter
>>>>           generic_perform_write
>>>> 	  ext4_da_write_begin
>>>> 	    ext4_da_write_inline_data_begin -> If inline data size too
>>>> 	    small will allocate block to write, then mapping will has
>>>> 	    dirty page
>>>> 	    	ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
>>>> 2. fallocate
>>>> do_vfs_ioctl
>>>>     ioctl_preallocate
>>>>       vfs_fallocate
>>>>         ext4_fallocate
>>>>           ext4_convert_inline_data
>>>> 	  ext4_convert_inline_data_nolock
>>>> 	    ext4_map_blocks -> fail will goto restore data
>>>> 	    ext4_restore_inline_data
>>>> 	      ext4_create_inline_data
>>>> 	      ext4_write_inline_data
>>>> 	      ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
>>>> 3. writepages
>>>> __ext4_ioctl
>>>>     ext4_alloc_da_blocks
>>>>       filemap_flush
>>>>         filemap_fdatawrite_wbc
>>>>           do_writepages
>>>> 	  ext4_writepages
>>>> 	    if (ext4_has_inline_data(inode))
>>>> 	      BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
>>>>
>>>> To solved this issue, record origin 'EXT4_STATE_MAY_INLINE_DATA' flag, then pass
>>>> value to 'ext4_restore_inline_data', 'ext4_restore_inline_data' will
>>>> decide to if recovery 'EXT4_STATE_MAY_INLINE_DATA' flag according to parameter.
>>>>
>>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>> I think this will get also fixed by a patch from your colleague I've
>>> reviewed here [1], won't it?
>>>
>>> [1] https://lore.kernel.org/all/20220428165725.mvjh6mx7gr5vekqe@quack3.lan
>>>
>> The issue I fixed is not the same as the isuue my colleague fixed.
> OK, maybe I've jumped to conclusion too early but the fix I've referenced
> above will protect ext4_convert_inline_data() in ext4_fallocate() with
> inode->i_rwsem so I think the race you describe with ext4_da_write_begin()
> cannot happen. The inline conversion path with be entered either from
> ext4_da_write_begin() or from ext4_fallocate() but not from both. If I'm
> missing something, please explain how you think the problem happens with
> the above fix applied... Thanks!
>
> 								Honza
It's happen as follows:
step1:
ext4_file_write_iter
   ext4_buffered_write_iter
     generic_perform_write
       ext4_da_write_begin
         if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
           ext4_da_write_inline_data_begin
             ext4_da_convert_inline_data_to_extent
               __block_write_begin
               ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
             ->clear EXT4_STATE_MAY_INLINE_DATA flag,  If inline data 
size too
         small will allocate block to write, then mapping will has dirty 
page

       ext4_da_write_end
         generic_write_end

step2：
vfs_fallocate
   ext4_fallocate
     ext4_convert_inline_data
       if (ext4_has_inline_data(inode))  -> This condition is satisfied
         ext4_convert_inline_data_nolock
           ext4_map_blocks -> fail will goto restore data
           ext4_restore_inline_data
            ext4_create_inline_data
            ext4_write_inline_data
            ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
step3:
do_writepages
   ext4_writepages
     if (ext4_has_inline_data(inode))
       BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))

As we call "ext4_destroy_inline_data" to destory inline data when delay 
allocation.
So，if we call fallocate before writepages while ext4_map_blocks return 
failed,
will lead to above issue.
This issue does not require concurrency conditions.

>>>> ---
>>>>    fs/ext4/inline.c | 13 +++++++++----
>>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>>>> index 9c076262770d..407061c79adc 100644
>>>> --- a/fs/ext4/inline.c
>>>> +++ b/fs/ext4/inline.c
>>>> @@ -1125,8 +1125,8 @@ static int ext4_update_inline_dir(handle_t *handle, struct inode *dir,
>>>>    }
>>>>    static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>>>> -				     struct ext4_iloc *iloc,
>>>> -				     void *buf, int inline_size)
>>>> +				     struct ext4_iloc *iloc, void *buf,
>>>> +				     int inline_size, bool has_data)
>>>>    {
>>>>    	int ret;
>>>> @@ -1138,7 +1138,8 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>>>>    		return;
>>>>    	}
>>>>    	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
>>>> -	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>>>> +	if (has_data)
>>>> +		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>>>>    }
>>>>    static int ext4_finish_convert_inline_dir(handle_t *handle,
>>>> @@ -1194,6 +1195,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>>>>    	struct buffer_head *data_bh = NULL;
>>>>    	struct ext4_map_blocks map;
>>>>    	int inline_size;
>>>> +	bool has_data;
>>>>    	inline_size = ext4_get_inline_size(inode);
>>>>    	buf = kmalloc(inline_size, GFP_NOFS);
>>>> @@ -1222,6 +1224,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>>>>    	if (error)
>>>>    		goto out;
>>>> +	has_data = !!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>>>> +
>>>>    	map.m_lblk = 0;
>>>>    	map.m_len = 1;
>>>>    	map.m_flags = 0;
>>>> @@ -1262,7 +1266,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>>>>    	unlock_buffer(data_bh);
>>>>    out_restore:
>>>>    	if (error)
>>>> -		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
>>>> +		ext4_restore_inline_data(handle, inode, iloc, buf,
>>>> +					 inline_size, has_data);
>>>>    out:
>>>>    	brelse(data_bh);
>>>> -- 
>>>> 2.31.1
>>>>

