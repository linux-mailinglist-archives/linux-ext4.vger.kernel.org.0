Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8F679F5A
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 18:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjAXRAB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 12:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjAXRAA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 12:00:00 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6B74B193
        for <linux-ext4@vger.kernel.org>; Tue, 24 Jan 2023 08:59:47 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30OGxdY7014535
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 11:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674579581; bh=vNchuX+RptDfRjqo4RKiSXRwP9wtWIzc1WJyDMEB5G0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=R2M+KWp3uVMjAzuNjFAgar66zinr94eyqHoUDK+sTOn0hHjm52nc1QRR5uJ6ODLVQ
         zJqzCUefByFuj6JY6GOf4K+ejF3zXdRObkI8jlzJTnZn7s5J/wK3H30jZcLS3QgJZ+
         huUYUFbpe58szER7jDh0kOXQ8mMxGEuoYq1ExA6bBza+x2zb341Vb/V/uwR+3IWS/A
         zqNUq7CdeWQZDeAvotTqvwtt/aqZj77DGPc+yNzuXZ1CSy3am6jy/AaRQbiqcfjfxt
         fhcVe5oHSKz5ErwikC0Nt1180yw7TSbmVLcoJYPv1/hXriOWQxyMr4a3qdIurik1rg
         zQD8099gEq6Xg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2882915C469B; Tue, 24 Jan 2023 11:59:39 -0500 (EST)
Date:   Tue, 24 Jan 2023 11:59:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
Subject: Re: [RFCv1 02/72] gen_bitmaps: Fix
 ext2fs_compare_generic_bmap/bitmap logic
Message-ID: <Y9AOe+gdM8g36g0d@mit.edu>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <da2a28305637aef648846f9bf75d269c0f7c6e57.1667822611.git.ritesh.list@gmail.com>
 <687F4A01-A443-4B5A-87B7-5958F2B3267F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <687F4A01-A443-4B5A-87B7-5958F2B3267F@dilger.ca>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 22, 2022 at 10:04:58PM -0700, Andreas Dilger wrote:
> On Nov 7, 2022, at 5:20 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
> > 
> > Currently this function was not correctly comparing against the right
> > length of the bitmap. Also when we compare bitarray v/s rbtree bitmap
> > the value returned by ext2fs_test_generic_bmap() could be different in
> > these two implementations. Hence only check against boolean value.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> > lib/ext2fs/gen_bitmap.c   |  9 ++++++---

The gen_bitmap.c file supports only the original 32-bit bitmaps, so
there is not rbtree bitmap.  That's why using memcmp is safe, and as
near as I can tell, no changes are needed for the
lib/ext2fs/gen_bitmap.c

> > diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> > index c860c10e..f7710afd 100644
> > --- a/lib/ext2fs/gen_bitmap64.c
> > +++ b/lib/ext2fs/gen_bitmap64.c
> > @@ -629,10 +629,14 @@ errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
> > 	    (bm1->end != bm2->end))
> 
> Conversely, *this* version of the function is *not* doing the memcmp() of
> the bulk of the bitmap contents, so it would appear to have a bug that the
> patch fixes, but in a very slow manner.  It would be better to use memcmp().

This is where we have a problem, and the reason why we can't use
memcmp is because in the case where the bitmap is really encoded using
an rbtree, a memcmp isn't applicable.

We *could* extract the bitmap into a bitarray, but that would require
allocating memory, and in the case of a very large file system/bitmap,
especially when running on a 32-bit NAS box, we might not be able to
*afford* to allocate that much memory (or it might not even be
addressable :-).

So yes, we need a fix here, and yes, comparing bit by bit is very
slow.  Fortunately, from what I can tell, no one is actually calling
this function, which is why no once noticed that the 64-bit compare
bitmap fucntion was totally hosed.

So applying Ritesh's fix here makes sense, since it at least fixes the
obvious problems.  In the long term, we should probably add proper
unit regression tests so can test whether or not this function is
actually working correctly, and if we *want* a faster version of it,
we could do something faster in the case where both bitmaps are the
same type (e.g., both bitarrays or both rbtrees), and if they could do
something where we look for "runs" where all of the bits are all set
or not set, and then compare that against the other bitmap, etc.  But
given that we don't have anyusers of this function any more (we used
to, but it disappeared when we optimzied e2fsck's pass5
implementation), that's probably not an urgent fix.

						- Ted
