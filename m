Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC0B52DA
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfIQQWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 12:22:12 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47109 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfIQQWM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 12:22:12 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8HGLboc027929;
        Tue, 17 Sep 2019 18:21:37 +0200
Date:   Tue, 17 Sep 2019 18:21:37 +0200
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
Message-ID: <20190917162137.GA27921@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <20190917121156.GC6762@mit.edu>
 <20190917155743.GB31567@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917155743.GB31567@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 05:57:43PM +0200, Lennart Poettering wrote:
> Note that calling getrandom(0) "too early" is not something people do
> on purpose. It happens by accident, i.e. because we live in a world
> where SSH or HTTPS or so is run in the initrd already, and in a world
> where booting sometimes can be very very fast.

It's not an accident, it's a lack of understanding of the impacts
from the people who package the systems. Generating an SSH key from
an initramfs without thinking where the randomness used for this could
come from is not accidental, it's a lack of experience that will be
fixed once they start to collect such reports. And those who absolutely
need their SSH daemon or HTTPS server for a recovery image in initramfs
can very well feed fake entropy by dumping whatever they want into
/dev/random to make it possible to build temporary keys for use within
this single session. At least all supposedly incorrect use will be made
*on purpose* and will still be possible to match what users need.

> So even if you write a
> program and you think "this stuff should run late I'll just
> getrandom(0)" it might not actually be that case IRL because people
> deploy it a slightly bit differently than you initially thought in a
> slightly differently equipped system with other runtime behaviour...

I agree with this, it's precisely because I think we should not restrict
userspace capabilities that I want the issue addressed in a way that lets
users do what they need instead of relying on dangerous workarounds. Just
googling for "mknod /dev/random c 1 9" returns tens, maybe hundreds of
pages all explaining how to fix the problem of non-booting systems. It
simply proves that the kernel is not the place to decide what users are
allowed to do. Let's give them the tools to work correctly and be
responsible for their choices. They just need to be hit by bad choices
to get some feedback from the field other than a new list of well-known
SSH keys.

Willy
