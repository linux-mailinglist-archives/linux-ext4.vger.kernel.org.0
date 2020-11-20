Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9292BA0A7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 03:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgKTCy1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Nov 2020 21:54:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8558 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTCy1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Nov 2020 21:54:27 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cch2b4lMLzLqBb;
        Fri, 20 Nov 2020 10:53:59 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 10:54:11 +0800
Subject: Re: [Bug report] journal data mode trigger panic in
 jbd2_journal_commit_transaction
To:     Mauricio Oliveira <mauricio.oliveira@canonical.com>
CC:     "Theodore Y . Ts'o" <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        <zhangxiaoxu5@huawei.com>, Ye Bin <yebin10@huawei.com>,
        <hejie3@huawei.com>
References: <68b9650e-bef2-69e2-ab5e-8aaddaf46cfe@huawei.com>
 <CAO9xwp12E1wjErfX-Ef6+OKnme_ENOx22Hh=44g9cLn7aBr3-w@mail.gmail.com>
 <c4c16548-1f37-a63e-de38-de5812bcc97e@huawei.com>
 <CAO9xwp37T_pDohXYOpHhb-KhDYUBEMR0qDN0NJvCLRUoG3CK2Q@mail.gmail.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <17d7ecde-5fda-cd03-6fef-e7b8250489f9@huawei.com>
Date:   Fri, 20 Nov 2020 10:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAO9xwp37T_pDohXYOpHhb-KhDYUBEMR0qDN0NJvCLRUoG3CK2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2020/11/19 21:12, Mauricio Oliveira 写道:
> On Thu, Nov 19, 2020 at 1:25 AM yangerkun <yangerkun@huawei.com> wrote:
>>
>>
>>
>> 在 2020/11/16 21:50, Mauricio Oliveira 写道:
>>> Hi Kun,
>>>
>>> On Sat, Nov 14, 2020 at 5:18 AM yangerkun <yangerkun@huawei.com> wrote:
>>>> While using ext4 with data=journal(3.10 kernel), we meet a problem that
>>>> we think may never happend...
>>> [...]
>>>
>>> Could you please confirm you mean 5.10-rc* kernel instead of 3.10?
>>> (It seems so as you mention a recent commit below.)  Thanks!
>>>
>>>> For now, what I have seen that can dirty buffer directly is
>>>> ext4_page_mkwrite(64a9f1449950 ("ext4: data=journal: fixes for
>>>> ext4_page_mkwrite()")), and runing ext4_punch_hole with keep_size
>>>> /ext4_page_mkwrite parallel can trigger above warning easily.
>>> [...]
>>>
>>>
>>
>> Hi,
>>
>> Sorry for the long delay reply... And thanks a lot for your advise! The
>> bug trigger with a very low probability. So won't trigger with 5.10 can
>> not prove no bug exist in 5.10.
>>
> 
> No worries, and thanks for following up.
> So I understand that the bug report was indeed on 3.10, and 5.10-rcN
> is not yet confirmed.
> 
>> Google a lot and notice that someone before has report the same bug[1].
>> '3b136499e906 ("ext4: fix data corruption in data=journal mode")' seems
>> fix the problem. I will try to understand this, and give a analysis
>> about how to reproduce it!
> 
> Cool, thanks!
> 
>> Thanks,
>> Kun.
> 
> 
> 
Hi,

The follow step can reproduce the bug[1] reported before easily. And the 
bug we meet seems same. Following patch will fix the bug.

3b136499e906 ext4: fix data corruption in data=journal mode
b90197b65518 ext4: use private version of page_zero_new_buffers() for 
data=journal mode


1. mkfs.ext4
2. touch $tofile(ino == 12)
3. touch $fromfile(ino == 13) and write 4k to fromfile and sync

mmap $fromfile 4k
and write 4k
to $tofile

...
generic_perform_write
  ext4_write_begin
   ext4_journal_start
   (trans 1)
  if (ino == 12) sleep for 30s
  ...                           truncate $fromfile
                                to 0
  copied=0,bytes=4k
  ext4_journalled_write_end
   page_zero_new_buffers
    mark_buffer_dirty
   write_end_fn
    ...
    __jbd2_journal_file_buffer
     test_clear_buffer_dirty
     __jbd2_journal_temp_unlink_buffer
   ext4_journal_stop
   (trans 1)
                                                  trans1 commit
                                                  ...
   ext4_truncate_failed_write
    ...
    journal_unmap_buffer
     set_buffer_freed
                                                  forget list
                                                   ...
                                                   clear_buffer_jbddirty
                                                   ...
                                                   J_ASSERT_BH(bh,
                                                   !buffer_dirty(bh))
                                                   ^^^^^^^^^^^^^^^^^
                                                   trigger the bug...



[1]. https://www.spinics.net/lists/linux-ext4/msg56447.html

Thanks,
Kun.
