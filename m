Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759D62409B
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 12:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKJLCH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 06:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKJLBy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 06:01:54 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BE6C71E
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 03:01:51 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-333a4a5d495so11865607b3.10
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 03:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmHpbHS5doLrhzAjJPWJ0TWG+6ktMdA7UyRQfP5yVLQ=;
        b=PLbZrq9bLdievV0a3Mb3BaXEmA0lIlXEss9RAzy1kIWFQcyoX58mVA9H25RToeQszv
         5YvjuWvLH/5NrA6TyG40gt3N0kKc23/A76AT88SS5ZTAe2T4n9e5jWLXGZpGYLIXjEqQ
         Khc8dLGZ8N7MaH3FLaoh08tpHLRjoS7QxA8kr5/5fJgId7Xy8vZ/wOwRGZwr9f6d4282
         +pnfoWEXAiSc54Zb5MGIncElzoGgObabXLveU3e1AC2ar9FWmubdTRQJwgj+eSJ1gRxV
         gbiBAeXoiiYsuVJihJyxE1Ps8zJ7mYhKmo3OErMbadxuKY3GcSaJWPGlaCt1AsgWghiJ
         V5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmHpbHS5doLrhzAjJPWJ0TWG+6ktMdA7UyRQfP5yVLQ=;
        b=SblhEppGQDE8368cyH8DGTcPd09LlliSJ1RcU3+QjRzsebPVR190U9X6V8HSzolAVd
         56ZX0gbA0Ogqys3Yr/JkQaOBThgRDB7hUcb6mWpOpMFIrnPrGrPMNNhPFT26+CAVWWaj
         ErIJPpa29PdinZqBognXjGK8QoDxhyEx9pbACqxW3yWN83sVTti0qg5R3ZRJ2bJvrgtX
         h2OWpBlURnblXWtCzckobPvK5pe0U4SN9585v0AK1hKzmxiME1nDNA56adh/fnSBe8FP
         MKLGv8BBEey9NUR5agQO7efSfbqhHhQKsxavEc93SIskgQBx5UIED/BIPcITU36puA1E
         KnWQ==
X-Gm-Message-State: ACrzQf1kodZEDEzpoInZSkOiEbQScnw0DIO1aPujnHhB5tgEiKvKWI4Q
        m2ILzMYaE9D0ubtuZIYn02KJxng0m+9LEf9fTKtRNg==
X-Google-Smtp-Source: AMsMyM4R1yv3ctd1jPaIemb0nxA+rY5vVqfKSKgK+YNO+lpbSGR7xqL6G42PREeei1JWOBTJSsRAC/uEYrLUaBmIUU0=
X-Received: by 2002:a0d:da03:0:b0:368:5712:5795 with SMTP id
 c3-20020a0dda03000000b0036857125795mr61929838ywe.428.1668078109722; Thu, 10
 Nov 2022 03:01:49 -0800 (PST)
MIME-Version: 1.0
References: <00000000000058d01705ecddccb0@google.com> <CAG_fn=WAyOc+1GEC+P3PpTM2zLcLcepAX1pPXkj5C6aPyrDVUA@mail.gmail.com>
 <Y2lGu/QTIWNpzFI3@sol.localdomain> <CAG_fn=VQBv-sgPhT0gLVChAtMNx0F3RcQYDKdvhBL4mBpiDkFA@mail.gmail.com>
 <CAG_fn=VPvdHxQc3xm5xkqgFq3uo5oTU_w5vyMj-qQD7DvwQ4BA@mail.gmail.com> <Y2qUylpsZcJ7HF0Z@sol.localdomain>
In-Reply-To: <Y2qUylpsZcJ7HF0Z@sol.localdomain>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 10 Nov 2022 12:01:13 +0100
Message-ID: <CAG_fn=WVUmodhyY+bNyKWC6BM5gXaq3fguw70ngsjZWc4mXkPg@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in pagecache_write
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 8, 2022 at 6:41 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Nov 08, 2022 at 10:08:36AM +0100, 'Alexander Potapenko' via syzka=
ller-bugs wrote:
> > > >
> > > > Anyway, this patch doesn't hurt, I suppose.  Can please you send it=
 out as a
> > > > formal patch to linux-ext4?  It would be easy for people to miss th=
is patch
> > > > buried in this thread.  Also, can you please send a patch to linux-=
f2fs-devel
> > > > for the same code in fs/f2fs/verity.c?
> > >
> > > Will do!
> >
> > Shall I also initialize fsdata here:
> >
> > $ git grep 'void \*fsdata;'
> > fs/affs/file.c:         void *fsdata;
> > fs/ext4/verity.c:               void *fsdata;
> > fs/f2fs/verity.c:               void *fsdata;
> > fs/hfs/extent.c:                void *fsdata;
> > fs/hfsplus/extents.c:           void *fsdata;
> > fs/ocfs2/mmap.c:        void *fsdata;
>
> Yes, it looks like they all need this.  Except maybe ocfs2?  It's hard to=
 tell.

For ocfs2 the begin/end functions are always the same, so it's harder
to mess fsdata up.
Guess we can say for now that __ocfs2_page_mkwrite() never passes an
uninitialized variable to another function.

> - Eric



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
