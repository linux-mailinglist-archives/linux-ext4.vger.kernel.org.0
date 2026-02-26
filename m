Return-Path: <linux-ext4+bounces-14055-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB98GbZPoGmIiAQAu9opvQ
	(envelope-from <linux-ext4+bounces-14055-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:50:46 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B751A6FA9
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 14:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7ACF30341AA
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Feb 2026 13:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA11309F01;
	Thu, 26 Feb 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="loThPtzI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dsk1D7QG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="serO32Wy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QXjCB3NI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7AE2DB7AA
	for <linux-ext4@vger.kernel.org>; Thu, 26 Feb 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113364; cv=none; b=daB/QG45rIpXRDEHz/RbjLA6eMEujlryVH0tTelnQXnhUlcMV1EtARsUaMsXjF9OsofyCY4xA1mr1it8T5s8mtwhZ7xaQnIYKDnZaRqfyWmM2L8IXWMP4XkIWpkSmm5dZocQO5fh1Qzn6U+3Qi1Y6vJEJuLmVINeXRoeDs9dbfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113364; c=relaxed/simple;
	bh=s550snIqDJ0ywicY67DWoFFAcZLDlmTadUwn8kskgWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7Tn/NwCLk901jw3BXSStUdiOdZH80K5BL5lWrlVawiMCFk8gZCYOpmAExge2asY4EHMJVigPfibALSPJCj43GJqVHDt7M9rpooyY34adq9r37VLvWw+qFSCs7lKTnvGh1FITs/Xz7tYDIunefEwZVZVXXfuWvAGfJNhTt6UOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=loThPtzI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dsk1D7QG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=serO32Wy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QXjCB3NI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DEE6F1FAA3;
	Thu, 26 Feb 2026 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFI0elnYDOhY2r6C0zAf5uTNtHqHigHRD2xFQXO+NCI=;
	b=loThPtzIdmG27N4TTCeTkhmiTveNSKAAMf6dA6EEIbbaPCgSAhBRcUjiFz4uYZu4+fo8Jk
	DVd9FRBSreZl8WfNcU84q14M52GxLnYlOOZ1+/20HtboyOLK5xzV/yyVojNsRz43GxRVV1
	5hKsrgeoPmVRlgQIi5cGnC7AkSOcnOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113360;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFI0elnYDOhY2r6C0zAf5uTNtHqHigHRD2xFQXO+NCI=;
	b=Dsk1D7QGnZ6RZ7XD1CLKogcqxjFJA2NMjcTcNNai10oPiztzUX4Wb5n7/Iye85hT9ISxoy
	+ianQ9PJNHlztIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=serO32Wy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QXjCB3NI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772113359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFI0elnYDOhY2r6C0zAf5uTNtHqHigHRD2xFQXO+NCI=;
	b=serO32Wyl63+Zn8QShrKtQX+cZ4hd6QcbxyEzXXF6ya4Z9Ind1GYqSdDbaQwH1d9dA8uan
	ks2MohT/38HUS16EflfEVqIwHFYLuiVb1TevQg/m2fI/sNSU+/viUtTXs40eaOXfcHWzyf
	dIv3NHwyjK1weHDDOw4PzQHsMmrSlHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772113359;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFI0elnYDOhY2r6C0zAf5uTNtHqHigHRD2xFQXO+NCI=;
	b=QXjCB3NIqu06JpWOkJmd1InU50EcR6bewmmI1LTlxHNasWkii61g39qEd1uL50ehpdomEj
	d4Na581oY8P+E0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C28C33EA62;
	Thu, 26 Feb 2026 13:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GrGULs9NoGkHaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 13:42:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8301FA0A27; Thu, 26 Feb 2026 14:42:39 +0100 (CET)
Date: Thu, 26 Feb 2026 14:42:39 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH] ext4: fix mballoc-test.c is not compiled when
 EXT4_KUNIT_TESTS=M
Message-ID: <o65evw32fb2cg2sclvxc3dkbqlhzzdns3uducvb7mgbkp4i5l3@hsluqhpejick>
References: <20260226110917.1904980-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226110917.1904980-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14055-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 80B751A6FA9
X-Rspamd-Action: no action

