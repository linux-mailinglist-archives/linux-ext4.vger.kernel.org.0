Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5AA1F781B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLMu2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 08:50:28 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40919 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgFLMu1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Jun 2020 08:50:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 948605C016C;
        Fri, 12 Jun 2020 08:50:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 12 Jun 2020 08:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IvXvnc
        vpnabP2EIAHZZHp11K503gFJ2zV9fFie1Cj6I=; b=h7ovUA5/D0HmSQNTyyKWCK
        qikuYqHkdyDj30R/zu4aFncETSYE10AFWRtka5iYW4U+Ig5bv6N2WawhwxRRJzj5
        mc1bmOOcsS0ezZd25jXBvxgv7NZh0zX6ZOHIaE9szJ8Elg3ChQqk9xfBsdoIlcb1
        9dmD547Rp0fpVJsETb20/fskJHL4KAP95lZMmjgXtoYMq9YAFwIDQZaq2vBPVI68
        m8HWo4UAE79rXFwjoa2Dlihc4yuTCoZbKOq3wbwPKik3mKz0QfauEcukiO4Es//t
        +vp9KaLWq21KV9lhwBzn5ztYAGTYMSPjvtTXzhsgVxw/U7CykD+Cl/S6WODiUQ7Q
        ==
X-ME-Sender: <xms:EXrjXnXvZZPSfsUQ-llXMxRCaEKFrfa-PLlJgJXCAYicMfQ54F1HiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeiuddgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpefgvefgveeuudeuffeiffehieffgfejleevtdetueetueffkeevgffgtddugfek
    veenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejledrudejledrledtrd
    efvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehi
    ughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:EXrjXvkuXNVYa6T5AiWeCpIe9w3tZyqwEs73b_MKQeY8J5C5zi3Srg>
    <xmx:EXrjXjYOYN0t4qo6THsMVIqDc0rO8rDWPEEwPYofm2T8HeNBL4EGcQ>
    <xmx:EXrjXiX9VcGqBn3XZ80LHSFXTU6CL1IfF04ePHgEwLbwrxQNeW7i-Q>
    <xmx:EnrjXqAHwS5bkARNPvrPdq_NhknNDhbQ0zzSS5xx9h8CmcDlUxttWg>
Received: from localhost (bzq-79-179-90-32.red.bezeqint.net [79.179.90.32])
        by mail.messagingengine.com (Postfix) with ESMTPA id 115B132801A2;
        Fri, 12 Jun 2020 08:43:41 -0400 (EDT)
Date:   Fri, 12 Jun 2020 15:43:40 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     syzbot <syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6792
Message-ID: <20200612124340.GA23832@splinter>
References: <0000000000008ff8ea05a71818b5@google.com>
 <20200602124130.256274203F@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602124130.256274203F@d06av24.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jun 02, 2020 at 06:11:29PM +0530, Ritesh Harjani wrote:
> #syz test:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 0e21d4620dd047da7952f44a2e1ac777ded2d57e

> >From cc1cf67d99d5fa61db0651c89c288df31bad6b8e Mon Sep 17 00:00:00 2001
> From: Ritesh Harjani <riteshh@linux.ibm.com>
> Date: Tue, 2 Jun 2020 17:54:12 +0530
> Subject: [PATCH 1/1] ext4: mballoc: Use raw_cpu_ptr in case if preemption is enabled
> 
> It doesn't matter really in ext4_mb_new_blocks() about whether the code
> is rescheduled on any other cpu due to preemption. Because we care
> about discard_pa_seq only when the block allocation fails and then too
> we add the seq counter of all the cpus against the initial sampled one
> to check if anyone has freed any blocks while we were doing allocation.
> 
> So just use raw_cpu_ptr to not trigger this BUG.
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6927
> caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
> CPU: 1 PID: 6927 Comm: syz-fuzzer Not tainted 5.7.0-next-20200602-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
>  ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
>  ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
>  ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
>  ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
>  ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
>  ext4_append+0x153/0x360 fs/ext4/namei.c:67
>  ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
>  ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
>  vfs_mkdir+0x419/0x690 fs/namei.c:3632
>  do_mkdirat+0x21e/0x280 fs/namei.c:3655
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com

Hi,

Are you going to submit this patch formally? Without it I'm constantly
seeing the above splat.

Thanks

> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a9083113a8c0..b79b32dbe3ea 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4708,7 +4708,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>  	}
>  
>  	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
> -	seq = *this_cpu_ptr(&discard_pa_seq);
> +	seq = *raw_cpu_ptr(&discard_pa_seq);
>  	if (!ext4_mb_use_preallocated(ac)) {
>  		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
>  		ext4_mb_normalize_request(ac, ar);
> -- 
> 2.21.3
> 

