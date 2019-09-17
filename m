Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6BB543F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfIQR3y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:29:54 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47192 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfIQR3y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 13:29:54 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8HHTThI028042;
        Tue, 17 Sep 2019 19:29:29 +0200
Date:   Tue, 17 Sep 2019 19:29:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lennart Poettering <mzxreary@0pointer.de>
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
Message-ID: <20190917172929.GD27999@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917155743.GB31567@gardel-login>
 <20190917162137.GA27921@1wt.eu>
 <20190917171328.GA31798@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917171328.GA31798@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 07:13:28PM +0200, Lennart Poettering wrote:
> On Di, 17.09.19 18:21, Willy Tarreau (w@1wt.eu) wrote:
> 
> > On Tue, Sep 17, 2019 at 05:57:43PM +0200, Lennart Poettering wrote:
> > > Note that calling getrandom(0) "too early" is not something people do
> > > on purpose. It happens by accident, i.e. because we live in a world
> > > where SSH or HTTPS or so is run in the initrd already, and in a world
> > > where booting sometimes can be very very fast.
> >
> > It's not an accident, it's a lack of understanding of the impacts
> > from the people who package the systems. Generating an SSH key from
> > an initramfs without thinking where the randomness used for this could
> > come from is not accidental, it's a lack of experience that will be
> > fixed once they start to collect such reports. And those who absolutely
> > need their SSH daemon or HTTPS server for a recovery image in initramfs
> > can very well feed fake entropy by dumping whatever they want into
> > /dev/random to make it possible to build temporary keys for use within
> > this single session. At least all supposedly incorrect use will be made
> > *on purpose* and will still be possible to match what users need.
> 
> What do you expect these systems to do though?
> 
> I mean, think about general purpose distros: they put together live
> images that are supposed to work on a myriad of similar (as in: same
> arch) but otherwise very different systems (i.e. VMs that might lack
> any form of RNG source the same as beefy servers with muliple sources
> the same as older netbooks with few and crappy sources, ...). They can't
> know what the specific hw will provide or won't. It's not their
> incompetence that they build the image like that. It's a common, very
> common usecase to install a system via SSH, and it's also very common
> to have very generic images for a large number varied systems to run
> on.

I'm totally file with installing the system via SSH, using a temporary
SSH key. I do make a strong distinction between the installation phase
and the final deployment. The SSH key used *for installation* doesn't
need to the be same as the final one. And very often at the end of the
installation we'll have produced enough entropy to produce a correct
key.

It's not because people got used to doing things the wrong way by
ignorance of how randomness works and raised this to an industrial
level that they must not adapt a little bit. If they insist on producing
an SSH key immediately at boot, you can be sure that many of those that
never fail are probably bad because they probably used some of the
tricks mentioned in this thread (like the fairly common mknod trick
that can make sense in a temporary system installation image) :-/

I maintain that we don't need the same amount of entropy to run a
regular system and to create a new key, and that as such it is not
a reasonable thing to do to create such a key as the first action.
I'm not saying that doing things correctly is as easy, but it's not
impossible at all: many of us have already used systems which use
something like dropbear with temporary key on the install image but
run off openssh in the final system image.

And even when booting off a pre-configured final image we could
easily imagine that the ssh service detects lack of entropy and
runs with a temporary key that is not saved, and in the background
starts a process trying to produce a final key for later use.

Willy
