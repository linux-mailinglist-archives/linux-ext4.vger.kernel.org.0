Return-Path: <linux-ext4+bounces-12595-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A11CF9301
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 16:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FF1D303FCE6
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECB0239086;
	Tue,  6 Jan 2026 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLwjGSh1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="heNLf2Ur";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RLwjGSh1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="heNLf2Ur"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D36814F9D6
	for <linux-ext4@vger.kernel.org>; Tue,  6 Jan 2026 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714966; cv=none; b=CfS/IBEms6C+7reDHEJZ/aod3vqejCSu7PLzeXoIDiVkcwNRZFJ8YpYfJ9H4SDBL0QosrSZo+ttYlqH1ynOMp7DtJruLIfe9bs4DKxBST42vm9y/BnhjUD2uPMM1VYQTHQPajcAhtWMqlOrbkrNzBdl6PgSyue9xXpYyTVPNPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714966; c=relaxed/simple;
	bh=Iaa4SkSRHIZ8EkaIuujEnqq6FphVFOJwwOnJ8Fq8Vf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpfIhHUkVMd61ARVdLBXCG1uoVFZd3ngzpKyIOVMjAF4/Epc5Nv1nISo74H3yUV0L2CaqLM1cqGa6XxCVML46Pev82JPModd6gdGHo96Vw9CPsICz15oVGSwa9RZSrmRfi7gzOvpzKwh0Eh8zN845zO6lCT1QO4Mipib0UlqpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RLwjGSh1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=heNLf2Ur; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RLwjGSh1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=heNLf2Ur; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7BD6C33682;
	Tue,  6 Jan 2026 15:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767714961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57TJjeBZZdz1Fun6tBXRKC6WQOROhxIoMLFl5fjOjJk=;
	b=RLwjGSh14903N2GYyK+00WBCr5e4H4pqId466Vvwuk2doSNxwuNnQ4RcZtxWp8DdWGNAUs
	fuN8mZKW2MF9a1AiUQWf7cvjMpoWw+oiNpvGQiYRbmMrR5+jtdFPf7+7yNroTk3sp3rCqk
	rW5IW0R8yVXGi3cVnNvMRUj9bG3M98k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767714961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57TJjeBZZdz1Fun6tBXRKC6WQOROhxIoMLFl5fjOjJk=;
	b=heNLf2UruY5/MVDg2W3kAUk45Bu/gS1R1G85PLWdZjtbM1+/UZGTS+StT/c963i4i3efs4
	ppEKTvE/8gUlZXCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RLwjGSh1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=heNLf2Ur
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767714961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57TJjeBZZdz1Fun6tBXRKC6WQOROhxIoMLFl5fjOjJk=;
	b=RLwjGSh14903N2GYyK+00WBCr5e4H4pqId466Vvwuk2doSNxwuNnQ4RcZtxWp8DdWGNAUs
	fuN8mZKW2MF9a1AiUQWf7cvjMpoWw+oiNpvGQiYRbmMrR5+jtdFPf7+7yNroTk3sp3rCqk
	rW5IW0R8yVXGi3cVnNvMRUj9bG3M98k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767714961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=57TJjeBZZdz1Fun6tBXRKC6WQOROhxIoMLFl5fjOjJk=;
	b=heNLf2UruY5/MVDg2W3kAUk45Bu/gS1R1G85PLWdZjtbM1+/UZGTS+StT/c963i4i3efs4
	ppEKTvE/8gUlZXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D16C3EA63;
	Tue,  6 Jan 2026 15:56:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RuOZGpEwXWkLQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 15:56:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23A9AA0A4A; Tue,  6 Jan 2026 16:55:53 +0100 (CET)
