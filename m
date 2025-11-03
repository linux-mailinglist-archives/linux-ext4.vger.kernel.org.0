Return-Path: <linux-ext4+bounces-11426-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2094C2E2C8
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 22:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1CD1888517
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D42D46A2;
	Mon,  3 Nov 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEsRVN4H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CD23EAA6
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205869; cv=none; b=ZZOjbz/J/dDUbCTtbb4jOSf1VVmnEFWK8BaR6L3+C739y5psqSAZXRdJFwxwXyq4lYZ6I2TFJ930IZRRzyUYBuMaD45bDuw/CHU5BZAc1NWsmEhs7dlY4iF1vSFAmZ8tFCwyo47TCPs6OsCJOdlk1eilQTjntxoyeb/m0OgWzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205869; c=relaxed/simple;
	bh=Yp95Cm2/IEal6SUf7o8oFxPKOXWxIABtmRachxH93OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5bsRI1RmIZpmT+VKEQu/gcI60aZhhoVRDqsUGX9xg0FTkrIU7Y3AK5f6ywnHtz2kDf4iCw4mgedKRp0LctS60VXvrht9X3pbXhYeFU4mGba0VRAVSS/I18/cYB4ybX+WkjJiD2BwEON8CxtgJ+Ca4K5KVaH9wxllBjrAArUrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEsRVN4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED149C4CEE7;
	Mon,  3 Nov 2025 21:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762205869;
	bh=Yp95Cm2/IEal6SUf7o8oFxPKOXWxIABtmRachxH93OU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HEsRVN4HQghsYTREY4QO1w5dBJ+h91YvLf5nm0yJyLyT4NlhV9L7SSoLvwwgSA1vD
	 KBcCbVxOh5uWdMKXZPzn61jwgyWWqu9c9PuGmOTP/aBfk83IJC4aQcrxbLsNZsg/mh
	 ZYFgHFj1zogc5ItUM2Zif1vTe5V8UO+1d0dnlBcKeG+jigw4u8C15OO5WJz2E8+kNx
	 iYQAuB7E0UJA/Qh7MWoSWkN2IC+PwnvuPa6buE/fQ/aC4LdcrCFX1kSpfrYITVRtMp
	 nVd/5x+7bywSKLurr/JXv2DC1LIbuyMygSyuSk4XeIiGu4g8+/4y8txgiqLZ4uoKE/
	 0Et08Kqfm1Rmg==
Date: Mon, 3 Nov 2025 13:37:48 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz
Subject: Re: [PATCH v2] jbd2: fix the inconsistency between checksum and data
 in memory for journal sb
Message-ID: <20251103213748.GA196358@frogsfrogsfrogs>
References: <20251103010123.3753631-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103010123.3753631-1-yebin@huaweicloud.com>

On Mon, Nov 03, 2025 at 09:01:23AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Copying the file system while it is mounted as read-only results in
> a mount failure:
> [~]# mkfs.ext4 -F /dev/sdc
> [~]# mount /dev/sdc -o ro /mnt/test
> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
> [~]# mount /dev/sda /mnt/test1
> [ 1094.849826] JBD2: journal checksum error
> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
> mount: mount /dev/sda on /mnt/test1 failed: Bad message
> 
> The process described above is just an abstracted way I came up with to
> reproduce the issue. In the actual scenario, the file system was mounted
> read-only and then copied while it was still mounted. It was found that
> the mount operation failed. The user intended to verify the data or use
> it as a backup, and this action was performed during a version upgrade.
> Above issue may happen as follows:
> ext4_fill_super
>  set_journal_csum_feature_set(sb)
>   if (ext4_has_metadata_csum(sb))
>    incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>   if (test_opt(sb, JOURNAL_CHECKSUM)
>    jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>     lock_buffer(journal->j_sb_buffer);
>     sb->s_feature_incompat  |= cpu_to_be32(incompat);
>     //The data in the journal sb was modified, but the checksum was not
>       updated, so the data remaining in memory has a mismatch between the
>       data and the checksum.
>     unlock_buffer(journal->j_sb_buffer);
> 
> In this case, the journal sb copied over is in a state where the checksum
> and data are inconsistent, so mounting fails.
> To solve the above issue, update the checksum in memory after modifying
> the journal sb.
> 
> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/jbd2/journal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..bf255f8b5eeb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2349,6 +2349,12 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>  	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  
> @@ -2378,9 +2384,17 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  
>  	sb = journal->j_superblock;
>  
> +	lock_buffer(journal->j_sb_buffer);
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
> +	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  }
>  EXPORT_SYMBOL(jbd2_journal_clear_features);
> -- 
> 2.34.1
> 
> 

