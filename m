Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E7C2D2F4F
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgLHQSo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 11:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLHQSo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 11:18:44 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A18C0613D6
        for <linux-ext4@vger.kernel.org>; Tue,  8 Dec 2020 08:18:03 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id n18so5775113ual.9
        for <linux-ext4@vger.kernel.org>; Tue, 08 Dec 2020 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbhQFLdCZ96w5QgWAp8Vujq+g3QNVh3Nk4mA27hHp4E=;
        b=AgMVHkahg2pNl5nrPVCbBT6B42GivboG1Yz/6C5NBBO/M2kq7nj3AtQORQH/Tz3SDy
         hqq7b0OosMo40YDshPaDilSCSjaj5ZYq5hI5tdW4Uig/9HxEIQVvlQGSok/vW2+tOtzK
         JthEGykf4eNRVxdThvsfkJFLbHgoDpquHPVXZONp2qrH4Jrf2cV+UMDxtzW8884yaoAW
         wyceVnJbTTdL1ZqHpGr1A3XNDe8NCxKMumXB5CSDv7Lvh/vs2lLQxrM98Uv6WRx4fhp2
         18NOUlunN2xd7t1OR+IAh1nabV3jHV6G2cBmuZh9KXWEMUtKR7mys+Kil346lysIVuK7
         coqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbhQFLdCZ96w5QgWAp8Vujq+g3QNVh3Nk4mA27hHp4E=;
        b=FmR8igQ82SIeoA3PMfVTNz5K4vliAl+htmx1TVWI7uCtEs8nHZAtElu3yNu4xR+RXG
         YN9ynxK1oj9CXAoW9xH7ii8JozukiCFW3XNpayO51cqodYQPNkP/EV6UBjfriuq4Dxu/
         KsGb8oSiPYAIYMt5Vr9buQ7eNj3ZCqCmJaoawaGQNBlLf/NuF72kF3WMeuVP6WDiuIVO
         OPXh6wXBqNxV7XjwFR/2V3rOvFUNATWxfz1EvDiK72omU/3bryRjm2LiVCoyc5O00WI6
         NtBhG13RZcKYQBCE2WGberR+9ibXT3Bf90gNZK/QhNzhc8z6mbz4l0uTH6QKeogPnlNk
         oqJA==
X-Gm-Message-State: AOAM531Wc2QSbObdIs5VPo49q4IVxumCxXHssUsr4pnlE1yOAwx7CYn4
        XeiL7hOj848eVdtMUGXnSKD5sIYd6wXsdPamsHChRA==
X-Google-Smtp-Source: ABdhPJzxv8o/M3YY8OFK/T3OqqY6UqmQZxHO883P7R6h8izIJvHIhNlJw8HwiAOuyi446Y2TIIwJJBYA0FYRT8aSAMM=
X-Received: by 2002:a9f:3e4b:: with SMTP id c11mr15703128uaj.19.1607444282471;
 Tue, 08 Dec 2020 08:18:02 -0800 (PST)
MIME-Version: 1.0
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc> <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc> <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com> <d7041bbb403698ac1097f7740f364467@walle.cc>
In-Reply-To: <d7041bbb403698ac1097f7740f364467@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Dec 2020 17:17:26 +0100
Message-ID: <CAPDyKFqFT9g8OnyxEOEiATgmkgdCceu_G3drKqX3NawxSDV0kg@mail.gmail.com>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
To:     Michael Walle <michael@walle.cc>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 8 Dec 2020 at 12:26, Michael Walle <michael@walle.cc> wrote:
>
> Hi Ulf, Hi Ted,
>
> Am 2020-12-08 10:49, schrieb Ulf Hansson:
> > On Tue, 8 Dec 2020 at 03:41, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >> On Mon, Dec 07, 2020 at 09:39:32PM +0100, Michael Walle wrote:
> >> > > There are three different MMC commands which are defined:
> >> > >
> >> > > 1) DISCARD
> >> > > 2) ERASE
> >> > > 3) SECURE ERASE
> >> > >
> >> > > The first two are expected to be fast, since it only involves clearing
> >> > > some metadata fields in the Flash Translation Layer (FTL), so that the
> >> > > LBA's in the specified range are no longer mapped to a flash page.
> >> >
> >> > Mh, where is it specified that the erase command is fast? According
> >> > to the Physical Layer Simplified Specification Version 8.00:
> >> >
> >> >  The actual erase time may be quite long, and the host may issue CMD7
> >> >  to deselect thhe card or perform card disconnection, as described in
> >> >  the Block Write section, above.
> >
> > Before I go into some more detail, of course I fully agree that
> > dealing with erase/discard from the eMMC/SD specifications (and other
> > types of devices) point of view isn't entirely easy. :-)
> >
> > But I also think we can do better than currently, at least for eMMC/SD.
> >
> >>
> >> I looked at the eMMC specification from JEDEC (JESD84-A44) and there,
> >> both the "erase" and "trim" are specified that the work is to be
> >> queued to be done at a time which is convenient to the controller
> >> (read: FTL).  This is in contrast to the "secure erase" and "secure
> >> trim" commands, where the erasing has to be done NOW NOW NOW for "high
> >> security applications".
>
> Oh this might also be because I've cited from the wrong place, namely
> the
> mmc_init_card() function. But what I really meant was the sd card
> equivalent
> which should be mmc_read_ssr(). Sorry.
>
>         discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
>         card->erase_arg = (card->scr.sda_specx && discard_support) ?
>                             SD_DISCARD_ARG : SD_ERASE_ARG;

