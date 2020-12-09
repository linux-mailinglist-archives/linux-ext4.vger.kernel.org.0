Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181A62D46DD
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 17:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgLIQgj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Dec 2020 11:36:39 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51922 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730461AbgLIQg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Dec 2020 11:36:29 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B9GZX6O005765
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Dec 2020 11:35:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A87AF420136; Wed,  9 Dec 2020 11:35:33 -0500 (EST)
Date:   Wed, 9 Dec 2020 11:35:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, linux-ext4@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
Message-ID: <20201209163533.GI52960@mit.edu>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu>
 <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
 <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
 <d7041bbb403698ac1097f7740f364467@walle.cc>
 <20201208165214.GD52960@mit.edu>
 <CAPDyKFrpccdMyqsxTi2dotbtr3_7hL0hUjWXc5Sx52kGnrDuLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrpccdMyqsxTi2dotbtr3_7hL0hUjWXc5Sx52kGnrDuLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 09, 2020 at 03:51:24PM +0100, Ulf Hansson wrote:
> 
> Even if the discarded blocks are flushed at some wisely selected
> point, when the device is idle, that doesn't guarantee that the
> internal garbage collection runs inside the device. In the end that
> depends on the FW implementation of the card - and I assume it's
> likely triggered based on some internal idle time and the amount of
> "garbage" there is to deal with.

At least from a file system perspective, I don't care when the
internal garbage collection actually runs inside the device.  What I
do care is that (a) a read to a discarded sector returns zero's after
it has been discard (or the storage device needs to tell me I can't
count on that), and (b) that eventually, for write endurance reasons,
the garbage collection will *eventually* happen.

If the list of erase blocks or flash pages that are not in use are
tracked in such a way that they are actually garbage collected before
the device actually needs free blocks, it really doesn't matter if it
happens right away, or hours later.  (If the device is 90% free,
because it was just formatted and we did a pre-discard at format time,
then it could happen hours or days later.)

But if the device's FTL is too incompetent such that it loses track of
which erase blocks / flash pages do need to be GC'ed, such that it
impacts device lifetime... well then, that's sad, and it would be nice
to find out about this without having to do an expensive,
time-consuming certification process.  (OTOH, all the big companies
are doing hardware certifications anyway, because you can't fully
trust the storage vendors, and how many storage vendors are really
going to admit, or make it easy to determine, "the FTL is so
cost-optimized that it's cr*p"?  :-)

Having a way to tell the storage device that it would be better to
suspend GC, or to accelerate GC, because we know the device is about
to become much less likely to perform writes, would certainly be a
good and useful thing to do, although I see that as mostly being
useful for improving I/O performance, especially for low-end flash ---
I suspect that for high-end SSD's, which are designed so that they can
handle continuous write streams without much performance degradation,
they have enough oomph in their internal CPU that they can do GC's in
real-time while the device is under a continuous random write workload
with only minimal performance impacts.

> *) Use the runtime PM framework to detect an idle period and then
> trigger background operations. The problem is, that we don't really
> know how long we will be idle, meaning that we don't know if it's
> really a wise decision to trigger the background operations in the
> end.
> 
> **) Invent a new type of generic block request, as to let userspace
> trigger this.

I think you really want to give userspace the ability to trigger this.
Whether it's via a generic block request, or an ioctl, I'll leave that
to the people maintain the driver and/or block layer.  That's because
userspace will have knowledge to things like, "the screen is off", or
"the phone is on the wireless charger and/or the user has said, "OK,
Google, goodnight" to trigger the night-time home automation commands.

We can of course try to make some automatic determinations based on
the runtime PM framework, but that doesn't necessarily tell us the
likelihood that the system will become busy in the future; OTOH, maybe
that doesn't matter, if the storage needs only a very tiny amount of
time after it's told, "stop GC", to finish up what it's doing so it
can respond to I/O request at full speed?

						- Ted
