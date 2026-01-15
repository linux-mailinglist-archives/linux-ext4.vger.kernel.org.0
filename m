Return-Path: <linux-ext4+bounces-12854-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C41D23E94
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 11:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0A23043102
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E523A35502E;
	Thu, 15 Jan 2026 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n6e8kpvj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cygpGJE6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="prYNBnTo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Okir0O1h"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67332ABC1
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472429; cv=none; b=akEdpeGqyAOOw4ez5pF6zoSwqvzHHa+yP5U1WWzmPUOzs2207UAt2l/22VjRgn84mwmQJ2RPcgdu5Id7ZGAqp/qpqCB2VemRjTSiJ8uMV1i1aSV4A4S8zsyJb89Ev6RyhAP0k+WH31N997XCJdQuqiyYthGxXPZwrBHJSX3vGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472429; c=relaxed/simple;
	bh=xzjwX5arLUS3DAsvFrxgHF+SmLdTjO2r2Mo0emt1mlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX8zNvv20yeQebqiaXlat+JwgOW4mf7L/TEt3mJ9CVvuApY/YhivkQYFpYPQ/FJdKHsCU/2bxNl3OD//rVOTtAx8/B0tU7k2Knlb0G4Esw3eTn2L4T/6mvTKutVWx4wDnWF8NeRXwv9/cp7JlTnLGkyNK7mIiRMnwu3LXR3j8hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n6e8kpvj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cygpGJE6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=prYNBnTo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Okir0O1h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE71E3368D;
	Thu, 15 Jan 2026 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768472426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTS7uvtCzUqL7/yFfi/Va7omjtgkwbgzykqHiXkFFO4=;
	b=n6e8kpvjDoHInB8aAa6CYeXtMZElxJUwhRkMWQgmxSHhT2SDHqvfE5vbrI08/fB2XiqJ88
	FAPd80XztiSxN2cdDsxWYHEuMWV2Dupn2dWU7sozbbPvYi2t31DQg0LConSVJv6yzWByDB
	79D03Fvp5fpKG2wlMtEFU+zaEtMhqs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768472426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTS7uvtCzUqL7/yFfi/Va7omjtgkwbgzykqHiXkFFO4=;
	b=cygpGJE6/tqmQuEAhlLEbUjThOEIvwqin3VZXBmCOq+ojM3kuUTGoRNj76Bp1A7SSX+lbq
	v1lnyk/y2Q9oJ6Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=prYNBnTo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Okir0O1h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768472425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTS7uvtCzUqL7/yFfi/Va7omjtgkwbgzykqHiXkFFO4=;
	b=prYNBnToJ1E3G81H8l2/KvRtRr12It0lQDSRiC3T/DRjCZUqcoT8pLHdrA3cNav6TaDO9X
	r9mZxrPMOM90Q+G6WrX7FJ4aTFUSow/3kEwpM5kOpz5E5lQVfOACSayquDUo3Qq1hTXUhB
	lFMj11akVr+f2ouWpv/E+haSR8uYeuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768472425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTS7uvtCzUqL7/yFfi/Va7omjtgkwbgzykqHiXkFFO4=;
	b=Okir0O1hmNONrZ2OM++cg9cDyZvrasRW98H7SRJDt7HW7c7sxQs4O82d3yjXM7wWlze4VS
	aIrBjBCC8fMfStAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C16F43EA63;
	Thu, 15 Jan 2026 10:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T7czL2m/aGnKfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 Jan 2026 10:20:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79367A090F; Thu, 15 Jan 2026 11:20:25 +0100 (CET)
Date: Thu, 15 Jan 2026 11:20:25 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] ext4: kunit tests for extent splitting and
 conversion
Message-ID: <735xahhes7x62f2yuhpfgoojerfclo2kdwf5d7h2lgxtuq57ew@jt4ijbxfpocq>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <da910e221a92a16601654ced8df50348bdff6f31.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da910e221a92a16601654ced8df50348bdff6f31.1768402426.git.ojaswin@linux.ibm.com>
X-Spam-Score: -2.51
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CE71E3368D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed 14-01-26 20:27:45, Ojaswin Mujoo wrote:
> Add multiple KUnit tests to test various permutations of extent
> splitting and conversion.
> 
> We test the following cases:
> 
> 1. Split of unwritten extent into 2 parts and convert 1 part to written
> 2. Split of unwritten extent into 3 parts and convert 1 part to written
> 3. Split of written extent into 2 parts and convert 1 part to unwritten
> 4. Split of written extent into 3 parts and convert 1 part to unwritten
> 5. Zeroout fallback for all the above cases except 3-4 because zeroout
>    is not supported for written to unwritten splits
> 
> The main function we test here is ext4_split_convert_extents().
> Currently some of the tests are failing due to issues in implementation.
> All failures are mitigated at other layers in ext4 [1] but still point
> out the mismatch in expectation of what the caller wants vs what the
> function does.
> 
> The aim is to eventually fix all the failures we see here. More detailed
> implementation notes can be found in the topmost commit in the test file.
> 
> [1] for example, EXT4_GET_BLOCKS_CONVERT doesn't
> really convert the split extent to written, but rather the callers end up
> doing the conversion.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Overall this looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Couple nits below:

> +static void test_split_convert(struct kunit *test)
> +{
> +	struct ext4_ext_path *path;
> +	struct inode *inode = &k_ctx.k_ei->vfs_inode;
> +	struct ext4_extent *ex;
> +	struct ext4_map_blocks map;
> +	const struct kunit_ext_test_param *param =
> +		(const struct kunit_ext_test_param *)(test->param_value);
> +	int blkbits = inode->i_sb->s_blocksize_bits;
> +
> +	if (param->is_zeroout_test)
> +		/*
> +		 * Force zeroout by making ext4_ext_insert_extent return ENOSPC
> +		 */
> +		kunit_activate_static_stub(test, ext4_ext_insert_extent,
> +					   ext4_ext_insert_extent_stub);
> +
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	ex = path->p_ext;
> +	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
> +	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));

Shouldn't we use EX_DATA_LBLK and other constants instead for numbers?

...

> +static const struct kunit_ext_test_param test_split_convert_params[] = {
> +	/* unwrit to writ splits */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .is_unwrit_at_start = 0,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/*
> +	 * ***** zeroout tests *****
> +	 */
> +	/* unwrit to writ splits */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of data followed by 2 blocks of zeroes */
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of zeroes followed by 2 blocks of data */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 3,
> +	  /* [zeroes] [data] [zeroes] */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 2, .len_blk = 1 } } },
> +
> +};

Also in these definitions of split_map and exp_ext_state I think it would be
cleaner to use EX_DATA_LBLK and EX_DATA_LEN...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

