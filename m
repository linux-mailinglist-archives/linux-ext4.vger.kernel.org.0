Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA657BC73
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbiGTRQu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 13:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiGTRQt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 13:16:49 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F86B192B0;
        Wed, 20 Jul 2022 10:16:49 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id t127so16925093vsb.8;
        Wed, 20 Jul 2022 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpuO2zBU6FoivfVNiIeAwgkNy+HaH0gJeb81o/gdeDA=;
        b=V6706ZCetAGXyzEa10g6FKFOxQYean1vJnVx3buWiksY4a9Y4Vwj6ufkkqYx50Qw73
         v+lobX/0o4NcGZt+YjXnpkZQHUcYDDCUx4ettoUkl3JhAXuVm++0wat3jCfcoPoyKbPl
         Sqyg69t3LBXoo08eUuWggFbvB5ngPwv9Je1zgLDx3XnvlaW8OGqBqOeM2GCr7STLObKs
         V9c1on5+/FqMyIxUd2v5Qbx7s2KR3dyAVsh5H/OcUA4mqnKc3tC6o4i3W+OlYZlYRssm
         QB90PaSQd4wCSUIvQHXVfLz1epjoE4bicTTyM3L4oPdBboyIWDdhaMO/VVf3CIOKxgCA
         nIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpuO2zBU6FoivfVNiIeAwgkNy+HaH0gJeb81o/gdeDA=;
        b=Qqb1HQurBUltlDGR2gG1XUkYHO3veaj/vMP2cDQFVSieO6KhK7ZiguHpAzcSyCEPeK
         gXlSNZyw94Bp92yuVALXvbatum3gqdJne9F5J5XRJDt2uDqWDxCYDIGObKwZq9T9+hGg
         Vn07/87FrnIh93kYsUilxuYJbUAupuw15puvfy6JcyIp8NTgBS8Swe78nTlAXQEcs61Y
         RnofEpw9HzExomFMYXHo4aLFqsE9JS9ThomcV91SHJvFY3k5UGkFmPt5JTDSMwKwsGkF
         EdR7M/CcNm5ojwx69JWKwMESTZCVzoMJJqR9Gb5mxIuBh7mb8oHKTyTwMWCbqUBXEy3W
         PAAQ==
X-Gm-Message-State: AJIora86NQ1cfbpg0U2toGbFdk+m+HMTQwBcJoWJu3Jx2r6KpPhyl2KH
        KiRzuktkXI4flnBIdiWcnndTFpGzRjC16TNAUo/iVYQ/4uNnjqcF
X-Google-Smtp-Source: AGRyM1smX16Hl0dMp4wao/Y1kBLKJS2J4zWDDguWTa3BgaAUCdNI6P9WruTXLQiOTQgHOBESG/6HEWG1xvQM0giQw/g=
X-Received: by 2002:a05:6102:302a:b0:357:2c0b:782a with SMTP id
 v10-20020a056102302a00b003572c0b782amr13375198vsa.74.1658337408221; Wed, 20
 Jul 2022 10:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220720000256.239531-1-bongiojp@gmail.com> <20220720100949.dttc5qbmy4qziz65@zlang-mailbox>
 <YtfqIVEi7g4fFpqU@mit.edu> <20220720150636.cvd3ls2mbxbows27@zlang-mailbox> <YtgfevC8CnGaZpQ5@mit.edu>
In-Reply-To: <YtgfevC8CnGaZpQ5@mit.edu>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Wed, 20 Jul 2022 10:16:37 -0700
Message-ID: <CANfQU3x0jEOdbin0hOO-KBUgBLvK=uCfwyLA5iGJrOWa2stYhA@mail.gmail.com>
Subject: Re: [PATCH v5] ext4/056: add a check to make sure ext4 uuid ioctls
 get/set during fsstress.
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Zorro Lang <zlang@redhat.com>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 20, 2022 at 8:30 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Jul 20, 2022 at 11:06:36PM +0800, Zorro Lang wrote:
> > > The kill -9 is needed, because otherwise the test will run for a
> > > **very** long time.  The reason for it is because of the -n 999999 in
> >
> > Sure, I mean:
> >
> >   kill -9 $fsstress_pid 2>/dev/null
> >   wait
> >
> > Not remove the "kill" line :)
>
> Ah yes, sorry, I misunderstood what you meant.
>
> > > Also, Jeremy, it looks like you haven't updated your xfstests-dev
> > > repository in a few weeks.  Since you started this project, ext4/056
> > > has been assigned, and there has been some new helper programs added
> > > which caused patch conflicts in src/Makefile and in .gitignore.  They
> > > were pretty trivial to fix up the patch conflicts (which I've done in
> > > my xfstests-dev tree), but it's best practice to rebase on top of
> > > origin/for-next and re-test just to make sure there haven't been some
> > > major change in the fstests common scripts that might catch your test
> > > out.
> >
> > Thanks for pointing out that, yes, better to rebase to latest fstests
> > for-next branch.
>
> Jeremy, for your convenience, my version of the change which is
> rebased on for-next, fixes the merge conflicts and uses ext4/057
> instead of ext4/056 can be found here:
>
> https://github.com/tytso/xfstests/commit/330bf72dc67dd39e0fd413ecea78ab18b5405fb9

Great. Thank you everyone! I'll use your merged version, fix the wait
line, and add Reviewed-by: Zorro Lang <zlang@redhat.com>.

>
>                                                         - Ted
