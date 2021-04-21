Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB348366AF0
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Apr 2021 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbhDUMjX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Apr 2021 08:39:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17809 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbhDUMjW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Apr 2021 08:39:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FQKmP3PgDz7w5B;
        Wed, 21 Apr 2021 20:36:21 +0800 (CST)
Received: from [10.174.176.255] (10.174.176.255) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 21 Apr 2021 20:38:43 +0800
Subject: Re: [PATCH v2] ext4: Fix bug on in ext4_es_cache_extent as
 ext4_split_extent_at failed
To:     Jan Kara <jack@suse.cz>
References: <20210420142518.1573012-1-yebin10@huawei.com>
 <20210421092156.GL8706@quack2.suse.cz>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-kernel@vger.kernel.org>, <linux-ext4@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <60801CD3.60000@huawei.com>
Date:   Wed, 21 Apr 2021 20:38:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20210421092156.GL8706@quack2.suse.cz>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.255]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2021/4/21 17:21, Jan Kara wrote:
> On Tue 20-04-21 22:25:18, Ye Bin wrote:
>> We got follow bug_on when run fsstress with injecting IO fault:
>> [130747.323114] kernel BUG at fs/ext4/extents_status.c:762!
>> [130747.323117] Internal error: Oops - BUG: 0 [#1] SMP
> Which BUG_ON is that please? I don't see any relevant one near that line in
> current upstream kernel...
ext4_es_cache_extent:
......
           if (!len)
                   return;

          BUG_ON(end < lblk);    --> BUG_ON at here.
......

>> ......
>> [130747.334329] Call trace:
>> [130747.334553]  ext4_es_cache_extent+0x150/0x168 [ext4]
>> [130747.334975]  ext4_cache_extents+0x64/0xe8 [ext4]
>> [130747.335368]  ext4_find_extent+0x300/0x330 [ext4]
>> [130747.335759]  ext4_ext_map_blocks+0x74/0x1178 [ext4]
>> [130747.336179]  ext4_map_blocks+0x2f4/0x5f0 [ext4]
>> [130747.336567]  ext4_mpage_readpages+0x4a8/0x7a8 [ext4]
>> [130747.336995]  ext4_readpage+0x54/0x100 [ext4]
>> [130747.337359]  generic_file_buffered_read+0x410/0xae8
>> [130747.337767]  generic_file_read_iter+0x114/0x190
>> [130747.338152]  ext4_file_read_iter+0x5c/0x140 [ext4]
>> [130747.338556]  __vfs_read+0x11c/0x188
>> [130747.338851]  vfs_read+0x94/0x150
>> [130747.339110]  ksys_read+0x74/0xf0
>>
>> If call ext4_ext_insert_extent failed but new extent already inserted, we just
>> update "ex->ee_len = orig_ex.ee_len", this will lead to extent overlap, then
>> cause bug on when cache extent.
>> If call ext4_ext_insert_extent failed don't update ex->ee_len with old value.
>> Maybe there will lead to block leak, but it can be fixed by fsck later.
> Thanks for the analysis and the patch but the fact is that the extent tree
> is going to be corrupted one way or the other. And I think other disk
> corruptions can lead to similar problematic extent layout anyway. So I
> rather think we need to make the code more robust to not take the kernel
> down when seeing corrupted extent tree - and we've done work to make code
> more robust in this sence in the past. Can you reproduce the issue with the
> current upstream kernel? If yes, we are probably still missing extent tree
> consistency checks on some path and we need to add them...
>
> 								Honza
I will try to reproduce this issue with the current upstream kernel.  
Actually, the  reason of this
issue is obvious, as i reproduced this issue with kernel-4.19.95 and got 
follow information:
We inject IO fault when runing  fsstress,  JBD detect IO error then 
trigger JBD abort. At the same time,
if ext4_ext_insert_extent already insert new extent then call 
ext4_ext_dirty to dirty metadata , but
JBD already aborted ,  ext4_ext_dirty will return error.
In ext4_ext_dirty function call  ext4_ext_check_inode check extent if 
ok, if not, trigger BUG_ON and
also print extent detail information. I caught follow call trace and 
extent information:
================================================================================= 

[ 7597.436071] inode 1808 ext4_ext_check_inode
[ 7597.436074] inode[1808]: [4] lblk=76 len=5 orig_len=32773 prev=0
[ 7597.436077] inode[1808]: [3] lblk=81 len=25 orig_len=25 prev=81
[ 7597.436080] inode[1808]: [2] lblk=106 len=130 orig_len=32898 prev=106
[ 7597.436084] inode[1808]: [1] lblk=228 len=8 orig_len=32776 prev=236
[ 7597.436181] ------------[ cut here ]------------
[ 7597.436183] kernel BUG at fs/ext4/extents.c:221!
[ 7597.436216] invalid opcode: 0000 [#1] SMP KASAN
[ 7597.436219] Buffer I/O error on dev sda, logical block 131072, lost 
sync page write
[ 7597.436224] CPU: 7 PID: 5157 Comm: kworker/u16:1 Not tainted 
4.19.95-00020-gb095ded9163d-dirty #186
[ 7597.436230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[ 7597.436242] Workqueue: writeback wb_workfn (flush-8:16)
[ 7597.436248] RIP: 0010:__ext4_ext_dirty.cold+0x2ee/0x308
[ 7597.436251] Code: ff 48 89 df e8 c7 e1 d0 ff e9 48 ff ff ff 48 c7 c7 
80 d1 f7 ae e8 87 45 84 ff 48 83 05 ee 3b ca 07 01 48 83 05 c6 3c ca 07 
01 <0f> 04
[ 7597.436253] RSP: 0018:ffff88838bcaf050 EFLAGS: 00010202
[ 7597.436256] RAX: 0000000000000000 RBX: ffff888364b67783 RCX: 
0000000000000000
[ 7597.436258] RDX: 0000000000000001 RSI: 0000000000000008 RDI: 
ffffed1071795dfd
[ 7597.436259] RBP: 000000000000003b R08: 0000000000000000 R09: 
0000000000000001
[ 7597.436261] R10: ffffed10744fbd6e R11: ffff8883a27deb77 R12: 
dffffc0000000000
[ 7597.436262] R13: dffffc0000000000 R14: ffff888364b673f0 R15: 
ffff888364b6730c
[ 7597.436264] FS:  0000000000000000(0000) GS:ffff8883a27c0000(0000) 
knlGS:0000000000000000
[ 7597.436266] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7597.436267] CR2: 00007fca7a249000 CR3: 000000039ce75000 CR4: 
00000000000006e0
[ 7597.436270] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[ 7597.436271] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[ 7597.436275] JBD2: Error -5 detected when updating journal superblock 
for sda-8.
[ 7597.436277] Call Trace:
[ 7597.436294]  ext4_split_extent_at+0x785/0xc80
[ 7597.466767]  ext4_split_extent.isra.0+0x2af/0x550
[ 7597.472503]  ext4_ext_convert_to_initialized+0x4b4/0x2510
[ 7597.536999]  ext4_ext_map_blocks+0x37ef/0x50c0
[ 7597.542467]  ext4_map_blocks+0x685/0x1910
[ 7597.544107]  ext4_writepages+0x1809/0x32f0
[ 7597.547546]  do_writepages+0x7f/0x1b0
[ 7597.548619]  __writeback_single_inode+0xc6/0xc40
[ 7597.549203]  writeback_sb_inodes+0x49f/0xd60
[ 7597.550748]  wb_writeback+0x252/0x9d0
[ 7597.552335]  wb_workfn+0x309/0xe60
[ 7597.557029]  process_one_work+0x70b/0x1610
[ 7597.557566]  worker_thread+0x5a9/0x1060
[ 7597.559091]  kthread+0x35e/0x430
[ 7597.560601]  ret_from_fork+0x1f/0x30
================================================================================= 

Obviously, the follow extent is  overlap:
[ 7597.436080] inode[1808]: [2] lblk=106 len=130 orig_len=32898 prev=106
[ 7597.436084] inode[1808]: [1] lblk=228 len=8 orig_len=32776 prev=236
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/extents.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 77c84d6f1af6..6161db9c17c9 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3245,8 +3245,11 @@ static int ext4_split_extent_at(handle_t *handle,
>>   		err = ext4_zeroout_es(inode, &zero_ex);
>>   
>>   		goto out;
>> -	} else if (err)
>> +	} else if (err == -EROFS) {
>> +		return err;
>> +	} else {
>>   		goto fix_extent_len;
>> +	}
>>   
>>   out:
>>   	ext4_ext_show_leaf(inode, path);
>> -- 
>> 2.25.4
>>

