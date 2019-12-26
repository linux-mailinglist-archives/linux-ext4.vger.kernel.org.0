Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DE12AD17
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 15:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfLZOjk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 09:39:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39447 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbfLZOjk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 09:39:40 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQEdZh2009503
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 09:39:36 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D82B9420485; Thu, 26 Dec 2019 09:39:34 -0500 (EST)
Date:   Thu, 26 Dec 2019 09:39:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Prevent ext4_kvmalloc re-entring the filesystem
 and deadlocking
Message-ID: <20191226143934.GC3158@mit.edu>
References: <20191226071008.7812-1-naoto.kobayashi4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226071008.7812-1-naoto.kobayashi4c@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 26, 2019 at 04:10:08PM +0900, Naoto Kobayashi wrote:
> Although __vmalloc() doesn't support GFP_NOFS[1],
> ext4_kvmalloc/kvzalloc caller may be under GFP_NOFS context
> (e.g. fs/ext4/resize.c::add_new_gdb). In such cases, the memory
> reclaim can re-entr the filesystem and potentially deadlock.
> 
> To prevent the memory relcaim re-entring the filesystem,
> use memalloc_nofs_save/restore that gets __vmalloc() to drop
> __GFP_FS flag.
> 
> [1] linux-tree/Documentation/core-api/gfp-mask-fs-io.rst
> 
> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>

Good catch!  However, we're not actually using ext4_kvzalloc()
anywhere, at least not any more.  And also, all the users of
ext4_kvmalloc() are using GFP_NOFS (otherwise, they would have been
converted over to use the generic kvmalloc() helper function).

So... a cleaner fix would be to (a) delete ext4_kvmazalloc(), (b)
rename ext4_kvmalloc() to ext4_kvmalloc_nofs(), and drop its flags
argument, and then the calls memalloc_nfs_save/restore() to
ext4_kvmalloc_nofs() --- and so we won't need the

	if (!(flags & __GFP_FS))

test.

Could you make those changes and resend the patch?

Thanks,

					- Ted
