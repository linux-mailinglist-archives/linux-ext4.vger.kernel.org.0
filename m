Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86470485FFB
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiAFEoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:44:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39766 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232983AbiAFEoo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:44:44 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064idIY004201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:44:39 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3795B15C00E1; Wed,  5 Jan 2022 23:44:39 -0500 (EST)
Date:   Wed, 5 Jan 2022 23:44:39 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH linux] ext4: Delete useless ret assignment
Message-ID: <YdZzt0LF/ajTGNXo@mit.edu>
References: <20211230062905.586150-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230062905.586150-1-luo.penghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 30, 2021 at 06:29:05AM +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The assignments in these two places will be overwritten by new
> assignments later, so they should be deleted.
> 
> The clang_analyzer complains as follows:
> 
> fs/ext4/fast_commit.c
> 
> Value stored to 'ret' is never read

I suspect the right answer here is that we *should* be checking the
return value, and reflecting the error up to caller, if appropriate.

Harshad, what do you think?

					- Ted

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>  fs/ext4/fast_commit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 8ea5a81..8d5d044 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1660,7 +1660,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
>  		return 0;
>  	}
>  
> -	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +	ext4_fc_record_modified_inode(sb, inode->i_ino);
>  
>  	start = le32_to_cpu(ex->ee_block);
>  	start_pblk = ext4_ext_pblock(ex);
> @@ -1785,7 +1785,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  		return 0;
>  	}
>  
> -	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> +	ext4_fc_record_modified_inode(sb, inode->i_ino);
>  
>  	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
>  			inode->i_ino, le32_to_cpu(lrange.fc_lblk),
> -- 
> 2.15.2
> 
> 
