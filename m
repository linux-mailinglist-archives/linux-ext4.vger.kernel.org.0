Return-Path: <linux-ext4+bounces-4337-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C5A987464
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C33E1C23401
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646222EF4;
	Thu, 26 Sep 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1QaxqQm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIJk/80K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1QaxqQm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xIJk/80K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE2E4D8CB
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727357094; cv=none; b=opbmolLVM8pXARa5Tjj5PidQv/dtsiscS26H6Jb7pmqiHPqHTToj1Pl+3zlxM2zYwmnJzO+53YJtpMDepuBSOBIDiTbolIV2aJt3RclOQ0Wz7i+BVrBj490/R652470vu2b4r6dnuC05VLe6WlozXCq+JLtGvkXMt+LjF4sVn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727357094; c=relaxed/simple;
	bh=hD+eHUnLnQjC4YiAwUVlQP8uoeFyEPKkwdLsA0Mnmb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHMVU1tURecoMAPDUsTY8q9Yu6Jk6U3VvMrfrliF24psN669t8ddMm92Xt76hJf8YNsPfHuErVzTsitM/6dR3DhsrVf61nNg9r66v92oD0E+KH1C22Ymg5RM1TZWoZiarQYh98oM+sqQMgF/iQNg4lm4pVb7EQRrgGkHXGrCEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1QaxqQm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIJk/80K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1QaxqQm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xIJk/80K; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAA011FCEB;
	Thu, 26 Sep 2024 13:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727357090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2m3co6sUifs+cdD2bbjBfiNVYLtSc+sI+x+OxrwDlJ4=;
	b=M1QaxqQmvFpBguBrmnQKwyQ2bUgQKWYzpHAqtpglGOTFvcIYQdDUDmhGl4/YQ26buwWEIc
	DIC4FdO4EfIbgy4mCn0LFjg/AKet6KLU3B54oGT5J8PiozMxDFKWNAtkk1cw65BLtcEG0A
	V4P0XSD7yFaUIC9FyM6gEdqfZ7Uijgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727357090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2m3co6sUifs+cdD2bbjBfiNVYLtSc+sI+x+OxrwDlJ4=;
	b=xIJk/80KHjJ/p2c5dC5eavu2W5LHLGsOPO4yu5DLQbn2xsfhaPDbJEeeNR5PXOvqwB06p1
	3VZAHFxui3yPjIBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M1QaxqQm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="xIJk/80K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727357090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2m3co6sUifs+cdD2bbjBfiNVYLtSc+sI+x+OxrwDlJ4=;
	b=M1QaxqQmvFpBguBrmnQKwyQ2bUgQKWYzpHAqtpglGOTFvcIYQdDUDmhGl4/YQ26buwWEIc
	DIC4FdO4EfIbgy4mCn0LFjg/AKet6KLU3B54oGT5J8PiozMxDFKWNAtkk1cw65BLtcEG0A
	V4P0XSD7yFaUIC9FyM6gEdqfZ7Uijgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727357090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2m3co6sUifs+cdD2bbjBfiNVYLtSc+sI+x+OxrwDlJ4=;
	b=xIJk/80KHjJ/p2c5dC5eavu2W5LHLGsOPO4yu5DLQbn2xsfhaPDbJEeeNR5PXOvqwB06p1
	3VZAHFxui3yPjIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4A7013793;
	Thu, 26 Sep 2024 13:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z0UfLKJg9WZwZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 13:24:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D5C2A0845; Thu, 26 Sep 2024 15:24:46 +0200 (CEST)
Date: Thu, 26 Sep 2024 15:24:46 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 4/5] jbd2: factor out jbd2_do_replay()
Message-ID: <20240926132446.aa4qxyuqpejxwr5i@quack3>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-5-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918113604.660640-5-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: CAA011FCEB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 18-09-24 19:36:03, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Factor out jbd2_do_replay() no funtional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

The patch looks good but I have a few comments below:

> +static __always_inline int jbd2_do_replay(journal_t *journal,
> +					  struct recovery_info *info,
> +					  struct buffer_head *bh,
> +					  unsigned long *next_log_block,
> +					  unsigned int next_commit_ID,
> +					  int *success, int *block_error)

So you remove block_error in the later patch so that is good. But I also
wonder if we need the 'success' parameter. I'd think that jbd2_do_replay()
can just keep success internally to track if any error happened and then
return it at the end? do_one_pass() will then incorporate the returned
value in its 'success' variable. That way the error handling will be more
standard...

