Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93513C32
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2019 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfEDVtv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 4 May 2019 17:49:51 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36982 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbfEDVtv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 4 May 2019 17:49:51 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x44LnjiH012724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 4 May 2019 17:49:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 065F9420024; Sat,  4 May 2019 17:49:45 -0400 (EDT)
Date:   Sat, 4 May 2019 17:49:44 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Cc:     Artem Blagodarenko <artem.blagodarenko@gmail.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Alexey Lyashkov <c17817@cray.com>
Subject: Re: [PATCH] e2fsck: Do not to be quiet if verbose option used.
Message-ID: <20190504214944.GA10073@mit.edu>
References: <20190426130913.9288-1-c17828@cray.com>
 <20190428233847.GA31999@mit.edu>
 <5DF9A5AD-ADCA-452B-8242-FE43946002ED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5DF9A5AD-ADCA-452B-8242-FE43946002ED@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 29, 2019 at 07:16:36AM +0300, Alexey Lyashkov wrote:
> Theodore,
> 
> Usecase is simple. User use a -p with -v flag,
> in this case, -p block any messages on console in case it successfully fixed.
> It’s OK _without_ -v flag, situation is different with -v flag.
> In this case, user expect to see mode debug info about check/fix process,
> and «no messages» in this mode confuse a user, as he think «no messages» == «no bugs fixed»,
> but it’s not a true in common way.
> From other side, -p print a messages about fix process, but not for bitmaps, it’s source of additional
>  confuse for the user, as he lack an info about FS changes during e2fsck run.

That's not a use case.   *Why* is the user using -p?

The -p option is only intended to be used when called from boot
scripts, where e2fsck is run in parallel.  This usage, "preen mode"
dates back to BSD 4.3.  What it does is pretty clearly described in
the man page.

The user seems to be very confused with their expectation, and it's
not at all clear it's a correct one.  Why does the user have this
expectation, and under what circumstances would they want e2fsck to
abort for some fixes, and automatically fix others, *and* want a full
set of messages of what was fixed?

If you are running things interactively (e.g., not at boot time),
having e2fsck abort for certain sets of error may end up wasting a lot
of time, since then you'll have to restart the e2fsck run.

Essentially, I'm asking for a complete justification for why this is a
general thing that many users will want, and why it makes sense for
them to want it.  The fact that *some* user had some twisted
expectation, and filed a Lustre bug, doesn't mean that you
automatically get to have that expectation satisified in the upstream
e2fsprogs sources.  You need to justify why other users would want it,
and how this is optimal for that particular way that people would want
to run e2fsck, for some particular set of circumstances.

Otherwise, some other user will have some *other* set if expectations,
and file another bug with Debian or Red Hat, demanding some other
random change, and this way lies madness.

					- Ted
