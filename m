Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E582C1840
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 23:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgKWWMq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 17:12:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33281 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728895AbgKWWMp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 17:12:45 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANMCcvm027535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 17:12:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16EBC420136; Mon, 23 Nov 2020 17:12:38 -0500 (EST)
Date:   Mon, 23 Nov 2020 17:12:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 03/61] e2fsck: copy fs when using multi-thread fsck
Message-ID: <20201123221238.GF132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-4-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-4-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:49AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> This patch only copy the fs to a new one when -m is enabled.
> It doesn't actually start any thread. When pass1 test finishes,
> the new fs is copied back to the original context.
> 
> This patch handles the fs fields in dblist, inode_map and block_map
> properly.
> 
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

I'm a bit surprised that we're not adding a ext2fs_clone_fs()
function, but instead creating an e2fsck_pass1_copy_fs() function.

Again, what's going to happen when we need to copy the fs structure
for other passes.  Also, just simply copying the fs structure seems
dangerous; how are we going to know which allocated substructures were
created before the fs structure was clonsed (and hence can't be safely
freed in a copy of the fs structure), and which substructures were
allocated *after* the fs structure is cloned, in which case they need
to be freed when the cloned fs structuers are released?

Perhaps the simplest thing to do is to assume that *everything* is
cloned.  If that results in too much memory consumed, maybe we can add
a set of flags indicating which structures should *not* be freed for a
particular fs structure, with the assumption that they will be freed
when the top-level master fs structure is closed.  There may be some
potential traps with this, since in some cases a substructure can be
released and re-allocated, in which case, if that substructure is
shared by child fs structures, they could be left pointing at already
freed copies of the data structures.

Basically, even if this works (and the fact that I saw a crash with a
data structure being double-freed in the f_multithread_ok test
strongly suggesting that it isn't), I'd be worried about making sure
that the resulting architecture is one which is robust and
maintainable, and not leaving traps for future developers when they
don't realize what the assumptions are about shared substructures.
Which strongly suggests that this should be a first-class aspect of
libext2fs and it should be clearly documented how sharing does or
doesn't work.

Cheers,

					- Ted
