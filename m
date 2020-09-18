Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D029926EA4C
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgIRBJ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 21:09:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIRBJ5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 17 Sep 2020 21:09:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5228E2DA0A323F0FFE6C;
        Fri, 18 Sep 2020 09:09:47 +0800 (CST)
Received: from [10.174.179.187] (10.174.179.187) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 18 Sep 2020 09:09:45 +0800
Subject: Re: [PATCH] ext4: clear buffer verified flag if read meta block from
 disk
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.com>
References: <20200914112420.1906407-1-yi.zhang@huawei.com>
 <20200915130711.GP4863@quack2.suse.cz>
 <2b43d24e-f220-a9f8-d1a6-e85363020a3b@huawei.com>
 <20200917115103.GD16097@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <8837f7a9-3789-b68c-cfcf-c00f2935e714@huawei.com>
Date:   Fri, 18 Sep 2020 09:09:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200917115103.GD16097@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.187]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/9/17 19:51, Jan Kara wrote:
> On Tue 15-09-20 22:57:35, zhangyi (F) wrote:
>> Hi, Jan
>>
>> On 2020/9/15 21:07, Jan Kara wrote:
>>> On Mon 14-09-20 19:24:20, zhangyi (F) wrote:
>>>> The metadata buffer is no longer trusted after we read it from disk
>>>> again because it is not uptodate for some reasons (e.g. failed to write
>>>> back). Otherwise we may get below memory corruption problem in
>>>> ext4_ext_split()->memset() if we read stale data from the newly
>>>> allocated extent block on disk which has been failed to async write
>>>> out but miss verify again since the verified bit has already been set
>>>> on the buffer.
>>>>
>>>> [   29.774674] BUG: unable to handle kernel paging request at ffff88841949d000
>>>> ...
>>>> [   29.783317] Oops: 0002 [#2] SMP
>>>> [   29.784219] R10: 00000000000f4240 R11: 0000000000002e28 R12: ffff88842fa1c800
>>>> [   29.784627] CPU: 1 PID: 126 Comm: kworker/u4:3 Tainted: G      D W
>>>> [   29.785546] R13: ffffffff9cddcc20 R14: ffffffff9cddd420 R15: ffff88842fa1c2f8
>>>> [   29.786679] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),BIOS ?-20190727_0738364
>>>> [   29.787588] FS:  0000000000000000(0000) GS:ffff88842fa00000(0000) knlGS:0000000000000000
>>>> [   29.789288] Workqueue: writeback wb_workfn
>>>> [   29.790319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   29.790321]  (flush-8:0)
>>>> [   29.790844] CR2: 0000000000000008 CR3: 00000004234f2000 CR4: 00000000000006f0
>>>> [   29.791924] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>> [   29.792839] RIP: 0010:__memset+0x24/0x30
>>>> [   29.793739] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>> [   29.794256] Code: 90 90 90 90 90 90 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2 07 48 c1 e9 033
>>>> [   29.795161] Kernel panic - not syncing: Fatal exception in interrupt
>>>> ...
>>>> [   29.808149] Call Trace:
>>>> [   29.808475]  ext4_ext_insert_extent+0x102e/0x1be0
>>>> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
>>>> [   29.809652]  ext4_map_blocks+0x290/0x8a0
>>>> [   29.809085]  ext4_ext_map_blocks+0xa89/0x1bb0
>>>> [   29.809652]  ext4_map_blocks+0x290/0x8a0
>>>> [   29.810161]  ext4_writepages+0xc85/0x17c0
>>>> ...
>>>>
>>>> Fix this by clear buffer's verified bit if we read it from disk again.
>>>>
>>>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>>>
>>> Good spotting! When looking at the patch I was just wondering that it's
>>> rather easy to miss clearing of buffer_verified() bit in some place where
>>> we read metadata block from disk. So I was wondering that maybe it would be
>>
>> Indeed, I clear the buffer_verified() bit in some common helpers of ext4,
>> such as ext4_bread() and ext4_sb_bread(), so we may not miss clear it
>> where we invoke these helpers, but it is rather easy to miss in the
>> others places where submit read bio directly. How about add some common
>> helpers for them too ?
> 
> I was thinking about this for some time and yes, I agree this is probably
> the best way forward. I've looked at places where we submit reads and
> probably some helper like below should work:
> 
> void ext4_read_bh(struct buffer_head *bh, int op_flags,
> 		  void (*end_io)(struct buffer_head *bh, int uptodate))
> 
> which would do the final ext4_buffer_uptodate() check, set end_io (fill in
> end_buffer_read_sync if NULL), clear verified bit, get bh ref, and do
> submit_bh(). And use this in all the places reading metadata buffers
> instead of various different helpers.
> 

Yeah, I agree with you, I will do this.

Thanks,
Yi.
