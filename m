Return-Path: <linux-ext4+bounces-12856-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91545D23F9F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 11:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9999D3016716
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 10:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CF36BCD4;
	Thu, 15 Jan 2026 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dCxq8FKg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iT4yPHvD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dCxq8FKg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iT4yPHvD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666336AB6D
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473536; cv=none; b=JiMMfaAC1grsq5IdHJlO4tVQim4I38GaCaGHbCnRFqrNwJNmWiYPKxnI47rReps4LsM891LPmX/ZZRweXKovPLKxpqDpmr+eA4lLuAe2WkjXj99Du3jw2MGUGYKzGecxoJzjLv3kiTOrSQDzullU3MBNEynVGmRKWl9WLJ0n4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473536; c=relaxed/simple;
	bh=2bMW5jgkTh3DamfJOG/kncQVyG+ViWUaqd2Lnty405A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvu7np7PATdiPWaVkGtF5btM2DqfjJ3fN6YyEbWnIkvNRfCn8KgwwlAR4oQZKoI4F3biNnydm8RdS3uKZaQ6hcjLRcKox9kiLmhluRdytVTgH04rlnRST0RJk+mNH5Ez0pJ+Cva8YZ1i+urKvYK3n44K94RDDhMGDAvi7eDbI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dCxq8FKg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iT4yPHvD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dCxq8FKg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iT4yPHvD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 586FA33710;
	Thu, 15 Jan 2026 10:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768473533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCEkzq6lLRI8zWZvD8rBR7WNruhxIoVulCwOZvQ4XFg=;
	b=dCxq8FKgTLxMcCaCQEz14Sf7LdfAwlWfncUl2Tw68+N4tM/cuS1bhEqWNID2i5GGtAJ741
	j3iKaTeiO8q6wjenKZEv4ef3PefwoFSEqwFS22C2/Ee7ouxKqDnVDDb7kXdSRzuYxG6i6m
	ujMVZ1WTwgozPsQ9+WeLjnhNdaCbVHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768473533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCEkzq6lLRI8zWZvD8rBR7WNruhxIoVulCwOZvQ4XFg=;
	b=iT4yPHvDsDJq+tHmI874pDTcOFX1Pa/wYwvotMiM7EmEeetQW6exvFuejTZ4Ah4JsYoR7X
	jfEmcSoPevwZbABQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dCxq8FKg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iT4yPHvD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768473533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCEkzq6lLRI8zWZvD8rBR7WNruhxIoVulCwOZvQ4XFg=;
	b=dCxq8FKgTLxMcCaCQEz14Sf7LdfAwlWfncUl2Tw68+N4tM/cuS1bhEqWNID2i5GGtAJ741
	j3iKaTeiO8q6wjenKZEv4ef3PefwoFSEqwFS22C2/Ee7ouxKqDnVDDb7kXdSRzuYxG6i6m
	ujMVZ1WTwgozPsQ9+WeLjnhNdaCbVHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768473533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GCEkzq6lLRI8zWZvD8rBR7WNruhxIoVulCwOZvQ4XFg=;
	b=iT4yPHvDsDJq+tHmI874pDTcOFX1Pa/wYwvotMiM7EmEeetQW6exvFuejTZ4Ah4JsYoR7X
	jfEmcSoPevwZbABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47E463EA63;
	Thu, 15 Jan 2026 10:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zpyKEb3DaGloDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 Jan 2026 10:38:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0908CA090F; Thu, 15 Jan 2026 11:38:49 +0100 (CET)
Date: Thu, 15 Jan 2026 11:38:48 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] ext4: Add extent status cache support to kunit
 tests
