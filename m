Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34624EACCA
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 14:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiC2MDU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 08:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiC2MDT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 08:03:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1B6315
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 05:01:36 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j83so18768979oih.6
        for <linux-ext4@vger.kernel.org>; Tue, 29 Mar 2022 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehEFZcYrASqbAc6jhYepxilgTtwp09yvtYpdMuhCCT4=;
        b=WBWtSlgW0p5oyOGwsz7SJGDGSXCJRRcSzVbR7Y6+Lhl7rjildBSauyXcNlnhOSjpMZ
         ZRKFVOZXexxjZ1tWhfkobK7zlYzPQB2FWbtCi/Y9JVkiJ+yW3DxnTVxmneqxIjBWbtEw
         Cf2WahhGlg/f3SDCvkMu2j3iFHwJMBO007lnt96b5sqsCER2LFzU9YYm6hQeu1MxNDrr
         cqRSvdudI7LkVzxrIRdW9Fas50jg9p3s1psjcAtuk9g2Z+mF1L42sPOY5eMYy86CCfPN
         U/ftL/qkkQZqLTb1ELksInGgL3aKgF+GRmgGS1LtFUJQ7xRIN2Bdya+Ij8kng7aNyo1N
         s1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehEFZcYrASqbAc6jhYepxilgTtwp09yvtYpdMuhCCT4=;
        b=GR26mWSM7vgrj3BG297gY2ncxW25c5ffziUPnKMslBd1oh2iU/utE/gnE3mI89ImCL
         2wHPlxSMQeo6s8XMNJTYfU7t6YLYWdcUFL9sCtrkNIrq7S2nyGdw7UqZLJXZV0ssyW2i
         101+PUHVKQOQWUGa7HJLuXw0KbgJjG9lIqSzv5vnnMUGVCMI2aEmqbDWhMoMWSFS4KnY
         1Z0L8CWBEoO6tz9v334ceGMeKOMOhMow4V4tbWUOMLIx8Q+Er487nSD0B9+g7ZBham0u
         /KzBBP0AvGKE2g9M2BPT5R7d6m9Yq3VZuHrjQupTS3j0NEXmpVI5cPM/4WimkVMzlv6E
         zvuw==
X-Gm-Message-State: AOAM533vklttmCRurErx+pUrgdm7ngcrb5WDGKEuchmGUJunEx+Q3gg/
        wmP/sc0zNiWht/DwRzLqiVGvhZD4k+YAIOvYVUAwMjiiZun2Gg==
X-Google-Smtp-Source: ABdhPJyFsxcS2Y8brGth5S0LA5+NbL+9QCiz64jOeuZSPkBhTeLeF6HPo07YXZxBoIE1oW67ddCnM60hMm5zr7qifuc=
X-Received: by 2002:a05:6808:16a4:b0:2f7:1fd1:f48 with SMTP id
 bb36-20020a05680816a400b002f71fd10f48mr1065976oib.163.1648555294201; Tue, 29
 Mar 2022 05:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000079c56a05ba1c18c3@google.com> <000000000000b8cdba05dae41558@google.com>
 <CACT4Y+bWiUfw4YEx7x9rCb80SwbQPfFfSWP6-7cYxOSs5vw39A@mail.gmail.com> <20220329115011.5fyhukqlfvvzojbg@riteshh-domain>
In-Reply-To: <20220329115011.5fyhukqlfvvzojbg@riteshh-domain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 29 Mar 2022 14:01:22 +0200
Message-ID: <CACT4Y+ZhCWZhrzt9bW-Q=munq9RC+eow8zCpJU1fzFiEGQa+6w@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in ext4_xattr_set_entry (4)
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     syzbot <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjc@chobot.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, wanjiabing@vivo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 29 Mar 2022 at 13:50, Ritesh Harjani <ritesh.list@gmail.com> wrote:
>
> On 22/03/25 07:18AM, Dmitry Vyukov wrote:
> > On Wed, 23 Mar 2022 at 16:07, syzbot
> > <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot suspects this issue was fixed by commit:
> > >
> > > commit 6e47a3cc68fc525428297a00524833361ebbb0e9
> > > Author: Lukas Czerner <lczerner@redhat.com>
> > > Date:   Wed Oct 27 14:18:52 2021 +0000
> > >
> > >     ext4: get rid of super block and sbi from handle_mount_ops()
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100bc10b700000
> > > start commit:   f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
> > > git tree:       upstream
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=96b123631a6700e9
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4cb1e27475bf90a9b926
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11131f94d00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3761b500000
> > >
> > > If the result looks correct, please mark the issue as fixed by replying with:
> > >
> > > #syz fix: ext4: get rid of super block and sbi from handle_mount_ops()
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > Looks reasonable:
> >
> > #syz fix: ext4: get rid of super block and sbi from handle_mount_ops()
>
> Sorry, I might have missed some discussion maybe.
> But why do we think that this patch could fix the reported bug?
> Because I see this patch from Lukas is a part of "ext4: new mount API
> conversion" patch series. This I guess has nothing to do with the reported call
> stack, no?
>
> Or am I missing anything?

Hi Ritesh,

It looked reasonable because the identified patch is in ext4 and the
bug is also in ext4 + the bisection log looked reasonable + there were
no other suggestions/corrections. In such a case it's better to close
the bug with at least some reasonable fix, then let it pile to
hundreds of other unclosed bugs and prevent reporting of new bugs.



> BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
> Read of size 4 at addr ffff888030c00004 by task syz-executor392/11280
>
> CPU: 0 PID: 11280 Comm: syz-executor392 Not tainted 5.11.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x107/0x163 lib/dump_stack.c:120
>  print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
>  __kasan_report mm/kasan/report.c:396 [inline]
>  kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
>  ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
>  ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2224
>  ext4_xattr_set_handle+0x8f4/0x13e0 fs/ext4/xattr.c:2380
>  ext4_xattr_set+0x13a/0x340 fs/ext4/xattr.c:2493
>  __vfs_setxattr+0x10e/0x170 fs/xattr.c:177
>  __vfs_setxattr_noperm+0x11a/0x4c0 fs/xattr.c:208
>  __vfs_setxattr_locked+0x1bf/0x250 fs/xattr.c:266
>  vfs_setxattr+0x135/0x320 fs/xattr.c:291
>  setxattr+0x1ff/0x290 fs/xattr.c:553
>  path_setxattr+0x170/0x190 fs/xattr.c:572
>  __do_sys_setxattr fs/xattr.c:587 [inline]
>  __se_sys_setxattr fs/xattr.c:583 [inline]
>  __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:583
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>
>
> -ritesh
