Return-Path: <linux-ext4+bounces-12855-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F3D23F6C
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7F6308E9A2
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 10:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB5836AB5F;
	Thu, 15 Jan 2026 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxRPuxv0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kB7o68Mn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VxRPuxv0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kB7o68Mn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C770736AB7E
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473330; cv=none; b=hPvuOmA3ex7LRxRIUYol4mkd14yEOBK1ns6u16W5uvgk8DNHrn0cTtQccZWv4LPdEYceb0qgwTxHWNk2i9Fm73lWV4hNCRcR1m43h2LkDPaSRIT+ypbwoYEqattEs64ZWdCkYYwwVqRIVmeFAI63mMsfCvOYRDfaOSEgCqFi7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473330; c=relaxed/simple;
	bh=wqNtSn4ayTMT7AKZ+5pUx6yqCv/DonOAkAydByjsgTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8fssBt6/74eOZZmISPGZh02rVUUdVbGwIhM13C9ERHYwsymJPnhB3qbmbLaXvW6yz1dNukBCq/bDNmp2smb74IglmS193Coxs0OuY+fZxkCM2rSauJ/t/eTxl26VZ8h0tQRuzuATPA1JSO/3/FJsReyNn6Yq6/20SqVg96qVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxRPuxv0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kB7o68Mn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VxRPuxv0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kB7o68Mn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 030345BCEB;
	Thu, 15 Jan 2026 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768473326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1+MS0t8JXqklAkRR3lwsfZ9aU6ChM+JVKmY4SQG/pc=;
	b=VxRPuxv0gFdtTOZXRxCTonQe2NHquFvxsC2Q3p605/GUTatQr9RDOOoCuZ1ZWtq3t+OOD6
	D2xqgVn0+lYhTED2gEMHql6TToFBd0V6HykyfAZhgs6XgLRhTnztQVlLRwX9A87RHOeB7g
	VYMdR5iGw+Mnab8BzQlLV7DJTtHnjKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768473326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1+MS0t8JXqklAkRR3lwsfZ9aU6ChM+JVKmY4SQG/pc=;
	b=kB7o68MnpU71Ke/PoK0VfaOdbDoT6g7ctLaUnKIYyUQ39VOJE7Dm/Mq2lOjRnWqvvJ6tRN
	qSUGOr/FT5+upzDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768473326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1+MS0t8JXqklAkRR3lwsfZ9aU6ChM+JVKmY4SQG/pc=;
	b=VxRPuxv0gFdtTOZXRxCTonQe2NHquFvxsC2Q3p605/GUTatQr9RDOOoCuZ1ZWtq3t+OOD6
	D2xqgVn0+lYhTED2gEMHql6TToFBd0V6HykyfAZhgs6XgLRhTnztQVlLRwX9A87RHOeB7g
	VYMdR5iGw+Mnab8BzQlLV7DJTtHnjKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768473326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I1+MS0t8JXqklAkRR3lwsfZ9aU6ChM+JVKmY4SQG/pc=;
	b=kB7o68MnpU71Ke/PoK0VfaOdbDoT6g7ctLaUnKIYyUQ39VOJE7Dm/Mq2lOjRnWqvvJ6tRN
	qSUGOr/FT5+upzDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB04D3EA63;
	Thu, 15 Jan 2026 10:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9QRbOe3CaGlBDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 Jan 2026 10:35:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFC7EA090F; Thu, 15 Jan 2026 11:35:25 +0100 (CET)
Date: Thu, 15 Jan 2026 11:35:25 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] ext4: kunit tests for higher level extent
 manipulation functions
