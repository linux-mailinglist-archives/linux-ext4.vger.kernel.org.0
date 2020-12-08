Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB022D2100
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 03:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLHClr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 21:41:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41626 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726418AbgLHClr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 21:41:47 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B82evWA024426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Dec 2020 21:40:58 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AAC93420136; Mon,  7 Dec 2020 21:40:57 -0500 (EST)
Date:   Mon, 7 Dec 2020 21:40:57 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-ext4@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
Message-ID: <20201208024057.GC52960@mit.edu>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 07, 2020 at 09:39:32PM +0100, Michael Walle wrote:
> > There are three different MMC commands which are defined:
> > 
> > 1) DISCARD
> > 2) ERASE
> > 3) SECURE ERASE
> > 
> > The first two are expected to be fast, since it only involves clearing
> > some metadata fields in the Flash Translation Layer (FTL), so that the
> > LBA's in the specified range are no longer mapped to a flash page.
> 
> Mh, where is it specified that the erase command is fast? According
> to the Physical Layer Simplified Specification Version 8.00:
> 
>  The actual erase time may be quite long, and the host may issue CMD7
>  to deselect thhe card or perform card disconnection, as described in
>  the Block Write section, above.

I looked at the eMMC specification from JEDEC (JESD84-A44) and there,
both the "erase" and "trim" are specified that the work is to be
queued to be done at a time which is convenient to the controller
(read: FTL).  This is in contrast to the "secure erase" and "secure
trim" commands, where the erasing has to be done NOW NOW NOW for "high
security applications".

The only difference between "erase" and "trim" seems to be that erahse
has to be done in units of the "erase groups" which is typically
larger than the "write pages" which is the granularity required by the
trim command.  There is also a comment that when you are erasing the
entire partition, "erase" is preferred over "trim".  (Presumably
because it is more convenient?  The spec is not clear.)

Unfortunately, the SD Card spec and the eMMC spec both read like they
were written by a standards committee stacked by hardware engineers.
It doesn't look like they had file system engineers in the room,
because the distinctions between "erase" and "trim" are pretty silly,
and not well defined.  Aside from what I wrote, the spec is remarkably
silent about what the host OS can depend upon.

From the fs perspective, what we care about is whether or not the
command is a hint or a reliable way to zero a range of sectors.  A
command could be a hint if the device is allowed to ignore it, or if
the values of the sector are indeterminate, or if the sectors are
zero'ed or not could change after a power cycle.  (I've seen an
implementation where discard would result in the LBA's being read as
zero --- but after a power cycle, reading from the same LBA would
return the old data again.  This is standards complaint, but it's not
terribly useful.)

Assuming that the command is reliable, the next question is whether
the erase operation is logical or physical --- which is to say, if an
attacker has physical access to the die, with the ability to bypass
the FTL and directly read the flash cells, could the attack retrieve
the data, even if it required a distructive, physical attack on the
hardware?  A logical erase would not require that the data be erased
or otherwise made inaccessible against an attacker who bypasses the
FTL; a physical erase would provide security guarantees that even if
your phone has handed over to state-sponsored attacker, that nothing
could be extracted after a physical erase.

So if I were king, those would be the three levels of discard: "hint",
"reliable logical", and "reliable physical", as those map to real use
cases that are of actual use to a Host.  The challenge is mapping what
we *actually* are given by different specs, which were written by
hardware engineers and make distinctions that are not well defined so
that multiple implementations can be "standard compliant", but have
completely different performance profiles, thus making life easy for
the marketing types, and hard for the file system engineers.  :-)

All I can tell you is that I know a bunch of Android system team
members at $WORK, and the current assumptions seem to work just fine
for the sorts of devices that are used on mobile handsets --- even
really cheap ones that are sold in India.  At least, there are bunch
of "cost optimized" (as well as high end) Android devices running
ext4, and no one has complained to me about mke2fs taking a long time.

I definitely agree with you that the SD Card spec seems to imply that
other standards-compliant implementations could have the erase command
taking minutes, and this seems to be allowable by the spec.  I would
consider this to be a flaw in the spec, myself.  But I don't sit on
the standards committess, and I don't write the specs.  I (and
everyone else) just have to live with them.   Sigh....

	       	    	    	      - Ted
