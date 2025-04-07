Return-Path: <linux-ext4+bounces-7092-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D6A7EC9F
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 21:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC7446978
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 19:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF3258CD9;
	Mon,  7 Apr 2025 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF6Mwva6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865822E41C;
	Mon,  7 Apr 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052301; cv=none; b=BgzyaR1mROZMMuxAiGZeBrPzZZBaS82WbdGX57NiF+M6Ahf6dZA7SnjtflH8wIVzA8oKAklb2anEy8rkjoKZZlR9l6ZlatI3+L4u5mGW/0S3WVbayNpPMKuNjZw0LeABBg9bN6ErnSgdGyXQO2xjAsOOpH2EKZH92qxsL2GBtIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052301; c=relaxed/simple;
	bh=RJY+f1R8hI4t/Wsf1l9yEDTJPhNF5RCZngtFawzlXwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrTJEvkDt5lSg67SDNyiVxbXOnVzf5W3bg/wyN3k9W8RdIyvJE8okXme5wpxrbBL5Z5mLxJn2DCdLAKcoKf/koKmlOCBlgz7rTKjVJw6YFYt5vyKYHdBPs7yGdHqAOcfhKlbjuU5Bjk0hrfLoJmykITd1MgURuduY5g4JtA6aL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF6Mwva6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77358C4CEDD;
	Mon,  7 Apr 2025 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744052300;
	bh=RJY+f1R8hI4t/Wsf1l9yEDTJPhNF5RCZngtFawzlXwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZF6Mwva6UbJZzY0vnZ9L5tUFhcQF8KHT8qbFcwyDqIJkvI5YnJxnwh8DTRKC9itRw
	 QGHVd+fiUPzjSYtyx2fLVTh0ls7zriFZdp7cfc/4PQxNA4ew0xzN5GFaiQCPRqH2l2
	 1A84Viiss7tpJyfI7L+sYf00qXOJqTFFpoAQg/gmfiwwShZ85+75GRLxG4AA9SZoOF
	 bruJqFYNkHWNDQft+qfH7jzE/OYTTZUEaqgILb+ocwSqoHLb2ZRYxUKgkOebLf2hql
	 eE0Cu1XQnL7Ivh2hsGIbg/b19rdqOEyHZyAgitB5iBMilmpaa388dJXGfQNiKjO79Z
	 4+HnP4AC9ao/Q==
Date: Mon, 7 Apr 2025 11:58:17 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ext4: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <202504071156.2344BA19@keescook>
References: <Z-SF97N3AxcIMlSi@kspp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-SF97N3AxcIMlSi@kspp>

On Wed, Mar 26, 2025 at 04:55:51PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> fs/ext4/mballoc.c:3041:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  fs/ext4/mballoc.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0d523e9fb3d5..f88424c28194 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3037,10 +3037,8 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  	unsigned char blocksize_bits = min_t(unsigned char,
>  					     sb->s_blocksize_bits,
>  					     EXT4_MAX_BLOCK_LOG_SIZE);
> -	struct sg {
> -		struct ext4_group_info info;
> -		ext4_grpblk_t counters[EXT4_MAX_BLOCK_LOG_SIZE + 2];
> -	} sg;
> +	DEFINE_RAW_FLEX(struct ext4_group_info, sg, bb_counters,
> +			EXT4_MAX_BLOCK_LOG_SIZE + 2);

Yup, struct ext4_group_info::bb_counters is ext4_grpblk_t, so everything
matches up.

>  
>  	group--;
>  	if (group == 0)
> @@ -3048,7 +3046,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  			      " 2^0   2^1   2^2   2^3   2^4   2^5   2^6  "
>  			      " 2^7   2^8   2^9   2^10  2^11  2^12  2^13  ]\n");
>  
> -	i = (blocksize_bits + 2) * sizeof(sg.info.bb_counters[0]) +
> +	i = (blocksize_bits + 2) * sizeof(sg->bb_counters[0]) +
>  		sizeof(struct ext4_group_info);
>  
>  	grinfo = ext4_get_group_info(sb, group);
> @@ -3068,14 +3066,14 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  	 * We care only about free space counters in the group info and
>  	 * these are safe to access even after the buddy has been unloaded
>  	 */
> -	memcpy(&sg, grinfo, i);
> -	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg.info.bb_free,
> -			sg.info.bb_fragments, sg.info.bb_first_free);
> +	memcpy(sg, grinfo, i);
> +	seq_printf(seq, "#%-5u: %-5u %-5u %-5u [", group, sg->bb_free,
> +			sg->bb_fragments, sg->bb_first_free);
>  	for (i = 0; i <= 13; i++)
>  		seq_printf(seq, " %-5u", i <= blocksize_bits + 1 ?
> -				sg.info.bb_counters[i] : 0);
> +				sg->bb_counters[i] : 0);
>  	seq_puts(seq, " ]");
> -	if (EXT4_MB_GRP_BBITMAP_CORRUPT(&sg.info))
> +	if (EXT4_MB_GRP_BBITMAP_CORRUPT(sg))
>  		seq_puts(seq, " Block bitmap corrupted!");
>  	seq_putc(seq, '\n');
>  	return 0;

Replacements looks good.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

