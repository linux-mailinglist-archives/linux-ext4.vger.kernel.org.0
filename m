Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F231B5224
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfIQP5r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 11:57:47 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40574 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfIQP5q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 11:57:46 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 4BBA1E80FFC;
        Tue, 17 Sep 2019 17:57:44 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id EB22F160ADC; Tue, 17 Sep 2019 17:57:43 +0200 (CEST)
Date:   Tue, 17 Sep 2019 17:57:43 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917155743.GB31567@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917121156.GC6762@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 08:11, Theodore Y. Ts'o (tytso@mit.edu) wrote:

> On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
> > Willy Tarreau - 17.09.19, 07:24:38 CEST:
> > > On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
> > > > >Well, the patch actually made getrandom() return en error too, but
> > > > >you seem more interested in the hypotheticals than in arguing
> > > > >actualities.>
> > > > If you want to be safe, terminate the process.
> > >
> > > This is an interesting approach. At least it will cause bug reports in
> > > application using getrandom() in an unreliable way and they will
> > > check for other options. Because one of the issues with systems that
> > > do not finish to boot is that usually the user doesn't know what
> > > process is hanging.
> >
>
> I would be happy with a change which changes getrandom(0) to send a
> kill -9 to the process if it is called too early, with a new flag,
> getrandom(GRND_BLOCK) which blocks until entropy is available.  That
> leaves it up to the application developer to decide what behavior they
> want.

Note that calling getrandom(0) "too early" is not something people do
on purpose. It happens by accident, i.e. because we live in a world
where SSH or HTTPS or so is run in the initrd already, and in a world
where booting sometimes can be very very fast. So even if you write a
program and you think "this stuff should run late I'll just
getrandom(0)" it might not actually be that case IRL because people
deploy it a slightly bit differently than you initially thought in a
slightly differently equipped system with other runtime behaviour...

Lennart
