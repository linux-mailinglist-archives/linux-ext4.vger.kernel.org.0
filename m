Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B280B64D8
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Sep 2019 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfIRNkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Sep 2019 09:40:42 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:41628 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfIRNkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Sep 2019 09:40:41 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 241C7E80FFC;
        Wed, 18 Sep 2019 15:40:40 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id D1D6B160ADC; Wed, 18 Sep 2019 15:40:39 +0200 (CEST)
Date:   Wed, 18 Sep 2019 15:40:39 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190918134039.GB32346@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <2658007.Cequ2ms4lF@merkaba>
 <20190917205234.GA1765@darwi-home-pc>
 <1722575.Y5XjozQscI@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722575.Y5XjozQscI@merkaba>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 23:38, Martin Steigerwald (martin@lichtvoll.de) wrote:

> (I know that it still with /dev/urandom, so if it is using RDRAND now,
> this may indeed be different, but would it then deplete entropy the CPU
> has available and that by default is fed into the Linux crng as well
> (even without trusting it completely)?)

Neither RDRAND nor /dev/urandom know a concept of "depleting
entropy". That concept does not exist for them. It does exist for
/dev/random, but only crazy people use that. systemd does not.

Lennart

--
Lennart Poettering, Berlin
