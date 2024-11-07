Return-Path: <linux-ext4+bounces-4998-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9BF9C0A74
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE534B21FA3
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5320C48E;
	Thu,  7 Nov 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuUayhm+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MLwBIlvX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuUayhm+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MLwBIlvX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144082876
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994827; cv=none; b=NHtQa0CV+b0IrD+Z14rI1Qm99K7NiDmh4HYX2N5kKGw9f7f7CpWQiDrCmyCyeil2c53kW60XhzLmN7rIOIO9BDYhHIg2Lgv5t5ykNfpAQM3BvOPfiS9PokjQBtWCoxGfHQJb3UFZBT8WYeWP7073GqL+mL2s02zdP3oO3XYXebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994827; c=relaxed/simple;
	bh=n6489/AEjwTgDQHKZHHSbAb9oKoo14jcExJqKJ5DL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0+69m9ExbsJRguwGx4TP6Q1WSQB+ci205SGTxEyixODIcMj+SOloOjkNw1EtekG7JwsiVIeaFeiA+YmrBUUw/iuhVQAY5CpfIVg5W8GtvZF3FtfCc4ISPCxDdZibb6wrAThz3hLppGVGHjTZw1RjduraDgcVRMw1At0IuFY9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuUayhm+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MLwBIlvX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuUayhm+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MLwBIlvX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC71721E9D;
	Thu,  7 Nov 2024 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730994823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q427MA/+tRZf6PUP0VXXp9dtrDpG5OOeHuOqBbU498=;
	b=XuUayhm+NY3d+Su6rTDm67vErJWldeB/w9x+mPmaaKZelwwbrDREuha3OLAxaOrnCBZ5Fy
	nzyUmErpxZ0E2fFLBuJyRRq+pssAfRTWebbFBNnS+VHiSDNKKhEuvCeOPJJJb47kSSAU8f
	TY9YLTipy64qpYQidnAqzlQMZDXZzC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730994823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q427MA/+tRZf6PUP0VXXp9dtrDpG5OOeHuOqBbU498=;
	b=MLwBIlvXBlYRkKOSJOiufC8RORjFJOHVuJJJR+NSx3NTR08RM5PrY2q3j1ROVzhpH+vLOM
	nU9uU6q/tpwNvvBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730994823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q427MA/+tRZf6PUP0VXXp9dtrDpG5OOeHuOqBbU498=;
	b=XuUayhm+NY3d+Su6rTDm67vErJWldeB/w9x+mPmaaKZelwwbrDREuha3OLAxaOrnCBZ5Fy
	nzyUmErpxZ0E2fFLBuJyRRq+pssAfRTWebbFBNnS+VHiSDNKKhEuvCeOPJJJb47kSSAU8f
	TY9YLTipy64qpYQidnAqzlQMZDXZzC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730994823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Q427MA/+tRZf6PUP0VXXp9dtrDpG5OOeHuOqBbU498=;
	b=MLwBIlvXBlYRkKOSJOiufC8RORjFJOHVuJJJR+NSx3NTR08RM5PrY2q3j1ROVzhpH+vLOM
	nU9uU6q/tpwNvvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3F40139B3;
	Thu,  7 Nov 2024 15:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2qmbK4fiLGdCfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 15:53:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEDA9A08FE; Thu,  7 Nov 2024 16:53:42 +0100 (CET)
Date: Thu, 7 Nov 2024 16:53:42 +0100
From: Jan Kara <jack@suse.cz>
To: leo.lilong@huaweicloud.com
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, leo.lilong@huawei.com,
	linux-ext4@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [RESEND PATCH] ext4: Fix race in buffer_head read fault injection
Message-ID: <20241107155342.sonicmzg7leo63nq@quack3>
References: <20241024021909.4032340-1-leo.lilong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024021909.4032340-1-leo.lilong@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 24-10-24 10:19:09, leo.lilong@huaweicloud.com wrote:
> From: Long Li <leo.lilong@huawei.com>
> 
> When I enabled ext4 debug for fault injection testing, I encountered the
> following warning:
> 
>   EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
>          Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
>   WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0
> 
> The root cause of the issue lies in the improper implementation of ext4's
> buffer_head read fault injection. The actual completion of buffer_head
> read and the buffer_head fault injection are not atomic, which can lead
> to the uptodate flag being cleared on normally used buffer_heads in race
> conditions.
> 
> [CPU0]           [CPU1]         [CPU2]
> ext4_read_inode_bitmap
>   ext4_read_bh()
>   <bh read complete>
>                  ext4_read_inode_bitmap
>                    if (buffer_uptodate(bh))
>                      return bh
>                                jbd2_journal_commit_transaction
>                                  __jbd2_journal_refile_buffer
>                                    __jbd2_journal_unfile_buffer
>                                      __jbd2_journal_temp_unlink_buffer
>   ext4_simulate_fail_bh()
>     clear_buffer_uptodate
>                                       mark_buffer_dirty
>                                         <report warning>
>                                         WARN_ON_ONCE(!buffer_uptodate(bh))
> 
> The best approach would be to perform fault injection in the IO completion
> callback function, rather than after IO completion. However, the IO
> completion callback function cannot get the fault injection code in sb.
> 
> Fix it by passing the result of fault injection into the bh read function,
> we simulate faults within the bh read function itself. This requires adding
> an extra parameter to the bh read functions that need fault injection.
> 
> Fixes: 46f870d690fe ("ext4: simulate various I/O and checksum errors when reading metadata")
> Signed-off-by: Long Li <leo.lilong@huawei.com>

Thanks for the fix! One suggestion below:

> @@ -3100,9 +3092,9 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>  extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
>  						   sector_t block);
>  extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
> -				bh_end_io_t *end_io);
> +				bh_end_io_t *end_io, bool simu_fail);
>  extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> -			bh_end_io_t *end_io);
> +			bh_end_io_t *end_io, bool simu_fail);

Instead of adding a bool argument whether we should simulate a failure, I'd
pass the 'code' into ext4_read_bh_nowait() and handle the check in there.
That reduces the boilerplate code a bit and looks somewhat cleaner.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

