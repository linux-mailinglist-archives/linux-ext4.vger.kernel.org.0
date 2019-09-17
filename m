Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F120B46D1
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392373AbfIQFZK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 01:25:10 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46631 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391179AbfIQFZK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 01:25:10 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8H5OckJ026945;
        Tue, 17 Sep 2019 07:24:38 +0200
Date:   Tue, 17 Sep 2019 07:24:38 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20190917052438.GA26923@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
 <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
 <20190916231103.bic65ab4ifv7vhio@srcf.ucam.org>
 <CAHk-=wjwJDznDUsiaXH=UCxFRQxNEpj2tTCa0GvZm2WB4+hJ4A@mail.gmail.com>
 <20190916232922.GA7880@darwi-home-pc>
 <CAHk-=wh2PuYtuUVt523j20cTceN+ps8UNJY=uRWQuRaDeDyLQw@mail.gmail.com>
 <BEF07E89-E36D-480F-AB1E-25C80C9DABE7@srcf.ucam.org>
 <CAHk-=whfPwei+yf9vBgfSuG5HDtiYmt3nOu9Js+vkTYSrMf2ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
> >Well, the patch actually made getrandom() return en error too, but you
> >seem more interested in the hypotheticals than in arguing actualities.
> 
> If you want to be safe, terminate the process.

This is an interesting approach. At least it will cause bug reports in
application using getrandom() in an unreliable way and they will check
for other options. Because one of the issues with systems that do not
finish to boot is that usually the user doesn't know what process is
hanging.

Anyway regarding the impact on applications relying on getrandom() for
security, I'm in favor of not *silently* changing their behavior and
provide a new flag to help others get insecure randoms without waiting.

With your option above we could then have this way to go:

  - GRND_SECURE: the application wants secure randoms, i.e. like
    the current getrandom(0), waiting for entropy.

  - GRND_INSECURE: the application never wants to wait, it just
    wants a replacement for /dev/urandom.

  - GRND_RANDOM: unchanged, or subject to CAP_xxx, or maybe just emit
    a "deprecated" warning if called without a certain capability, to
    spot potentially harmful applications.

  - by default (0), the application continues to wait but when the
    timeout strikes (30 seconds ?), it gets terminated with a
    message in the logs for users to report the issue.

After some time all relevant applications which accidently misuse
getrandom() will be fixed to either use GRND_INSECURE or GRND_SECURE
and be able to wait longer if they want (likely SECURE|NONBLOCK).

Willy
