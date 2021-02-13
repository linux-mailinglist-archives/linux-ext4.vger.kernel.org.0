Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC831AAF3
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Feb 2021 12:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhBMK7a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 Feb 2021 05:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhBMK71 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 Feb 2021 05:59:27 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4CC061574
        for <linux-ext4@vger.kernel.org>; Sat, 13 Feb 2021 02:58:47 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id t62so2117619qke.7
        for <linux-ext4@vger.kernel.org>; Sat, 13 Feb 2021 02:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpE0yQR+r9TZYKB7SOgK9TDG3SDQRc6/EdWKyoqtYyE=;
        b=TpklhvP9JfuDBxHn2I3a5Czxo0QLDVJk590yNeMrhm/7AfqgRxG2Yz6j2K0ePngkcK
         36eQEV+FsXe+MYP7CeUrtWvmSmJ7KJRLbl4s0vyhSPWexVHpyvgvggop5oEB/zhTADtX
         sAJppDn5uad6XoGeoHhT292p/tosHlO9LIzkKTS0k5PPVAD//XP8224R8zJoFZy0r9HC
         gTfBBG77pNRyb55g2w6o9A65mNzSfsbNEFf0bjkZsfGJ7E9C8NoyJ0csCP9hLhnVIbB8
         YbNrqMbyWsZm16BbY4r6oSF0rvyDRmFC/QzDs3qUM0YIHkBUC7D4MZsFGuUhuikJ9DWL
         +ySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpE0yQR+r9TZYKB7SOgK9TDG3SDQRc6/EdWKyoqtYyE=;
        b=QzdUHJDufSP/yoxzwY7e11d6nQu5ICO2FwZdK4EWdwJpQlHUK4+/H9JyPPLbjXZrwf
         jMf1G9ZvHItgxrNXWm1iyubP+Fgmy7M7fvIHyq1NYypuCRcG/btdcrWWgmftNaVI9BB5
         7fJKWgSt83uOWefjziiksA4sipP5a15rXNnPokWdAoxixc7RW7c3oqAAwfAbGyFM1s+e
         92k0sEAJYuIV4RUNmzENCONa9gaWbDBjxJxnMIt9S33Ven3EjUtchy18r00grfQxSwl7
         5gt/vXPmUjByn7tA4v7y+xYxuo2lfWl7G4Unj/6tm4oy6gbQqZxZK3ecE0K0Ib65oU6/
         gfpg==
X-Gm-Message-State: AOAM530AT5znXwm7ugB5uK005aF8WbMGbegJVPIMc1L+oTnLz/Nm4haj
        7PO1bSG4czoT4snrJMrVxKae5w9YSaBi1uQfS28Z9WVSa/dCDg==
X-Google-Smtp-Source: ABdhPJyiAR9TdBbuhnelWfP1ti2thf0+q9WpLfxdUaZskEcbXoxYjf1Inq7VahxEH/4Z+rYbayGvK2xRS/8FSHV7Hg0=
X-Received: by 2002:a05:620a:1351:: with SMTP id c17mr6679766qkl.350.1613213925899;
 Sat, 13 Feb 2021 02:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20210211125717.GH308988@casper.infradead.org> <YCUr99//z8hJmnDH@dhcp22.suse.cz>
 <20210211132533.GI308988@casper.infradead.org> <YCU9OR7SfRpwl4+4@dhcp22.suse.cz>
 <20210211142630.GK308988@casper.infradead.org> <YCVeLF8aZGfRVY3C@dhcp22.suse.cz>
 <9cff0fbf-b6e7-1166-e4ba-d4573aef0c82@i-love.sakura.ne.jp>
 <20210212122207.GM308988@casper.infradead.org> <YCZ056SJDGrgXCss@dhcp22.suse.cz>
 <2b90c488-a6b9-2565-bd3a-e4f8bf8404e9@i-love.sakura.ne.jp> <YCaiIGE69ps3m8OO@dhcp22.suse.cz>
