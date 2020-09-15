Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2418126A887
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 17:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgIOPOv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 11:14:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbgIOPN4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 11:13:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D88DD58F7AB3808AD984;
        Tue, 15 Sep 2020 22:57:39 +0800 (CST)
Received: from [10.174.179.187] (10.174.179.187) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 22:57:35 +0800
Subject: Re: [PATCH] ext4: clear buffer verified flag if read meta block from
 disk
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.com>
References: <20200914112420.1906407-1-yi.zhang@huawei.com>
 <20200915130711.GP4863@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <2b43d24e-f220-a9f8-d1a6-e85363020a3b@huawei.com>
Date:   Tue, 15 Sep 2020 22:57:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200915130711.GP4863@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.187]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Jan

On 2020/9/15 21:07, Jan Kara wrote:
> On Mon 14-09-20 19:24:20, zhangyi (F) wrote:
>> The metadata buffer is no longer trusted after we read it from disk
>> again because it is not uptodate for some reasons (e.g. failed to write
>> back). Otherwise we may get below memory corruption problem in
>> ext4_ext_split()->memset() if we read stale data from the newly
>> allocated extent block on disk which has been failed to async write
>> out but miss verify again since the verified bit has already been set
>> on the buffer.
>>
>> [   29.774674] BUG: unable to handle kernel paging request at ffff88841949d000
>> ...
>> [   29.783317] Oops: 0002 [#2] SMP
>> [   29.784219] R10: 00000000000f4240 R11: 0000000000002e28 R12: ffff88842fa1c800
>> [   29.784627] CPU: 1 PID: 126 Comm: kworker/u4:3 Tainted: G      D W
>> [   29.785546] R13: ffffffff9cddcc20 R14: ffffffff9cddd420 R15: ffff88842fa1c2f8
>> [   29.786679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?-20190727_0738364
>> [   29.787588] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
>> [   29.789288] Workqueue: writeback wb_workfn
>> [   29.790319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   29.790321]  (flush-8:0)
>> [   29.790844] CR2: 0000000000000008 CR3: 00000004234f2000 CR4: 00000000000006f0
>> [   29.791924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [   29.792839] RIP: 0010:__memset+0x24/0x30
>> [   29.793739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [   29.794256] Code: 90 90 90 90 90 90 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 033
>> [   29.795161] Kernel panic - not syncing: Fatal exception in interrupt
>> ...
>> [   29.808149] Call Trace:
>> [   29.808475]  ext4_ext_insert_extent+0x102e/0x1be0
>> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
>> [   29.809652]  ext4_map_blocks+0x290/0x8a0
>> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
>> [   29.809652]  ext4_map_blocks+0x290/0x8a0
>> [   29.810161]  ext4_writepages+0xc85/0x17c0
>> ...
>>
>> Fix this by clear buffer's verified bit if we read it from disk again.
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> Good spotting! When looking at the patch I was just wondering that it's
> rather easy to miss clearing of buffer_verified() bit in some place where
> we read metadata block from disk. So I was wondering that maybe it would be

Indeed, I clear the buffer_verified() bit in some common helpers of ext4, such as
ext4_bread() and ext4_sb_bread(), so we may not miss clear it where we invoke these
helpers, but it is rather easy to miss in the others places where submit read bio
directly. How about add some common helpers for them too ?

> less error prone to have:
> 
> ext4_buffer_verified() -> buffer_verified() && !buffer_write_io_error()
> ext4_set_buffer_verified() -> clear_buffer_write_io_error(); set_buffer_verified();
> 
> And this should make sure we recheck the buffer contents as needed. What do
> people think?
> 

Thanks for your suggestion, but I think it makes the buffer verify bit a little more
confused. Now the BH_Verified bit is used by ext4 only. We should check the meta data
after we read buffer from the disk and set BH_Verified bit if the data is fine, so I
think the semantic of the buffer is actually verified or not is the bh is "newly read
from disk and need check" or not, not the write_io_error bit (although it seems that
the write out failure is the only reason of re-read metadata from disk but keep the
verified bit now).

And let us think about the ext4_buffer_uptodate(), we invoke this helper in some
places before read metadata from disk, it will re-set the uptodate bit to void read
from disk again, so recheck the buffer is not required for these cases. If we use
ext4_buffer_verified(), it will force to recheck the buffer again. So I think clear
the buffer_verified() properly may be more clear to me. What do you think ?

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/balloc.c  | 1 +
>>  fs/ext4/extents.c | 1 +
>>  fs/ext4/ialloc.c  | 1 +
>>  fs/ext4/inode.c   | 5 ++++-
>>  fs/ext4/super.c   | 1 +
>>  5 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
>> index 48c3df47748d..8e7e9715cde9 100644
>> --- a/fs/ext4/balloc.c
>> +++ b/fs/ext4/balloc.c
>> @@ -494,6 +494,7 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
>>  	 * submit the buffer_head for reading
>>  	 */
>>  	set_buffer_new(bh);
>> +	clear_buffer_verified(bh);
>>  	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
>>  	bh->b_end_io = ext4_end_bitmap_read;
>>  	get_bh(bh);
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index a0481582187a..0a5205edc00a 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -501,6 +501,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
>>  
>>  	if (!bh_uptodate_or_lock(bh)) {
>>  		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
>> +		clear_buffer_verified(bh);
>>  		err = bh_submit_read(bh);
>>  		if (err < 0)
>>  			goto errout;
>> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
>> index df25d38d6539..20cda952c621 100644
>> --- a/fs/ext4/ialloc.c
>> +++ b/fs/ext4/ialloc.c
>> @@ -188,6 +188,7 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
>>  	/*
>>  	 * submit the buffer_head for reading
>>  	 */
>> +	clear_buffer_verified(bh);
>>  	trace_ext4_load_inode_bitmap(sb, block_group);
>>  	bh->b_end_io = ext4_end_bitmap_read;
>>  	get_bh(bh);
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index bf596467c234..7eaa55651d29 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -884,6 +884,7 @@ struct buffer_head *ext4_bread(handle_t *handle, struct inode *inode,
>>  		return bh;
>>  	if (!bh || ext4_buffer_uptodate(bh))
>>  		return bh;
>> +	clear_buffer_verified(bh);
>>  	ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1, &bh);
>>  	wait_on_buffer(bh);
>>  	if (buffer_uptodate(bh))
>> @@ -909,9 +910,11 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
>>  
>>  	for (i = 0; i < bh_count; i++)
>>  		/* Note that NULL bhs[i] is valid because of holes. */
>> -		if (bhs[i] && !ext4_buffer_uptodate(bhs[i]))
>> +		if (bhs[i] && !ext4_buffer_uptodate(bhs[i])) {
>> +			clear_buffer_verified(bhs[i]);
>>  			ll_rw_block(REQ_OP_READ, REQ_META | REQ_PRIO, 1,
>>  				    &bhs[i]);
>> +		}
>>  
>>  	if (!wait)
>>  		return 0;
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index ea425b49b345..9e760bf9e8b1 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -156,6 +156,7 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
>>  		return ERR_PTR(-ENOMEM);
>>  	if (ext4_buffer_uptodate(bh))
>>  		return bh;
>> +	clear_buffer_verified(bh);
>>  	ll_rw_block(REQ_OP_READ, REQ_META | op_flags, 1, &bh);
>>  	wait_on_buffer(bh);
>>  	if (buffer_uptodate(bh))
>> -- 
>> 2.25.4
>>
