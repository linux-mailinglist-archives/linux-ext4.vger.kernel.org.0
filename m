Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31A7DE14F
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 14:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjKAM7B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKAM7A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 08:59:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD59DC;
        Wed,  1 Nov 2023 05:58:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698843532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWUnEh6XW9/W7DLWKsdahGToSptXq7swAyngnisC52k=;
        b=30M76bIlVflBqCCitsRhE+s18iWhKakGePKEieuSV5J+DUrqDBNa95RL8c9tjyHzGvS879
        miwOWjTEET/JcyR7+IcWwde4IsiD1fKQXGmM/JtTmOINrlPfrAveABoCSSM+RxsHvGCqj2
        JKAra6A58yjTXK7Wisou2KyXzjlNfNFiUtwuHqMJcHVtuvl2fvM7/nveQzPOLfbXyoPLMR
        yIi+tbJDoCCVwPhADENXd1vBFK690Q5bcQE31JahHaq6stW3qOLMVnOAOpLGqXFLfl1y2q
        0BlPG9LuRd/SprlEnHFWti6y00cDc2JE21sVzkgtY2gcHyttagKd05Ab9RIPJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698843532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SWUnEh6XW9/W7DLWKsdahGToSptXq7swAyngnisC52k=;
        b=iaB1DzDW6lOg8Ec9QhS5dsYFAVz46LGqEBVNLbQLXr0grx4QqKk5VzZnBgaTuDzsugZyZu
        XMm2rK/pmM8DetAQ==
To:     syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
In-Reply-To: <000000000000cfd180060910a687@google.com>
References: <000000000000cfd180060910a687@google.com>
Date:   Wed, 01 Nov 2023 13:58:51 +0100
Message-ID: <875y2lmxys.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 31 2023 at 22:36, syzbot wrote:
> general protection fault, probably for non-canonical address 0xdffffc003ffff113: 0000 [#1] PREEMPT SMP KASAN
> KASAN: probably user-memory-access in range [0x00000001ffff8898-0x00000001ffff889f]
> CPU: 1 PID: 5308 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> RIP: 0010:lookup_object lib/debugobjects.c:195 [inline]
> RIP: 0010:lookup_object_or_alloc lib/debugobjects.c:564 [inline]
> RIP: 0010:__debug_object_init+0xf3/0x2b0 lib/debugobjects.c:634
> Code: d8 48 c1 e8 03 42 80 3c 20 00 0f 85 85 01 00 00 48 8b 1b 48 85 db 0f 84 9f 00 00 00 48 8d 7b 18 83 c5 01 48 89 f8 48 c1 e8 03 <42> 80 3c 20 00 0f 85 4c 01 00 00 4c 3b 73 18 75 c3 48 8d 7b 10 48
> RSP: 0018:ffffc900050e7d08 EFLAGS: 00010012
> RAX: 000000003ffff113 RBX: 00000001ffff8880 RCX: ffffffff8169123e
> RDX: 1ffffffff249b149 RSI: 0000000000000004 RDI: 00000001ffff8898
> RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000000000216
> R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
> R13: ffffffff924d8a48 R14: ffffc900050e7d90 R15: ffffffff924d8a50
> FS:  0000555556eec480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa23ab065ee CR3: 000000007e5c1000 CR4: 0000000000350ee0

So this dies in debugobjects::lookup_object()

hlist_for_each_entry()

>   10:	48 8b 1b             	mov    (%rbx),%rbx

Gets the next entry

>   13:	48 85 db             	test   %rbx,%rbx
>   16:	0f 84 9f 00 00 00    	je     0xbb

Checks for the termination condition (NULL pointer)

>   1c:	48 8d 7b 18          	lea    0x18(%rbx),%rdi

Calculates the address of obj->object

>   20:	83 c5 01             	add    $0x1,%ebp

cnt++;

>   23:	48 89 f8             	mov    %rdi,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax

KASAN shadow address calculation

> * 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction

Kasan accesses 0xdffffc003ffff113 and dies.

RBX contains the pointer to the next object: 0x00000001ffff8880 which is
clearly a user space address, but I have no idea where that might come
from. It's obviously data corruption of unknown provenience.

Unfortunately repro.syz does not hold up to its name and refuses to
reproduce.

Thanks,

        tglx

