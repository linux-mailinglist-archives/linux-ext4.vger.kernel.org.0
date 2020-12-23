Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B62E204F
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Dec 2020 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgLWSNO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Dec 2020 13:13:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42248 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725957AbgLWSNO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Dec 2020 13:13:14 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BNICO40016733
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 13:12:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8D087420280; Wed, 23 Dec 2020 13:12:24 -0500 (EST)
Date:   Wed, 23 Dec 2020 13:12:24 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: discard and data=writeback
Message-ID: <X+OIiNOGKmbwITC3@mit.edu>
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu>
 <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu>
 <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 23, 2020 at 01:47:33AM +0100, Matteo Croce wrote:
> As an extra test I extracted the archive with data=ordered, remounted
> with data=writeback and timed the rm -rf and viceversa.
> The mount option is the one that counts, the one using during
> extraction doesn't matter.

Hmm... that's really surprising.  At this point, the only thing I can
suggest is to try using blktrace to see what's going on at the block
layer when the I/O's and discard requests are being submitted.  If
there are no dirty blocks in the page cache, I don't see how
data=ordered vs data=writeback would make a difference to how mount -o
discard processing would take place.

Cheers,

					- Ted