I assumed you were referring to this, but good that you pointed this
out, for clarity.

>
> >> The only difference between "erase" and "trim" seems to be that erahse
> >> has to be done in units of the "erase groups" which is typically
> >> larger than the "write pages" which is the granularity required by the
> >> trim command.  There is also a comment that when you are erasing the
> >> entire partition, "erase" is preferred over "trim".  (Presumably
> >> because it is more convenient?  The spec is not clear.)
> >>
> >> Unfortunately, the SD Card spec and the eMMC spec both read like they
> >> were written by a standards committee stacked by hardware engineers.
> >> It doesn't look like they had file system engineers in the room,
> >> because the distinctions between "erase" and "trim" are pretty silly,
> >> and not well defined.  Aside from what I wrote, the spec is remarkably
> >> silent about what the host OS can depend upon.
> >
> > Moreover, the specs have evolved over the years. Somehow, we need to
> > map a REQ_OP_DISCARD and   to the best matching
> > operation that the currently inserted eMMC/SD card supports...
>
> Do we really need to map these functions? What if we don't have an
> actual discard, but just a slow erase (I'm now assuming that erase
> will likely be slow on sdcards)? Can't we just tell the user space
> there is no discard? Like on a normal HDD?

I have considered that, but not sure what would be the best option.

> I really don't know the
> implications, seems like mmc_erase() is just there for the linux
> discard feature.

mmc_erase() is used for both REQ_OP_DISCARD and REQ_OP_SECURE_ERASE,
but that's an implementation detail that we can change, of course.

Honestly, the hole erase/discard support in the mmc core deserves a
cleanup and I am looking at that (occasionally).

>
> Coming from the user space side. Does mkfs.ext4 assumes its pre-discard
> is fast? I'd think so, right? I'd presume it was intented to tell the
> FTL of the block device, "hey these blocks are unused, you can do some
> wear leveling with them".

I would assume that too.

On the other hand, I guess there are situations when user space could
live with slow formatting times. In particular if the goal is to let
card clean up its internal garbage, as a way to improve "performance"
for later I/O writes.

>
> > Long time time ago, both the SD and eMMC spec introduced support for
> > real discards commands, as being hints to the card without any
> > guarantees of what will happen to the data from a logical or a
> > physical point of view. If the card supports that, we should use it as
> > the first option for REQ_OP_DISCARD. Although, what should we pick as
> > the second best option, when the card doesn't support discard - that's
> > when it becomes more tricky. And the similar applies for
> > REQ_OP_SECURE_ERASE, or course.
> >
> > If you have any suggestions for how we can improve in the above
> > decisions, feel free to suggest something.
> >
> > Another issue that most likely is causing poor performance for
> > REQ_OP_DISCARD/REQ_OP_SECURE_ERASE for eMMC/SD, is that in
> > mmc_queue_setup_discard() we set up the maximum discard sectors
> > allowed per request and the discard granularity.
> >
> > To find performance bottlenecks, I would start looking at what actual
> > eMMC/SD commands/args we end up mapping towards the
> > REQ_OP_DISCARD/REQ_OP_SECURE_ERASE requests. Then definitely, I would
> > also look at the values we end up picking as max discard sectors and
> > the discard granularity.
>
> I'm just about finding some SD cards and looking how they behave timing
> wise and what they report they support (ie. erase or discard). Looks
> like other cards are doing better. But I'd have to find out if they
> support the discard (mine doesn't) and if they are slow too if I force
> them to use the normal erase.

Sounds great, looking forward to hear more about your findings.

[...]

Kind regards
Uffe
