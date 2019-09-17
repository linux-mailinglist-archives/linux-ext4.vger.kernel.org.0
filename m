Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D109B544F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfIQRct (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:32:49 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47204 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIQRct (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 13:32:49 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8HHWPHL028048;
        Tue, 17 Sep 2019 19:32:25 +0200
Date:   Tue, 17 Sep 2019 19:32:25 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917173225.GE27999@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
 <6ae36cda-5045-6873-9727-1d36bf45b84e@gmail.com>
 <20190917173036.GC31798@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917173036.GC31798@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 07:30:36PM +0200, Lennart Poettering wrote:
> On Di, 17.09.19 21:58, Alexander E. Patrakov (patrakov@gmail.com) wrote:
> 
> > I am worried that the getrandom delays will be serialized, because processes
> > sometimes run one after another. If there are enough chained/dependent
> > processes that ask for randomness before it is ready, the end result is
> > still a too-big delay, essentially a failed boot.
> >
> > In other words: your approach of adding delays only makes sense for heavily
> > parallelized boot, which may not be the case, especially for embedded
> > systems that don't like systemd.
> 
> As mentioned elsewhere: once the pool is initialized it's
> initialized. This means any pending getrandom() on the whole system
> will unblock at the same time, and from the on all getrandom()s will
> be non-blocking.

He means that all process will experience this delay until there's enough
entropy.

Willy
