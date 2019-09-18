Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225BBB64BD
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 15:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfIRNiJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 09:38:09 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:41602 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfIRNiJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 09:38:09 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 81113E80FFC;
        Wed, 18 Sep 2019 15:38:07 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 0B989160ADC; Wed, 18 Sep 2019 15:38:06 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:38:06 +0200
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
Message-ID: <20190918133806.GA32346@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917155743.GB31567@gardel-login>
 <20190917162137.GA27921@1wt.eu>
 <20190917171328.GA31798@gardel-login>
 <20190917172929.GD27999@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917172929.GD27999@1wt.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 19:29, Willy Tarreau (w@1wt.eu) wrote:

> > What do you expect these systems to do though?
> >
> > I mean, think about general purpose distros: they put together live
> > images that are supposed to work on a myriad of similar (as in: same
> > arch) but otherwise very different systems (i.e. VMs that might lack
> > any form of RNG source the same as beefy servers with muliple sources
> > the same as older netbooks with few and crappy sources, ...). They can't
> > know what the specific hw will provide or won't. It's not their
> > incompetence that they build the image like that. It's a common, very
> > common usecase to install a system via SSH, and it's also very common
> > to have very generic images for a large number varied systems to run
> > on.
>
> I'm totally file with installing the system via SSH, using a temporary
> SSH key. I do make a strong distinction between the installation phase
> and the final deployment. The SSH key used *for installation* doesn't
> need to the be same as the final one. And very often at the end of the
> installation we'll have produced enough entropy to produce a correct
> key.

That's not how systems are built today though. And I am not sure they
should be. I mean, the majority of systems at this point probably have
some form of hardware (or virtualized) RNG available (even raspi has
one these days!), so generating these keys once at boot is totally
OK. Probably a number of others need just a few seconds to get the
entropy needed, where things are totally OK too. The only problem is
systems that lack any reasonable source of entropy and where
initialization of the pool will take overly long.

I figure we can reduce the number of systems where entropy is scarce
quite a bit if we'd start crediting entropy by default from various hw
rngs we currently don't credit entropy for. For example, the TPM and
older intel/amd chipsets. You currently have to specify
rng_core.default_quality=1000 on the kernel cmdline to make them
credit entropy. I am pretty sure this should be the default now, in a
world where CONFIG_RANDOM_TRUST_CPU=y is set anyway. i.e. why say
RDRAND is fine but those chipsets are not? That makes no sense to me.

I am very sure that crediting entropy to chipset hwrngs is a much
better way to solve the issue on those systems than to just hand out
rubbish randomness.

Lennart

--
Lennart Poettering, Berlin
