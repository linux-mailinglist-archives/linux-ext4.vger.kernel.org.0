Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A428062E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbgJASDo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 14:03:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37482 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730029AbgJASDl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 14:03:41 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091I3bOr025033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 14:03:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EDCC842003C; Thu,  1 Oct 2020 14:03:36 -0400 (EDT)
Date:   Thu, 1 Oct 2020 14:03:36 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     adilger@whamcloud.com
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH] e2fsck: skip extent optimization by default
Message-ID: <20201001180336.GM23474@mit.edu>
References: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600726562-9567-1-git-send-email-adilger@whamcloud.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 21, 2020 at 04:16:02PM -0600, adilger@whamcloud.com wrote:
> From: Andreas Dilger <adilger@whamcloud.com>
> 
> The e2fsck error message:
> 
>     inode nnn extent tree (at level 1) could be narrower. Optimize<y>?
> 
> can be fairly verbose at times, and leads users to think that there
> may be something wrong with the filesystem.  Basically, almost any
> message printed by e2fsck makes users nervous when they are facing
> other corruption, and a few thousand of these printed may hide other
> errors.  It also isn't clear that saving a few blocks optimizing the
> extent tree noticeably improves performance.
> 
> This message has previously been annoying enough for Ted to add the
> "-E no_optimize_extents" option to disable it.  Just enable this
> option by default, similar to the "-D" directory optimization option.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Applying this patch causes a whole bunch of tests fail:

348 tests succeeded 9 tests failed
Tests failed: d_punch_bigalloc d_punch f_collapse_extent_tree
      f_compress_extent_tree_level f_extent_bad_node f_extent_int_bad_magic
      f_extent_leaf_bad_magic f_extent_oobounds f_quota_extent_opt


> @@ -1051,6 +1053,11 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
>  	if (c)
>  		ctx->options |= E2F_OPT_NOOPT_EXTENTS;
>  
> +	profile_get_boolean(ctx->profile, "options", "optimize_extents",
> +			    0, 0, &c);
> +	if (c)
> +		ctx->options &= ~E2F_OPT_NOOPT_EXTENTS;
> +

We already have a no_optimize_extents option supported in e2fsck.conf.
So if we want to change the default, a simpler way to do this might be
to edit e2fsck.conf.5.in to simply add "no_optimize_extents=true" to
the default version of e2fsck.conf defined by default.

As a reminder, for future changes, when we add a new tunable to
e2fsck.conf or mke2fs.conf, the man page should be edited.  And please
do run the regression test suites before sending out a patch.   Thanks!!

       	   	      	   	  	 	 - Ted
