Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A2B906D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfITNNR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 09:13:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52448 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfITNNR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 09:13:17 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8KDDAT5018281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 09:13:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D5A52420811; Fri, 20 Sep 2019 09:13:09 -0400 (EDT)
Date:   Fri, 20 Sep 2019 09:13:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920131309.GB16111@mit.edu>
References: <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu>
 <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
 <CAHk-=wiRUqH1dch2VCaYqNT+_vPj6LXGHcP4oW9-M3zdSfXrTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRUqH1dch2VCaYqNT+_vPj6LXGHcP4oW9-M3zdSfXrTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 19, 2019 at 08:50:15AM -0700, Linus Torvalds wrote:
> .. btw, instead of bad workarounds for a theoretical attack, here's
> something that should add actual *practical* real value: use the time
> of day (whether from an RTC device, or from ntp) to add noise to the
> random pool.

Actally, we used to seed the pool from the RTC device --- that was the
case in the 3.4 kernel referenced by the Blackhat attack, and it
didn't stop the researchers.  In later kernels, we moved up when
rand_initialized() got called to before time_init(), so
init_std_data() was no longer seeding the pool from the RTC clock.

That being said, adding calls to add_device_randomness() to
do_settimeofday64() and timekeeping_inject_offset() is an obviously
good thing to do.  I'll prepare a separate patch for the random.git
tree to do that.

					- Ted

