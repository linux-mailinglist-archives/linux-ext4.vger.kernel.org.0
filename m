Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EECD7AE9C0
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2019 13:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393046AbfIJL4x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Sep 2019 07:56:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37767 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393023AbfIJL4w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Sep 2019 07:56:52 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8ABua45016670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 07:56:39 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 97FF742049E; Tue, 10 Sep 2019 07:56:35 -0400 (EDT)
Date:   Tue, 10 Sep 2019 07:56:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, zhangjs <zachary@baishancloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 5.3-rc8
Message-ID: <20190910115635.GB2740@mit.edu>
References: <CAHk-=whBQ+6c-h+htiv6pp8ndtv97+45AH9WvdZougDRM6M4VQ@mail.gmail.com>
 <20190910042107.GA1517@darwi-home-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910042107.GA1517@darwi-home-pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 10, 2019 at 06:21:07AM +0200, Ahmed S. Darwish wrote:
> 
> The commit b03755ad6f33 (ext4: make __ext4_get_inode_loc plug), [1]
> which was merged in v5.3-rc1, *always* leads to a blocked boot on my
> system due to low entropy.
> 
> The hardware is not a VM: it's a Thinkpad E480 (i5-8250U CPU), with
> a standard Arch user-space.

Hmm, I'm not seeing this on a Dell XPS 13 (model 9380) using a Debian
Bullseye (Testing) running a rc4+ kernel.

This could be because Debian is simply doing more I/O; or it could be
because I don't have some package installed which is trying to reading
from /dev/random or calling getrandom(2).  Previously, Fedora ran into
blocking issues because of some FIPS compliance patches to some
userspace daemons.  So it's going to be very user space dependent and
package dependent.

> It seems that batching the directory lookup I/O requests (which are
> possibly a lot during boot) is minimizing sources of disk-activity-
> induced entropy? [2] [3]
> 
> Can this even be considered a user-space breakage? I'm honestly not
> sure. On my modern RDRAND-capable x86, just running rng-tools rngd(8)
> early-on fixes the problem. I'm not sure about the status of older
> CPUs though.

You can probably also fix this problem by adding random.trust_cpu=true
to the boot command line, or by enabling CONFIG_RANDOM_TRUST_CPU.
This obviously assumes that you trust Intel's implementation of
RDRAND, but that's true regardless of whether of whether you use rngd
or the kernel config option.

As far as whether it's considered user-space breakage; that's though.
File system performance improvements can cause a reduced amount of
I/O, and that can cause less entropy to be collected, and depending on
a complex combination of kernel config options, distribution-specific
patches, and what packages are loaded, that could potentially cause
boot hangs waiting for entropy.  Does that we we're can't make any
file system performace improvements?  Surely that doesn't seem like
the right answer.

It would be useful to figure out what process is blocking waiting on
entropy, since in general, trying to rely on cryptographic entropy in
early boot, especially if it is to generate cryptographic keys, is
going to be more dangerous compared to a "just in time" approach to
generating crypto keys.  So this could also be considered a userspace
bug, depending on your point of view...

					- Ted
