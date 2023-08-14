Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E977B0D1
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Aug 2023 07:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjHNFgh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Aug 2023 01:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjHNFgH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Aug 2023 01:36:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55FE6A;
        Sun, 13 Aug 2023 22:36:05 -0700 (PDT)
Received: from [192.168.164.158] (unknown [116.71.172.205])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73708660705E;
        Mon, 14 Aug 2023 06:36:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691991364;
        bh=nLnbezrLbPR5RoJdshRlKgiF8rUE9mLIpaRXSjjmjew=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=fp5tmCr/XWFz8lxF7z72ES7J+e0hUHl5fMK9E3GrdJgTwxhHo5Gq+BW312AdUWYMo
         Dv2hnGYvDG+++dQXcsQvgKmRFewIqwBbyjvZeaSkb5+Ou8BX7iRSVMdUWY09Ubb5ap
         Zu4ELyZpcySE8eOL9s14TlsHu1aqQCVhXEk2priJqaHOgrp+jHcy9h+t5Lq6rpHyV2
         BrH+OgXHhQRfKhWqp3C2LVnZJbq9lV/V9EdRTwsqNAC5NVjWNmXEtLWf9xcKY6Aiqn
         xtiIc2o63Qvz164peNAd602XOn3+piz3+VfPC28DrTGIh7UUAl2E+wfdLLwLbn4ZQy
         enB4/096uHgNQ==
Message-ID: <0fc2546b-da7c-aac4-b402-3ef4970a1789@collabora.com>
Date:   Mon, 14 Aug 2023 10:35:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>,
        regressions@lists.linux.dev, Baokun Li <libaokun1@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: Re: [v6.1] kernel BUG in ext4_writepages
Content-Language: en-US
To:     syzbot <syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com>,
        syzkaller-lts-bugs@googlegroups.com
References: <00000000000081f8c905f6c24e0d@google.com>
 <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
 <4637f58c-1cf3-0691-4fc1-6fbc38ec47ce@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <4637f58c-1cf3-0691-4fc1-6fbc38ec47ce@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/14/23 10:31 AM, Muhammad Usama Anjum wrote:
> On 8/10/23 3:49 PM, Muhammad Usama Anjum wrote:
>> Hi,
>>
>> Syzbot has reporting hitting this bug on 6.1.18 and 5.15.101 LTS kernels
>> and provided reproducer as well.
>>
>> 	BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA));
>>
>> I've copied the same config and reproduced the bug on 6.1.18, 6.1.44 and
>> next-20230809.
>>
>> This part of code hasn't been changed from the time it was introduced
>> 4e7ea81db53465 ("ext4: restructure writeback path"). I'm not sure why the
>> inlined data is being destroyed before copying it somewhere else.
>>
>> Please consider this a report.
>>
>> Regards,
>> Muhammad Usama Anjum
>>
>>
>> On 3/13/23 11:34 AM, syzbot wrote:
>>> syzbot has found a reproducer for the following issue on:
>>>
>>> HEAD commit: 1cc3fcf63192 Linux 6.1.18
>>> git tree: linux-6.1.y
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=10d4b342c80000
>>> kernel config: https://syzkaller.appspot.com/x/.config?x=157296d36f92ea19
>> ^ Kernel config
>>
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=a8068dd81edde0186829
>>> compiler: Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>>> userspace arch: arm64
>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=13512ec6c80000
>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=15ca0ff4c80000
>> ^ reproducers. C reproducer reproduces the bug easily.
>>
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/0e4c0d43698b/disk-1cc3fcf6.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/a4de39d735de/vmlinux-1cc3fcf6.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/82bab928f6e3/Image-1cc3fcf6.gz.xz
>>> mounted in repro: https://storage.googleapis.com/syzbot-assets/bf2e21b96210/mount_0.gz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com
>>>
>>> ------------[ cut here ]------------
>>> kernel BUG at fs/ext4/inode.c:2746!
>>> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>> Modules linked in:
>>> CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.18-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
>>> Workqueue: writeback wb_workfn (flush-7:0)
>>> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>> pc : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>>> lr : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>>> sp : ffff800019d16d40
>>> x29: ffff800019d17120 x28: ffff800008e691e4 x27: dfff800000000000
>>> x26: ffff0000de1f3ee0 x25: ffff800019d17590 x24: ffff800019d17020
>>> x23: ffff0000dd616000 x22: ffff800019d16f40 x21: ffff0000de1f4108
>>> x20: 0000008410000000 x19: 0000000000000001 x18: ffff800019d16a20
>>> x17: ffff80001572d000 x16: ffff8000083099b4 x15: 000000000000ba31
>>> x14: 00000000ffffffff x13: dfff800000000000 x12: 0000000000000001
>>> x11: ff80800008e6c7d8 x10: 0000000000000000 x9 : ffff800008e6c7d8
>>> x8 : ffff0000c099b680 x7 : 0000000000000000 x6 : 0000000000000000
>>> x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000001
>>> x2 : 0000000000000000 x1 : 0000008000000000 x0 : 0000000000000000
>>> Call trace:
>>> ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
>>> do_writepages+0x2e8/0x56c mm/page-writeback.c:2469
>>> __writeback_single_inode+0x228/0x1ec8 fs/fs-writeback.c:1587
>>> writeback_sb_inodes+0x9c0/0x1844 fs/fs-writeback.c:1878
>>> wb_writeback+0x4f8/0x1580 fs/fs-writeback.c:2052
>>> wb_do_writeback fs/fs-writeback.c:2195 [inline]
>>> wb_workfn+0x460/0x11b8 fs/fs-writeback.c:2235
>>> process_one_work+0x868/0x16f4 kernel/workqueue.c:2289
>>> worker_thread+0x8e4/0xfec kernel/workqueue.c:2436
>>> kthread+0x24c/0x2d4 kernel/kthread.c:376
>>> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>>> Code: d4210000 97da5cfa d4210000 97da5cf8 (d4210000)
>>> ---[ end trace 0000000000000000 ]---
>>>
>>>
> 
> The last refactoring was done by 4e7ea81db53465 on this code in 2013. The
> code segment in question is present from even before that. It means that
> this bug is present for several years. 4.14 is the most old kernel being
> maintained today. So it affects all current LTS and mainline kernels. I'll
> report 4e7ea81db53465 with regzbot for proper tracking. Thus probably the
> bug report will get associated with all LTS kernels as well.
> 
> #regzbot title: Race condition between buffer write and page_mkwrite

#regzbot title: ext4: Race condition between buffer write and page_mkwrite

> 
> #regzbot introduced: 4e7ea81db53465
> 
> #regzbot monitor:
> https://lore.kernel.org/all/20230530134405.322194-1-libaokun1@huawei.com
> 

-- 
BR,
Muhammad Usama Anjum
