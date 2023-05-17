Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5031F705F08
	for <lists+linux-ext4@lfdr.de>; Wed, 17 May 2023 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjEQE6k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 17 May 2023 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQE6j (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 17 May 2023 00:58:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A235A0;
        Tue, 16 May 2023 21:58:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F02846416A;
        Wed, 17 May 2023 04:58:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5962CC433D2;
        Wed, 17 May 2023 04:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684299517;
        bh=JXO7heg5WUZNlDmWN57OsaeJjG0fLyTe1q0jhMPHx8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGnmx7T2UPfkCaLcykQ0xfMavWGp2hBEAtVEAMg+GX4izdX9own4BrEBiSTKQbx2X
         mETpWoBKxajo9ApB+RLkYyg2EQdoB69w6sYFGGLylRYtPo/CuqyqD97bpEspbZOU0i
         MSGChGqoyURojFqKlALzEPKGVVCQ8e6qwTNcBLYumWqd/gmeRzyards7t4nwTDAufh
         PBaF2FzSJkbXvyXxc1Mzk2GXyZHdEs2DDu9yT9HJV2tybtVJVj3U0OGQDxkK6ZLohW
         g1btsIpyrnR3QWR9cxg1S0dBH82zN408AnNgr0U1u/xt+Yajs+ZS8jia6Zw4Nad3Xk
         tybf/8myBcU8g==
Date:   Tue, 16 May 2023 21:58:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix possible corruption when moving a directory
Message-ID: <20230517045836.GA11594@frogsfrogsfrogs>
References: <20230126112221.11866-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126112221.11866-1-jack@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 26, 2023 at 12:22:21PM +0100, Jan Kara wrote:
> When we are renaming a directory to a different directory, we need to
> update '..' entry in the moved directory. However nothing prevents moved
> directory from being modified and even converted from the inline format
> to the normal format. When such race happens the rename code gets
> confused and we crash. Fix the problem by locking the moved directory.

Four months later, I have a question --

Is it necessary for ext4_cross_rename to inode_lock_nested on both
old.inode and new.inode?  We're resetting the dotdot entries on both
children in that case, which means that we also need to lock out inline
data conversions, right?

--D

> CC: stable@vger.kernel.org
> Fixes: 32f7f22c0b52 ("ext4: let ext4_rename handle inline dir")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/namei.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index dd28453d6ea3..270fbcba75b6 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3872,9 +3872,16 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  			if (new.dir != old.dir && EXT4_DIR_LINK_MAX(new.dir))
>  				goto end_rename;
>  		}
> +		/*
> +		 * We need to protect against old.inode directory getting
> +		 * converted from inline directory format into a normal one.
> +		 */
> +		inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
>  		retval = ext4_rename_dir_prepare(handle, &old);
> -		if (retval)
> +		if (retval) {
> +			inode_unlock(old.inode);
>  			goto end_rename;
> +		}
>  	}
>  	/*
>  	 * If we're renaming a file within an inline_data dir and adding or
> @@ -4006,6 +4013,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
>  	} else {
>  		ext4_journal_stop(handle);
>  	}
> +	if (old.dir_bh)
> +		inode_unlock(old.inode);
>  release_bh:
>  	brelse(old.dir_bh);
>  	brelse(old.bh);
> -- 
> 2.35.3
> 
