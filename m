Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468122CC52B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 19:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgLBSa2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 13:30:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50557 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729110AbgLBSa2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 13:30:28 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2ITcas007033
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 13:29:38 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 25BFB420136; Wed,  2 Dec 2020 13:29:38 -0500 (EST)
Date:   Wed, 2 Dec 2020 13:29:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 04/15] mke2fs, dumpe2fs: make fast commit blocks
 configurable
Message-ID: <20201202182938.GH390058@mit.edu>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-5-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191606.2224881-5-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:55AM -0800, Harshad Shirwadkar wrote:
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index a8a6e091..01132245 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -1625,15 +1631,18 @@ extern errcode_t ext2fs_zero_blocks(ext2_filsys fs, blk_t blk, int num,
>  extern errcode_t ext2fs_zero_blocks2(ext2_filsys fs, blk64_t blk, int num,
>  				     blk64_t *ret_blk, int *ret_count);
>  extern errcode_t ext2fs_create_journal_superblock(ext2_filsys fs,
> -						  __u32 num_blocks, int flags,
> -						  char  **ret_jsb);
> +						  __u32 num_blocks, __u32 num_fc_blks,
> +						  int flags, char  **ret_jsb);
> +extern errcode_t ext2fs_split_journal_size(ext2_filsys fs, blk_t *journal_blks,
> +					   blk_t *fc_blks, blk_t total_blks);
>  extern errcode_t ext2fs_add_journal_device(ext2_filsys fs,
>  					   ext2_filsys journal_dev);
>  extern errcode_t ext2fs_add_journal_inode(ext2_filsys fs, blk_t num_blocks,
> -					  int flags);
> +					  blk_t num_fc_blocks, int flags);
>  extern errcode_t ext2fs_add_journal_inode2(ext2_filsys fs, blk_t num_blocks,
> -					   blk64_t goal, int flags);
> -extern int ext2fs_default_journal_size(__u64 num_blocks);
> +				    blk_t num_fc_blocks,
> +				    blk64_t goal, int flags);
> +extern errcode_t ext2fs_default_journal_size(int *journal_size, int *fc_size, ext2_filsys fs);
>  extern int ext2fs_journal_sb_start(int blocksize);
>  

We must never change the type or function signature of anything which
is exported via a shared library.  Otherwise, if someone grabs a new
mke2fs binary, and somehow fails to run against an older version of
libext2fs.so, Much Hilarity will ensue.

It's also possible that there may be some other userspace application
which is shipped separately from e2fsprogs --- maybe in some company's
userspace program which has never been published and might be living
in some Perforce depot for all we know --- that might be using a
published interface.  So even without shared libraries, we don't want
to break those applications when that company imports the newer
version of e2fsprogs into their code base.

That means that we can define new functions (and they should be
prefixed with ext2fs_ to avoid namespace polution), but we must not
modify existing functions.  We can either do something like, say,
ext2fs_default_journal_size2() or perhaps better in this case, we
could define a new function ext2fs_default_journal_params(), and then
define ext2fs_default_journal_size() in terms of the new function.

> @@ -2122,6 +2131,8 @@ static inline unsigned int ext2_dir_htree_level(ext2_filsys fs)
>  	return EXT4_HTREE_LEVEL_COMPAT;
>  }
>  
> +#define max(a, b) ((a) > (b) ? (a) : (b))
> +
>  #ifdef __cplusplus
>  }
>  #endif

Please don't define max() in ext2fs.h, since that's a public header
file, and we don't want cause problems for applciations which may have
their own max() definition.

There is the ext2fsP.h header file which is private to the ext2fs
library, or you could define a new function or cpp macros in
libsupport, if it's really necessary for multiple e2fsprogs
applications.  Or maybe max() is so simple that we can just have it
defined in those .c files where it's needed....


> diff --git a/lib/ext2fs/mkjournal.c b/lib/ext2fs/mkjournal.c
> index f47f71e6..74d0c7fc 100644
> --- a/lib/ext2fs/mkjournal.c
> +++ b/lib/ext2fs/mkjournal.c
> +errcode_t ext2fs_split_journal_size(ext2_filsys fs, blk_t *journal_blks,
> +		blk_t *fc_blks, blk_t total_blks)
> +{
> +	if (total_blks < JBD2_MIN_JOURNAL_BLOCKS)
> +		return EXT2_ET_JOURNAL_TOO_SMALL;
> +
> +	if (!ext2fs_has_feature_fast_commit(fs->super)) {
> +		*journal_blks = total_blks;
> +		*fc_blks = 0;
> +		return 0;
> +	}
> +	*journal_blks = ext2fs_blocks_count(fs->super) *
> +			EXT2_JOURNAL_TO_FC_BLKS_RATIO /
> +			(EXT2_JOURNAL_TO_FC_BLKS_RATIO + 1);
> +	*journal_blks = max(JBD2_MIN_JOURNAL_BLOCKS, *journal_blks);
> +	*fc_blks = total_blks - *journal_blks;
> +	return 0;
> +}

Maybe we should just have a ext2fs_default_journal_params structure,
and do this as part of a new "ext2fs_get_journal_params"?  If the
number of journal blocks or fast commit blocks is zero, then we can
have the function fill in an appropriate default value, perhaps?

Cheers,

						- Ted
