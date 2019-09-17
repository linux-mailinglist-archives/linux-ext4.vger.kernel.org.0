Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E084DB53BA
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfIQRNb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:13:31 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40706 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfIQRNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:13:31 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 2C072E80FFC;
        Tue, 17 Sep 2019 19:13:29 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id B6E09160ADC; Tue, 17 Sep 2019 19:13:28 +0200 (CEST)
Date:   Tue, 17 Sep 2019 19:13:28 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
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
Message-ID: <20190917171328.GA31798@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917155743.GB31567@gardel-login>
 <20190917162137.GA27921@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190917162137.GA27921@1wt.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 18:21, Willy Tarreau (w@1wt.eu) wrote:

> On Tue, Sep 17, 2019 at 05:57:43PM +0200, Lennart Poettering wrote:
> > Note that calling getrandom(0) "too early" is not something people do
> > on purpose. It happens by accident, i.e. because we live in a world
> > where SSH or HTTPS or so is run in the initrd already, and in a world
> > where booting sometimes can be very very fast.
>
> It's not an accident, it's a lack of understanding of the impacts
> from the people who package the systems. Generating an SSH key from
> an initramfs without thinking where the randomness used for this could
> come from is not accidental, it's a lack of experience that will be
> fixed once they start to collect such reports. And those who absolutely
> need their SSH daemon or HTTPS server for a recovery image in initramfs
> can very well feed fake entropy by dumping whatever they want into
> /dev/random to make it possible to build temporary keys for use within
> this single session. At least all supposedly incorrect use will be made
> *on purpose* and will still be possible to match what users need.

What do you expect these systems to do though?

I mean, think about general purpose distros: they put together live
images that are supposed to work on a myriad of similar (as in: same
arch) but otherwise very different systems (i.e. VMs that might lack
any form of RNG source the same as beefy servers with muliple sources
the same as older netbooks with few and crappy sources, …). They can't
know what the specific hw will provide or won't. It's not their
incompetence that they build the image like that. It's a common, very
common usecase to install a system via SSH, and it's also very common
to have very generic images for a large number varied systems to run
on.

Lennart

--
Lennart Poettering, Berlin
