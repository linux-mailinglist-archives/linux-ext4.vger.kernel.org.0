Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D592D2822
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgLHJuu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 04:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgLHJut (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 04:50:49 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBA6C0613D6
        for <linux-ext4@vger.kernel.org>; Tue,  8 Dec 2020 01:50:03 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v3so1103084vkb.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Dec 2020 01:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2kZdU6xAATA8afPjSbaUFvj53IL1FloZ2Fcg9Z0qb0=;
        b=SbL5adQziQdh41QS9rIWevrpl3jNzf2hMWA39qV7Sr++gAmUeFcJzR4+3YHe+6yILx
         YtOvysRrbLU1FP7a9pLUytPmGXtujjXe3bXyV7s0WdpDty84gRtTgZfyhQecMcrntVsF
         Z4Lc2HHJOHgSZoic98FIlLGMDp6wqgM8GvwMp3G/vG1jpgzAnH/4Y3gHEb6ad+8Zym5J
         Sy66uy7282XP8fWthAgR7ZVKE7ozfXfFH2+76CqlhX9ILWBSkBawPEXWXqHZ7FYMmRY2
         BukxA4fnWQr5W5bO0p1KlB2dTxn8e4tBnUOk1gbxB05Vbhnx8bu2vh2i3eD1ZCZRvwaP
         VNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2kZdU6xAATA8afPjSbaUFvj53IL1FloZ2Fcg9Z0qb0=;
        b=qEucDVTcRnJf08yGUI3l/x145yrbzJvhz0rqTCn+toLZujU5peeRXEAwZxJK4Ht7c/
         EtNksUOmExL5gODfjsAEMwa3KRsAm9mUCjtN88rT49mO7XMQDPDZqA12oGK/GBAXkVrW
         iDIPjTNod0Azv05yTPUqweIOL780/K7GD7C7L1bTrl9smIL7SViVqIANuxOCcztQFCFL
         eWO3g7ldndElE7a1P8CneCENrDNoEp0OiDxAxORyQ/mpVWLkYRP/GnvpZE9Y9z+nbVgH
         kEBR92tQuNN5Ur2Zuu4eFocpbQ+j3PYxip5k0gwFAi2jEs1esu7nSA/FC1q4AefHCv50
         uykQ==
X-Gm-Message-State: AOAM533OypLu/79xceYPmqmaR+i7D6tjUKDAvI5KVGd1yjwgiNUF4RpK
        j4gsEhFj1FLGLcAt0Na7h7OOfNOkrW27iklcdIymkQ==
X-Google-Smtp-Source: ABdhPJz9FLrnfEq+ttBq7kxXr5aUvSnFrr/unwT7mZDLOoTpuZGVnF+AL0GuhpkR0nPFa8fJgflwL9QbL2jgEflNe7I=
X-Received: by 2002:a1f:8f48:: with SMTP id r69mr15757760vkd.6.1607421002919;
 Tue, 08 Dec 2020 01:50:02 -0800 (PST)
MIME-Version: 1.0
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc> <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc> <20201208024057.GC52960@mit.edu>
In-Reply-To: <20201208024057.GC52960@mit.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Dec 2020 10:49:26 +0100
Message-ID: <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Michael Walle <michael@walle.cc>
Cc:     linux-ext4@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted, Michael,

On Tue, 8 Dec 2020 at 03:41, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Dec 07, 2020 at 09:39:32PM +0100, Michael Walle wrote:
> > > There are three different MMC commands which are defined:
> > >
> > > 1) DISCARD
> > > 2) ERASE
> > > 3) SECURE ERASE
> > >
> > > The first two are expected to be fast, since it only involves clearing
> > > some metadata fields in the Flash Translation Layer (FTL), so that the
> > > LBA's in the specified range are no longer mapped to a flash page.
> >
> > Mh, where is it specified that the erase command is fast? According
> > to the Physical Layer Simplified Specification Version 8.00:
> >
> >  The actual erase time may be quite long, and the host may issue CMD7
> >  to deselect thhe card or perform card disconnection, as described in
> >  the Block Write section, above.

