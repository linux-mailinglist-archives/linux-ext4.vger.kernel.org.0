Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E22D44D2
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 15:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgLIOwo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 09:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbgLIOwm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 09:52:42 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030FAC061794
        for <linux-ext4@vger.kernel.org>; Wed,  9 Dec 2020 06:52:01 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id w66so394320vka.3
        for <linux-ext4@vger.kernel.org>; Wed, 09 Dec 2020 06:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdMQ4ENUJAwDKpq6YGuzjxRRhbtj63eVZUaKhU3HWx4=;
        b=WusDzr6lbmJcpg7SlW+CJ9WoxWVL0WYU3va7KO80XJ/idS8gQKVqlgSIfTd8/l4bJI
         +fp842fy9wDLEkWjL5UU+EM7v/1raLon67cpxhDenquRw5C6yegTwQbcHyoc873GjtM6
         XGqOghMwHoq2UfN/n+W9l8ZmLq7y7QW09aI/vMCNkfMGd4K+XamHOzBlkE99BfT/eYrj
         6G60MHKLL0hvHXq3xXjVQfbp6oo6DZZj1T0CGMP/NEt54DyY3AxQ1olP0wkDzZgF3+Hu
         nZi4D61NDIbc0hsQs516L8EdT/9Si6fZ6GKuDeNWT+AkE+3l7CdKPpWH6DZnuF6iQpNA
         nBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdMQ4ENUJAwDKpq6YGuzjxRRhbtj63eVZUaKhU3HWx4=;
        b=tAdNss9RTwIHrtekf8bu/yYzGu57r+HFYA0u/JF2bQ1D6dCHVCL9dDTczha9yke2Tt
         wLUfzk+Ch6xr4gCP38GfE4rdA8GAznrbkZ1/EmfanF7UifiO793HdaoKAZrTFvJ73wQC
         I9trSr2ee18a0x4SnJne2Jdp9B1Tx/wEA3HMHFA//LtNQBh3BGNqPKzBpA2BFguLPvhD
         Grq3zwqLAQz2+N3C+XR6GL47IpBN8HsME/Emog3xGCi5xH4hQk55agqcpvMmqpaLhSRp
         YOT/bkyaUVPmJSeDfxT4qjYGHtLRC3K6ZgXV553uZpFojnzxFqyoFolhQfkHabm2pYAO
         GZFA==
X-Gm-Message-State: AOAM5332GeuSUjtRhzBub2gKE9zSxVVodYvuPrttheY33PbzB2K1yEIz
        yvCkOEyqFOvMDDleGF/nXMLwhE95KSei5ouKkOmDJQ==
X-Google-Smtp-Source: ABdhPJxLMJiclWLbEVkhdiex2z02t+bsvo4kzUXNOWOXd3kibkzblj+Jly65Bgz0STAEqM9AUer3aG4gvYdnemVe9Kw=
X-Received: by 2002:a1f:dec2:: with SMTP id v185mr2358196vkg.8.1607525520925;
 Wed, 09 Dec 2020 06:52:00 -0800 (PST)
MIME-Version: 1.0
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc> <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc> <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
 <d7041bbb403698ac1097f7740f364467@walle.cc> <20201208165214.GD52960@mit.edu>
In-Reply-To: <20201208165214.GD52960@mit.edu>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Dec 2020 15:51:24 +0100
Message-ID: <CAPDyKFrpccdMyqsxTi2dotbtr3_7hL0hUjWXc5Sx52kGnrDuLw@mail.gmail.com>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Michael Walle <michael@walle.cc>, linux-ext4@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 8 Dec 2020 at 17:52, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Dec 08, 2020 at 12:26:22PM +0100, Michael Walle wrote:
> > Do we really need to map these functions? What if we don't have an
> > actual discard, but just a slow erase (I'm now assuming that erase
> > will likely be slow on sdcards)? Can't we just tell the user space
> > there is no discard? Like on a normal HDD? I really don't know the
> > implications, seems like mmc_erase() is just there for the linux
> > discard feature.
>
> So the potential gotcha here is that "discard" is important for
> reducing write amplification, and thus improving the lifespan of
> devices.  (See my reference to the Tesla engine controller story
> earlier.)  So if a device doesn't have "discard" but has "erase", and
> "erase" is fast, then skipping the discard could end up significantly
> reducing the lifespan of your product, and we're back to the NHTSA
> investigating whether they should stick Tesla for the $1500 engine
> controller replacement when cards die early.

