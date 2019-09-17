Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBE89B4998
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 10:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388419AbfIQIfz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 04:35:55 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:46740 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387967AbfIQIfy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Sep 2019 04:35:54 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8H8ZGKL027108;
        Tue, 17 Sep 2019 10:35:16 +0200
Date:   Tue, 17 Sep 2019 10:35:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Matthew Garrett <mjg59@srcf.ucam.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20190917083516.GA27098@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2508489.jOnZlRuxVn@merkaba>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
> However this again would be burdening users with an issue they should 
> not have to care about. Unless userspace developers care enough and 
> manage to take time to fix the issue before updated kernels come to their 
> systems. Cause again it would be users systems that would not be 
> working. Just cause kernel and userspace developers did not agree and 
> chose to fight with each other instead of talking *with* each other.

It has nothing to do with fighting at all, it has to do with offering
what applications *need* without breaking existing assumptions that
make most applications work. And more importantly it involves not
silently breaking applications which need good randomness for long
lived keys because the breakage will not be visible initially and can
hit them hard later. Right now most applications which block in the
early stages are only victim of the current situation and their
developers possibly didn't understand the possible impacts of lack
of entropy (or how real an issue it was). These applications do need
to be able to get low-quality random without blocking forever,
provided these are not accidently used by those who need security. At
some point, just like for any syscall, the doc makes the difference.

> At least with killing gdm Systemd may restart it if configured to do so. 
> But if it doesn't, the user is again stuck with a non working system 
> until restarting gdm themselves.
> 
> It may still make sense to make the API harder to use,

No. What is hard to use is often misused. It must be harder to misuse
it, which means it should be easier to correctly use it. The choice of
flag names and the emission of warnings definitely helps during the
development stage.

> but it does not 
> replace talking with userspace developers and it would need some time to 
> allow for adapting userspace applications and services.

Which is how adding new flags can definitely help even if adoption takes
time. By the way in this discussion I am a userspace developer and have
been hit several times by libraries switching to getrandom() that silently
failed to respond in field. As a userspace developer, I really want to see
a solution to this problem. And I'm fine if the kernel decides to kill
haproxy for using getrandom() with the old settings, at least users will
notice, will complain to me and will update.

Willy