Message-ID: <i6ymajhzfwy7wh2fe4imbgnnljmdt4mjriv4oi7gtp2kz2p6bd@d6xjxxroty6k>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <4ff7e1f19b9663f20735d321af3a8133567400f8.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff7e1f19b9663f20735d321af3a8133567400f8.1768402426.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 586FA33710
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 14-01-26 20:27:47, Ojaswin Mujoo wrote:
> Add support in Kunit tests to ensure that the extent status cache is
> also in sync after the extent split and conversion operations.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents-test.c   | 106 ++++++++++++++++++++++++---------------
>  fs/ext4/extents.c        |   2 -
>  fs/ext4/extents_status.c |   5 --
>  3 files changed, 65 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index ebd7af64315a..86fcac66be6f 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -149,12 +149,6 @@ static void extents_kunit_exit(struct kunit *test)
>  	kfree(k_ctx.k_data);
>  }
>  
> -static void ext4_cache_extents_stub(struct inode *inode,
> -				    struct ext4_extent_header *eh)
> -{
> -	return;
> -}
> -
>  static int __ext4_ext_dirty_stub(const char *where, unsigned int line,
>  				 handle_t *handle, struct inode *inode,
>  				 struct ext4_ext_path *path)
> @@ -170,24 +164,6 @@ ext4_ext_insert_extent_stub(handle_t *handle, struct inode *inode,
>  	return ERR_PTR(-ENOSPC);
>  }
>  
> -static void ext4_es_remove_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> -				       ext4_lblk_t len)
> -{
> -	return;
> -}
> -
> -void ext4_es_insert_extent_stub(struct inode *inode, ext4_lblk_t lblk,
> -				ext4_lblk_t len, ext4_fsblk_t pblk,
> -				unsigned int status, bool delalloc_reserve_used)
> -{
> -	return;
> -}
> -
> -static void ext4_zeroout_es_stub(struct inode *inode, struct ext4_extent *ex)
> -{
> -	return;
> -}
> -
>  /*
>   * We will zeroout the equivalent range in the data area
>   */
> @@ -244,13 +220,7 @@ static int extents_kunit_init(struct kunit *test)
>  	struct ext4_sb_info *sbi = NULL;
>  	struct kunit_ext_test_param *param =
>  		(struct kunit_ext_test_param *)(test->param_value);
> -
> -	/* setup the mock inode */
> -	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
> -	if (k_ctx.k_ei == NULL)
> -		return -ENOMEM;
> -	ei = k_ctx.k_ei;
> -	inode = &ei->vfs_inode;
> +	int err;
>  
>  	sb = sget(&ext_fs_type, NULL, ext_set, 0, NULL);
>  	if (IS_ERR(sb))
> @@ -269,6 +239,24 @@ static int extents_kunit_init(struct kunit *test)
>  	if (!param || !param->disable_zeroout)
>  		sbi->s_extent_max_zeroout_kb = 32;
>  
> +	/* setup the mock inode */
> +	k_ctx.k_ei = kzalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
> +	if (k_ctx.k_ei == NULL)
> +		return -ENOMEM;
> +	ei = k_ctx.k_ei;
> +	inode = &ei->vfs_inode;
> +
> +	err = ext4_es_register_shrinker(sbi);
> +	if (err)
> +		return err;
> +
> +	ext4_es_init_tree(&ei->i_es_tree);
> +	rwlock_init(&ei->i_es_lock);
> +	INIT_LIST_HEAD(&ei->i_es_list);
> +	ei->i_es_all_nr = 0;
> +	ei->i_es_shk_nr = 0;
> +	ei->i_es_shrink_lblk = 0;
> +
>  	ei->i_disksize = (EX_DATA_LBLK + EX_DATA_LEN + 10)
>  			 << sb->s_blocksize_bits;
>  	ei->i_flags = 0;
> @@ -305,16 +293,15 @@ static int extents_kunit_init(struct kunit *test)
>  	if (!param || param->is_unwrit_at_start)
>  		ext4_ext_mark_unwritten(EXT_FIRST_EXTENT(eh));
>  
> +	ext4_es_insert_extent(inode, EX_DATA_LBLK, EX_DATA_LEN, EX_DATA_PBLK,
> +			      ext4_ext_is_unwritten(EXT_FIRST_EXTENT(eh)) ?
> +				      EXTENT_STATUS_UNWRITTEN :
> +				      EXTENT_STATUS_WRITTEN,
> +			      0);
> +
>  	/* Add stubs */
> -	kunit_activate_static_stub(test, ext4_cache_extents,
> -				   ext4_cache_extents_stub);
>  	kunit_activate_static_stub(test, __ext4_ext_dirty,
>  				   __ext4_ext_dirty_stub);
> -	kunit_activate_static_stub(test, ext4_es_remove_extent,
> -				   ext4_es_remove_extent_stub);
> -	kunit_activate_static_stub(test, ext4_es_insert_extent,
> -				   ext4_es_insert_extent_stub);
> -	kunit_activate_static_stub(test, ext4_zeroout_es, ext4_zeroout_es_stub);
>  	kunit_activate_static_stub(test, ext4_ext_zeroout, ext4_ext_zeroout_stub);
>  	kunit_activate_static_stub(test, ext4_issue_zeroout,
>  				   ext4_issue_zeroout_stub);
> @@ -379,11 +366,12 @@ static void test_split_convert(struct kunit *test)
>  		kunit_activate_static_stub(test, ext4_ext_insert_extent,
>  					   ext4_ext_insert_extent_stub);
>  
> -	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
>  	ex = path->p_ext;
>  	KUNIT_EXPECT_EQ(test, 10, ex->ee_block);
>  	KUNIT_EXPECT_EQ(test, 3, ext4_ext_get_actual_len(ex));
> -	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start, ext4_ext_is_unwritten(ex));
> +	KUNIT_EXPECT_EQ(test, param->is_unwrit_at_start,
> +			ext4_ext_is_unwritten(ex));
>  	if (param->is_zeroout_test)
>  		KUNIT_EXPECT_EQ(test, 0,
>  				check_buffer(k_ctx.k_data, 'X',
> @@ -404,17 +392,47 @@ static void test_split_convert(struct kunit *test)
>  		KUNIT_FAIL(test, "param->type %d not support.", param->type);
>  	}
>  
> -	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
> +	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, EXT4_EX_NOCACHE);
>  	ex = path->p_ext;
>  
>  	for (int i = 0; i < param->nr_exp_ext; i++) {
>  		struct kunit_ext_state exp_ext = param->exp_ext_state[i];
> +		bool es_check_needed = param->type != TEST_SPLIT_CONVERT;
> +		struct extent_status es;
> +		int contains_ex, ex_end, es_end, es_pblk;
>  
>  		KUNIT_EXPECT_EQ(test, exp_ext.ex_lblk, ex->ee_block);
>  		KUNIT_EXPECT_EQ(test, exp_ext.ex_len,
>  				ext4_ext_get_actual_len(ex));
>  		KUNIT_EXPECT_EQ(test, exp_ext.is_unwrit,
>  				ext4_ext_is_unwritten(ex));
> +		/*
> +		 * Confirm extent cache is in sync. Note that es cache can be
> +		 * merged even when on-disk extents are not so take that into
> +		 * account.
> +		 *
> +		 * Also, ext4_split_convert_extents() forces EXT4_EX_NOCACHE hence
> +		 * es status are ignored for that case.
> +		 */
> +		if (es_check_needed) {
> +			ext4_es_lookup_extent(inode, ex->ee_block, NULL, &es,
> +					      NULL);
> +
> +			ex_end = exp_ext.ex_lblk + exp_ext.ex_len;
> +			es_end = es.es_lblk + es.es_len;
> +			contains_ex = es.es_lblk <= exp_ext.ex_lblk &&
> +				      es_end >= ex_end;
> +			es_pblk = ext4_es_pblock(&es) +
> +				  (exp_ext.ex_lblk - es.es_lblk);
> +
> +			KUNIT_EXPECT_EQ(test, contains_ex, 1);
> +			KUNIT_EXPECT_EQ(test, ext4_ext_pblock(ex), es_pblk);
> +			KUNIT_EXPECT_EQ(test, 1,
> +					(exp_ext.is_unwrit &&
> +					 ext4_es_is_unwritten(&es)) ||
> +						(!exp_ext.is_unwrit &&
> +						 ext4_es_is_written(&es)));
> +		}
>  
>  		/* Only printed on failure */
>  		kunit_log(KERN_INFO, test,
> @@ -424,6 +442,12 @@ static void test_split_convert(struct kunit *test)
>  			  "# [extent %d] got: lblk:%d len:%d unwrit:%d\n", i,
>  			  ex->ee_block, ext4_ext_get_actual_len(ex),
>  			  ext4_ext_is_unwritten(ex));
> +		if (es_check_needed)
> +			kunit_log(
> +				KERN_INFO, test,
> +				"# [extent %d] es: lblk:%d len:%d pblk:%lld type:0x%x\n",
> +				i, es.es_lblk, es.es_len, ext4_es_pblock(&es),
> +				ext4_es_type(&es));
>  		kunit_log(KERN_INFO, test, "------------------\n");
>  
>  		ex = ex + 1;
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 4cebd82ef3e4..a581e9278d48 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3149,8 +3149,6 @@ static void ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
>  	ext4_fsblk_t ee_pblock;
>  	unsigned int ee_len;
>  
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_zeroout_es, inode, ex);
> -
>  	ee_block = le32_to_cpu(ex->ee_block);
>  	ee_len = ext4_ext_get_actual_len(ex);
>  	ee_pblock = ext4_ext_pblock(ex);
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 095ccb7ba4ba..a1538bac51c6 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -916,9 +916,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>  	struct pending_reservation *pr = NULL;
>  	bool revise_pending = false;
>  
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_es_insert_extent, inode, lblk, len,
> -				   pblk, status, delalloc_reserve_used);
> -
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> @@ -1631,8 +1628,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  	int reserved = 0;
>  	struct extent_status *es = NULL;
>  
> -	KUNIT_STATIC_STUB_REDIRECT(ext4_es_remove_extent, inode, lblk, len);
> -
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

