Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0C9B5197
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfIQPc4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 11:32:56 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40460 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfIQPcz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 11:32:55 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 4E947E80FFC;
        Tue, 17 Sep 2019 17:32:53 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id C7EDE160ADC; Tue, 17 Sep 2019 17:32:52 +0200 (CEST)
Date:   Tue, 17 Sep 2019 17:32:52 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917153252.GA31567@gardel-login>
References: <20190915065142.GA29681@gardel-login>
 <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
 <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu>
 <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu>
 <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916172117.GB15263@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mo, 16.09.19 13:21, Theodore Y. Ts'o (tytso@mit.edu) wrote:

> We could create a new flag, GRND_INSECURE, which never blocks.  And
> that that allows us to solve the problem for silly applications that
> are using getrandom(2) for non-cryptographic use cases.  Use cases
> might include Python dictionary seeds, gdm for MIT Magic Cookie, UUID
> generation where best efforts probably is good enough, etc.  The
> answer today is they should just use /dev/urandom, since that exists
> today, and we have to support it for backwards compatibility anyway.
> It sounds like gdm recently switched to getrandom(2), and I suspect
> that it's going to get caught on some hardware configs anyway, even
> without the ext4 optimization patch.  So I suspect gdm will switch
> back to /dev/urandom, and this particular pain point will probably go
> away.

The problem is that reading from /dev/urandom at a point where it's
not initialized yet results in noisy kernel logging on current
kernels. If you want people to use /dev/urandom then the logging needs
to go away, because it scares people, makes them file bug reports and
so on, even though there isn't actually any problem for these specific
purposes.

For that reason I'd prefer GRND_INSECURE I must say, because it
indicates people grokked "I know I might get questionnable entropy".

Lennart
