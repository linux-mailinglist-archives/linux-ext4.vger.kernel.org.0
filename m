Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF33FFFFA
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Sep 2021 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhICMtq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Sep 2021 08:49:46 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52014 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234262AbhICMtq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Sep 2021 08:49:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 183Cmc41032040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Sep 2021 08:48:39 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A8CA615C33F9; Fri,  3 Sep 2021 08:48:38 -0400 (EDT)
Date:   Fri, 3 Sep 2021 08:48:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext2: do not sleep in ext2_error()
Message-ID: <YTIZpijSZc+ykNUY@mit.edu>
References: <20210903090538.GA7283@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903090538.GA7283@kili>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 03, 2021 at 12:05:38PM +0300, Dan Carpenter wrote:
> No one expects error logging functions to sleep so sometimes they are
> called with spinlocks held.  In this case the problematic call tree is:
> 
> ext2_statfs() <- disables preempt
> -> ext2_count_free_inodes()
>    -> ext2_get_group_desc()
>       -> ext2_error()
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is just from static analysis.  NOT TESTED!
> 
> Probably a safer fix would be to just call pr_err() instead of
> ext2_error() in ext2_get_group_desc().  I can send that fix instead if
> people want.

Looking at both of the ext2_error() calls in ext2_get_group_desc(),
those are really more in the way of assertions rather than warning of
an on-disk corruption issue.  The second "group descriptor not loaded"
should never happen, and the "block_group >= groups_count" should have
been caught via an invalid block number or check by the caller (or an
outright code bug in say ext2_statfs().

So I suspect both of those would be more usefule as a WARN() rather
than a call to ext2_error(), since stack trace would actually provide
more useful data to root causing the issue.  Jan, what do you think?

     	    	    	 	 - Ted

P.S.  The same analysis applies for ext4_get_group_desc(), BTW.  We
don't take a lock in ext4_statfs() so trying to take a lock while
sleeping is not an issue.

For both ext2 and ext4, the caller is not supposed to holding spin
locks when it calls ext[24]_error().  In cases where it is absolutely
not avoidable, special measures are required --- see for example
__ext4_grp_locked_error().
