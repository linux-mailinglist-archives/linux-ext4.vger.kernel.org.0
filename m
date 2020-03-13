Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0792C1842C2
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Mar 2020 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCMIgw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Mar 2020 04:36:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgCMIgv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 13 Mar 2020 04:36:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E0B99E8F17E00DE4C12A;
        Fri, 13 Mar 2020 16:15:54 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.50) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 13 Mar 2020
 16:15:48 +0800
Subject: Re: [PATCH] ocfs2: fix a null pointer derefrence in
 ocfs2_block_group_clear_bits()
To:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, Jan Kara <jack@suse.com>
References: <1d38573d-61c7-be60-334e-c263caf7465c@huawei.com>
 <c56390f0-9f01-cd71-0b8e-b83d746bab74@huawei.com>
 <f702081e-1953-c2c1-76e4-f441302ab2f3@huawei.com>
 <7c5c64a8-0629-b301-6cbb-91d1c9f75fa0@linux.alibaba.com>
 <8017150f-0fa1-2804-4934-5e64ad04ae6e@huawei.com>
CC:     piao jun <piaojun@huawei.com>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux ext4 <linux-ext4@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>
From:   lishan <lishan24@huawei.com>
Message-ID: <d96c776b-20de-c653-a032-bbd3f1df1793@huawei.com>
Date:   Fri, 13 Mar 2020 16:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <8017150f-0fa1-2804-4934-5e64ad04ae6e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.50]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping ?
to Jan Kara

