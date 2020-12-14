Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4932D918F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 02:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437707AbgLNB16 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Dec 2020 20:27:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9434 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731697AbgLNB16 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Dec 2020 20:27:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CvNyv0NthzhrwC;
        Mon, 14 Dec 2020 09:26:47 +0800 (CST)
Received: from [10.174.177.113] (10.174.177.113) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 14 Dec 2020 09:27:05 +0800
Subject: Re: [PATCH] e2fsck: Avoid changes on recovery flags when
 jbd2_journal_recover() failed
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>, <tytso@alum.mit.edu>,
        <liangyun2@huawei.com>
References: <1bb3c556-4635-061b-c2dc-df10c15e6398@huawei.com>
 <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
From:   Haotian Li <lihaotian9@huawei.com>
Message-ID: <3e3c18f6-9f45-da04-9e81-ebf1ae16747e@huawei.com>
Date:   Mon, 14 Dec 2020 09:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <CAD+ocbxAyyFqoD6AYQVjQyqFzZde3+QOnUhC-VikAq4A3_t8JA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.113]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Harshad,

Thanks for your review. I think you are right, so I try to find
all the recoverable err_codes in journal recovery. But I have no
idea to distinguish all the err_codes. Only the following three
err_codes I think may be recoverable. -ENOMEM,EXT2_ET_NO_MEMORY
,-EIO. In these cases, I think we probably don't need ask user if
they want to continue or not, only tell them why journal recover
failed and exit instead. Because, the reason cause these cases
may not disk errors, we need try to avoid the changes on the disk.
What do you think?

Thanks,
Haotian

在 2020/12/12 6:07, harshad shirwadkar 写道:
> Hi Haotian,
> 
> Thanks for your patch. I noticed that the following test fails:
> 
> $ make -j 64
> ...
> 365 tests succeeded     1 tests failed
> Tests failed: j_corrupt_revoke_rcount
> make: *** [Makefile:397: test_post] Error 1
> 
> This test fails because the test expects e2fsck to continue even if
> the journal superblock is corrupt and with your patch e2fsck exits
> immediately. This brings up a higher level question - if we abort on
> errors when recovery fails during fsck, how would that problem get
> fixed if we don't run fsck? In this particular example, the journal
> superblock is corrupt and that is an unrecoverable error. I wonder if
> instead we should check for certain specific transient errors such as
> -ENOMEM and only then exit? I suspect even in those cases we probably
> should ask the user if they would like to continue or not. What do you
> think?
> 
> Thanks,
> Harshad
> 
> 
> On Fri, Dec 11, 2020 at 4:19 AM Haotian Li <lihaotian9@huawei.com> wrote:
>>
>> jbd2_journal_revocer() may fail when some error occers
>> such as ENOMEM. However, jsb->s_start is still cleared
>> by func e2fsck_journal_release(). This may break
>> consistency between metadata and data in disk. Sometimes,
>> failure in jbd2_journal_revocer() is temporary but retry
>> e2fsck will skip the journal recovery when the temporary
>> problem is fixed.
>>
>> To fix this case, we use "fatal_error" instead "goto errout"
>> when recover journal failed. We think if journal recovery
>> fails, we need send error message to user and reserve the
>> recovery flags to recover the journal when try e2fsck again.
>>
>> Reported-by: Liangyun <liangyun2@huawei.com>
>> Signed-off-by: Haotian Li <lihaotian9@huawei.com>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>> ---
>>  e2fsck/journal.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
>> index 7d9f1b40..546beafd 100644
>> --- a/e2fsck/journal.c
>> +++ b/e2fsck/journal.c
>> @@ -952,8 +952,13 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
>>                 goto errout;
>>
>>         retval = -jbd2_journal_recover(journal);
>> -       if (retval)
>> -               goto errout;
>> +       if (retval && retval != EFSBADCRC && retval != EFSCORRUPTED) {
>> +               ctx->fs->flags &= ~EXT2_FLAG_VALID;
>> +               com_err(ctx->program_name, 0,
>> +                                       _("Journal recovery failed "
>> +                                         "on %s\n"), ctx->device_name);
>> +               fatal_error(ctx, 0);
>> +       }
>>
>>         if (journal->j_failed_commit) {
>>                 pctx.ino = journal->j_failed_commit;
>> --
>> 2.19.1
>>
> .
> 