Message-ID: <t4jmqx34obpnpkzvbfxhjhn7lmcxhxa46uewss7qvh7ag4spko@jpzdd4nk6hnv>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <9d586426ba81a0b9fcb359325a23a0b7ae1d7cbf.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d586426ba81a0b9fcb359325a23a0b7ae1d7cbf.1768402426.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.cz:email];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 14-01-26 20:27:46, Ojaswin Mujoo wrote:
> Add more kunit tests to cover the high level caller
> ext4_map_create_blocks(). We pass flags in a manner that covers
> the below function:
> 
> 1. ext4_ext_handle_unwritten_extents()
>   1.1 - Split/Convert unwritten extent to written in endio convtext.
>   1.2 - Split/Convert unwritten extent to written in non endio context.
>   1.3 - Zeroout tests for the above 2 cases
> 2. convert_initialized_extent() - Convert written extent to unwritten
>    during zero range
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Same comment regarding using symbols for block numbers / extent lenghts but
otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h           |   4 +
>  fs/ext4/extents-test.c   | 287 ++++++++++++++++++++++++++++++++++++++-
>  fs/ext4/extents_status.c |   3 +
>  fs/ext4/inode.c          |   8 +-
>  4 files changed, 295 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 174c51402864..5f744bd19dea 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3786,6 +3786,10 @@ extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
>  					     ext4_io_end_t *io_end);
>  extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  			   struct ext4_map_blocks *map, int flags);
> +extern int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +				  struct ext4_map_blocks *map, int flags);
> +extern int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> +				  struct ext4_map_blocks *map, int flags);
>  extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
>  						   int num,
>  						   struct ext4_ext_path *path);
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 02565ad19abe..ebd7af64315a 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -77,10 +77,18 @@ struct kunit_ext_data_state {
>  	ext4_lblk_t len_blk;
>  };
>  
> +enum kunit_test_types {
> +	TEST_SPLIT_CONVERT,
> +	TEST_CREATE_BLOCKS,
> +};
> +
>  struct kunit_ext_test_param {
>  	/* description of test */
>  	char *desc;
>  
> +	/* determines which function will be tested */
> +	int type;
> +
>  	/* is extent unwrit at beginning of test */
>  	bool is_unwrit_at_start;
>  
> @@ -90,6 +98,9 @@ struct kunit_ext_test_param {
>  	/* map describing range to split */
>  	struct ext4_map_blocks split_map;
>  
> +	/* disable zeroout */
> +	bool disable_zeroout;
> +
>  	/* no of extents expected after split */
>  	int nr_exp_ext;
>  
> @@ -131,6 +142,9 @@ static struct file_system_type ext_fs_type = {
>  
>  static void extents_kunit_exit(struct kunit *test)
>  {
> +	struct ext4_sb_info *sbi = k_ctx.k_ei->vfs_inode.i_sb->s_fs_info;
> +
> +	kfree(sbi);
>  	kfree(k_ctx.k_ei);
>  	kfree(k_ctx.k_data);
>  }
> @@ -162,6 +176,13 @@ static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
>  	return;
>  }
>  
> +void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> +				ext4_lblk_t len, ext4_fsblk_t pblk,
> +				unsigned int status, bool delalloc_reserve_used)
> +{
> +	return;
> +}
> +
>  static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
>  {
>  	return;
> @@ -220,6 +241,7 @@ static int extents_kunit_init(struct kunit *test)
>  	struct ext4_inode_info *ei;
>  	struct inode *inode;
>  	struct super_block *sb;
> +	struct ext4_sb_info *sbi = NULL;
>  	struct kunit_ext_test_param *param =
>  		(struct kunit_ext_test_param *)(test->param_value);
>  
> @@ -237,7 +259,20 @@ static int extents_kunit_init(struct kunit *test)
>  	sb->s_blocksize = 4096;
>  	sb->s_blocksize_bits = 12;
>  
> -	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10) << sb->s_blocksize_bits;
> +	sbi = kzalloc(sizeof(struct ext4_sb_info), GFP_KERNEL);
> +	if (sbi == NULL)
> +		return -ENOMEM;
> +
> +	sbi->s_sb = sb;
> +	sb->s_fs_info = sbi;
> +
> +	if (!param || !param->disable_zeroout)
> +		sbi->s_extent_max_zeroout_kb = 32;
> +
> +	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
> +			 << sb->s_blocksize_bits;
> +	ei->i_flags = 0;
> +	ext4_set_inode_flag(inode, EXT4_INODE_EXTENTS);
>  	inode->i_sb = sb;
>  
>  	k_ctx.k_data = kzalloc(EX_DATA_LEN * 4096, GFP_KERNEL);
> @@ -277,6 +312,8 @@ static int extents_kunit_init(struct kunit *test)
>  				   __ext4_ext_dirty_stub);
>  	kunit_activate_static_stub(test, ext4_es_remove_extent,
>  				   ext4_es_remove_extent_stub);
> +	kunit_activate_static_stub(test, ext4_es_insert_extent,
> +				   ext4_es_insert_extent_stub);
>  	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
>  	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
>  	kunit_activate_static_stub(test, ext4_issue_zeroout,
> @@ -301,6 +338,30 @@ static int check_buffer(char *buf, int c, int size)
>  	return 1;
>  }
>  
> +/*
> + * Simulate a map block call by first calling ext4_map_query_blocks() to
> + * correctly populate map flags and pblk and then call the
> + * ext4_map_create_blocks() to do actual split and conversion. This is easier
> + * than calling ext4_map_blocks() because that needs mocking a lot of unrelated
> + * functions.
> + */
> +static void ext4_map_create_blocks_helper(struct kunit *test,
> +					  struct inode *inode,
> +					  struct ext4_map_blocks *map,
> +					  int flags)
> +{
> +	int retval = 0;
> +
> +	retval = ext4_map_query_blocks(NULL, inode, map, flags);
> +	if (retval < 0) {
> +		KUNIT_FAIL(test,
> +			   "ext4_map_query_blocks() failed. Cannot proceed\n");
> +		return;
> +	}
> +
> +	ext4_map_create_blocks(NULL, inode, map, flags);
> +}
> +
>  static void test_split_convert(struct kunit *test)
>  {
>  	struct ext4_ext_path *path;
> @@ -330,8 +391,18 @@ static void test_split_convert(struct kunit *test)
>  
>  	map.m_lblk = param->split_map.m_lblk;
>  	map.m_len = param->split_map.m_len;
> -	ext4_split_convert_extents(NULL, inode, &map, path,
> -				   param->split_flags, NULL);
> +
> +	switch (param->type) {
> +	case TEST_SPLIT_CONVERT:
> +		path = ext4_split_convert_extents(NULL, inode, &map, path,
> +						  param->split_flags, NULL);
> +		break;
> +	case TEST_CREATE_BLOCKS:
> +		ext4_map_create_blocks_helper(test, inode, &map, param->split_flags);
> +		break;
> +	default:
> +		KUNIT_FAIL(test, "param->type %d not support.", param->type);
> +	}
>  
>  	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
>  	ex = path->p_ext;
> @@ -383,6 +454,7 @@ static void test_split_convert(struct kunit *test)
>  static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	/* unwrit to writ splits */
>  	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -391,6 +463,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -399,6 +472,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -410,6 +484,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  
>  	/* writ to unwrit splits */
>  	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 0,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>  	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -418,6 +493,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 0,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>  	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -426,6 +502,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 0,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
>  	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -440,6 +517,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	 */
>  	/* unwrit to writ splits */
>  	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 10, .m_len = 1 },
> @@ -451,6 +529,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
>  			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
>  	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 11, .m_len = 2 },
> @@ -462,6 +541,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
>  			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
>  	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (zeroout)",
> +	  .type = TEST_SPLIT_CONVERT,
>  	  .is_unwrit_at_start = 1,
>  	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
>  	  .split_map = { .m_lblk = 11, .m_len = 1 },
> @@ -476,6 +556,185 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  
>  };
>  
> +static const struct kunit_ext_test_param test_convert_initialized_params[] = {
> +	/* writ to unwrit splits */
> +	{ .desc = "split writ extent to 2 extents and convert 1st half unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 2 extents and convert 2nd half unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split writ extent to 3 extents and convert 2nd half to unwrit",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,
> +	  .is_unwrit_at_start = 0,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +};
> +
> +static const struct kunit_ext_test_param test_handle_unwritten_params[] = {
> +	/* unwrit to writ splits via endio path */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CONVERT,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/* unwrit to writ splits via non-endio path */
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 2,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 2,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 2, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 0 },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half to writ (non endio)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 1 },
> +	  .nr_exp_ext = 3,
> +	  .disable_zeroout = true,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> +			     { .ex_lblk = 11, .ex_len = 1, .is_unwrit = 0 },
> +			     { .ex_lblk = 12, .ex_len = 1, .is_unwrit = 1 } },
> +	  .is_zeroout_test = 0 },
> +
> +	/*
> +	 * ***** zeroout tests *****
> +	 */
> +	/* unwrit to writ splits (endio)*/
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
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
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
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
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
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
> +	/* unwrit to writ splits (non-endio)*/
> +	{ .desc = "split unwrit extent to 2 extents and convert 1st half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 10, .m_len = 1 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of data followed by 2 blocks of zeroes */
> +	  .exp_data_state = { { .exp_char = 'X', .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 0, .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 2 extents and convert 2nd half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
> +	  .split_map = { .m_lblk = 11, .m_len = 2 },
> +	  .nr_exp_ext = 1,
> +	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> +	  .is_zeroout_test = 1,
> +	  .nr_exp_data_segs = 2,
> +	  /* 1 block of zeroes followed by 2 blocks of data */
> +	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 1 },
> +			      { .exp_char = 'X', .off_blk = 1, .len_blk = 2 } } },
> +	{ .desc = "split unwrit extent to 3 extents and convert 2nd half writ (non-endio, zeroout)",
> +	  .type = TEST_CREATE_BLOCKS,
> +	  .is_unwrit_at_start = 1,
> +	  .split_flags = EXT4_GET_BLOCKS_CREATE,
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
> +
>  static void ext_get_desc(struct kunit *test, const void *p, char *desc)
>  
>  {
> @@ -493,6 +752,24 @@ static int test_split_convert_param_init(struct kunit *test)
>  	return 0;
>  }
>  
> +static int test_convert_initialized_param_init(struct kunit *test)
> +{
> +	size_t arr_size = ARRAY_SIZE(test_convert_initialized_params);
> +
> +	kunit_register_params_array(test, test_convert_initialized_params,
> +				    arr_size, ext_get_desc);
> +	return 0;
> +}
> +
> +static int test_handle_unwritten_init(struct kunit *test)
> +{
> +	size_t arr_size = ARRAY_SIZE(test_handle_unwritten_params);
> +
> +	kunit_register_params_array(test, test_handle_unwritten_params,
> +				    arr_size, ext_get_desc);
> +	return 0;
> +}
> +
>  /*
>   * Note that we use KUNIT_CASE_PARAM_WITH_INIT() instead of the more compact
>   * KUNIT_ARRAY_PARAM() because the later currently has a limitation causing the
> @@ -503,6 +780,10 @@ static int test_split_convert_param_init(struct kunit *test)
>  static struct kunit_case extents_test_cases[] = {
>  	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
>  				   test_split_convert_param_init, NULL),
> +	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
> +				   test_convert_initialized_param_init, NULL),
> +	KUNIT_CASE_PARAM_WITH_INIT(test_split_convert, kunit_array_gen_params,
> +				   test_handle_unwritten_init, NULL),
>  	{}
>  };
>  
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 6c1faf7c9f2a..095ccb7ba4ba 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -916,6 +916,9 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct pending_reservation *pr = NULL;
>  	bool revise_pending = false;
>  
> +	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
> +				   pblk, status, delalloc_reserve_used);
> +
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c60813260f9a..8a6ad16e7417 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -542,8 +542,8 @@ static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
>  	return map->m_len;
>  }
>  
> -static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> -				 struct ext4_map_blocks *map, int flags)
> +int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> +			  struct ext4_map_blocks *map, int flags)
>  {
>  	unsigned int status;
>  	int retval;
> @@ -589,8 +589,8 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  	return retval;
>  }
>  
> -static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> -				  struct ext4_map_blocks *map, int flags)
> +int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> +			   struct ext4_map_blocks *map, int flags)
>  {
>  	unsigned int status;
>  	int err, retval = 0;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

