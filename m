Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93DCB9C08
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Sep 2019 05:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405243AbfIUDGC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Sep 2019 23:06:02 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49432 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbfIUDGC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 20 Sep 2019 23:06:02 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x8L35l8v002407;
        Sat, 21 Sep 2019 05:05:47 +0200
Date:   Sat, 21 Sep 2019 05:05:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Message-ID: <20190921030547.GF1889@1wt.eu>
References: <20190920134609.GA2113@pc>
 <CALCETrWvE5es3i+to33y6jw=Yf0Tw6ZfV-6QWjZT5v0fo76tWw@mail.gmail.com>
 <CAHk-=wgW8rN2EVL_Rdn63V9vQO0GkZ=RQFeqqsYJM==8fujpPg@mail.gmail.com>
 <CALCETrV=4TX2a4uV5t2xOFzv+zM_jnOtMLJna8Vb7uXz6S=wSw@mail.gmail.com>
 <CAHk-=wjpTWgpo6d24pTv+ubfea_uEomX-sHjjOkdACfV-8Nmkg@mail.gmail.com>
 <CALCETrUEqjFmPvpcJQwJe3dNbz8eaJ4k3_AV2u0v96MffjLn+g@mail.gmail.com>
 <CAHk-=whJ3kmcZp=Ws+uXnRB9KokG6nXSQCSuBnerG--jkAfP5w@mail.gmail.com>
 <CALCETrXMp3dJaKDm+RQijQEUuPNPmpKWr8Ljf+RqycXChGnKrw@mail.gmail.com>
 <CAHk-=whz7Okts01ygAP6GZWBvCV7s==CKjghmOp+r+LWketBYQ@mail.gmail.com>
 <CALCETrWCjGHKnKikj+YVw22Ufpmnh1TCdGPjG2RL-qzsF=wisA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWCjGHKnKikj+YVw22Ufpmnh1TCdGPjG2RL-qzsF=wisA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 20, 2019 at 04:30:20PM -0700, Andy Lutomirski wrote:
> So I think that just improving the
> getrandom()-is-blocking-on-x86-and-arm behavior, adding GRND_INSECURE
> and GRND_SECURE_BLOCKING, and adding the warning if 0 is passed is
> good enough.

I think so as well. Anyway, keep in mind that *with a sane API*,
userland can improve very quickly (faster than kernel deployments in
field). But userland developers need reliable and testable support for
features. If it's enough to do #ifndef GRND_xxx/#define GRND_xxx and
call getrandom() with these flags to detect support, it's basically 5
reliable lines of code to add to userland to make a warning disappear
and/or to allow a system that previously failed to boot to now boot. So
this gives strong incentive to userland to adopt the new API, provided
there's a way for the developer to understand what's happening (which
the warning does).

If we do it right, all we'll hear are userland developers complaining
that those stupid kernel developers have changed their API again and
really don't know what they want. That will be a good sign that the
warning flows back to them and that adoption is taking.

And if the change is small enough, maybe it could make sense to backport
it to stable versions to fix boot issues. With a testable feature it
does make sense.

Willy
