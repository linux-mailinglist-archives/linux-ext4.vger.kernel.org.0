Return-Path: <linux-ext4+bounces-11339-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D69C1B7A3
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 15:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 488E134AD29
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Oct 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C340331A72;
	Wed, 29 Oct 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJnodWxe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDD53271E7
	for <linux-ext4@vger.kernel.org>; Wed, 29 Oct 2025 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749740; cv=none; b=oG7lZiL5fj2y+50qqKTlA7RN03OXlwnc5Cchc6eVD/uItAw4SR2Sa1ABe35M9UiAtgvOKXQwsewQdJ4vHzgOMPoKozYXwAFyhu5/wnTCPjCsr0qjZr9ZHybGT8rn+IuLxu6OusOyZky0pxnRwb9SvAETSOhSN4nXqk6n4Oh9itw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749740; c=relaxed/simple;
	bh=Fq4tvpve4ZOyLILttpQEtylyB6eBRjCb67csUFSJJ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKRC71dUoNNFOqarPyM81BcrNOEot8MJC7ET//TT7vRrdHopwzf7QKBQdqTNJkKhDPvLNBQzer6ZHgdpkIBIEq3mvq7CdS8N8npXxfYn2U/01OQcx68+RBNBkI1lNcL6A1d9L+es6YwJuUqvruzqVxAVjkf+GDaVPkoS12t/fYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJnodWxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B391DC4CEF7;
	Wed, 29 Oct 2025 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761749739;
	bh=Fq4tvpve4ZOyLILttpQEtylyB6eBRjCb67csUFSJJ8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aJnodWxeLLPbgS0tGiPa/zvxMX3NppG9pz+A0e8yRK7iG4elztTsoMvsqzYxuuo6J
	 9k7K1N916sJaOwGf1DIRMSzCnkHHgxwAHYIZdtcQtuKUhsS479dyJOfNlWIFF3UmYT
	 hgh9d+WjPx0AsGQuyyj/c9fxVhanZt9z0fJFrABP9L6cBqo7K+0MXgAnX3Sj06DG9Y
	 05/nsCJN59NsXIj/MZIufHJ9PAjOVuaiVtFhg5vDkFVsohXQD5dHeHCikbKEQTSbF3
	 40FHglsHiMPxhqr5lhSyIMMvcU/V7Eu686V2F94m57T/tRkN2QGPZ+XSnLeB/PwPKr
	 tbpNz+QSpHUYw==
Date: Wed, 29 Oct 2025 07:55:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
Message-ID: <20251029145539.GU6170@frogsfrogsfrogs>
References: <20251028064728.91827-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028064728.91827-1-yebin@huaweicloud.com>

On Tue, Oct 28, 2025 at 02:47:28PM +0800, Ye Bin wrote:
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

I was about to say "Well don't do that, freeze the fs first..."

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

...but I think the actual change is correct because (a) we shouldn't
unlock the bh with an incorrect checksum because userspace can see that;
and (b) if the bh ever gets marked dirty, then writeback can push the
inconsistent buffer to disk at any time.

I think it's the case that j_sb_buffer is only ever written out
explicitly with submit_bh rather than going through the dirty -> flush
machinery, but I guess syzbot could read and write the same value from
userspace to dirty the buffer and flush it out while racing to shut down
the journal, and now the ondisk journal is inconsistent.

Anyway, the "set csum before unlock_buffer" paradigm is all over the
ext4 code so

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/journal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..5b6e8c1a5e6a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2349,6 +2349,8 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>  	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  
> @@ -2378,9 +2380,13 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  
>  	sb = journal->j_superblock;
>  
> +	lock_buffer(journal->j_sb_buffer);
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
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

