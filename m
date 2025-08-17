Return-Path: <linux-ext4+bounces-9388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3326B295B5
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Aug 2025 01:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817A317F327
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Aug 2025 23:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9BD2192F4;
	Sun, 17 Aug 2025 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3qjAasU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4213AD3F;
	Sun, 17 Aug 2025 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755474233; cv=none; b=XPUuvlsCxxxW//EDE8hzbmJ0xAn6NbttBOYYsZ88CTQ9DRtsl6MjK7ISgtl0iXMs9WeMK9IZkO1u0JFtOeggtSubES/Fr4yq5t1qmsglfdB0fMpyFqLTtvOIS7viJyNaP1MFRl99AfaaXXy+JR74fjjxUw545YO7HLNILYpPujE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755474233; c=relaxed/simple;
	bh=mqjeVrC5GbIEs+kq7B3jMm6zMRskrNPVoSIIjxkSK38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8n6UwVim3betGp9jyb7fRFxjmBe4zMXo3S8CAjjynRLpZKP8bCdEq+x9N7D/K1pZ6fWNGeBnrpSGTLA45bSXZ7CrgvUBVKxKj+9Er6NAtjgrZAHSzbIFhiKqCyskPVFHk19uF3LejvV2dnkRlZV/I3ESGoOoR7QJgLCONMLzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3qjAasU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B9C4CEEB;
	Sun, 17 Aug 2025 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755474233;
	bh=mqjeVrC5GbIEs+kq7B3jMm6zMRskrNPVoSIIjxkSK38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3qjAasU7BoOxS43FW3V4OWgzaQql/MmGBT07BN99nXrmNGm8l6UgnMlrtEaa5Nf7
	 003qlgGRNJ5C++6teVoUoZYH1xf6MCf6TgZwK/qfJKbYLLR/YTj3ZE0qElXiS3QtAO
	 D/ReDpo0AoDO99EwkwTKJbdi2wByRB1onyRlpXzBmWoPorWFbZ0vLrA6BlJFqz7mP7
	 IUmtw76nAmgLoJQZx0OvoOdc3liV/i+qCEW/AmvueoDgpIZJsbdwtgVzBAt+36NNYQ
	 3GBbYh9CkMz3LRGoWcQrmyUDvBtYDJyIjr0RPW0rf3mvof+R8TUVdK2enT06S/5Af1
	 ZcRNSnm7R9kWw==
Date: Sun, 17 Aug 2025 16:43:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH RESEND] fs/ext4: remove unused variable 'de' in
 ext4_init_new_dir()
Message-ID: <20250817234352.GH7938@frogsfrogsfrogs>
References: <20250813182440.17581-1-suchitkarunakaran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813182440.17581-1-suchitkarunakaran@gmail.com>

On Wed, Aug 13, 2025 at 11:54:40PM +0530, Suchit Karunakaran wrote:
> The variable 'de' was declared but never used in the ext4_init_new_dir()
> function, causing a compiler warning:
> variable 'de' set but not used [-Werror=unused-but-set-variable]
> Remove the unused declaration to clean up the code and fix the warning.
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

Gets rid of an annoying warning on my build system, so
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/namei.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index d83f91b62317..bb2370829928 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2965,7 +2965,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
>  			     struct inode *inode)
>  {
>  	struct buffer_head *dir_block = NULL;
> -	struct ext4_dir_entry_2 *de;
>  	ext4_lblk_t block = 0;
>  	int err;
>  
> @@ -2982,7 +2981,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
>  	dir_block = ext4_append(handle, inode, &block);
>  	if (IS_ERR(dir_block))
>  		return PTR_ERR(dir_block);
> -	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
>  	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
>  	if (err)
>  		goto out;
> -- 
> 2.50.1
> 
> 

