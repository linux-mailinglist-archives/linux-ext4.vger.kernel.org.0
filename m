Return-Path: <linux-ext4+bounces-6373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F2DA2BA0B
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 05:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209D13A62B0
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA307231CB0;
	Fri,  7 Feb 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8M89Dqv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BD51DE2A0
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 04:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901516; cv=none; b=oRcEghlVGUFI3EjwGfRcRkBT8+UxmeH38WpbgLX+oT6M5IX+Mh3ND4O9eHRw4WJ6hfemr/JlRhQgOURxr3LBuAWzDXLPagitDknuNL+fP6qlTFnRQOVq1zAmA3PbiqK70gTKIFtZmRGEF/FUIt3DO2yG5gYJyitmctpnSfX6uI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901516; c=relaxed/simple;
	bh=pn6HlFcA0BCAqoMSMStk88lQgt0QI2qB6F67AJZhLvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY3Vags9s1nrJrxXmKYsek2LaMlxg20Vd2xtBkrqLYSTXSdz4JYMIfWgVlJhZ5MIYQX8mBs3sXh6gd/UZyQuEn8ppW79Uikrll377iUo9a3Mz7iGEOJEwNieDQyTeA00wfiXmQbbg6hpPJX0FY5QulOUBGHw6Vlu9VkU9RKnyzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8M89Dqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E973CC4CED1;
	Fri,  7 Feb 2025 04:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738901516;
	bh=pn6HlFcA0BCAqoMSMStk88lQgt0QI2qB6F67AJZhLvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8M89DqvwiByKDu5Oidk1QcF7+oIrZqqF7cQFsjQ16hWjvliDeo2iVNp9WLYiBSVy
	 MmgDf92133DPLl8TpHLLy1oyb6NTGRxrb7Rl6yilDZUldovkNliygLRZueQsl3i0XW
	 7wDthBWWjVL/V7ad4ZgyR0RNBkDKFHIFbopc0jd16pM0YCxp62KuBz5aQ1+gEbio6G
	 7IU+hNW+e/oGhW43sOV2FZqbJ5nZ/ourLQgzLpXDWNhkxkI9XM7qQyrWFUNdFUcT11
	 aCqM+oC0FpzIS6PFzD2BMBVLvOI91yhEZIW1A5sqHexkOWHomPD3G9/gXzgPw9whgs
	 RfXKEq1BnYnAw==
Date: Thu, 6 Feb 2025 20:11:55 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH] jbd2: remove redundant function
 jbd2_journal_has_csum_v2or3_feature
Message-ID: <20250207041155.GC21787@frogsfrogsfrogs>
References: <20250207031424.42755-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207031424.42755-1-ebiggers@kernel.org>

On Thu, Feb 06, 2025 at 07:14:24PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since commit dd348f054b24 ("jbd2: switch to using the crc32c library"),
> jbd2_journal_has_csum_v2or3() and jbd2_journal_has_csum_v2or3_feature()
> are the same.  Remove jbd2_journal_has_csum_v2or3_feature() and just
> keep jbd2_journal_has_csum_v2or3().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/jbd2/journal.c    | 4 ++--
>  include/linux/jbd2.h | 8 ++------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d8084b31b3610..4de74056a3c36 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1359,19 +1359,19 @@ static int journal_check_superblock(journal_t *journal)
>  		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
>  		       "at the same time!\n");
>  		return err;
>  	}
>  
> -	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
> +	if (jbd2_journal_has_csum_v2or3(journal) &&
>  	    jbd2_has_feature_checksum(journal)) {
>  		/* Can't have checksum v1 and v2 on at the same time! */
>  		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
>  		       "at the same time!\n");
>  		return err;
>  	}
>  
> -	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
> +	if (jbd2_journal_has_csum_v2or3(journal)) {
>  		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
>  			printk(KERN_ERR "JBD2: Unknown checksum type\n");
>  			return err;
>  		}
>  
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 561025b4f3d91..a7e8163637b44 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1734,18 +1734,14 @@ static inline int tid_geq(tid_t x, tid_t y)
>  }
>  
>  extern int jbd2_journal_blocks_per_page(struct inode *inode);
>  extern size_t journal_tag_bytes(journal_t *journal);
>  
> -static inline bool jbd2_journal_has_csum_v2or3_feature(journal_t *j)
> -{
> -	return jbd2_has_feature_csum2(j) || jbd2_has_feature_csum3(j);
> -}
> -
>  static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
>  {
> -	return jbd2_journal_has_csum_v2or3_feature(journal);
> +	return jbd2_has_feature_csum2(journal) ||
> +	       jbd2_has_feature_csum3(journal);
>  }
>  
>  static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
>  {
>  	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);
> 
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> -- 
> 2.48.1
> 
> 

