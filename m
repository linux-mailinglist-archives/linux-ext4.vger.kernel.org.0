Return-Path: <linux-ext4+bounces-8010-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306EABBB06
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 12:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D441172A9C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618852741BE;
	Mon, 19 May 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4DpuhZS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGdz6qAk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fRel86Rz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BMA6+gTQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A91F8EFF
	for <linux-ext4@vger.kernel.org>; Mon, 19 May 2025 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650278; cv=none; b=TfY07S1lraqXWvUZ7pHb0evwhD6UTII4SW7IMd4Vi6nKZzrGKSOgBqHPziz0MlOoAM+kIDcUNmPvjlqsZFmiS/3T7rbZ8uD9TI2ukFlkzYeqJn054N0u5THOHUR2xqxS4WF+ycqfG29z3qnERtvTWg6axY6bh0cXUYSQhpkXO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650278; c=relaxed/simple;
	bh=5kGVsJlG6r9uHm5ybJMlVtKYSBUCfPgeLEDwdEsKmKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOU8xaJiPrzUtShe5Vh6kwXXSBHaLMrSphPUCv0TQUHxKXNpbhGYDtj19HpQzzxLDbdH+w6fDZ+UB4ACMrND+BdTUt1AqY5Mv+gGqwRP5t+G7H8Rv5rwe/jc0OeqmXN74rLiY+ocYb6C3RsbQglPOCBEGLszemqm8tBCPPsJjvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4DpuhZS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGdz6qAk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fRel86Rz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BMA6+gTQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21E75227EF;
	Mon, 19 May 2025 10:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747650274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgQfNBaoSMyaw7OtF4JJf9jCo6rA+7iKmGLaJFgDFy4=;
	b=w4DpuhZSUDtQyX0djIQBbrM24bC/MLgfjf9x3X1X3NJygkxhE/7FHgOvFcTzhPhbvdZt9K
	BePc61Sah9AbmgeLf8uzwZD6748sTUSbNITwFWSev5VnbzYMu77F/cc02Fs6tOlkz3YMmC
	X5BZjzsOhy30tBLxmViQl47J0tc72gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747650274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgQfNBaoSMyaw7OtF4JJf9jCo6rA+7iKmGLaJFgDFy4=;
	b=vGdz6qAkwDoIGRu41RvrKQE4BWcbFSFCywLWZ8IQHwvvznbbVsPMU2KMKX+vo+OqlpBxU9
	9rlsyb4ZT0+AI0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747650273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgQfNBaoSMyaw7OtF4JJf9jCo6rA+7iKmGLaJFgDFy4=;
	b=fRel86RzraR0pt36R7uA7TXbw16df3UJSqWdq4WeyRXjwQGsqsuukW4utP7HsIdXJYqM0X
	DsxzfZeBsbBWI4hEcbPY0NF6aj3lLWSeVyHsuMlP+w8ifnKmB5d3aepSSoAFtadWlNEPDl
	a++cG0H1X75IOdx/pKJplMVcK9JvtBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747650273;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CgQfNBaoSMyaw7OtF4JJf9jCo6rA+7iKmGLaJFgDFy4=;
	b=BMA6+gTQ3337B0rEBbA8Al5AXHBPYJJn6MQPwAlLf5zkv3WNg7ph4ItWaQU4+HEx0wNUXC
	Dg1S0jyIH0TNnjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13EDE13A30;
	Mon, 19 May 2025 10:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hsrYBOEGK2hidwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 May 2025 10:24:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1C13A0A28; Mon, 19 May 2025 12:24:32 +0200 (CEST)
Date: Mon, 19 May 2025 12:24:32 +0200
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: only dirty folios when data journaling regular
 files
Message-ID: <l2k5kbcipqjbeyw52cz2vuapgna6upxbm7cwehrnm7rdeshuon@v3yeyhe2xbha>
References: <20250516173800.175577-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516173800.175577-1-bfoster@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Fri 16-05-25 13:38:00, Brian Foster wrote:
> fstest generic/388 occasionally reproduces a crash that looks as
> follows:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> Call Trace:
>  <TASK>
>  ext4_block_zero_page_range+0x30c/0x380 [ext4]
>  ext4_truncate+0x436/0x440 [ext4]
>  ext4_process_orphan+0x5d/0x110 [ext4]
>  ext4_orphan_cleanup+0x124/0x4f0 [ext4]
>  ext4_fill_super+0x262d/0x3110 [ext4]
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x26/0xd0
>  vfs_cmd_create+0x59/0xe0
>  __do_sys_fsconfig+0x4ed/0x6b0
>  do_syscall_64+0x82/0x170
>  ...
> 
> This occurs when processing a symlink inode from the orphan list. The
> partial block zeroing code in the truncate path calls
> ext4_dirty_journalled_data() -> folio_mark_dirty(). The latter calls
> mapping->a_ops->dirty_folio(), but symlink inodes are not assigned an
> a_ops vector in ext4, hence the crash.
> 
> To avoid this problem, update the ext4_dirty_journalled_data() helper to
> only mark the folio dirty on regular files (for which a_ops is
> assigned). This also matches the journaling logic in the ext4_symlink()
> creation path, where ext4_handle_dirty_metadata() is called directly.
> 
> Fixes: d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Yeah, I forgot about this subtlety when writing d84c9ebdac1e. Good catch
and thanks for fixing this up! The fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> 
> Hi Jan,
> 
> I'm not intimately familiar with the jbd machinery here so this may well
> be wrong, but it survives my testing so far. I initially hacked this to
> mark the buffer dirty instead of the folio, but discovered jbd2 doesn't
> seem to like that. I suspect that is because jbd2 wants to dirty/submit
> the buffer itself after it's logged..?
> 
> Anyways, after that, this struck me as most consistent with behavior
> prior to d84c9ebdac1e and/or with the creation path, so I'm floating
> this as a first pass. Is my understanding of d84c9ebdac1e correct in
> that it is mainly an optimization to allow writeback to force the
> journaling mechanism vs. otherwise waiting for the other way around
> (i.e. a journal commit to mark folios dirty)? Thoughts appreciated..

Well, the motivation for d84c9ebdac1e was not so much an optimization but
rather to provide better visibility to the generic code what needs writing
out. Otherwise we had to special-case data journalling in a lot of places
that tried to do "clean the inode & purge the page cache" because simple
filemap_write_and_wait() was not enough to get the dirty pages in the inode
to disk.

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..d3c138003ad3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1009,7 +1009,12 @@ int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
>   */
>  static int ext4_dirty_journalled_data(handle_t *handle, struct buffer_head *bh)
>  {
> -	folio_mark_dirty(bh->b_folio);
> +	struct folio *folio = bh->b_folio;
> +	struct inode *inode = folio->mapping->host;
> +
> +	/* only regular files have a_ops */
> +	if (S_ISREG(inode->i_mode))
> +		folio_mark_dirty(folio);
>  	return ext4_handle_dirty_metadata(handle, NULL, bh);
>  }
>  
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

