Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477E2CBC48
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgLBMC0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 07:02:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8231 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgLBMC0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 07:02:26 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CmHcN6fK4zkkWH;
        Wed,  2 Dec 2020 20:01:08 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 2 Dec 2020 20:01:39 +0800
Subject: Re: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to
 update log tail info when load journal
To:     Likai <li.kai4@h3c.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>
References: <20200111022542.5008-1-li.kai4@h3c.com>
 <20200114103119.GE6466@quack2.suse.cz> <20200117212657.GF448999@mit.edu>
 <453bb3b47a214a429abb5c2e38c494c8@h3c.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "gechangwei@live.cn" <gechangwei@live.cn>,
        Wangyong <wang.yongD@h3c.com>, Wangxibo <wang.xibo@h3c.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <5FC78223.8070000@huawei.com>
Date:   Wed, 2 Dec 2020 20:01:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <453bb3b47a214a429abb5c2e38c494c8@h3c.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Have you really encountered the problem of file system inconsistency 
caused by non-replay of logs?

(1) if (needs_recovery==0)
      jbd2_journal_wipe will call jbd2_mark_journal_empty to update 
s_start and s_sequence.

(2) if (needs_recovery == 1)
   ext4_fill_super:
......
   if (needs_recovery) {
          ext4_msg(sb, KERN_INFO, "recovery complete");
          ext4_mark_recovery_complete(sb, es);    -->Will update s_start 
and s_sequence
  }
......
   Recently, I encountered the problem of inconsistent file system data, 
which may be
caused by the log not replaying during fsck. But according to the 
description of your
patch, the s_start and the  s_sequence will all be updated.
   Therefore, I doubt whether the problem you described really exists.


On 2020/1/20 14:30, Likai wrote:
> On 2020/1/18 5:27, Theodore Y. Ts'o wrote:
>> On Tue, Jan 14, 2020 at 11:31:19AM +0100, Jan Kara wrote:
>>> Thanks for the patch! Just some small comments below:
>>>
>>> On Sat 11-01-20 10:25:42, Kai Li wrote:
>>>> Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"
>>> This tag should come at the bottom of the changelog (close to your
>>> Signed-off-by).
>>>
>>>> If journal is dirty when mount, it will be replayed but jbd2 sb
>>>> log tail cannot be updated to mark a new start because
>>>> journal->j_flags has already been set with JBD2_ABORT first
>>>> in journal_init_common.
>>>> When a new transaction is committed, it will be recorded in block 1
>>>> first(journal->j_tail is set to 1 in journal_reset). If emergency
>>>> restart again before journal super block is updated unfortunately,
>>>> the new recorded trans will not be replayed in the next mount.
>>>> It is danerous which may lead to metadata corruption for file system.
>>> I'd slightly rephrase the text here so that it is more easily readable and
>>> correct some grammar mistakes. Something like:
>>>
>>> If the journal is dirty when the filesystem is mounted, jbd2 will replay
>>> the journal but the journal superblock will not be updated by
>>> journal_reset() because JBD2_ABORT flag is still set (it was set in
>>> journal_init_common()). This is problematic because when a new transaction
>>> is then committed, it will be recorded in block 1 (journal->j_tail was set
>>> to 1 in journal_reset()). If unclean shutdown happens again before the
>>> journal superblock is updated, the new recorded transaction will not be
>>> replayed during the next mount (because of stale sb->s_start and
>>> sb->s_sequence values) which can lead to filesystem corruption.
>>>
>>> Otherwise the patch looks good to me so feel free to add:
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>>
>>> (again this is added to the bottom of the changelog like the 'Fixes' tag or
>>> 'Signed-off-by' tag).
>> Thanks, applied with a fixed up commit description.
>>
>> 		       	     	       - Ted
>>
> Sorry for reply so late due to my business trip recently.  This new
> comment is ok and more clear. Thanks.
>
>                                                                         
>                                                                         
>        - Kai
>
> .
>