Date: Tue, 6 Jan 2026 16:55:53 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ext4: Refactor split and convert extents
Message-ID: <dc3wbvaswrznr33ouhccidxtymn5uklocwhjpsyld3ribt5vvz@xmtlawj2mcaq>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c318aa0eeb0c5c4ad0b5f620de3a7f4df596b82.1767528171.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 7BD6C33682
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sun 04-01-26 17:49:19, Ojaswin Mujoo wrote:
> ext4_split_convert_extents() has been historically prone to subtle
> bugs and inconsistent behavior due to the way all the various flags
> interact with the extent split and conversion process. For example,
> callers like ext4_convert_unwritten_extents_endio() and
> convert_initialized_extents() needed to open code extent conversion
> despite passing CONVERT or CONVERT_UNWRITTEN flags because
> ext4_split_convert_extents() wasn't performing the conversion.
> 
> Hence, refactor ext4_split_convert_extents() to clearly enforce the
> semantics of each flag. The major changes here are:
> 
>  * Clearly separate the split and convert process:
>    * ext4_split_extent() and ext4_split_extent_at() are now only
>      responsible to perform the split.
>    * ext4_split_convert_extents() is now responsible to perform extent
>      conversion after calling ext4_split_extent() for splitting.
>    * This helps get rid of all the MARK_UNWRIT* flags.
> 
>  * Clearly enforce the semantics of flags passed to
>    ext4_split_convert_extents():
> 
>    * EXT4_GET_BLOCKS_CONVERT: Will convert the split extent to written
>    * EXT4_GET_BLOCKS_CONVERT_UNWRITTEN: Will convert the split extent to
>      unwritten
>    * Passing neither of the above means we only want a split.
>    * Modify all callers to enforce the above semantics.
> 
>  * Use ext4_split_convert_extents() instead of ext4_split_extents()
>  * in ext4_ext_convert_to_initialized() for uniformity.
> 
>  * Cleanup all callers open coding the conversion logic.
>  * Further, modify kuniy tests to pass flags based on the new semantics.
> 
> From an end user point of view, we should not see any changes in
> behavior of ext4.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents-test.c |  12 +-
>  fs/ext4/extents.c      | 299 +++++++++++++++++++----------------------
>  2 files changed, 145 insertions(+), 166 deletions(-)
> 
> diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
> index 54aed3eabfe2..725d5e79be96 100644
> --- a/fs/ext4/extents-test.c
> +++ b/fs/ext4/extents-test.c
> @@ -567,7 +567,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	/* unwrit to unwrit splits */
>  	{ .desc = "split unwrit extent to 2 unwrit extents",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 10, .m_len = 1 },
>  	  .nr_exp_ext = 2,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> @@ -575,7 +575,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split unwrit extent to 2 extents (2)",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 11, .m_len = 2 },
>  	  .nr_exp_ext = 2,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> @@ -583,7 +583,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .is_zeroout_test = 0 },
>  	{ .desc = "split unwrit extent to 3 unwrit extents",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 11, .m_len = 1 },
>  	  .nr_exp_ext = 3,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 1, .is_unwrit = 1 },
> @@ -660,7 +660,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	/* unwrit to unwrit splits */
>  	{ .desc = "split unwrit extent to 2 unwrit extents (zeroout)",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 10, .m_len = 1 },
>  	  .nr_exp_ext = 1,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> @@ -669,7 +669,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
>  	{ .desc = "split unwrit extent to 2 unwrit extents (2) (zeroout)",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 11, .m_len = 2 },
>  	  .nr_exp_ext = 1,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> @@ -678,7 +678,7 @@ static const struct kunit_ext_test_param test_split_convert_params[] = {
>  	  .exp_data_state = { { .exp_char = 0, .off_blk = 0, .len_blk = 3 } } },
>  	{ .desc = "split unwrit extent to 3 unwrit extents (zeroout)",
>  	  .is_unwrit_at_start = 1,
> -	  .split_flags = EXT4_GET_BLOCKS_UNWRIT_EXT,
> +	  .split_flags = 0,
>  	  .split_map = { .m_lblk = 11, .m_len = 1 },
>  	  .nr_exp_ext = 1,
>  	  .exp_ext_state = { { .ex_lblk = 10, .ex_len = 3, .is_unwrit = 0 } },
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8082e1d93bbf..9fb8a3220ae2 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -41,8 +41,9 @@
>   */
>  #define EXT4_EXT_MAY_ZEROOUT	0x1  /* safe to zeroout if split fails \
>  					due to ENOSPC */
> -#define EXT4_EXT_MARK_UNWRIT1	0x2  /* mark first half unwritten */
> -#define EXT4_EXT_MARK_UNWRIT2	0x4  /* mark second half unwritten */
> +static struct ext4_ext_path *ext4_split_convert_extents(
> +	handle_t *handle, struct inode *inode, struct ext4_map_blocks *map,
> +	struct ext4_ext_path *path, int flags, unsigned int *allocated);
>  
>  static __le32 ext4_extent_block_csum(struct inode *inode,
>  				     struct ext4_extent_header *eh)
> @@ -84,8 +85,7 @@ static void ext4_extent_block_csum_set(struct inode *inode,
>  static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  						  struct inode *inode,
>  						  struct ext4_ext_path *path,
> -						  ext4_lblk_t split,
> -						  int split_flag, int flags);
> +						  ext4_lblk_t split, int flags);
>  
>  static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  {
> @@ -333,15 +333,12 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
>  			   struct ext4_ext_path *path, ext4_lblk_t lblk,
>  			   int nofail)
>  {
> -	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
>  	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
>  
>  	if (nofail)
>  		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
>  
> -	return ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
> -			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
> -			flags);
> +	return ext4_split_extent_at(handle, inode, path, lblk, flags);
>  }
>  
>  static int
> @@ -3174,17 +3171,11 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>   * @inode: the file inode
>   * @path: the path to the extent
>   * @split: the logical block where the extent is splitted.
> - * @split_flags: indicates if the extent could be zeroout if split fails, and
> - *		 the states(init or unwritten) of new extents.
>   * @flags: flags used to insert new extent to extent tree.
>   *
>   *
>   * Splits extent [a, b] into two extents [a, @split) and [@split, b], states
> - * of which are determined by split_flag.
> - *
> - * There are two cases:
> - *  a> the extent are splitted into two extent.
> - *  b> split is not needed, and just mark the extent.
> + * of which are same as the original extent. No conversion is performed.
>   *
>   * Return an extent path pointer on success, or an error pointer on failure. On
>   * failure, the extent is restored to original state.
> @@ -3193,14 +3184,14 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  						  struct inode *inode,
>  						  struct ext4_ext_path *path,
>  						  ext4_lblk_t split,
> -						  int split_flag, int flags)
> +						  int flags)
>  {
>  	ext4_fsblk_t newblock;
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex, newex, orig_ex;
>  	struct ext4_extent *ex2 = NULL;
>  	unsigned int ee_len, depth;
> -	int err = 0, insert_err = 0;
> +	int err = 0, insert_err = 0, is_unwrit = 0;
>  
>  	/* Do not cache extents that are in the process of being modified. */
>  	flags |= EXT4_EX_NOCACHE;
> @@ -3214,39 +3205,24 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	ee_block = le32_to_cpu(ex->ee_block);
>  	ee_len = ext4_ext_get_actual_len(ex);
>  	newblock = split - ee_block + ext4_ext_pblock(ex);
> +	is_unwrit = ext4_ext_is_unwritten(ex);
>  
>  	BUG_ON(split < ee_block || split >= (ee_block + ee_len));
> -	BUG_ON(!ext4_ext_is_unwritten(ex) &&
> -	       split_flag & (EXT4_EXT_MAY_ZEROOUT |
> -			     EXT4_EXT_MARK_UNWRIT1 |
> -			     EXT4_EXT_MARK_UNWRIT2));
>  
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> +	/*
> +	 * No split needed
> +	 */
> +	if (split == ee_block)
>  		goto out;
>  
> -	if (split == ee_block) {
> -		/*
> -		 * case b: block @split is the block that the extent begins with
> -		 * then we just change the state of the extent, and splitting
> -		 * is not needed.
> -		 */
> -		if (split_flag & EXT4_EXT_MARK_UNWRIT2)
> -			ext4_ext_mark_unwritten(ex);
> -		else
> -			ext4_ext_mark_initialized(ex);
> -
> -		if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
> -			ext4_ext_try_to_merge(handle, inode, path, ex);
> -
> -		err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
>  		goto out;
> -	}
>  
>  	/* case a */
>  	memcpy(&orig_ex, ex, sizeof(orig_ex));
>  	ex->ee_len = cpu_to_le16(split - ee_block);
> -	if (split_flag & EXT4_EXT_MARK_UNWRIT1)
> +	if (is_unwrit)
>  		ext4_ext_mark_unwritten(ex);
>  
>  	/*
> @@ -3261,7 +3237,7 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>  	ex2->ee_block = cpu_to_le32(split);
>  	ex2->ee_len   = cpu_to_le16(ee_len - (split - ee_block));
>  	ext4_ext_store_pblock(ex2, newblock);
> -	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
> +	if (is_unwrit)
>  		ext4_ext_mark_unwritten(ex2);
>  
>  	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
> @@ -3384,16 +3360,11 @@ ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>  		if (err)
>  			/* ZEROOUT failed, just return original error */
>  			return ERR_PTR(err);
> -	} else if (flags & EXT4_GET_BLOCKS_UNWRIT_EXT) {
> +	} else {
>  		/*
> -		 * EXT4_GET_BLOCKS_UNWRIT_EXT: Today, this flag
> -		 * implicitly implies that callers when wanting an
> -		 * unwritten to unwritten split. So zeroout the whole
> -		 * extent.
> -		 *
> -		 * TODO: The implicit meaning of the flag is not ideal
> -		 * and eventually we should aim for a more well defined
> -		 * behavior
> +		 * None of the convert flags imply we just want a split.
> +		 * In this case we can only zeroout if an unwritten split
> +		 * was needed.
>  		 */
>  
>  		if (!is_unwrit)
> @@ -3415,7 +3386,7 @@ ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
>  
>  	ext4_ext_mark_initialized(ex);
>  
> -	ext4_ext_dirty(handle, inode, path + path->p_depth);
> +	ext4_ext_dirty(handle, inode, path + depth);
>  	if (err)
>  		return ERR_PTR(err);
>  
> @@ -3438,13 +3409,13 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  					       struct ext4_ext_path *path,
>  					       struct ext4_map_blocks *map,
>  					       int split_flag, int flags,
> -					       unsigned int *allocated)
> +					       unsigned int *allocated, bool *did_zeroout)
>  {
>  	ext4_lblk_t ee_block, orig_ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len, orig_ee_len, depth;
>  	int unwritten, orig_unwritten;
> -	int split_flag1 = 0, flags1 = 0;
> +	int flags1 = 0;
>  	int err = 0, orig_err;
>  
>  	depth = ext_depth(inode);
> @@ -3462,11 +3433,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  
>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
>  		flags1 = flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> -		if (unwritten)
> -			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
> -				       EXT4_EXT_MARK_UNWRIT2;
> +
>  		path = ext4_split_extent_at(handle, inode, path,
> -				map->m_lblk + map->m_len, split_flag1, flags1);
> +					    map->m_lblk + map->m_len, flags1);
>  
>  		if (IS_ERR(path)) {
>  			orig_err = PTR_ERR(path);
> @@ -3494,13 +3463,8 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  	}
>  
>  	if (map->m_lblk >= ee_block) {
> -		split_flag1 = 0;
> -		if (unwritten) {
> -			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
> -			split_flag1 |= split_flag & EXT4_EXT_MARK_UNWRIT2;
> -		}
>  		path = ext4_split_extent_at(handle, inode, path, map->m_lblk,
> -					    split_flag1, flags);
> +					    flags);
>  
>  		if (IS_ERR(path)) {
>  			orig_err = PTR_ERR(path);
> @@ -3546,6 +3510,11 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>  		 */
>  		if (ext4_split_extent_zeroout(handle, inode, path, map, flags))
>  			return ERR_PTR(orig_err);
> +
> +		/* zeroout succeeded */
> +		if (did_zeroout)
> +			*did_zeroout = true;
> +		goto out;
>  	}
>  
>  	/* There's an error and we can't zeroout, just return the err */
> @@ -3596,7 +3565,6 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>  	ext4_lblk_t ee_block, eof_block;
>  	unsigned int ee_len, depth, map_len = map->m_len;
>  	int err = 0;
> -	int split_flag = 0;
>  	unsigned int max_zeroout = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
> @@ -3748,9 +3716,7 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>  	 * It is safe to convert extent to initialized via explicit
>  	 * zeroout only if extent is fully inside i_size or new_size.
>  	 */
> -	split_flag |= ee_block + ee_len <= eof_block ? EXT4_EXT_MAY_ZEROOUT : 0;
> -
> -	if (EXT4_EXT_MAY_ZEROOUT & split_flag)
> +	if (ee_block + ee_len <= eof_block)
>  		max_zeroout = sbi->s_extent_max_zeroout_kb >>
>  			(inode->i_sb->s_blocksize_bits - 10);
>  
> @@ -3805,8 +3771,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>  	}
>  
>  fallback:
> -	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
> -				 flags, NULL);
> +	path = ext4_split_convert_extents(handle, inode, &split_map, path,
> +					  flags | EXT4_GET_BLOCKS_CONVERT, NULL);
>  	if (IS_ERR(path))
>  		return path;
>  out:
> @@ -3820,6 +3786,26 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
>  	return ERR_PTR(err);
>  }
>  
> +static bool ext4_ext_needs_conv(struct inode *inode, struct ext4_ext_path *path,
> +				int flags)
> +{
> +	struct ext4_extent *ex;
> +	bool is_unwrit;
> +	int depth;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +	is_unwrit = ext4_ext_is_unwritten(ex);
> +
> +	if (is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT))
> +		return true;
> +
> +	if (!is_unwrit && (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> +		return true;
> +
> +	return false;
> +}
> +
>  /*
>   * This function is called by ext4_ext_map_blocks() from
>   * ext4_get_blocks_dio_write() when DIO to write
> @@ -3856,7 +3842,9 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  	ext4_lblk_t ee_block;
>  	struct ext4_extent *ex;
>  	unsigned int ee_len;
> -	int split_flag = 0, depth;
> +	int split_flag = 0, depth, err = 0;
> +	bool did_zeroout = false;
> +	bool needs_conv = ext4_ext_needs_conv(inode, path, flags);
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len);
> @@ -3870,19 +3858,81 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  	ee_block = le32_to_cpu(ex->ee_block);
>  	ee_len = ext4_ext_get_actual_len(ex);
>  
> -	if (flags & (EXT4_GET_BLOCKS_UNWRIT_EXT |
> -			    EXT4_GET_BLOCKS_CONVERT)) {
> +	/* No split needed */
> +	if (ee_block == map->m_lblk && ee_len == map->m_len)
> +		goto convert;
> +
> +	/*
> +	 * We don't use zeroout fallback for written to unwritten conversion as
> +	 * it is not as critical as endio and it might take unusually long.
> +	 * Also, it is only safe to convert extent to initialized via explicit
> +	 * zeroout only if extent is fully inside i_size or new_size.
> +	 */
> +	if (!(flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN))
> +		split_flag |= ee_block + ee_len <= eof_block ?
> +				      EXT4_EXT_MAY_ZEROOUT :
> +				      0;
> +
> +	/*
> +	 * pass SPLIT_NOMERGE explicitly so we don't end up merging extents we
> +	 * just split.
> +	 */
> +	path = ext4_split_extent(handle, inode, path, map, split_flag,
> +				 flags | EXT4_GET_BLOCKS_SPLIT_NOMERGE,
> +				 allocated, &did_zeroout);
> +
> +convert:
> +	/*
> +	 * We don't need a conversion if:
> +	 * 1. There was an error in split.
> +	 * 2. We split via zeroout.
> +	 * 3. None of the convert flags were passed.
> +	 */
> +	if (IS_ERR(path) || did_zeroout || !needs_conv)
> +		return path;
> +
> +	path = ext4_find_extent(inode, map->m_lblk, path, flags);
> +	if (IS_ERR(path))
> +		return path;
> +
> +	depth = ext_depth(inode);
> +	ex = path[depth].p_ext;
> +
> +	err = ext4_ext_get_access(handle, inode, path + depth);
> +	if (err)
> +		goto err;
> +
> +	if (flags & EXT4_GET_BLOCKS_CONVERT)
> +		ext4_ext_mark_initialized(ex);
> +	else if (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)
> +		ext4_ext_mark_unwritten(ex);
> +
> +	if (!(flags & EXT4_GET_BLOCKS_SPLIT_NOMERGE))
>  		/*
> -		 * It is safe to convert extent to initialized via explicit
> -		 * zeroout only if extent is fully inside i_size or new_size.
> +		 * note: ext4_ext_correct_indexes() isn't needed here because
> +		 * borders are not changed
>  		 */
> -		split_flag |= ee_block + ee_len <= eof_block ?
> -			      EXT4_EXT_MAY_ZEROOUT : 0;
> -		split_flag |= EXT4_EXT_MARK_UNWRIT2;
> +		ext4_ext_try_to_merge(handle, inode, path, ex);
> +
> +	err = ext4_ext_dirty(handle, inode, path + depth);
> +	if (err)
> +		goto err;
> +
> +	/* Lets update the extent status tree after conversion */
> +	ext4_es_insert_extent(inode, le32_to_cpu(ex->ee_block),
> +			      ext4_ext_get_actual_len(ex), ext4_ext_pblock(ex),
> +			      ext4_ext_is_unwritten(ex) ?
> +				      EXTENT_STATUS_UNWRITTEN :
> +				      EXTENT_STATUS_WRITTEN,
> +			      false);
> +
> +err:
> +	if (err) {
> +		ext4_free_ext_path(path);
> +		return ERR_PTR(err);
>  	}
> -	flags |= EXT4_GET_BLOCKS_SPLIT_NOMERGE;
> -	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
> -				 allocated);
> +
> +	return path;
>  }
>  
>  static struct ext4_ext_path *
> @@ -3894,7 +3944,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
>  	int depth;
> -	int err = 0;
>  
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -3904,41 +3953,8 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -						  flags, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		ex = path[depth].p_ext;
> -	}
> -
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> -		goto errout;
> -	/* first mark the extent as initialized */
> -	ext4_ext_mark_initialized(ex);
> -
> -	/* note: ext4_ext_correct_indexes() isn't needed here because
> -	 * borders are not changed
> -	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> -
> -	/* Mark modified extent as dirty */
> -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	if (err)
> -		goto errout;
> -
> -	ext4_ext_show_leaf(inode, path);
> -	return path;
> -
> -errout:
> -	ext4_free_ext_path(path);
> -	return ERR_PTR(err);
> +	return ext4_split_convert_extents(handle, inode, map, path, flags,
> +					  NULL);
>  }
>  
>  static struct ext4_ext_path *
> @@ -3952,7 +3968,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	ext4_lblk_t ee_block;
>  	unsigned int ee_len;
>  	int depth;
> -	int err = 0;
>  
>  	/*
>  	 * Make sure that the extent is no bigger than we support with
> @@ -3969,40 +3984,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)ee_block, ee_len);
>  
> -	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		path = ext4_split_convert_extents(handle, inode, map, path,
> -				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> -		if (IS_ERR(path))
> -			return path;
> -
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> -		if (IS_ERR(path))
> -			return path;
> -		depth = ext_depth(inode);
> -		ex = path[depth].p_ext;
> -		if (!ex) {
> -			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
> -					 (unsigned long) map->m_lblk);
> -			err = -EFSCORRUPTED;
> -			goto errout;
> -		}
> -	}
> -
> -	err = ext4_ext_get_access(handle, inode, path + depth);
> -	if (err)
> -		goto errout;
> -	/* first mark the extent as unwritten */
> -	ext4_ext_mark_unwritten(ex);
> -
> -	/* note: ext4_ext_correct_indexes() isn't needed here because
> -	 * borders are not changed
> -	 */
> -	ext4_ext_try_to_merge(handle, inode, path, ex);
> +	path = ext4_split_convert_extents(
> +		handle, inode, map, path,
> +		flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +	if (IS_ERR(path))
> +		return path;
>  
> -	/* Mark modified extent as dirty */
> -	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> -	if (err)
> -		goto errout;
>  	ext4_ext_show_leaf(inode, path);
>  
>  	ext4_update_inode_fsync_trans(handle, inode, 1);
> @@ -4012,10 +3999,6 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  		*allocated = map->m_len;
>  	map->m_len = *allocated;
>  	return path;
> -
> -errout:
> -	ext4_free_ext_path(path);
> -	return ERR_PTR(err);
>  }
>  
>  static struct ext4_ext_path *
> @@ -5649,7 +5632,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  	struct ext4_extent *extent;
>  	ext4_lblk_t start_lblk, len_lblk, ee_start_lblk = 0;
>  	unsigned int credits, ee_len;
> -	int ret, depth, split_flag = 0;
> +	int ret, depth;
>  	loff_t start;
>  
>  	trace_ext4_insert_range(inode, offset, len);
> @@ -5720,12 +5703,8 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		 */
>  		if ((start_lblk > ee_start_lblk) &&
>  				(start_lblk < (ee_start_lblk + ee_len))) {
> -			if (ext4_ext_is_unwritten(extent))
> -				split_flag = EXT4_EXT_MARK_UNWRIT1 |
> -					EXT4_EXT_MARK_UNWRIT2;
>  			path = ext4_split_extent_at(handle, inode, path,
> -					start_lblk, split_flag,
> -					EXT4_EX_NOCACHE |
> +					start_lblk, EXT4_EX_NOCACHE |
>  					EXT4_GET_BLOCKS_SPLIT_NOMERGE |
>  					EXT4_GET_BLOCKS_METADATA_NOFAIL);
>  		}
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

