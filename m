Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56060B6197
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbfIRKml (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 06:42:41 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47725 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfIRKmk (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Sep 2019 06:42:40 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8IAg55l029595;
        Wed, 18 Sep 2019 12:42:05 +0200
Date:   Wed, 18 Sep 2019 12:42:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190918104205.GA29590@1wt.eu>
References: <20190917121156.GC6762@mit.edu>
 <20190917123015.sirlkvy335crozmj@debian-stretch-darwi.lab.linutronix.de>
 <20190917160844.GC31567@gardel-login>
 <CAHk-=wgsWTCZ=LPHi7BXzFCoWbyp3Ey-zZbaKzWixO91Ryr9=A@mail.gmail.com>
 <20190917174219.GD31798@gardel-login>
 <CAHk-=wjABG3+daJFr4w3a+OWuraVcZpi=SMUg=pnZ+7+O0E2FA@mail.gmail.com>
 <CAHk-=wgOCv2eOT2M8Vw9GD_yOpsTwF364-hkeADyEu9erHgMGw@mail.gmail.com>
 <89aeae9d-0bca-2a59-5ce2-1e18f6479936@rasmusvillemoes.dk>
 <20190918101616.GA29565@1wt.eu>
 <2c5a27b5-66cb-269a-547d-5584d51337bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c5a27b5-66cb-269a-547d-5584d51337bb@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 18, 2019 at 03:25:51PM +0500, Alexander E. Patrakov wrote:
> The results so far are:
> 
> 1. Desktop with MSI Z87I board: works.
> 2. Lenovo Yoga 2 Pro laptop: works.
> 3. Server based on the Intel Corporation S1200SPL board (available from OVH
> as EG-32): does not work, memory is cleared.
> 4. Cheap server based on Gooxi G1SCN-B board (the cheapes thing with IPMI
> available on bacloud.com): works.
> 
> So that's 75% of success stories (found at least one page that is preserved
> after the "reboot" command) based on my samples.

That's pretty good! I didn't have this luck each time I tried this in
the past :-/ I remember noticing that video RAM from graphics card was
often usable however, which I figured I could use after seeing a ghost
image from a previous boot when switching to graphics mode.

Willy
