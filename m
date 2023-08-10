Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9C777640
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Aug 2023 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHJKt4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Aug 2023 06:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjHJKtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Aug 2023 06:49:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48FB2127;
        Thu, 10 Aug 2023 03:49:50 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.230])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C2E46607226;
        Thu, 10 Aug 2023 11:49:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691664589;
        bh=2DHTnt0ykY9ysNtT/x/1b9zKTmFg8gH3BLKxpnIDOD0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=YikP6BV5qWCfRmdN6ZPVjujftznapPz57ClZ/HXZvE1TYTx/xn7HKPSHDJ40lrj0I
         LcyulQ/mELfZ4eMaWZDheYfI7t968zoPcv6gTOEpbaq2bxs+RkBTKaN2FMyhbdVO6N
         ItkxKFk0Y7yP0InnhjOm4IYlFBam4iZIfyomrjMXVqZVIY45Z9WoSykBG8jxfiVje5
         b+ifToyPACdWOKO2l+Aa99WBTRdrsy7/ejwiF+37kar8tWhbc8K6PCsbcx3KFxWiBp
         VfYOHM+AGWRT8Qi0yYSmCx0NOb1erdcaU4oCphb7w4oNXxGigU8XJM9p8FLeXXijb2
         zn3VUz3e4xaBQ==
Message-ID: <87dcdf62-8a74-1fbf-5f10-f4f3231f774f@collabora.com>
Date:   Thu, 10 Aug 2023 15:49:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>
Subject: Re: [v6.1] kernel BUG in ext4_writepages
To:     syzbot <syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com>,
        syzkaller-lts-bugs@googlegroups.com, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <00000000000081f8c905f6c24e0d@google.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <00000000000081f8c905f6c24e0d@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Syzbot has reporting hitting this bug on 6.1.18 and 5.15.101 LTS kernels
and provided reproducer as well.

	BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA));

I've copied the same config and reproduced the bug on 6.1.18, 6.1.44 and
next-20230809.

This part of code hasn't been changed from the time it was introduced
4e7ea81db53465 ("ext4: restructure writeback path"). I'm not sure why the
inlined data is being destroyed before copying it somewhere else.

Please consider this a report.

Regards,
Muhammad Usama Anjum


On 3/13/23 11:34 AM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit: 1cc3fcf63192 Linux 6.1.18
> git tree: linux-6.1.y
> console output: https://syzkaller.appspot.com/x/log.txt?x=10d4b342c80000
> kernel config: https://syzkaller.appspot.com/x/.config?x=157296d36f92ea19
^ Kernel config

> dashboard link: https://syzkaller.appspot.com/bug?extid=a8068dd81edde0186829
> compiler: Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=13512ec6c80000
> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=15ca0ff4c80000
^ reproducers. C reproducer reproduces the bug easily.

> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0e4c0d43698b/disk-1cc3fcf6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a4de39d735de/vmlinux-1cc3fcf6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/82bab928f6e3/Image-1cc3fcf6.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/bf2e21b96210/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a8068dd81edde0186829@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inode.c:2746!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 11 Comm: kworker/u4:1 Not tainted 6.1.18-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> Workqueue: writeback wb_workfn (flush-7:0)
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
> lr : ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
> sp : ffff800019d16d40
> x29: ffff800019d17120 x28: ffff800008e691e4 x27: dfff800000000000
> x26: ffff0000de1f3ee0 x25: ffff800019d17590 x24: ffff800019d17020
> x23: ffff0000dd616000 x22: ffff800019d16f40 x21: ffff0000de1f4108
> x20: 0000008410000000 x19: 0000000000000001 x18: ffff800019d16a20
> x17: ffff80001572d000 x16: ffff8000083099b4 x15: 000000000000ba31
> x14: 00000000ffffffff x13: dfff800000000000 x12: 0000000000000001
> x11: ff80800008e6c7d8 x10: 0000000000000000 x9 : ffff800008e6c7d8
> x8 : ffff0000c099b680 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000008000000000 x0 : 0000000000000000
> Call trace:
> ext4_writepages+0x35f4/0x35f8 fs/ext4/inode.c:2745
> do_writepages+0x2e8/0x56c mm/page-writeback.c:2469
> __writeback_single_inode+0x228/0x1ec8 fs/fs-writeback.c:1587
> writeback_sb_inodes+0x9c0/0x1844 fs/fs-writeback.c:1878
> wb_writeback+0x4f8/0x1580 fs/fs-writeback.c:2052
> wb_do_writeback fs/fs-writeback.c:2195 [inline]
> wb_workfn+0x460/0x11b8 fs/fs-writeback.c:2235
> process_one_work+0x868/0x16f4 kernel/workqueue.c:2289
> worker_thread+0x8e4/0xfec kernel/workqueue.c:2436
> kthread+0x24c/0x2d4 kernel/kthread.c:376
> ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Code: d4210000 97da5cfa d4210000 97da5cf8 (d4210000)
> ---[ end trace 0000000000000000 ]---
> 
> 

-- 
BR,
Muhammad Usama Anjum
