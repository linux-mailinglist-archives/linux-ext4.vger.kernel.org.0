Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89EEB2EE5
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Sep 2019 09:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfIOHBW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 03:01:22 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:45081 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfIOHBV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 15 Sep 2019 03:01:21 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8F713NQ021628;
        Sun, 15 Sep 2019 09:01:03 +0200
Date:   Sun, 15 Sep 2019 09:01:03 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190915070103.GC20811@1wt.eu>
References: <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu>
 <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc>
 <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <214fed0e-6659-def9-b5f8-a9d7a8cb72af@gmail.com>
 <CAHk-=wiB0e_uGpidYHf+dV4eeT+XmG-+rQBx=JJ110R48QFFWw@mail.gmail.com>
 <20190915065655.GB29681@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915065655.GB29681@gardel-login>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 08:56:55AM +0200, Lennart Poettering wrote:
> There's benefit in being able to wait until the pool is initialized
> before we update the random seed stored on disk with a new one,

And what exactly makes you think that waiting with arms crossed not
doing anything else has any chance to make the situation change if
you already had no such entropy available when reaching that first
call, especially during early boot ?

Willy