In-Reply-To: <YCaiIGE69ps3m8OO@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 13 Feb 2021 11:58:34 +0100
Message-ID: <CACT4Y+Z1yUxb5DQuQ4AqW2NypUkeYTmQm7rMAgG34fmdv1_CtA@mail.gmail.com>
Subject: Re: possible deadlock in start_this_handle (2)
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 12, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 12-02-21 21:58:15, Tetsuo Handa wrote:
> > On 2021/02/12 21:30, Michal Hocko wrote:
> > > On Fri 12-02-21 12:22:07, Matthew Wilcox wrote:
> > >> On Fri, Feb 12, 2021 at 08:18:11PM +0900, Tetsuo Handa wrote:
> > >>> On 2021/02/12 1:41, Michal Hocko wrote:
> > >>>> But I suspect we have drifted away from the original issue. I thought
> > >>>> that a simple check would help us narrow down this particular case and
> > >>>> somebody messing up from the IRQ context didn't sound like a completely
> > >>>> off.
> > >>>>
> > >>>
> > >>>  From my experience at https://lkml.kernel.org/r/201409192053.IHJ35462.JLOMOSOFFVtQFH@I-love.SAKURA.ne.jp ,
> > >>> I think we can replace direct PF_* manipulation with macros which do not receive "struct task_struct *" argument.
> > >>> Since TASK_PFA_TEST()/TASK_PFA_SET()/TASK_PFA_CLEAR() are for manipulating PFA_* flags on a remote thread, we can
> > >>> define similar ones for manipulating PF_* flags on current thread. Then, auditing dangerous users becomes easier.
> > >>
> > >> No, nobody is manipulating another task's GFP flags.
> > >
> > > Agreed. And nobody should be manipulating PF flags on remote tasks
> > > either.
> > >
> >
> > No. You are misunderstanding. The bug report above is an example of
> > manipulating PF flags on remote tasks.
>
> The bug report you are referring to is ancient. And the cpuset code
> doesn't touch task->flags for a long time. I haven't checked exactly but
> it is years since regular and atomic flags have been separated unless I
> misremember.
>
> > You say "nobody should", but the reality is "there indeed was". There
> > might be unnoticed others. The point of this proposal is to make it
> > possible to "find such unnoticed users who are manipulating PF flags
> > on remote tasks".
>
> I am really confused what you are proposing here TBH and referring to an
> ancient bug doesn't really help. task->flags are _explicitly_ documented
> to be only used for _current_. Is it possible that somebody writes a
> buggy code? Sure, should we build a whole infrastructure around that to
> catch such a broken code? I am not really sure. One bug 6 years ago
> doesn't sound like a good reason for that.

Another similar one was just reported:

https://syzkaller.appspot.com/bug?extid=1b2c6989ec12e467d65c

WARNING: possible circular locking dependency detected
5.11.0-rc7-syzkaller #0 Not tainted
------------------------------------------------------
kswapd0/2232 is trying to acquire lock:
ffff88801f552650 (sb_internal){.+.+}-{0:0}, at: evict+0x2ed/0x6b0 fs/inode.c:577

but task is already holding lock:
ffffffff8be89240 (fs_reclaim){+.+.}-{0:0}, at:
__fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
       fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
       might_alloc include/linux/sched/mm.h:193 [inline]
       slab_pre_alloc_hook mm/slab.h:493 [inline]
       slab_alloc_node mm/slab.c:3221 [inline]
       kmem_cache_alloc_node_trace+0x48/0x520 mm/slab.c:3596
       __do_kmalloc_node mm/slab.c:3618 [inline]
       __kmalloc_node+0x38/0x60 mm/slab.c:3626
       kmalloc_node include/linux/slab.h:575 [inline]
       kvmalloc_node+0x61/0xf0 mm/util.c:587
       kvmalloc include/linux/mm.h:781 [inline]
       ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
       ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
       ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
       ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
       ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
       __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
       __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
       __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
       vfs_setxattr+0x135/0x320 fs/xattr.c:291
       setxattr+0x1ff/0x290 fs/xattr.c:553
       path_setxattr+0x170/0x190 fs/xattr.c:572
       __do_sys_setxattr fs/xattr.c:587 [inline]
       __se_sys_setxattr fs/xattr.c:583 [inline]
       __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:583
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
