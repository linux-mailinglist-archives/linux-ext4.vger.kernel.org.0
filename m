Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3267DB5441
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbfIQRai (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:30:38 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40780 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbfIQRai (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:30:38 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id E36ACE80FFC;
        Tue, 17 Sep 2019 19:30:36 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id A1B96160ADC; Tue, 17 Sep 2019 19:30:36 +0200 (CEST)
Date:   Tue, 17 Sep 2019 19:30:36 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
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
Message-ID: <20190917173036.GC31798@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
 <6ae36cda-5045-6873-9727-1d36bf45b84e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae36cda-5045-6873-9727-1d36bf45b84e@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 21:58, Alexander E. Patrakov (patrakov@gmail.com) wrote:

> I am worried that the getrandom delays will be serialized, because processes
> sometimes run one after another. If there are enough chained/dependent
> processes that ask for randomness before it is ready, the end result is
> still a too-big delay, essentially a failed boot.
>
> In other words: your approach of adding delays only makes sense for heavily
> parallelized boot, which may not be the case, especially for embedded
> systems that don't like systemd.

As mentioned elsewhere: once the pool is initialized it's
initialized. This means any pending getrandom() on the whole system
will unblock at the same time, and from the on all getrandom()s will
be non-blocking.

systemd-random-seed.service is nowadays a synchronization point for
exactly the moment where the pool is considered full.

Lennart

--
Lennart Poettering, Berlin
