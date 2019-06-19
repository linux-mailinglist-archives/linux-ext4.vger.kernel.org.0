Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B994C127
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfFSTAg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 15:00:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42071 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbfFSTAf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jun 2019 15:00:35 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5JJ0U1h016837
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jun 2019 15:00:31 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EE544420484; Wed, 19 Jun 2019 15:00:29 -0400 (EDT)
Date:   Wed, 19 Jun 2019 15:00:29 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] e2fsck: process empty directory if large_dir and
 inline_data set
Message-ID: <20190619190029.GA3383@mit.edu>
References: <20190614144237.6010-1-c17828@cray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144237.6010-1-c17828@cray.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 14, 2019 at 05:42:37PM +0300, Artem Blagodarenko wrote:
> Doing a forced check on an ext4 file system with inline_data and
> large_dir results in lots of fsck messages. To reproduce:
> ...
> 
> Rootcause of this issue is large_dir optimization that is not
> appropriate for inline_data.
> 
> Let's not optimize it if inline_data is set.
> 
> Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Artem Blagodarenko <c17828@cray.com>

Thanks, applied, although I corrected the commit description.  The
initial description now reads:

    e2fsck: correctly handle inline directories when large_dir is enabled.
    
    Historically, e2fsck has required that directories not contain holes.
    (In fact, as of this writing, ext4 still requires this to be the
    case.)  Commit ae9efd05a98 ("e2fsck: 3 level hash tree directory
    optimization") removed this requirement if the large_dir feature is
    enabled; however, the way it was done caused it to incorrectly handle
    inline directories.

    To reproduce the problem fixed by this commit:
    ...

BTW, Removing the directory hole check in commit ae9efd05a98 for file
systems with the large_dir feature enabled was a wee bit optimistic,
since the kernel will still mark the file system as corrupted.

Fixing the kernel so that it doesn't complain about directories with
holes is going to be a bit more complicated than just removing the
check in __ext4_read_dirblock():

	if (!bh) {
		ext4_error_inode(inode, func, line, block,
				 "Directory hole found");
		return ERR_PTR(-EFSCORRUPTED);
	}

(That's because we have to fix all of the callers of
ext4_read_dirblock() to handle the case where it returns NULL if there
is no directory block at that specified location.)

I should have caught that when reviewing the e2fsprogs commit; my bad.
At this point, we should just fix the kernel so it can handle
directories with holes (both for large_dir and non-large_dir
directories).

      		      	      		- Ted