Before I go into some more detail, of course I fully agree that
dealing with erase/discard from the eMMC/SD specifications (and other
types of devices) point of view isn't entirely easy. :-)

But I also think we can do better than currently, at least for eMMC/SD.

>
> I looked at the eMMC specification from JEDEC (JESD84-A44) and there,
> both the "erase" and "trim" are specified that the work is to be
> queued to be done at a time which is convenient to the controller
> (read: FTL).  This is in contrast to the "secure erase" and "secure
> trim" commands, where the erasing has to be done NOW NOW NOW for "high
> security applications".
>
> The only difference between "erase" and "trim" seems to be that erahse
> has to be done in units of the "erase groups" which is typically
> larger than the "write pages" which is the granularity required by the
> trim command.  There is also a comment that when you are erasing the
> entire partition, "erase" is preferred over "trim".  (Presumably
> because it is more convenient?  The spec is not clear.)
>
> Unfortunately, the SD Card spec and the eMMC spec both read like they
> were written by a standards committee stacked by hardware engineers.
> It doesn't look like they had file system engineers in the room,
> because the distinctions between "erase" and "trim" are pretty silly,
> and not well defined.  Aside from what I wrote, the spec is remarkably
> silent about what the host OS can depend upon.

Moreover, the specs have evolved over the years. Somehow, we need to
map a REQ_OP_DISCARD and REQ_OP_SECURE_ERASE to the best matching
operation that the currently inserted eMMC/SD card supports...

Long time time ago, both the SD and eMMC spec introduced support for
real discards commands, as being hints to the card without any
guarantees of what will happen to the data from a logical or a
physical point of view. If the card supports that, we should use it as
the first option for REQ_OP_DISCARD. Although, what should we pick as
the second best option, when the card doesn't support discard - that's
when it becomes more tricky. And the similar applies for
REQ_OP_SECURE_ERASE, or course.

If you have any suggestions for how we can improve in the above
decisions, feel free to suggest something.

Another issue that most likely is causing poor performance for
REQ_OP_DISCARD/REQ_OP_SECURE_ERASE for eMMC/SD, is that in
mmc_queue_setup_discard() we set up the maximum discard sectors
allowed per request and the discard granularity.

To find performance bottlenecks, I would start looking at what actual
eMMC/SD commands/args we end up mapping towards the
REQ_OP_DISCARD/REQ_OP_SECURE_ERASE requests. Then definitely, I would
also look at the values we end up picking as max discard sectors and
the discard granularity.

>
> From the fs perspective, what we care about is whether or not the
> command is a hint or a reliable way to zero a range of sectors.  A
> command could be a hint if the device is allowed to ignore it, or if
> the values of the sector are indeterminate, or if the sectors are
> zero'ed or not could change after a power cycle.  (I've seen an
> implementation where discard would result in the LBA's being read as
> zero --- but after a power cycle, reading from the same LBA would
> return the old data again.  This is standards complaint, but it's not
> terribly useful.)

:-)

>
> Assuming that the command is reliable, the next question is whether
> the erase operation is logical or physical --- which is to say, if an
> attacker has physical access to the die, with the ability to bypass
> the FTL and directly read the flash cells, could the attack retrieve
> the data, even if it required a distructive, physical attack on the
> hardware?  A logical erase would not require that the data be erased
> or otherwise made inaccessible against an attacker who bypasses the
> FTL; a physical erase would provide security guarantees that even if
> your phone has handed over to state-sponsored attacker, that nothing
> could be extracted after a physical erase.
>
> So if I were king, those would be the three levels of discard: "hint",
> "reliable logical", and "reliable physical", as those map to real use
> cases that are of actual use to a Host.  The challenge is mapping what
> we *actually* are given by different specs, which were written by
> hardware engineers and make distinctions that are not well defined so
> that multiple implementations can be "standard compliant", but have
> completely different performance profiles, thus making life easy for
> the marketing types, and hard for the file system engineers.  :-)

I agree, these are the three levels that make sense to support.

Honestly I haven't been paying enough attention to discussions for the
generic block layer around discards. However, considering what you
just stated above, we seem to be missing one request operation, don't
we?

[...]

Kind regards
Uffe
