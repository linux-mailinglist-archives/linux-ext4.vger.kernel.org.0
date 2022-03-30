Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670864ED04E
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 01:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351857AbiC3XqU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Mar 2022 19:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbiC3XqT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Mar 2022 19:46:19 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2961437A34
        for <linux-ext4@vger.kernel.org>; Wed, 30 Mar 2022 16:44:32 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22UNhb9r030571;
        Thu, 31 Mar 2022 08:43:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Thu, 31 Mar 2022 08:43:37 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22UNhbP8030567
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 31 Mar 2022 08:43:37 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <688b3c92-e9aa-f506-a288-646c5477f6df@I-love.SAKURA.ne.jp>
Date:   Thu, 31 Mar 2022 08:43:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [syzbot] possible deadlock in p9_write_work
Content-Language: en-US
To:     "Perepechko, Andrew" <andrew.perepechko@hpe.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>,
        syzbot <syzbot+bde0f89deacca7c765b8@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
References: <0000000000009523b605db620972@google.com>
 <385ce718-f965-4005-56b6-34922c4533b8@I-love.SAKURA.ne.jp>
 <YkObebLZMp5AyRpr@codewreck.org>
 <fb5d20c5-36a6-2c51-288a-7cc1e0a76d3e@I-love.SAKURA.ne.jp>
 <YkPAkXVc4HZLUrGl@codewreck.org>
 <f593d3ac-b28e-3593-3cd8-8983b27e47a7@I-love.SAKURA.ne.jp>
 <PH7PR84MB167995181252E4B7E4541B64F51F9@PH7PR84MB1679.NAMPRD84.PROD.OUTLOOK.COM>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <PH7PR84MB167995181252E4B7E4541B64F51F9@PH7PR84MB1679.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello.

Since "ext4: truncate during setxattr leads to kernel panic" did not choose
per-superblock WQ, ext4_put_super() for some ext4 superblock currently waits
for completion of iput() from delayed_iput_fn() from delayed_iput() from
ext4_xattr_set_entry() from all ext4 superblocks (in addition to other tasks
scheduled by unrelated subsystems).

If ext4_put_super() for some superblock wants to wait for only works from that
superblock, please use per-superblock WQ. Creating per-superblock WQ via
alloc_workqueue() without WQ_MEM_RECLAIM flag will not consume much resource.

If ext4_put_super() for some superblock can afford waiting for iput() from
other ext4 superblocks, you can use per-filesystem WQ.

On 2022/03/31 1:56, Perepechko, Andrew wrote:
> Hello Tetsuo!
> 
> Thank you for your report.
> 
> I wonder if I can fix this issue by creating a separate per-superblock workqueue.
> 
> I may not fully understand the lockdep magic in process_one_work() so any advice is appreciated.
> 
> As I see it, if there's no shared locking between different workqueues, unmount should be able to flush only its own scheduled tasks (which should not conflict with any p9 tasks) and unblock the locking chain under similar conditions.
> 
> Thank you,
> Andrew
> ________________________________
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Sent: 30 March 2022 05:49
> To: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Perepechko, Andrew <andrew.perepechko@hpe.com>; Andreas Dilger <adilger@dilger.ca>; Theodore Ts'o <tytso@mit.edu>; syzbot <syzbot+bde0f89deacca7c765b8@syzkaller.appspotmail.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; syzkaller-bugs@googlegroups.com <syzkaller-bugs@googlegroups.com>; v9fs-developer@lists.sourceforge.net <v9fs-developer@lists.sourceforge.net>; open list:EXT4 FILE SYSTEM <linux-ext4@vger.kernel.org>
> Subject: Re: [syzbot] possible deadlock in p9_write_work
> 
> On 2022/03/30 11:29, Dominique Martinet wrote:
>> Tetsuo Handa wrote on Wed, Mar 30, 2022 at 10:57:15AM +0900:
>>>>> Please don't use schedule_work() if you need to use flush_scheduled_work().
>>>>
>>>> In this case we don't call flush_scheduled_work -- ext4 does.
>>>
>>> Yes, that's why I changed recipients to ext4 people.
>>
>> Sorry, I hadn't noticed.
>> 9p is the one calling schedule_work, so ultimately it really is the
>> combinaison of the two, and not just ext4 that's wrong here.
> 
> Calling schedule_work() itself does not cause troubles (unless there are
> too many pending works to make progress). Calling flush_scheduled_work()
> causes troubles because it waits for completion of all works even if
> some of works cannot be completed due to locks held by the caller of
> flush_scheduled_work(). 9p is innocent for this report.
> 
> 

