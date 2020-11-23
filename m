Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A142C1863
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 23:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgKWW2E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 17:28:04 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35814 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728895AbgKWW2D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 17:28:03 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANMRuPI032398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 17:27:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 17634420136; Mon, 23 Nov 2020 17:27:56 -0500 (EST)
Date:   Mon, 23 Nov 2020 17:27:56 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Wang Shilong <wshilong@ddn.com>, Li Xi <lixi@ddn.com>
Subject: Re: [RFC PATCH v3 04/61] e2fsck: clear icache when using
 multi-thread fsck
Message-ID: <20201123222756.GG132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-5-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-5-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:50AM -0800, Saranya Muruganandam wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> icache of fs will be rebuilt when needed, so after copying
> fs, icache can be inited to NULL.
> 
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

So this is part of the whole "how is the fs structure is shared
question".  It's going to be better if this is all in a single patch,
instead of being spread out into separate patches.  Certainly from a
review perspective, it's going to be much simpler....

> +static void e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
> +{
> +	struct ext2_inode_cache *icache = dest->icache;
> +
> +	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
> +	if (dest->dblist)
> +		dest->dblist->fs = dest;
> +	if (dest->inode_map)
> +		dest->inode_map->fs = dest;
> +	if (dest->block_map)
> +		dest->block_map->fs = dest;
> +	dest->icache = icache;
> +
> +	if (src->icache) {
> +		ext2fs_free_inode_cache(src->icache);
> +		src->icache = NULL;
> +	}
>  }

I'm not sure how the merge_fs function is supposed to work.  Right now
it's not doing much in the way of merging; I'm guessing how it works
is going to be done in a future patch, but this is going to make
review a bit tricky.

.... peaking ahead in the patch series.  Yeah, I think we need to
think very carefully about how we do stuff here.  It looks very ad
hoc, with some aspects of the merge functionality in e2fsck/pass1.c,
and some in libext2fs.

I wonder if we wouldn't be better off with the concept of a top-level
fs structure, and child fs structures which point back to the
top-level fs structure --- much like what is currently being done with
the e2fsck_t structure.  So if fs->parent_fs is non-NULL, we know that
this is a child fs structure, and there are very clear rules about how
things like io_managers are shared --- or not.  Note that some
io_managers, such as undo io manager, fundamentally *have* to be
shared, which implies that we need to have some kind of flag
indicating whether or not an io_manager is thread-aware or not.  And
if an io_manager is not thread-aware, then it wouldn't be safe to use
it in multi-threading mode.

I'm going to stop doing a fine-grained review of this patch series,
and it seems pretty clear to me that we need to have some fundamental
architectural discussions about how to make multi-threading work.  An
ad-hoc approach is great for a prototype, as this surfaces all of
these sorts of questions --- but I think we need to now stop, and
think very carefully about how to make multi-threading support
something which can be a long-term maintainable code base.  And that
means figuring out what the semantics should be about various shared
data sructures, and then documenting how things are supposed to work
very explicitly.  (I note that many of these functions don't have much
in the way of documentation, which is unfortunate from the prespective
of some future developer who is wishing to further extend this work.)

   	       		     		- Ted
