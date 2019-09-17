Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D46D2B53D6
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbfIQRRK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:17:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:47156 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfIQRRK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 13:17:10 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8HHGfPw028025;
        Tue, 17 Sep 2019 19:16:41 +0200
Date:   Tue, 17 Sep 2019 19:16:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Steigerwald <martin@lichtvoll.de>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917171641.GC27999@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
 <20190917163456.alzodstm3hd4yrni@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917163456.alzodstm3hd4yrni@srcf.ucam.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 05:34:56PM +0100, Matthew Garrett wrote:
> On Tue, Sep 17, 2019 at 09:27:44AM -0700, Linus Torvalds wrote:
> 
> > Does anybody believe that 128 bits of randomness is a good basis for a
> > long-term secure key?
> 
> Yes, it's exactly what you'd expect for an AES 128 key, which is still 
> considered to be secure.

AES keys are for symmetrical encryption and thus as such are short-lived.
We're back to what Linus was saying about the fact that our urandom is
already very good for such use cases, it should just not be used to
produce long-lived keys (i.e. asymmetrical).

However I'm worried regarding this precise patch about the fact that
delays will add up. I think that once we've failed to wait for a first
process, we've broken any hypothetical trust in terms of random quality
so there's no point continuing to wait for future requests.

Willy
