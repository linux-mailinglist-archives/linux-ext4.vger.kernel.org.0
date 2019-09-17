Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12150B49BA
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 10:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfIQIon convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 17 Sep 2019 04:44:43 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:47305 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726564AbfIQIon (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 04:44:43 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 5618877320;
        Tue, 17 Sep 2019 10:44:40 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Willy Tarreau <w@1wt.eu>
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
Date:   Tue, 17 Sep 2019 10:44:40 +0200
Message-ID: <16898130.scaMKaIPcm@merkaba>
In-Reply-To: <20190917083516.GA27098@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <2508489.jOnZlRuxVn@merkaba> <20190917083516.GA27098@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Willy Tarreau - 17.09.19, 10:35:16 CEST:
> On Tue, Sep 17, 2019 at 09:33:40AM +0200, Martin Steigerwald wrote:
> > However this again would be burdening users with an issue they
> > should
> > not have to care about. Unless userspace developers care enough and
> > manage to take time to fix the issue before updated kernels come to
> > their systems. Cause again it would be users systems that would not
> > be working. Just cause kernel and userspace developers did not
> > agree and chose to fight with each other instead of talking *with*
> > each other.
> It has nothing to do with fighting at all, it has to do with offering
> what applications *need* without breaking existing assumptions that
> make most applications work. And more importantly it involves not
[…]

Well I got the impression or interpretation that it would be about 
fighting… if it is not, all the better!

> > At least with killing gdm Systemd may restart it if configured to do
> > so. But if it doesn't, the user is again stuck with a non working
> > system until restarting gdm themselves.
> > 
> > It may still make sense to make the API harder to use,
> 
> No. What is hard to use is often misused. It must be harder to misuse
> it, which means it should be easier to correctly use it. The choice of
> flag names and the emission of warnings definitely helps during the
> development stage.

Sorry, this was a typo of mine. I actually meant harder to abuse. 
Anything else would not make sense in the context of what I have 
written.

Make it easier to use properly and harder to abuse.

> > but it does not
> > replace talking with userspace developers and it would need some
> > time to allow for adapting userspace applications and services.
> 
> Which is how adding new flags can definitely help even if adoption
> takes time. By the way in this discussion I am a userspace developer
> and have been hit several times by libraries switching to getrandom()
> that silently failed to respond in field. As a userspace developer, I
> really want to see a solution to this problem. And I'm fine if the
> kernel decides to kill haproxy for using getrandom() with the old
> settings, at least users will notice, will complain to me and will
> update.

Good to see that you are also engaging as a userspace developer in the 
discussion.

Thanks,
-- 
Martin


