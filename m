Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0A2901D
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 06:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfEXEhz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 00:37:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41541 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbfEXEhz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 00:37:55 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O4bju9032476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 00:37:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C6CA7420481; Fri, 24 May 2019 00:37:45 -0400 (EDT)
Date:   Fri, 24 May 2019 00:37:45 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Ext4 corruption on linux-next since 5.2 merge window
Message-ID: <20190524043745.GG2532@mit.edu>
References: <f79a1b38-898d-8bfa-37d6-a74ee97411e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f79a1b38-898d-8bfa-37d6-a74ee97411e5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 22, 2019 at 07:40:26PM -0400, Peter Geis wrote:
> Good Evening,
> 
> Since the 5.2 merge window, I've been encountering EXT4 corruption
> periodically.

Yeah, sorry.  The fix is in the ext4.git tree, on the dev branch.
I'll be pushing it to Linus shortly.

It's actually not an actual file system corruption, but rather a false
positive, when there is sufficient memory pressure to push the extent
status tree entries for the journal out of the cache.

The fix is:

commit 0a944e8a6c66ca04c7afbaa17e22bf208a8b37f0
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Wed May 22 10:27:01 2019 -0400

    ext4: don't perform block validity checks on the journal inode
    
    Since the journal inode is already checked when we added it to the
    block validity's system zone, if we check it again, we'll just trigger
    a failure.
    
    This was causing failures like this:
    
    [   53.897001] EXT4-fs error (device sda): ext4_find_extent:909: inode
    #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 
8, max 340(340), depth 0(0)
    [   53.931430] jbd2_journal_bmap: journal block not found at offset 49 on sda-8
    [   53.938480] Aborting journal on device sda-8.
    
    ... but only if the system was under enough memory pressure that
    logical->physical mapping for the journal inode gets pushed out of the
    extent cache.  (This is why it wasn't noticed earlier.)
    
    Fixes: 345c0dbf3a30 ("ext4: protect journal inode's blocks using block_validity")
    Reported-by: Dan Rue <dan.rue@linaro.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>
    Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

						- Ted
