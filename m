Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59C82DBE14
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLPJ4s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 04:56:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:51700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLPJ4s (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 04:56:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDE84AE87;
        Wed, 16 Dec 2020 09:56:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 555BA1E135E; Wed, 16 Dec 2020 10:56:06 +0100 (CET)
Date:   Wed, 16 Dec 2020 10:56:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 07/12] ext4: Defer saving error info from atomic context
Message-ID: <20201216095606.GA21258@quack2.suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-8-jack@suse.cz>
 <X9mbnUqNFnJSN1S8@mit.edu>
 <X9mdzfqfC1HJC4ts@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9mdzfqfC1HJC4ts@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-12-20 00:40:29, Theodore Y. Ts'o wrote:
> Applied with the following additional change folded in:

Cool. Thanks for fixing this!

								Honza


> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0c18f50f2207..9d0ce11bd48e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5475,17 +5475,21 @@ static int ext4_commit_super(struct super_block *sb, int sync)
>  	spin_lock(&sbi->s_error_lock);
>  	if (sbi->s_add_error_count > 0) {
>  		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> -		__ext4_update_tstamp(&es->s_first_error_time,
> -				     &es->s_first_error_time_hi,
> -				     sbi->s_first_error_time);
> -		strncpy(es->s_first_error_func, sbi->s_first_error_func,
> -			sizeof(es->s_first_error_func));
> -		es->s_first_error_line = cpu_to_le32(sbi->s_first_error_line);
> -		es->s_first_error_ino = cpu_to_le32(sbi->s_first_error_ino);
> -		es->s_first_error_block = cpu_to_le64(sbi->s_first_error_block);
> -		es->s_first_error_errcode =
> +		if (!es->s_first_error_time && !es->s_first_error_time_hi) {
> +			__ext4_update_tstamp(&es->s_first_error_time,
> +					     &es->s_first_error_time_hi,
> +					     sbi->s_first_error_time);
> +			strncpy(es->s_first_error_func, sbi->s_first_error_func,
> +				sizeof(es->s_first_error_func));
> +			es->s_first_error_line =
> +				cpu_to_le32(sbi->s_first_error_line);
> +			es->s_first_error_ino =
> +				cpu_to_le32(sbi->s_first_error_ino);
> +			es->s_first_error_block =
> +				cpu_to_le64(sbi->s_first_error_block);
> +			es->s_first_error_errcode =
>  				ext4_errno_to_code(sbi->s_first_error_code);
> -
> +		}
>  		__ext4_update_tstamp(&es->s_last_error_time,
>  				     &es->s_last_error_time_hi,
>  				     sbi->s_last_error_time);
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
