Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAAF1B5FD1
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgDWPqm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 11:46:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbgDWPqm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 11:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C4F0AD66;
        Thu, 23 Apr 2020 15:46:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 90E501E0E52; Thu, 23 Apr 2020 17:46:40 +0200 (CEST)
Date:   Thu, 23 Apr 2020 17:46:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: don't ignore return values from ext4_ext_dirty()
Message-ID: <20200423154640.GB28707@quack2.suse.cz>
References: <20200421030247.34306-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421030247.34306-1-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 20-04-20 20:02:47, Harshad Shirwadkar wrote:
> Don't ignore return values from ext4_ext_dirty, since the errors
> indicate valid failures below Ext4.  In all of the other instances of
> ext4_ext_dirty calls, the error return value is handled in some
> way. This patch makes those remaining couple of places to handle
> ext4_ext_dirty errors as well. In case of ext4_split_extent_at(), the
> ignorance of return value is intentional. The reason is that we are
> already in error path and there isn't much we can do if ext4_ext_dirty
> returns error. This patch adds a comment for that case explaining why
> we ignore the return value.
> 
> In the longer run, we probably should
> make sure that errors from other mark_dirty routines are handled as
> well.
> 
> Ran gce-xfstests smoke tests and verified that there were no
> regressions.
> 
> Changes since V1:
> Fixed incorrect return value handling in ext4_split_extent_at()

The 'Changes' part should go below the '---' separator. There's no need to
have it included in the final commit message.

> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Otherwise the patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b315a0..6425f4f9a197 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3244,6 +3244,10 @@ static int ext4_split_extent_at(handle_t *handle,
>  
>  fix_extent_len:
>  	ex->ee_len = orig_ex.ee_len;
> +	/*
> +	 * Ignore ext4_ext_dirty return value since we are already in error path
> +	 * and err is a non-zero error code.
> +	 */
>  	ext4_ext_dirty(handle, inode, path + path->p_depth);
>  	return err;
>  }
> @@ -3503,7 +3507,7 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	}
>  	if (allocated) {
>  		/* Mark the block containing both extents as dirty */
> -		ext4_ext_dirty(handle, inode, path + depth);
> +		err = ext4_ext_dirty(handle, inode, path + depth);
>  
>  		/* Update path to point to the right extent */
>  		path[depth].p_ext = abut_ex;
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