Yes, exactly. The point about wear leveling and the lifespan of the
device are critical.

That said, we should continue to map discard requests to legacy erase
commands for SD cards, unless the card supports the new discard, of
course.

One thing I realized though, is that we should probably announce and
implement support for secure erase (QUEUE_FLAG_SECERASE) for SD cards,
as that seems to map well towards with the erase command.

An erase is specified in the SD spec as, after the erase the data is
either "0" or "1", which I guess is what is expected from a
REQ_OP_SECURE_ERASE operation?

>
> I guess the JEDEC spec does specify a way to query the card for how
> long an erase takes, but I don't have the knowledge about how the
> actual real-world implementations of these specs (and their many
> variants over the years) actually behave.  Can the erase times that
> they advertise actually be trusted to be accurate?  How many of them
> actually supply erase times at all, no matter what the spec says?

For eMMC discard commands are fast, but probably also trim commands.
For erase I don't know.

Then, whether the corresponding "erase times" that are be specified in
the eMMC registers, I guess those always refer to the worst case
scenario. I don't know how useful they really are in the end.

In any case, we may end up with poor erase/discard performance,
because of internal FW implementations.

Although, what I think we may be able to improve, both from eMMC and
SD point of view, is to allow more blocks per discard/erase operation.
But honestly, I don't know how big of a problem this is, even if just
staring at the code, gives me some ideas.

>
> > Coming from the user space side. Does mkfs.ext4 assumes its pre-discard
> > is fast? I'd think so, right? I'd presume it was intented to tell the
> > FTL of the block device, "hey these blocks are unused, you can do some
> > wear leveling with them".
>
> Yes, the assumption is that discard is fast.  Exactly how fast seems
> to vary; this is one of the reasons why there are three different ways
> to do discards on a file system after files are deleted.  One way is
> to do them after the deleted definitely won't be unwound (i.e., after
> the ext4 journal commit).  But on some devices, the discard command,
> while fast, is slow enough that this will compete with the I/O
> completion times of other read commands, thus degrading system
> performance.  So you can also execute the trim commands out of cron,
> using the fstrim command, which will run the discards in the
> background, and the system administrator can adjust when fstrim is
> executed during times wheno performance isn't critical.  (e.g., when
> the phone is on a charger in the middle of the night, or at 4am local
> time, etc.)  Finally, you can configure e2fsck to run the discards
> after the file system consistency check is done.
>
> The reason why we have to leave this up to the system administrators
> is that we have essentially no guidance from the device how slow the
> discard command might be, how it intereferes with other device
> operations, and whether the discard might be more likely ignored if
> the device is busy.  So it might be that the discard will more likely
> improve write endurance when it is done when the device is idle.  All
> of the speccs (SCSI, SATA, UFS, eMMC, SD) are remarkable unhelpful
> because performance considerations is generally consider "out of
> scope" of standards committees.  They want to leave that up to market
> forces; which is why big companies (at handset vendors, hyperscale
> cloud providers, systems integrators, etc.) have to spend as much
> money doing certification testing before deciding which products to
> buy; think of it as a full-employment act for storage engineers.  :-)

A few comments related to the above.

Even if the discarded blocks are flushed at some wisely selected
point, when the device is idle, that doesn't guarantee that the
internal garbage collection runs inside the device. In the end that
depends on the FW implementation of the card - and I assume it's
likely triggered based on some internal idle time and the amount of
"garbage" there is to deal with.

For both eMMC and SD cards, the specs define commands for how to
manually control the background operations inside the cards. In
principle, this allows us to tell the card when it's a good time to
run garbage collection (and when not to).

Both for eMMC and SD, we are not using this, yet. However, I have been
playing with a couple of different ideas to explore this:

*) Use the runtime PM framework to detect an idle period and then
trigger background operations. The problem is, that we don't really
know how long we will be idle, meaning that we don't know if it's
really a wise decision to trigger the background operations in the
end.

**) Invent a new type of generic block request, as to let userspace
trigger this.

Of course, another option is also to leave this as is, thus relying on
the internal FW of the card to act the best it can.

Do you have any thoughts around this?

[...]

Kind regards
Uffe
