Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD77310DDE4
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2019 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfK3Oua (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Nov 2019 09:50:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbfK3Ou3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 30 Nov 2019 09:50:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C56233B173EF51170D9B;
        Sat, 30 Nov 2019 22:50:18 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 30 Nov 2019
 22:50:09 +0800
Subject: Re: [PATCH] ext4, jbd2: ensure panic when there is no need to record
 errno in the jbd2 sb
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     Jan Kara <jack@suse.cz>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <jack@suse.com>,
        <adilger.kernel@dilger.ca>, <liangyun2@huawei.com>
References: <20191126144537.30020-1-yi.zhang@huawei.com>
 <20191129144611.GA27588@quack2.suse.cz>
 <0aa529fe-a881-aa4c-3b8f-980c8eceb64b@huawei.com>
Message-ID: <a63cb7ea-8b39-df86-583b-e5af03a157fe@huawei.com>
Date:   Sat, 30 Nov 2019 22:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0aa529fe-a881-aa4c-3b8f-980c8eceb64b@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/11/30 11:24, zhangyi (F) wrote:
> On 2019/11/29 22:46, Jan Kara wrote:
>> On Tue 26-11-19 22:45:37, zhangyi (F) wrote:
>>> JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
>>> aborted, and then __ext4_abort() and ext4_handle_error() can invoke
>>> panic if ERRORS_PANIC is specified. But there is one exception, if jbd2
>>> thread failed to submit commit record, it abort journal through
>>> invoking __jbd2_journal_abort_hard() without set this flag, so we can
>>> no longer panic. Fix this by set such flag even if there is no need to
>>> record errno in the jbd2 super block.
>>>
>>> Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
>>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>>> Cc: <stable@vger.kernel.org>
>>
>> Thanks for the patch. This indeed looks like a bug. I was trying hard to
>> understand why are we actually using __jbd2_journal_abort_hard() in
>> fs/jbd2/commit.c in the first place. And after some digging, I think it is
>> an oversight and we should just use jbd2_journal_abort(). The calls have been
>> introduced by commit 818d276ceb83a "ext4: Add the journal checksum
>> feature". Before that commit, we were just using jbd2_journal_abort() when
>> writing commit block failed. And when we use jbd2_journal_abort() from
>> everywhere, that will also deal with the problem you've found.
>>
>> Also as a nice cleanup we could then just drop __jbd2_journal_abort_hard(),
>> __jbd2_journal_abort_soft() and have all the functionality in a single
>> function jbd2_journal_abort().
>>
> 
> Indeed, it seems that we also need to record the errno if we failed to
> submit commit block, I will remove __jbd2_journal_abort_hard() and combine
> them in my next iteration.
> 

Hi Ted and Jan,
I am confusing about the commit fb7c02445c49 "ext4: pass
-ESHUTDOWN code to jbd2 layer" when I trying to cleanup the
__journal_abort_soft() and __jbd2_journal_abort_hard().

Before this commit, we will not record the errno if we shutdown the
filesystem no matter it has been aborted or not, so the errno will not
change.
After this commit, we record 0 to "sb->s_errno" for the first
jbd2_journal_abort(-ESHUTDOWN), and we also do not update the errno
if it has been aborted and record a no-zero errno because of the
follow checking.

+       if (journal->j_flags & JBD2_ABORT) {
+               write_unlock(&journal->j_state_lock);
+               if (!old_errno && old_errno != -ESHUTDOWN &&
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+                   errno == -ESHUTDOWN)
+                       jbd2_journal_update_sb_errno(journal);
+               return;
+       }

So the only modification of this patch is:
1) fix the lock;
2) set journal->j_errno = -ESHUTDOWN and JBD2_REC_ERR flag when we
   invoke jbd2_journal_abort(-ESHUTDOWN). These two modifications
   do not relate to the git log you mentioned.

I guess do you want to mean
  if (old_errno && old_errno != -ESHUTDOWN && errno == -ESHUTDOWN) ?

If so, why we need to overwrite the last aborted errno to 0,
if the filesystem was already aborted for some reasons, will
it cover up the issue? Am I miss something?

Thanks,
Yi.