On 2020/3/12 10:38, lishan wrote:
> Hi, Jan Kara:
> 
> I have a long-standing problem,
> In the ocfs2 file system, there is a panic problem related to b_committed_data,
> details can be found in the historical mail.
> 
> Refer to the old version of the ext3 file system,
> ocfs2 file system uses the undo process to ensure that metadata
> which is not committed to disk is not reused.
> 
> I understand that for transactions that have not been committed,
> b_committed_data will not be NULL, so,
> in what scenario do you think b_committed_data will be set to NULL?
> 
> Thanks,
> Shan
> 
> On 2020/3/11 9:15, Joseph Qi wrote:
>>
>>
>> On 2020/3/9 16:26, lishan wrote:
>>> A NULL pointer panic dereference in ocfs2_block_group_clear_bits() happen again.
>>> The information of NULL pointer stack as follows:
>>>
>>> PID: 81866  TASK: ffffa07c3c21ae80  CPU: 66  COMMAND: "fallocate"
>>>   #0 [ffff0000b4d6b0b0] machine_kexec at ffff0000800a2954
>>>   #1 [ffff0000b4d6b110] __crash_kexec at ffff0000801bab34
>>>   #2 [ffff0000b4d6b2a0] panic at ffff0000800f02cc
>>>   #3 [ffff0000b4d6b380] die at ffff00008008f6ac
>>>   #4 [ffff0000b4d6b3d0] bug_handler at ffff00008008f744
>>>   #5 [ffff0000b4d6b400] brk_handler at ffff000080085d1c
>>>   #6 [ffff0000b4d6b420] do_debug_exception at ffff000080081194
>>>   #7 [ffff0000b4d6b630] el1_dbg at ffff00008008332c
>>>       PC: ffff00000190e9c0  [_ocfs2_free_suballoc_bits+1608]
>>>       LR: ffff00000190e990  [_ocfs2_free_suballoc_bits+1560]
>>>       SP: ffff0000b4d6b640  PSTATE: 60400009
>>>      X29: ffff0000b4d6b650  X28: 0000000000000000  X27: 00000000000052f3
>>>      X26: ffff807c511a9570  X25: ffff807ca0054000  X24: 00000000000052f2
>>>      X23: 0000000000000001  X22: ffff807c7cde7a90  X21: ffff0000811d9000
>>>      X20: ffff807c5e7d2000  X19: ffff00000190c768  X18: 0000000000000000
>>>      X17: 0000000000000000  X16: ffff000080a032f0  X15: 0000000000000000
>>>      X14: ffffffffffffffff  X13: fffffffffffffff7  X12: ffffffffffffffff
>>>      X11: 0000000000000038  X10: 0101010101010101   X9: ffffffffffffffff
>>>       X8: 7f7f7f7f7f7f7f7f   X7: 0000000000000000   X6: 0000000000000080
>>>       X5: 0000000000000000   X4: 0000000000000002   X3: ffff00000199f390
>>>       X2: a603c08321456e00   X1: ffff807c7cde7a90   X0: 0000000000000000
>>>   #8 [ffff0000b4d6b650] _ocfs2_free_suballoc_bits at ffff00000190e9bc [ocfs2]
>>>   #9 [ffff0000b4d6b710] _ocfs2_free_clusters at ffff0000019110d4 [ocfs2]
>>>  #10 [ffff0000b4d6b790] ocfs2_free_clusters at ffff000001913e94 [ocfs2]
>>>  #11 [ffff0000b4d6b7d0] __ocfs2_flush_truncate_log at ffff0000018b5294 [ocfs2]
>>>  #12 [ffff0000b4d6b8a0] ocfs2_remove_btree_range at ffff0000018bb34c [ocfs2]
>>>  #13 [ffff0000b4d6b960] ocfs2_commit_truncate at ffff0000018bc76c [ocfs2]
>>>  #14 [ffff0000b4d6ba60] ocfs2_wipe_inode at ffff0000018e57bc [ocfs2]
>>>  #15 [ffff0000b4d6bb00] ocfs2_evict_inode at ffff0000018e5db8 [ocfs2]
>>>  #16 [ffff0000b4d6bb70] evict at ffff000080365040
>>>  #17 [ffff0000b4d6bba0] iput at ffff0000803655d8
>>>  #18 [ffff0000b4d6bbe0] ocfs2_dentry_iput at ffff0000018c60a0 [ocfs2]
>>>  #19 [ffff0000b4d6bc30] dentry_unlink_inode at ffff00008035ef58
>>>  #20 [ffff0000b4d6bc50] __dentry_kill at ffff000080360384
>>>  #21 [ffff0000b4d6bc80] dentry_kill at ffff000080360670
>>>  #22 [ffff0000b4d6bcb0] dput at ffff00008036093c
>>>  #23 [ffff0000b4d6bcf0] __fput at ffff000080343930
>>>  #24 [ffff0000b4d6bd40] ____fput at ffff000080343aac
>>>  #25 [ffff0000b4d6bd60] task_work_run at ffff0000801172fc
>>>
>>> The direct panic reason is that bh2jh (group_bh)-> b_committed_data is null.
>>> It is presumed that the network was disconnected during the write process,
>>> causing the transaction abort. as follows:
>>> jbd2_journal_abort
>>>   .......
>>>   jbd2_journal_commit_transaction
>>>     jh->b_committed_data = NULL;
>>>
>>> _ocfs2_free_suballoc_bits
>>>   ocfs2_block_group_clear_bits
>>>     // undo_bg is now set to null
>>>     BUG_ON(!undo_bg);
>>>
>>> When applying for free space, if b_committed_data is null,
>>> it will be directly occupied, as follows:
>>> ocfs2_cluster_group_search
>>>   ocfs2_block_group_find_clear_bits
>>>     ocfs2_test_bg_bit_allocatable:
>>>       bg = (struct ocfs2_group_desc *) bh2jh(bg_bh)->b_committed_data;
>>>       if (bg)
>>>         ret = !ocfs2_test_bit(nr, (unsigned long *)bg->bg_bitmap);
>>>       else
>>>         ret = 1;
>>> b_committed_data is an intermediate state backup for bitmap transaction commits,
>>> newly applied space can overwrite previous dirty data,
>>> so, I think, while free clusters, if b_committed_data is null, ignore it.
>>> Host panic directly, too violent.
>>>
>>> Signed-off-by: Shan Li <lishan24@huawei.com>
>>> Reviewed-by: Jun Piao <piaojun@huawei.com>
>>> ---
>>>  fs/ocfs2/suballoc.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
>>> index 939df99d2dec..aaf1b3cbd984 100644
>>> --- a/fs/ocfs2/suballoc.c
>>> +++ b/fs/ocfs2/suballoc.c
>>> @@ -2412,14 +2412,19 @@ static int ocfs2_block_group_clear_bits(handle_t *handle,
>>>  	if (undo_fn) {
>>>  		spin_lock(&jh->b_state_lock);
>>>  		undo_bg = (struct ocfs2_group_desc *) jh->b_committed_data;
>>> -		BUG_ON(!undo_bg);
>>> +		if (!undo_bg)
>>> +			mlog(ML_NOTICE, "%s: group descriptor # %llu (device %s) journal "
>>> +					"b_committed_data had been cleared.\n",
>>> +					OCFS2_SB(alloc_inode->i_sb)->uuid_str,
>>> +					(unsigned long long)le64_to_cpu(bg->bg_blkno),
>>> +					alloc_inode->i_sb->s_id);
>>
>> Seems a kind of workaround.
>> I am worrying about other abnormal cases of NULL b_committed_data, it
>> may lead to a corrupt filesystem.
>> So how about isolating the journal abort case?
>>
>> Thanks,
>> Joseph
>>
>>>  	}
>>>
>>>  	tmp = num_bits;
>>>  	while(tmp--) {
>>>  		ocfs2_clear_bit((bit_off + tmp),
>>>  				(unsigned long *) bg->bg_bitmap);
>>> -		if (undo_fn)
>>> +		if (undo_fn && undo_bg)
>>>  			undo_fn(bit_off + tmp,
>>>  				(unsigned long *) undo_bg->bg_bitmap);
>>>  	}
>>>
>>
>> .
>>

