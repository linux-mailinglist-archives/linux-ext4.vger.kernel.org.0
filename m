Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AFC31898C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 12:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBKLcI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhBKL3n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 06:29:43 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EAAC0613D6
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 03:29:02 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id j13so2357527qvu.10
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 03:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9E3U2WsJbq5lq+cPvO75ifdr6pZnfAuKCKnYnoT37Hs=;
        b=aO6XwrM+laoJC+TCRRsc/llmw64ZusSVPcXSU1eS58RDSiICiFAavqWJ1+wlUPqUW2
         gzfWDAoxIccXHnGSoMILAHuh+q9ojnijdnkRpRlGstFkQsaD0RAwfEycZNzD+U6YWg2a
         zG/56nihol+8HG+odjT6QBHMuShFVKcvzXVEsaBsrxjaRBqhe7axNHOBLt+giAzfcc1k
         D5RmPt5t72l8/9HN3RlXWqXHkySsNN0vYlcAXHjBvVxPjhcfHrjdGJp7heDMaXxnetOk
         OACCvQ0CvgnQyCUhZZzx4SO2QHlgOyf3wcXGLntNj2Xq0QlgicEQV1vqfl6PI+gjwkoa
         6s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9E3U2WsJbq5lq+cPvO75ifdr6pZnfAuKCKnYnoT37Hs=;
        b=iHI1W863jJQ+9Zy1yng+BxxdIAxAhvuh7n83IpGinG28Rsx1P3orqeIG9WR4fkOEnE
         W3MZXPm6sQJrc83AYELHLxq8JyDLX46MThdAEA1A+SxsqOb6yTiNPGjOBlQ3rctA63Bn
         Um9ZxALbrRS7jtm6fRROV8OBmL3W/tW0nbLfd1VmhI9SE6/znI+rW3/+iRUPO1HZOG39
         Kw7NiA0fEe+4M6L/xzwsiUIDbiCXOudDSikDQ2BoQD9hGqTS1n+L8jjYVFYL/J6GSoa3
         mkl2K6hvHqbFIp/u5NokjNpD6kQCltn5ZoZFCdjJuu93vJhSgJO6ERwjvKT+jaf8oH1b
         gqxw==
X-Gm-Message-State: AOAM5315hbhy3fReM6ac7zMWKUnhINTFiEDL1eqZl9EzKqxaK0pSmYjm
        +XjkV8j8q+ymovYaElhVQELSrcqFN5Cidhpmz3ueyUxH3EdHzQ==
X-Google-Smtp-Source: ABdhPJzSFLQhssC/M3MzzqWhnULkeF3G/ieVd61jjCYgo3R+1BGFt9YIkm79Z4L7Etcq6JETSdaWeJm5sJTxKCb+US0=
X-Received: by 2002:a05:6214:1ca:: with SMTP id c10mr6814571qvt.44.1613042941490;
 Thu, 11 Feb 2021 03:29:01 -0800 (PST)
MIME-Version: 1.0
References: <000000000000563a0205bafb7970@google.com> <20210211104947.GL19070@quack2.suse.cz>
 <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
