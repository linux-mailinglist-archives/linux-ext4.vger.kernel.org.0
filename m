Return-Path: <linux-ext4+bounces-11359-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E87C1FA1F
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 11:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CB31886749
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Oct 2025 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1A72BEC20;
	Thu, 30 Oct 2025 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KCN/Wel0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2yLwj69";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YLPoF1mg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4r6EIj6i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E087483
	for <linux-ext4@vger.kernel.org>; Thu, 30 Oct 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821200; cv=none; b=GeYd+iS8ZziXxkjNH9HK/EE8X0yeM+raaMHnl0GSVtftkWV90Q23r+NfGOJTlmcPxJsHxVUJilk7Geg7PQTzM9g0adhTr9ZwavsxpejBWrLVMDqDkElYlSo9WEAZvQnB8z/SbQsXBIgqjiube91dJFq0NKAWOfgpZ4FShdtqOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821200; c=relaxed/simple;
	bh=OuInLxtH6EZ9snNqNGRvCPiubC6fbJwWr1Q0yr5pD7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNj5GLI5TNVCREid20Qqeu+5sdLvYdRexqSXPt2UJ3vNm47qFn6RaYQXGEMHQykzOlbo0IS5WLSf+kvnNGlmuhElAyltjdKWkUFPEVHNhwoyEHKyrhW51qGzFkBc/k8A4DcZWplxCvTDCvtg+1fwlu96sZZChn6VN4Orl2itVpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KCN/Wel0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2yLwj69; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YLPoF1mg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4r6EIj6i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 04171226DD;
	Thu, 30 Oct 2025 10:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761821197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a75cNn0DSc3HOH+OOOc7aGxntTD9ZHXa3Zsm3WxZ1gg=;
	b=KCN/Wel0cQRIsvRaPPA06Veu1oIn4PWLDoZ/UbpoPwSmPtOwZiCre7AVZ28QCj9Mx+8j5+
	ovxqW8aVDGophUKma/Ul61HCnuB0Qg2Pr3pLQJbVwrZZHpI3eD8vJMf8LARXyZgFOBTwiT
	dAJ7qu5Xm/PcGFSKmWxbenGs1c/NhAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761821197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a75cNn0DSc3HOH+OOOc7aGxntTD9ZHXa3Zsm3WxZ1gg=;
	b=o2yLwj69mMXyDKwbMbXBYNfC9OoL2HnPE1QSjqRLUuI7lhVdvt3IwqQQvdj6XtVd/l+YEG
	IP+C3ZRquaakdlCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761821196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a75cNn0DSc3HOH+OOOc7aGxntTD9ZHXa3Zsm3WxZ1gg=;
	b=YLPoF1mg1A+vQtEVypD3WbgmadgZRccCDK33olCQWzM9ZpoAr1QMgmx2X7acj1ViV1HN3f
	hEL0Fc1QoaAXhRaiP70hNBwo9rHwYf5ZKHGbKM416/YHFH9oIGT8YQ9oOP3v11Mi9Y+7e4
	uIChfPcwsf+BBAWpPJe5S2JDj/1pKHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761821196;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a75cNn0DSc3HOH+OOOc7aGxntTD9ZHXa3Zsm3WxZ1gg=;
	b=4r6EIj6iAQwCEUq8mHkLEvmXj8bB+8dS0MFyCacDKG7z5JI7CZ5L9G2gve6dsSCbB//gei
	Nv9HoBq4yZx7drDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED88213393;
	Thu, 30 Oct 2025 10:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Jv4OQtCA2kwQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 10:46:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 785DEA0AD6; Thu, 30 Oct 2025 11:46:35 +0100 (CET)
Date: Thu, 30 Oct 2025 11:46:35 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] jbd2: fix the inconsistency between checksum and data in
 memory for journal sb
Message-ID: <zxnvimnlpbimcdcanpfqggs5inyqwfykiibcqg6at54bbqmpwa@xyyxops25565>
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 28-10-25 14:47:28, Ye Bin wrote:
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

Looks good but please add a short comment before the checksum update
explaining why jbd2_superblock_csum() call in jbd2_write_superblock() isn't
enough. Something like:

	/*
	 * Update the checksum now so that it is valid even for read-only
	 * filesystems where jbd2_write_superblock() doesn't get called.
	 */

Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

