Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7E12C2DA
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Dec 2019 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfL2OuM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Dec 2019 09:50:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45667 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726230AbfL2OuM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Dec 2019 09:50:12 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBTEn4GM024237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Dec 2019 09:49:05 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 83EFA420485; Sun, 29 Dec 2019 09:49:04 -0500 (EST)
Date:   Sun, 29 Dec 2019 09:49:04 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephan Mueller <smueller@chronox.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Rework random blocking
Message-ID: <20191229144904.GB7177@mit.edu>
References: <20191226140423.GB3158@mit.edu>
 <4048434.Q8HajmOrkZ@tauon.chronox.de>
 <20191227130436.GC70060@mit.edu>
 <15817620.rmTN4T87Wr@tauon.chronox.de>
 <20191227220857.GD70060@mit.edu>
 <CALCETrUyVx_qb2yYH8D_z1T2bVu5RAEr71G0MTzEksBKKM1QsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUyVx_qb2yYH8D_z1T2bVu5RAEr71G0MTzEksBKKM1QsA@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 27, 2019 at 06:06:56PM -0800, Andy Lutomirski wrote:
> 
> I'm thinking of having a real class device and chardev for each hwrng
> device.  Authentication is entirely in userspace: whatever user code
> is involved can look at the sysfs hierarchy and decide to what extent
> it trusts a given source.  This could be done based on bus topology or
> based on anything else.

Yes, that's what I was thinking.  Another project on my "when I can
get a round tuit" list is to change how drivers/char/random.c taps
into the hwrng devices, mixing in a bit from each of these devies in a
round-robin fashion, instead of just feeding from a single hwrng.

> The kernel could also separately expose various noise sources, and the
> user code can do whatever it wants with them.  But these should be
> explicitly unconditioned, un-entropy-extracted sources -- user code
> can run its favorite algorithm to extract something it believes to be
> useful.  The only conceptually tricky bit is keeping user code like
> this from interfering with the in-kernel RNG.

The other problem is the unconditioned values of the noise sources may
leak unacceptable amounts of information about system operation.  The
most obvious example of this would be keyboard and mouse sources,
where today we mix in not only the timing information, but the actual
input values (e.g., the keyboard scancodes) into the entropy pool.
Exposing this to userspace, even if it is via a privileged system
call, would be... unwise.

						- Ted