In-Reply-To: <CACT4Y+b5gSAAtX3DUf-H3aRxbir44MTO6BCC3XYvN=6DniT+jw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 11 Feb 2021 12:28:48 +0100
Message-ID: <CACT4Y+a_iyaYY18Uw28bd178xjso=n6jfMBjyZuYJiNeo8x+LQ@mail.gmail.com>
Subject: Re: possible deadlock in start_this_handle (2)
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Michal Hocko <mhocko@suse.cz>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 11, 2021 at 12:22 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 11, 2021 at 11:49 AM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > added mm guys to CC.
> >
> > On Wed 10-02-21 05:35:18, syzbot wrote:
> > > HEAD commit:    1e0d27fc Merge branch 'akpm' (patches from Andrew)
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15cbce90d00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=bd1f72220b2e57eb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=bfdded10ab7dcd7507ae
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> > >
> > > ======================================================
> > > WARNING: possible circular locking dependency detected
> > > 5.11.0-rc6-syzkaller #0 Not tainted
> > > ------------------------------------------------------
> > > kswapd0/2246 is trying to acquire lock:
> > > ffff888041a988e0 (jbd2_handle){++++}-{0:0}, at: start_this_handle+0xf81/0x1380 fs/jbd2/transaction.c:444
> > >
> > > but task is already holding lock:
> > > ffffffff8be892c0 (fs_reclaim){+.+.}-{0:0}, at: __fs_reclaim_acquire+0x0/0x30 mm/page_alloc.c:5195
> > >
> > > which lock already depends on the new lock.
> > >
> > > the existing dependency chain (in reverse order) is:
> > >
> > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > >        __fs_reclaim_acquire mm/page_alloc.c:4326 [inline]
> > >        fs_reclaim_acquire+0x117/0x150 mm/page_alloc.c:4340
> > >        might_alloc include/linux/sched/mm.h:193 [inline]
> > >        slab_pre_alloc_hook mm/slab.h:493 [inline]
> > >        slab_alloc_node mm/slub.c:2817 [inline]
> > >        __kmalloc_node+0x5f/0x430 mm/slub.c:4015
> > >        kmalloc_node include/linux/slab.h:575 [inline]
> > >        kvmalloc_node+0x61/0xf0 mm/util.c:587
> > >        kvmalloc include/linux/mm.h:781 [inline]
> > >        ext4_xattr_inode_cache_find fs/ext4/xattr.c:1465 [inline]
> > >        ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1508 [inline]
> > >        ext4_xattr_set_entry+0x1ce6/0x3780 fs/ext4/xattr.c:1649
> > >        ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
> > >        ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
> > >        ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
> > >        ext4_xattr_user_set+0xbc/0x100 fs/ext4/xattr_user.c:40
> > >        __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
> > >        __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
> > >        __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
> > >        vfs_setxattr+0x135/0x320 fs/xattr.c:291
> > >        setxattr+0x1ff/0x290 fs/xattr.c:553
> > >        path_setxattr+0x170/0x190 fs/xattr.c:572
> > >        __do_sys_setxattr fs/xattr.c:587 [inline]
> > >        __se_sys_setxattr fs/xattr.c:583 [inline]
> > >        __ia32_sys_setxattr+0xbc/0x150 fs/xattr.c:583
> > >        do_syscall_32_irqs_on arch/x86/entry/common.c:77 [inline]
> > >        __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:139
> > >        do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:164
> > >        entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> >
> > This stacktrace should never happen. ext4_xattr_set() starts a transaction.
> > That internally goes through start_this_handle() which calls:
> >
> >         handle->saved_alloc_context = memalloc_nofs_save();
> >
> > and we restore the allocation context only in stop_this_handle() when
> > stopping the handle. And with this fs_reclaim_acquire() should remove
> > __GFP_FS from the mask and not call __fs_reclaim_acquire().
> >
> > Now I have no idea why something here didn't work out. Given we don't have
> > a reproducer it will be probably difficult to debug this. I'd note that
> > about year and half ago similar report happened (got autoclosed) so it may
> > be something real somewhere but it may also be just some HW glitch or
> > something like that.
>
> HW glitch is theoretically possible. But if we are considering such
> causes, I would say a kernel memory corruption is way more likely, we
> have hundreds of known memory-corruption-capable bugs open. In most
> cases they are caught by KASAN before doing silent damage. But KASAN
> can miss some cases.
>
> I see at least 4 existing bugs with similar stack:
> https://syzkaller.appspot.com/bug?extid=bfdded10ab7dcd7507ae
> https://syzkaller.appspot.com/bug?extid=a7ab8df042baaf42ae3c
> https://syzkaller.appspot.com/bug?id=c814a55a728493959328551c769ede4c8ff72aab
> https://syzkaller.appspot.com/bug?id=426ad9adca053dafcd698f3a48ad5406dccc972b
>
> All in all, I would not assume it's a memory corruption. When we had
> bugs that actually caused silent memory corruption, that caused a
> spike of random one-time crashes all over the kernel. This does not
> look like it.

I wonder if memalloc_nofs_save (or any other manipulation of
current->flags) could have been invoked from interrupt context? I
think it could cause the failure mode we observe (extremely rare
disappearing flags). It may be useful to add a check for task context
there.