On Thu 26-02-26 19:09:17, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, only EXT4_KUNIT_TESTS=Y testcase will be compiled in 'mballoc.c'.
> To solve this issue, the ext4 test code needs to be decoupled. The ext4
> test module is compiled into a separate module.
> 
> Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> Closes: https://patchwork.kernel.org/project/cifs-client/patch/20260118091313.1988168-2-chenxiaosong.chenxiaosong@linux.dev/
> Fixes: 7c9fa399a369 ("ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

I think this is a good idea but:

> -#ifdef CONFIG_EXT4_KUNIT_TESTS
> -#include "mballoc-test.c"
> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
> +void mb_clear_bits_test(void *bm, int cur, int len)
> +{
> +	 mb_clear_bits(bm, cur, len);
> +}
> +EXPORT_SYMBOL_GPL(mb_clear_bits_test);

Please use EXPORT_SYMBOL_FOR_MODULES() for the exports to make them clearly
ext4 internal. Thanks!

								Honza

> +
> +ext4_fsblk_t
> +ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
> +			       int *errp)
> +{
> +	return ext4_mb_new_blocks_simple(ar, errp);
> +}
> +EXPORT_SYMBOL_GPL(ext4_mb_new_blocks_simple_test);
> +
> +int mb_find_next_zero_bit_test(void *addr, int max, int start)
> +{
> +	return mb_find_next_zero_bit(addr, max, start);
> +}
> +EXPORT_SYMBOL_GPL(mb_find_next_zero_bit_test);
> +
> +int mb_find_next_bit_test(void *addr, int max, int start)
> +{
> +	return mb_find_next_bit(addr, max, start);
> +}
> +EXPORT_SYMBOL_GPL(mb_find_next_bit_test);
> +
> +void mb_clear_bit_test(int bit, void *addr)
> +{
> +	mb_clear_bit(bit, addr);
> +}
> +EXPORT_SYMBOL_GPL(mb_clear_bit_test);
> +
> +int mb_test_bit_test(int bit, void *addr)
> +{
> +	return mb_test_bit(bit, addr);
> +}
> +EXPORT_SYMBOL_GPL(mb_test_bit_test);
> +
> +int ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
> +				     handle_t *handle)
> +{
> +	return ext4_mb_mark_diskspace_used(ac, handle);
> +}
> +EXPORT_SYMBOL_GPL(ext4_mb_mark_diskspace_used_test);
> +
> +int mb_mark_used_test(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
> +{
> +	return mb_mark_used(e4b, ex);
> +}
> +EXPORT_SYMBOL_GPL(mb_mark_used_test);
> +
> +void ext4_mb_generate_buddy_test(struct super_block *sb, void *buddy,
> +				 void *bitmap, ext4_group_t group,
> +				 struct ext4_group_info *grp)
> +{
> +	ext4_mb_generate_buddy(sb, buddy, bitmap, group, grp);
> +}
> +EXPORT_SYMBOL_GPL(ext4_mb_generate_buddy_test);
> +
> +int ext4_mb_load_buddy_test(struct super_block *sb, ext4_group_t group,
> +			    struct ext4_buddy *e4b)
> +{
> +	return ext4_mb_load_buddy(sb, group, e4b);
> +}
> +EXPORT_SYMBOL_GPL(ext4_mb_load_buddy_test);
> +
> +void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b)
> +{
> +	ext4_mb_unload_buddy(e4b);
> +}
> +EXPORT_SYMBOL_GPL(ext4_mb_unload_buddy_test);
> +
> +void mb_free_blocks_test(struct inode *inode, struct ext4_buddy *e4b,
> +			 int first, int count)
> +{
> +	mb_free_blocks(inode, e4b, first, count);
> +}
> +EXPORT_SYMBOL_GPL(mb_free_blocks_test);
> +
> +void ext4_free_blocks_simple_test(struct inode *inode, ext4_fsblk_t block,
> +				  unsigned long count)
> +{
> +	return ext4_free_blocks_simple(inode, block, count);
> +}
> +EXPORT_SYMBOL_GPL(ext4_free_blocks_simple_test);
> +
> +EXPORT_SYMBOL_GPL(ext4_wait_block_bitmap);
> +EXPORT_SYMBOL_GPL(ext4_mb_init);
> +EXPORT_SYMBOL_GPL(ext4_get_group_desc);
> +EXPORT_SYMBOL_GPL(ext4_count_free_clusters);
> +EXPORT_SYMBOL_GPL(ext4_get_group_info);
> +EXPORT_SYMBOL_GPL(ext4_free_group_clusters_set);
> +EXPORT_SYMBOL_GPL(ext4_mb_release);
> +EXPORT_SYMBOL_GPL(ext4_read_block_bitmap_nowait);
> +EXPORT_SYMBOL_GPL(mb_set_bits);
> +EXPORT_SYMBOL_GPL(ext4_fc_init_inode);
> +EXPORT_SYMBOL_GPL(ext4_mb_mark_context);
>  #endif
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 15a049f05d04..b32e03e7ae8d 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -270,4 +270,34 @@ ext4_mballoc_query_range(
>  	ext4_mballoc_query_range_fn	formatter,
>  	void				*priv);
>  
> +#if IS_ENABLED(CONFIG_EXT4_KUNIT_TESTS)
> +extern void mb_clear_bits_test(void *bm, int cur, int len);
> +extern int ext4_mb_mark_context(handle_t *handle,
> +		struct super_block *sb, bool state,
> +		ext4_group_t group, ext4_grpblk_t blkoff,
> +		ext4_grpblk_t len, int flags,
> +		ext4_grpblk_t *ret_changed);
> +extern ext4_fsblk_t
> +ext4_mb_new_blocks_simple_test(struct ext4_allocation_request *ar,
> +			       int *errp);
> +extern int mb_find_next_zero_bit_test(void *addr, int max, int start);
> +extern int mb_find_next_bit_test(void *addr, int max, int start);
> +extern void mb_clear_bit_test(int bit, void *addr);
> +extern int mb_test_bit_test(int bit, void *addr);
> +extern int
> +ext4_mb_mark_diskspace_used_test(struct ext4_allocation_context *ac,
> +				 handle_t *handle);
> +extern int mb_mark_used_test(struct ext4_buddy *e4b,
> +			     struct ext4_free_extent *ex);
> +extern void ext4_mb_generate_buddy_test(struct super_block *sb,
> +		void *buddy, void *bitmap, ext4_group_t group,
> +		struct ext4_group_info *grp);
> +extern int ext4_mb_load_buddy_test(struct super_block *sb,
> +		ext4_group_t group, struct ext4_buddy *e4b);
> +extern void ext4_mb_unload_buddy_test(struct ext4_buddy *e4b);
> +extern void mb_free_blocks_test(struct inode *inode,
> +		struct ext4_buddy *e4b, int first, int count);
> +extern void ext4_free_blocks_simple_test(struct inode *inode,
> +		ext4_fsblk_t block, unsigned long count);
> +#endif
>  #endif
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

