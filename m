Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE1C3EA8BE
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Aug 2021 18:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbhHLQse (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Aug 2021 12:48:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55584 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233027AbhHLQse (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Aug 2021 12:48:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17CGm1QT028714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 12:48:02 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB2A415C37C1; Thu, 12 Aug 2021 12:48:01 -0400 (EDT)
Date:   Thu, 12 Aug 2021 12:48:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH 5/5] ext4: Improve scalability of ext4 orphan file
 handling
Message-ID: <YRVQwWt4m9UGHCHp@mit.edu>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811101925.6973-5-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 11, 2021 at 12:19:15PM +0200, Jan Kara wrote:
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index 019719c0ac12..18622ddeb41b 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -28,28 +43,40 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
>  		 */
>  		return -ENOSPC;
>  	}
> -	oi->of_binfo[i].ob_free_entries--;
> -	spin_unlock(&oi->of_lock);
>  
> -	/*
> -	 * Get access to orphan block. We have dropped of_lock but since we
> -	 * have decremented number of free entries we are guaranteed free entry
> -	 * in our block.
> -	 */
>  	ret = ext4_journal_get_write_access(handle, inode->i_sb,
>  				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
>  	if (ret)
>  		return ret;

Shouldn't there be a call to:

		atomic_inc(&oi->of_binfo[i].ob_free_entries);

before we return, so the free_entry count stays consistent?

Otherwise, with the test-bot comments also addressed, you can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks,


       	  	     	 	    	  - Ted
