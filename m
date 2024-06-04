Return-Path: <linux-ext4+bounces-2768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B68B88FBA7C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2024 19:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CCCB28F42
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2024 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C647714A0A7;
	Tue,  4 Jun 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4yaGbJg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DCE14A09B
	for <linux-ext4@vger.kernel.org>; Tue,  4 Jun 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522246; cv=none; b=kwoln8TBHx47WFmrcsQWkY57wd5oDD5L+ekm0JmAD3I42aPLeyznaXxx2qGHvSYMn+HQGCcCXl7cvWt51wHpqV4qfZeMB3E8EoEELITPVVOWIG0KFOS3w84AgEyoLEbMytutGYncB100n7MrLtUAfWO0/IUUx+Ur1Esj77w36/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522246; c=relaxed/simple;
	bh=sqz1qbKj8sYh1m4kyTeBM2R2X5vDzFS9JdeJ8ZaRFBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk84KbBH3BjtjvS4M00W+xu0+MmO9vvho0dD2bGA1Pl4F2mU/V609ExzzA4k/tG4xyOP6ESr1gFLl5X97QxHluEYS84IP8pN4GnBDXPqtj0VBltVmsFHgdTVxnBVGN0P+83KghEhXjDy20WMzjYzOS1lcFUFWNYy0KKhZtyN/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4yaGbJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAB4C2BBFC;
	Tue,  4 Jun 2024 17:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717522246;
	bh=sqz1qbKj8sYh1m4kyTeBM2R2X5vDzFS9JdeJ8ZaRFBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4yaGbJgPnAl6xNoqEAW0HFA8UkRhwMoy8F1abkiddtt6bJiotYqh3nxhM5tLHNtk
	 e1kmG+dJp9nzQM/a7qxJX4h6Nq5a/QWiF3zlBjEdQ1mWdwaZWQuaEizZoCuDJDEV7S
	 tyZyHjiT2AaORYvsfbrauZD1LYyO5TWbE5sNw8l0kt6xqPuOTqA6rClIOhQctEi1+8
	 yQOVs+3DTEjv9QaFTefQoYNGSlzX1gaNO4k7VlfCojT71fZRuM6jFBI9Tr2b+cWxGr
	 AtD4VgXygfOkqih3QU8IsKnd6j6IPE/1Ofvbq6UkE2Z15tmFiXQOIlcoPP2TGUjV7w
	 /hIkyxs/p48YA==
Date: Tue, 4 Jun 2024 10:30:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: carrion bent <carrionbent@163.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4:fix macro definition error of EXT4_DIRENT_HASH and
 EXT4_DIRENT_MINOR_HASH
Message-ID: <20240604173044.GB1566@sol.localdomain>
References: <1717412239-31392-1-git-send-email-carrionbent@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1717412239-31392-1-git-send-email-carrionbent@163.com>

On Mon, Jun 03, 2024 at 06:57:19PM +0800, carrion bent wrote:
> the macro parameter "entry" of EXT4_DIRENT_HASH and
> EXT4_DIRENT_MINOR_HASH was not used, but rather the
> variable de was directly used, which may be a local
> variable inside a function that calls the macros
> 
> Signed-off-by: carrion bent <carrionbent@163.com>
> ---
>  fs/ext4/ext4.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 983dad8..04bdd27 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2338,9 +2338,9 @@ struct ext4_dir_entry_2 {
>  	((struct ext4_dir_entry_hash *) \
>  		(((void *)(entry)) + \
>  		((8 + (entry)->name_len + EXT4_DIR_ROUND) & ~EXT4_DIR_ROUND)))
> -#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(de)->hash)
> +#define EXT4_DIRENT_HASH(entry) le32_to_cpu(EXT4_DIRENT_HASHES(entry)->hash)
>  #define EXT4_DIRENT_MINOR_HASH(entry) \
> -		le32_to_cpu(EXT4_DIRENT_HASHES(de)->minor_hash)
> +		le32_to_cpu(EXT4_DIRENT_HASHES(entry)->minor_hash)
>  
>  static inline bool ext4_hash_in_dirent(const struct inode *inode)
>  {

Thanks!  Can you call out explicitly in the commit message that (fortunately)
all callers pass in 'de', so this bug didn't have an effect?  Also, in the
commit title, there needs to be a space after "ext4:".  Otherwise this patch
looks good to me.

- Eric

