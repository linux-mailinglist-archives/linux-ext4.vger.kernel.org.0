Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFF23CBF1
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHEQDn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 12:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:33964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgHEPsi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Aug 2020 11:48:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80FB2ACC8;
        Wed,  5 Aug 2020 14:25:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4F7DC1E12CB; Wed,  5 Aug 2020 16:25:01 +0200 (CEST)
Date:   Wed, 5 Aug 2020 16:25:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't hardcode bit values in EXT4_FL_USER_*
Message-ID: <20200805142501.GD16475@quack2.suse.cz>
References: <20200713031012.192440-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713031012.192440-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 12-07-20 20:10:12, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Define the EXT4_FL_USER_* constants by OR-ing together the appropriate
> flags, rather than hard-coding a numeric value.  This makes it much
> easier to see which flags are listed.
> 
> No change in the actual values.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/ext4.h | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..b603a28a3696 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -434,8 +434,34 @@ struct flex_groups {
>  #define EXT4_CASEFOLD_FL		0x40000000 /* Casefolded directory */
>  #define EXT4_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
>  
> -#define EXT4_FL_USER_VISIBLE		0x725BDFFF /* User visible flags */
> -#define EXT4_FL_USER_MODIFIABLE		0x624BC0FF /* User modifiable flags */
> +/* User modifiable flags */
> +#define EXT4_FL_USER_MODIFIABLE		(EXT4_SECRM_FL | \
> +					 EXT4_UNRM_FL | \
> +					 EXT4_COMPR_FL | \
> +					 EXT4_SYNC_FL | \
> +					 EXT4_IMMUTABLE_FL | \
> +					 EXT4_APPEND_FL | \
> +					 EXT4_NODUMP_FL | \
> +					 EXT4_NOATIME_FL | \
> +					 EXT4_JOURNAL_DATA_FL | \
> +					 EXT4_NOTAIL_FL | \
> +					 EXT4_DIRSYNC_FL | \
> +					 EXT4_TOPDIR_FL | \
> +					 EXT4_EXTENTS_FL | \
> +					 0x00400000 /* EXT4_EOFBLOCKS_FL */ | \
> +					 EXT4_DAX_FL | \
> +					 EXT4_PROJINHERIT_FL | \
> +					 EXT4_CASEFOLD_FL)
> +
> +/* User visible flags */
> +#define EXT4_FL_USER_VISIBLE		(EXT4_FL_USER_MODIFIABLE | \
> +					 EXT4_DIRTY_FL | \
> +					 EXT4_COMPRBLK_FL | \
> +					 EXT4_NOCOMPR_FL | \
> +					 EXT4_ENCRYPT_FL | \
> +					 EXT4_INDEX_FL | \
> +					 EXT4_VERITY_FL | \
> +					 EXT4_INLINE_DATA_FL)
>  
>  /* Flags we can manipulate with through EXT4_IOC_FSSETXATTR */
>  #define EXT4_FL_XFLAG_VISIBLE		(EXT4_SYNC_FL | \
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
