Return-Path: <linux-ext4+bounces-8779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4FAF5CE0
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 17:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9400A1890818
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62782E03F0;
	Wed,  2 Jul 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb1QQVZi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1432E03E3
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469785; cv=none; b=jesD3QYRm1/pM0ndb8AHfdPsnsMeK9v0hynFX1H9BayTVUjLKnUfrNz8Uw10AusFXwVjyPt6k2A+7LDh9sBC+FBu9bhJsfcqoKjSqjXff9MV8rTRBB1Vb57NwzYrq0Q8eOFntfavL6geSAOAM+puN0RRIRBBfmvDadXUn07cf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469785; c=relaxed/simple;
	bh=xm1gq9lhS97XcQZwl/AsN21lNJP5zayxvV+GTIjjwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPSBmhADkMhtpawJ17e7E4X2IvPV6Tzp+BHdKpVPT0t4znjMEbrBh2jVM3EGG/H8rMT1BapZj3LqufAaTyEBAhZ/DDlaHEt/Md30Mu0m2db5jr9Z8eSagK4rO9yKvPz1VVbZ4rjp8VLzPM/furoHEcxPywG4SZF01g4GiCpy0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb1QQVZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ECFC4CEE7;
	Wed,  2 Jul 2025 15:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469784;
	bh=xm1gq9lhS97XcQZwl/AsN21lNJP5zayxvV+GTIjjwsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mb1QQVZiG82jf0vq5ExCwbYX3gSacc3cykNLfRefY/+g80uZYwLC/By2+nL9NjIEt
	 jXLuEhrnweX9GkgHaQA215EW2sr53wb4jKEpo8l4fufSl9kpiMHSB1vamD9C7BfrUM
	 SPhFeUMz7Na5drBLn0wjg4NHP9bwN5H+80nCgbFUkojt2uu6bEl+iVTgCaHd6ZFwim
	 tz7EbfKXUG5bZRW0sxocayZhcAIFoBogzy9IH+/Z4jk5SWPpAkMX2gET91fXdtid69
	 Z2uueqoRMzx81pGVG5JkZ5GsJ+vw2dlwEzx4S5QcVqSdpHatbGXx0WNybS/yiQZpEY
	 FfhDdexdwexaA==
Date: Wed, 2 Jul 2025 08:23:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: verify dirent offset in ext4_readdir()
Message-ID: <20250702152304.GM9987@frogsfrogsfrogs>
References: <20250701141141.55938-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701141141.55938-1-dmantipov@yandex.ru>

On Tue, Jul 01, 2025 at 05:11:41PM +0300, Dmitry Antipov wrote:
> On a corrupted filesystem, an unexpectedly large invalid value
> returned by 'ext4_rec_len_from_disk()' may cause 'ext4_readdir()'
> to read the next dirent from an area beyond the corresponding
> buffer head's data. At this point, an exact length of the dirent
> is not known yet but it's possible to check whether the shortest
> possible dirent will be read from within the bh's data at least.
> 
> Reported-by: syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5322c5c260eb44d209ed
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  fs/ext4/dir.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index d4164c507a90..8097016f69aa 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -258,6 +258,12 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  
>  		while (ctx->pos < inode->i_size
>  		       && offset < sb->s_blocksize) {
> +			/* Ensure that at least the shortest possible
> +			 * dirent will be read from within the bh's data.
> +			 */
> +			if (offset + offsetof(struct ext4_dir_entry_2, name)
> +			    > bh->b_size)
> +				break;

Why wouldn't you encode this check in __ext4_check_dir_entry and solve
this problem for all the callsites?

--D

>  			de = (struct ext4_dir_entry_2 *) (bh->b_data + offset);
>  			if (ext4_check_dir_entry(inode, file, de, bh,
>  						 bh->b_data, bh->b_size,
> -- 
> 2.50.0
> 
> 

