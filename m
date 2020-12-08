Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E372D29C1
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgLHL1G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 06:27:06 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:34537 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgLHL1F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 06:27:05 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 271BE22EE4;
        Tue,  8 Dec 2020 12:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607426783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWl+I7X6TJi78y7STr+Q0MnVYohL9QwffjUsZSPHXPA=;
        b=Sotu8v3/HzIH7GFx2gr7/3Dh9Lmeyk4m4JL+qWxY28Lh3KMPqmz7RfOBghDZvtuKI+s1Hq
        BvDcM6qoqaGjoxtwzDhk4n9N90dS+PnxENBByAqkWJplKlc5UumNAuPTbHkAGlsFOEa5B7
        /eI4kJUZzckQwg0z5QZlm6Mpv7ghG1E=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 12:26:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
In-Reply-To: <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu> <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
 <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d7041bbb403698ac1097f7740f364467@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ulf, Hi Ted,

Am 2020-12-08 10:49, schrieb Ulf Hansson:
> On Tue, 8 Dec 2020 at 03:41, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> On Mon, Dec 07, 2020 at 09:39:32PM +0100, Michael Walle wrote:
>> > > There are three different MMC commands which are defined:
>> > >
>> > > 1) DISCARD
>> > > 2) ERASE
>> > > 3) SECURE ERASE
>> > >
>> > > The first two are expected to be fast, since it only involves clearing
>> > > some metadata fields in the Flash Translation Layer (FTL), so that the
>> > > LBA's in the specified range are no longer mapped to a flash page.
>> >
>> > Mh, where is it specified that the erase command is fast? According
>> > to the Physical Layer Simplified Specification Version 8.00:
>> >
>> >  The actual erase time may be quite long, and the host may issue CMD7
>> >  to deselect thhe card or perform card disconnection, as described in
>> >  the Block Write section, above.
> 
> Before I go into some more detail, of course I fully agree that
> dealing with erase/discard from the eMMC/SD specifications (and other
> types of devices) point of view isn't entirely easy. :-)
> 
> But I also think we can do better than currently, at least for eMMC/SD.
> 
>> 
>> I looked at the eMMC specification from JEDEC (JESD84-A44) and there,
>> both the "erase" and "trim" are specified that the work is to be
>> queued to be done at a time which is convenient to the controller
>> (read: FTL).  This is in contrast to the "secure erase" and "secure
>> trim" commands, where the erasing has to be done NOW NOW NOW for "high
>> security applications".

Oh this might also be because I've cited from the wrong place, namely 
the
mmc_init_card() function. But what I really meant was the sd card 
equivalent
which should be mmc_read_ssr(). Sorry.

	discard_support = UNSTUFF_BITS(resp, 313 - 288, 1);
	card->erase_arg = (card->scr.sda_specx && discard_support) ?
			    SD_DISCARD_ARG : SD_ERASE_ARG;

>> The only difference between "erase" and "trim" seems to be that erahse
>> has to be done in units of the "erase groups" which is typically
>> larger than the "write pages" which is the granularity required by the
>> trim command.  There is also a comment that when you are erasing the
>> entire partition, "erase" is preferred over "trim".  (Presumably
>> because it is more convenient?  The spec is not clear.)
>> 
>> Unfortunately, the SD Card spec and the eMMC spec both read like they
>> were written by a standards committee stacked by hardware engineers.
>> It doesn't look like they had file system engineers in the room,
>> because the distinctions between "erase" and "trim" are pretty silly,
>> and not well defined.  Aside from what I wrote, the spec is remarkably
>> silent about what the host OS can depend upon.
> 
> Moreover, the specs have evolved over the years. Somehow, we need to
> map a REQ_OP_DISCARD and REQ_OP_SECURE_ERASE to the best matching
> operation that the currently inserted eMMC/SD card supports...

Do we really need to map these functions? What if we don't have an
actual discard, but just a slow erase (I'm now assuming that erase
will likely be slow on sdcards)? Can't we just tell the user space
there is no discard? Like on a normal HDD? I really don't know the
implications, seems like mmc_erase() is just there for the linux
discard feature.

Coming from the user space side. Does mkfs.ext4 assumes its pre-discard
is fast? I'd think so, right? I'd presume it was intented to tell the
FTL of the block device, "hey these blocks are unused, you can do some
wear leveling with them".

> Long time time ago, both the SD and eMMC spec introduced support for
> real discards commands, as being hints to the card without any
> guarantees of what will happen to the data from a logical or a
> physical point of view. If the card supports that, we should use it as
> the first option for REQ_OP_DISCARD. Although, what should we pick as
> the second best option, when the card doesn't support discard - that's
> when it becomes more tricky. And the similar applies for
> REQ_OP_SECURE_ERASE, or course.
> 
> If you have any suggestions for how we can improve in the above
> decisions, feel free to suggest something.
> 
> Another issue that most likely is causing poor performance for
> REQ_OP_DISCARD/REQ_OP_SECURE_ERASE for eMMC/SD, is that in
> mmc_queue_setup_discard() we set up the maximum discard sectors
> allowed per request and the discard granularity.
> 
> To find performance bottlenecks, I would start looking at what actual
> eMMC/SD commands/args we end up mapping towards the
> REQ_OP_DISCARD/REQ_OP_SECURE_ERASE requests. Then definitely, I would
> also look at the values we end up picking as max discard sectors and
> the discard granularity.

I'm just about finding some SD cards and looking how they behave timing
wise and what they report they support (ie. erase or discard). Looks
like other cards are doing better. But I'd have to find out if they
support the discard (mine doesn't) and if they are slow too if I force
them to use the normal erase.

>> From the fs perspective, what we care about is whether or not the
>> command is a hint or a reliable way to zero a range of sectors.  A
>> command could be a hint if the device is allowed to ignore it, or if
>> the values of the sector are indeterminate, or if the sectors are
>> zero'ed or not could change after a power cycle.  (I've seen an
>> implementation where discard would result in the LBA's being read as
>> zero --- but after a power cycle, reading from the same LBA would
>> return the old data again.  This is standards complaint, but it's not
>> terribly useful.)
> 
> :-)
> 
>> 
>> Assuming that the command is reliable, the next question is whether
>> the erase operation is logical or physical --- which is to say, if an
>> attacker has physical access to the die, with the ability to bypass
>> the FTL and directly read the flash cells, could the attack retrieve
>> the data, even if it required a distructive, physical attack on the
>> hardware?  A logical erase would not require that the data be erased
>> or otherwise made inaccessible against an attacker who bypasses the
>> FTL; a physical erase would provide security guarantees that even if
>> your phone has handed over to state-sponsored attacker, that nothing
>> could be extracted after a physical erase.
>> 
>> So if I were king, those would be the three levels of discard: "hint",
>> "reliable logical", and "reliable physical", as those map to real use
>> cases that are of actual use to a Host.  The challenge is mapping what
>> we *actually* are given by different specs, which were written by
>> hardware engineers and make distinctions that are not well defined so
>> that multiple implementations can be "standard compliant", but have
>> completely different performance profiles, thus making life easy for
>> the marketing types, and hard for the file system engineers.  :-)
> 
> I agree, these are the three levels that make sense to support.
> 
> Honestly I haven't been paying enough attention to discussions for the
> generic block layer around discards. However, considering what you
> just stated above, we seem to be missing one request operation, don't
> we?

-michael
