Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4AB9078
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Sep 2019 15:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfITNQQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 09:16:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53165 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726917AbfITNQQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Sep 2019 09:16:16 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8KDG9fQ019217
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 09:16:10 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 956AB420811; Fri, 20 Sep 2019 09:16:09 -0400 (EDT)
Date:   Fri, 20 Sep 2019 09:16:09 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190920131609.GC16111@mit.edu>
References: <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc>
 <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu>
 <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
 <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
 <6adb02d4-c486-a945-7f51-d007d6de45b2@gmail.com>
 <CAHk-=wjGAaPAGnfok6fuZK1PYMkZ9bNOGkWXLYtS7+6bAWnAGQ@mail.gmail.com>
 <bd24cba4-b9c8-2ed8-6434-ee5932c24fb9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd24cba4-b9c8-2ed8-6434-ee5932c24fb9@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 03:23:58AM +0500, Alexander E. Patrakov wrote:
> OTOH, I thought that at least part of the real entropy, if it exists, comes
> from the interference of the CPU's memory accesses with the refresh cycles
> that are clocked from an independent oscillator.

That's not a valid assumption; on *many* systems, there is only a
single master oscillator.  It saves on power, parts cost, reduces the
amount of RF interference, etc.

						- Ted
