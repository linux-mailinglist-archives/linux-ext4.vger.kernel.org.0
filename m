Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5FB4857
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404469AbfIQHdo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 03:33:44 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:48487 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404465AbfIQHdn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 03:33:43 -0400
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id BA1FB772DF;
        Tue, 17 Sep 2019 09:33:40 +0200 (CEST)
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
Date:   Tue, 17 Sep 2019 09:33:40 +0200
Message-ID: <2508489.jOnZlRuxVn@merkaba>
In-Reply-To: <20190917052438.GA26923@1wt.eu>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com> <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org> <20190917052438.GA26923@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Willy Tarreau - 17.09.19, 07:24:38 CEST:
> On Mon, Sep 16, 2019 at 06:46:07PM -0700, Matthew Garrett wrote:
> > >Well, the patch actually made getrandom() return en error too, but
> > >you seem more interested in the hypotheticals than in arguing
> > >actualities.> 
> > If you want to be safe, terminate the process.
> 
> This is an interesting approach. At least it will cause bug reports in
> application using getrandom() in an unreliable way and they will
> check for other options. Because one of the issues with systems that
> do not finish to boot is that usually the user doesn't know what
> process is hanging.

A userspace process could just poll on the kernel by forking a process 
to use getrandom() and waiting until it does not get terminated anymore. 
And then it would still hang.

So yes, that would it make it harder to abuse the API, but not 
impossible. Which may still be good, I don't know.

Either the kernel does not reveal at all whether it has seeded CRNG and 
leaves GnuPG, OpenSSH and others in the dark, or it does and risk that 
userspace does stupid things whether it prints a big fat warning or not.

Of course the warning could be worded like:

process blocking on entropy too early on boot without giving the kernel 
much chance to gather entropy. this is not a kernel issue, report to 
userspace developers

And probably then kill the process, so at least users will know.

However this again would be burdening users with an issue they should 
not have to care about. Unless userspace developers care enough and 
manage to take time to fix the issue before updated kernels come to their 
systems. Cause again it would be users systems that would not be 
working. Just cause kernel and userspace developers did not agree and 
chose to fight with each other instead of talking *with* each other.

At least with killing gdm Systemd may restart it if configured to do so. 
But if it doesn't, the user is again stuck with a non working system 
until restarting gdm themselves.

It may still make sense to make the API harder to use, but it does not 
replace talking with userspace developers and it would need some time to 
allow for adapting userspace applications and services.

-- 
Martin


