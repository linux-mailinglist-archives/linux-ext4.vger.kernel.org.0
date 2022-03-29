Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F074EACA5
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Mar 2022 13:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiC2Lv6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Mar 2022 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiC2Lv6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Mar 2022 07:51:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85430DD979;
        Tue, 29 Mar 2022 04:50:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so2555475pjo.2;
        Tue, 29 Mar 2022 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GDmR2wftvG4msxBNDtyhyNG/hSX+JfcBfKqZXC22S84=;
        b=lCEkb98plRxIzGgu8NPe39Af6CupawyEOqiHL0x0iXTQKydLayauFdzgC7AwCBDGpi
         XkMDMYOiX6a8LxGzUuIEs3iMH6aIkdvI0SngWsJETv/WPkL9tqMOWrJ+cOYrEUURn37s
         l8zYwLCP8Wxc7yKYNtRHngoyLH1pAjJkyjQZ5oNCmcJsBhLolgAuJUufMVq+uysWjnRg
         tP2ysLiZCDfRtLqIX19l3wh5iZL73uCVjr8IFEv1kWvASBRupJcdm9OWNmTk1uj8nV0N
         z7YWAkDh0Pn/XzNYGSEft3LFbxyOt68BGeDRGwM+m8idBrVEqutLLFrqAVpnwtS67c6E
         kUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GDmR2wftvG4msxBNDtyhyNG/hSX+JfcBfKqZXC22S84=;
        b=DpqgmIhXXlAGQE2gViH8EY579/9CxoLXfhUAMwFZPsHGwvhO+GJXTUoWQdYT8V4hQP
         +V6JZHSoKHbdDGuPK2lp4LuFTFVzedd2a/Cw+z1BHIpFWO6pAGSg77+jeyvL8JQ6Sav/
         ueH8Sr9kegNA24bnvpTjhupGz3LHWeBQ12Z4iMkrRcEkQ3dS8hWOZsflp+84WIUo81gz
         5XsZw0K38HyaYAXWA+fGuxeLpbzfvyuKntE96gdVk5ogYWbF95DDciVNb2OFg/fYzBr/
         YbypLHrX1bfjBKljPyFcW3Z9aK+NAr5nVIlCzlzsSdB8CZ5m850QMkLOZcfL6U6kwU3Z
         IN9g==
X-Gm-Message-State: AOAM531G9h6Zs7XYOOefXr2CerNlpC4cxGuoONlCvPTEuh+F/Dd5DnFl
        AmnF7oqyzlxdgSWq6i2BXCk=
X-Google-Smtp-Source: ABdhPJx5ptLka+N/vMi5mG5BEvE1mm3YiKy+HflePq4/ubOUE9Iw3Yveh1gxXR8yIJs4+3B8Icxh4w==
X-Received: by 2002:a17:902:9007:b0:14f:3680:66d1 with SMTP id a7-20020a170902900700b0014f368066d1mr29238402plp.91.1648554613937;
        Tue, 29 Mar 2022 04:50:13 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id g5-20020a056a001a0500b004def10341e5sm19466568pfv.22.2022.03.29.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:50:13 -0700 (PDT)
Date:   Tue, 29 Mar 2022 17:20:11 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, cmaiolino@redhat.com,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sjc@chobot.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu, wanjiabing@vivo.com
Subject: Re: [syzbot] KASAN: use-after-free Read in ext4_xattr_set_entry (4)
Message-ID: <20220329115011.5fyhukqlfvvzojbg@riteshh-domain>
References: <00000000000079c56a05ba1c18c3@google.com>
 <000000000000b8cdba05dae41558@google.com>
 <CACT4Y+bWiUfw4YEx7x9rCb80SwbQPfFfSWP6-7cYxOSs5vw39A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bWiUfw4YEx7x9rCb80SwbQPfFfSWP6-7cYxOSs5vw39A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/25 07:18AM, Dmitry Vyukov wrote:
> On Wed, 23 Mar 2022 at 16:07, syzbot
> <syzbot+4cb1e27475bf90a9b926@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6e47a3cc68fc525428297a00524833361ebbb0e9
> > Author: Lukas Czerner <lczerner@redhat.com>
> > Date:   Wed Oct 27 14:18:52 2021 +0000
> >
> >     ext4: get rid of super block and sbi from handle_mount_ops()
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100bc10b700000
> > start commit:   f8ad8187c3b5 fs/pipe: allow sendfile() to pipe again
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=96b123631a6700e9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=4cb1e27475bf90a9b926
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11131f94d00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3761b500000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
> >
> > #syz fix: ext4: get rid of super block and sbi from handle_mount_ops()
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Looks reasonable:
>
> #syz fix: ext4: get rid of super block and sbi from handle_mount_ops()

Sorry, I might have missed some discussion maybe.
But why do we think that this patch could fix the reported bug?
Because I see this patch from Lukas is a part of "ext4: new mount API
conversion" patch series. This I guess has nothing to do with the reported call
stack, no?

Or am I missing anything?

BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
Read of size 4 at addr ffff888030c00004 by task syz-executor392/11280

CPU: 0 PID: 11280 Comm: syz-executor392 Not tainted 5.11.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 ext4_xattr_set_entry+0x3151/0x3780 fs/ext4/xattr.c:1586
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


-ritesh
