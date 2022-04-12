Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7D4FDC23
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Apr 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352844AbiDLKOn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Apr 2022 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357541AbiDLJtT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Apr 2022 05:49:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E66964BEA
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 01:56:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l7so30505067ejn.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Apr 2022 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKIabKy8Ujh0kQ/uW3RVLX3p2wSYQC+7wg5wsnfok+w=;
        b=OoL77DEmQr5cDKpU0Ushyj5+A9aB1avdCEgr7FG4BfCtN/+1ogs1oY+Cz6flx1dMXN
         0/YvzjMtoNUj94PgQfHf2FSz8921HLW7Iqz+hy1Ge5bp3xywhFTMMjA0awrD2Afh4I+P
         1BA741Xl1FuQq/UnDwoY0sbPPhyn1rNX8K1IrottMecGHZjrDQrhDrAaRiUe5jLs/Xmz
         5OdY3byib7Y/OnGmgK3Fcx+tvZnttVN47bM9MM++6HJlh+VsWheZLhu9oEn0jpSYeriv
         vMXVbM9X4RMG14RZDw2damHPrUAOwT5UyGH8sDPjzpBGXF0pmsnDXPlUCLxP2Xaq16jC
         Ef4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKIabKy8Ujh0kQ/uW3RVLX3p2wSYQC+7wg5wsnfok+w=;
        b=CUN1Zwmh+mPzq3Fz9TMoLqzkEXU5XB5KG83QsuHf+H9VDhuzLRA17zus4mcmKIswCY
         BNqGP7j7M1IncGS+px9j9mBrhY7tyLOv8piPYd6krEHYykRLL4rFQeademCfDi+kNKF9
         0pPfjyLrnOeC4mlK0X4jElWlpdgZohBw0s3oaUJeCXyM/g52LSdC240kHi9tanOFpr+T
         hdG4tgOrPeqZ1wZewCAWv82Ott0bWvnSVO4tbWg0SDtk/rI9z5WA1pwZAtT/V3hbp8GA
         zYDZCkCUmVlMXU8VhqGnoyjGukrULknWkXFs0Qz9JvpPT5Z4AnwWf2WM6pYupRPg7OoE
         LMbg==
X-Gm-Message-State: AOAM5306l9ee8o9B/noLaLu5u/UUP8H/kzFA0+kFDsGaP5A4JLmIooEe
        wPBs5slFT5l1JRcd8qbLBdtGX0cf6OtXh49My6749sUG
X-Google-Smtp-Source: ABdhPJyNLHEj1gWQ/Ku3xPZnMD25VrMYPaoKJ360RDCLp38lHo0GgL5TndV6us5u5b1uM7ISsw34BxpgO70Nd9F/2xs=
X-Received: by 2002:a17:906:6bcd:b0:6e8:93e4:b37f with SMTP id
 t13-20020a1709066bcd00b006e893e4b37fmr7570825ejs.529.1649753772531; Tue, 12
 Apr 2022 01:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <CACA3K+i8nZRBxeTfdy7Uq5LHAsbZEHTNati7-RRybsj_4ckUyw@mail.gmail.com>
 <Yj4+IqC6FPzEOhcW@mit.edu> <CACA3K+hAnJESkkm9q6wHQLHRkML_8D1pMKquqqW7gfLH_QpXng@mail.gmail.com>
 <YkMEtJkiR2Qktq9s@mit.edu>
In-Reply-To: <YkMEtJkiR2Qktq9s@mit.edu>
From:   Fariya F <fariya.fatima03@gmail.com>
Date:   Tue, 12 Apr 2022 14:26:01 +0530
Message-ID: <CACA3K+iNFkLLuXJ7W5N70sVC+RVVszx-xVQojNUE8NqfWFuSVg@mail.gmail.com>
Subject: Re: df returns incorrect size of partition due to huge overhead block
 count in ext4 partition
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The e2fsprogs version is 1.42.99. The exact version of df utility when
I query is 8.25.
The Linux kernel is 4.9.31. Please note the e2fsprogs ipk file was
available as part of Arago distribution for the ARM processor I use.

From your email I understand that below are the options as of now:
a) Fix in the fsck tool and kernel fix: This is something I am looking
forward to. Could you please help prioritize it?
b) Recalculating overhead at mount time: Is it possible to do it with
some specific options at mount time. I still think option #a is what
works best for us.
c) Enabling metadata checksum: May not be possible for us at the moment.

 Thanks a lot for all your help, Ted. Appreciate if you could
prioritize the fix.

On Tue, Mar 29, 2022 at 6:38 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> (Removing linux-fsdevel from the cc list since this is an ext4
> specific issue.)
>
> On Mon, Mar 28, 2022 at 09:38:18PM +0530, Fariya F wrote:
> > Hi Ted,
> >
> > Thanks for the response. Really appreciate it. Some questions:
> >
> > a) This issue is observed on one of the customer board and hence a fix
> > is a must for us or at least I will need to do a work-around so other
> > customer boards do not face this issue. As I mentioned my script
> > relies on df -h output of used percentage. In the case of the board
> > reporting 16Z of used space and size, the available space is somehow
> > reported correctly. Should my script rely on available space and not
> > on the used space% output of df. Will that be a reliable work-around?
> > Do you see any issue in using the partition from then or some where
> > down the line the overhead blocks number would create a problem and my
> > partition would end up misbehaving or any sort of data loss could
> > occur? Data loss would be a concern for us. Please guide.
>
> I'm guessing that the problem was caused by a bit-flip in the
> superblock, so it was just a matter of hardware error.  What version
> of e2fsprogs are using, and did you have metadata checksum (meta_csum)
> feature enabled?  Depending on where the bit-flip happened --- e.g.,
> whether it was in memory and then superblock was written out, or on
> the eMMC or other storage device --- if the metadata checksum feature
> caught the superblock error, it would have detected the issue, and
> while it would have required a manual fsck to fix it, at that point it
> would have fallen back to use the backup superblock version.
>
> > b) Any other suggestions of a work-around so even if the overhead
> > blocks reports more blocks than actual blocks on the partition, i am
> > able to use the partition reliably or do you think it would be a
> > better suggestion to wait for the fix in e2fsprogs?
> >
> > I think apart from the fix in e2fsprogs tool, a kernel fix is also
> > required, wherein it performs check that the overhead blocks should
> > not be greater than the actual blocks on the partition.
>
> Yes, we can certainly have the kernel check to see if the overhead
> value is completely insane, and if so, recalculate it (even though it
> would slow down the mount).
>
> Another thing we could do is to always recaluclate the overhead amount
> if the file system is smaller than some arbitrary size, on the theory
> that (a) for small file systems, the increased time to mount the file
> system will not be noticeable, and (b) embedded and mobile devices are
> often where "cost optimized" (my polite way of saying crappy quality
> to save a pentty or two in Bill of Materials costs) are most likely,
> and so those are where bit flips are more likely.
>
> Cheers,
>
>                                                 - Ted