> +{
> +	char *tagp;
> +	int flags;
> +	int err;
> +	int tag_bytes = journal_tag_bytes(journal);
> +	int descr_csum_size = 0;
> +	unsigned long io_block;
> +	journal_block_tag_t tag;
> +	struct buffer_head *obh;
> +	struct buffer_head *nbh;
> +
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		descr_csum_size = sizeof(struct jbd2_journal_block_tail);
> +
> +	tagp = &bh->b_data[sizeof(journal_header_t)];
> +	while ((tagp - bh->b_data + tag_bytes) <=
	       ^^ no need for braces here...

> +	       journal->j_blocksize - descr_csum_size) {
		^^ when the indentation level is this close to the code
block indentation, I actually prefer indenting it one tab more like:

			journal->j_blocksize - descr_csum_size) {

But this is just a personal preference so feel free to ignore it :)

> +
> +		memcpy(&tag, tagp, sizeof(tag));
> +		flags = be16_to_cpu(tag.t_flags);
> +
> +		io_block = (*next_log_block)++;
> +		wrap(journal, *next_log_block);
> +		err = jread(&obh, journal, io_block);
> +		if (err) {
> +			/* Recover what we can, but report failure at the end. */
> +			*success = err;
> +			pr_err("JBD2: IO error %d recovering block %lu in log\n",
> +			      err, io_block);
> +		} else {
> +			unsigned long long blocknr;
> +
> +			J_ASSERT(obh != NULL);
> +			blocknr = read_tag_block(journal, &tag);
> +
> +			/* If the block has been revoked, then we're all done here. */
> +			if (jbd2_journal_test_revoke(journal, blocknr,
> +						     next_commit_ID)) {
> +				brelse(obh);
> +				++info->nr_revoke_hits;
> +				goto skip_write;
> +			}
> +
> +			/* Look for block corruption */
> +			if (!jbd2_block_tag_csum_verify(journal, &tag,
> +				(journal_block_tag3_t *)tagp, obh->b_data,
> +				next_commit_ID)) {
				^^^
Indentation like this is really confusing. I'd add one more tab here.

Otherwise the patch looks good.

									Honza


> +				brelse(obh);
> +				*success = -EFSBADCRC;
> +				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
> +				      blocknr, io_block);
> +				*block_error = 1;
> +				goto skip_write;
> +			}
> +
> +			/* Find a buffer for the new data being restored */
> +			nbh = __getblk(journal->j_fs_dev, blocknr,
> +				       journal->j_blocksize);
> +			if (nbh == NULL) {
> +				pr_err("JBD2: Out of memory during recovery.\n");
> +				brelse(obh);
> +				return -ENOMEM;
> +			}
> +
> +			lock_buffer(nbh);
> +			memcpy(nbh->b_data, obh->b_data, journal->j_blocksize);
> +			if (flags & JBD2_FLAG_ESCAPE) {
> +				*((__be32 *)nbh->b_data) =
> +				cpu_to_be32(JBD2_MAGIC_NUMBER);
> +			}
> +
> +			BUFFER_TRACE(nbh, "marking dirty");
> +			set_buffer_uptodate(nbh);
> +			mark_buffer_dirty(nbh);
> +			BUFFER_TRACE(nbh, "marking uptodate");
> +			++info->nr_replays;
> +			unlock_buffer(nbh);
> +			brelse(obh);
> +			brelse(nbh);
> +		}
> +
> +skip_write:
> +		tagp += tag_bytes;
> +		if (!(flags & JBD2_FLAG_SAME_UUID))
> +			tagp += 16;
> +
> +		if (flags & JBD2_FLAG_LAST_TAG)
> +			break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int do_one_pass(journal_t *journal,
>  			struct recovery_info *info, enum passtype pass)
>  {
> @@ -496,9 +595,7 @@ static int do_one_pass(journal_t *journal,
>  	struct buffer_head	*bh = NULL;
>  	unsigned int		sequence;
>  	int			blocktype;
> -	int			tag_bytes = journal_tag_bytes(journal);
>  	__u32			crc32_sum = ~0; /* Transactional Checksums */
> -	int			descr_csum_size = 0;
>  	int			block_error = 0;
>  	bool			need_check_commit_time = false;
>  	__u64			last_trans_commit_time = 0, commit_time;
> @@ -528,12 +625,6 @@ static int do_one_pass(journal_t *journal,
>  	 */
>  
>  	while (1) {
> -		int			flags;
> -		char *			tagp;
> -		journal_block_tag_t	tag;
> -		struct buffer_head *	obh;
> -		struct buffer_head *	nbh;
> -
>  		cond_resched();
>  
>  		/* If we already know where to stop the log traversal,
> @@ -587,11 +678,7 @@ static int do_one_pass(journal_t *journal,
>  		switch(blocktype) {
>  		case JBD2_DESCRIPTOR_BLOCK:
>  			/* Verify checksum first */
> -			if (jbd2_journal_has_csum_v2or3(journal))
> -				descr_csum_size =
> -					sizeof(struct jbd2_journal_block_tail);
> -			if (descr_csum_size > 0 &&
> -			    !jbd2_descriptor_block_csum_verify(journal,
> +			if (!jbd2_descriptor_block_csum_verify(journal,
>  							       bh->b_data)) {
>  				/*
>  				 * PASS_SCAN can see stale blocks due to lazy
> @@ -628,102 +715,16 @@ static int do_one_pass(journal_t *journal,
>  				continue;
>  			}
>  
> -			/* A descriptor block: we can now write all of
> -			 * the data blocks.  Yay, useful work is finally
> -			 * getting done here! */
> -
> -			tagp = &bh->b_data[sizeof(journal_header_t)];
> -			while ((tagp - bh->b_data + tag_bytes)
> -			       <= journal->j_blocksize - descr_csum_size) {
> -				unsigned long io_block;
> -
> -				memcpy(&tag, tagp, sizeof(tag));
> -				flags = be16_to_cpu(tag.t_flags);
> -
> -				io_block = next_log_block++;
> -				wrap(journal, next_log_block);
> -				err = jread(&obh, journal, io_block);
> -				if (err) {
> -					/* Recover what we can, but
> -					 * report failure at the end. */
> -					success = err;
> -					printk(KERN_ERR
> -						"JBD2: IO error %d recovering "
> -						"block %lu in log\n",
> -						err, io_block);
> -				} else {
> -					unsigned long long blocknr;
> -
> -					J_ASSERT(obh != NULL);
> -					blocknr = read_tag_block(journal,
> -								 &tag);
> -
> -					/* If the block has been
> -					 * revoked, then we're all done
> -					 * here. */
> -					if (jbd2_journal_test_revoke
> -					    (journal, blocknr,
> -					     next_commit_ID)) {
> -						brelse(obh);
> -						++info->nr_revoke_hits;
> -						goto skip_write;
> -					}
> -
> -					/* Look for block corruption */
> -					if (!jbd2_block_tag_csum_verify(
> -			journal, &tag, (journal_block_tag3_t *)tagp,
> -			obh->b_data, be32_to_cpu(tmp->h_sequence))) {
> -						brelse(obh);
> -						success = -EFSBADCRC;
> -						printk(KERN_ERR "JBD2: Invalid "
> -						       "checksum recovering "
> -						       "data block %llu in "
> -						       "journal block %lu\n",
> -						       blocknr, io_block);
> -						block_error = 1;
> -						goto skip_write;
> -					}
> -
> -					/* Find a buffer for the new
> -					 * data being restored */
> -					nbh = __getblk(journal->j_fs_dev,
> -							blocknr,
> -							journal->j_blocksize);
> -					if (nbh == NULL) {
> -						printk(KERN_ERR
> -						       "JBD2: Out of memory "
> -						       "during recovery.\n");
> -						err = -ENOMEM;
> -						brelse(obh);
> -						goto failed;
> -					}
> -
> -					lock_buffer(nbh);
> -					memcpy(nbh->b_data, obh->b_data,
> -							journal->j_blocksize);
> -					if (flags & JBD2_FLAG_ESCAPE) {
> -						*((__be32 *)nbh->b_data) =
> -						cpu_to_be32(JBD2_MAGIC_NUMBER);
> -					}
> -
> -					BUFFER_TRACE(nbh, "marking dirty");
> -					set_buffer_uptodate(nbh);
> -					mark_buffer_dirty(nbh);
> -					BUFFER_TRACE(nbh, "marking uptodate");
> -					++info->nr_replays;
> -					unlock_buffer(nbh);
> -					brelse(obh);
> -					brelse(nbh);
> -				}
> -
> -			skip_write:
> -				tagp += tag_bytes;
> -				if (!(flags & JBD2_FLAG_SAME_UUID))
> -					tagp += 16;
> -
> -				if (flags & JBD2_FLAG_LAST_TAG)
> -					break;
> -			}
> +			/*
> +			 * A descriptor block: we can now write all of the
> +			 * data blocks. Yay, useful work is finally getting
> +			 * done here!
> +			 */
> +			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> +					     next_commit_ID, &success,
> +					     &block_error);
> +			if (err)
> +				goto failed;
>  
>  			continue;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

