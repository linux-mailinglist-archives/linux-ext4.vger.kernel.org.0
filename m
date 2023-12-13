Return-Path: <linux-ext4+bounces-430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E19810D7C
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 10:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579F21C20955
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 09:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0E520316;
	Wed, 13 Dec 2023 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbhyZwP7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9AB8YIfN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KbhyZwP7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9AB8YIfN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825C7D0;
	Wed, 13 Dec 2023 01:31:35 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152FF22571;
	Wed, 13 Dec 2023 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702459892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6MGaSlKMS0AuPKsYuo4WMXeZr995LZPWDQ4VUOSKS4=;
	b=KbhyZwP76/cbjpihu41myN+ab6oR0tIVdZ1HQ5AXeYxNkTSXjPdfXEjTPAdn2heKvb8XQ/
	p6DHP6Xv1CMgtqVlQ/DWK/4xrMfKD0+vsE1k0c9miEp9/6GNEYJ2WQEYWAWetypOilsHKz
	8j/Fa6GHGMceN+f06TvIZBw/Js57tpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702459892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6MGaSlKMS0AuPKsYuo4WMXeZr995LZPWDQ4VUOSKS4=;
	b=9AB8YIfN7dJLjurkpS9idfIlCIeAIKpXhS9YkWAAZhEV2Ks1RQF50avcVjE1e3yDKylqcx
	9EZoIaFCx0WpuxBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702459892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6MGaSlKMS0AuPKsYuo4WMXeZr995LZPWDQ4VUOSKS4=;
	b=KbhyZwP76/cbjpihu41myN+ab6oR0tIVdZ1HQ5AXeYxNkTSXjPdfXEjTPAdn2heKvb8XQ/
	p6DHP6Xv1CMgtqVlQ/DWK/4xrMfKD0+vsE1k0c9miEp9/6GNEYJ2WQEYWAWetypOilsHKz
	8j/Fa6GHGMceN+f06TvIZBw/Js57tpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702459892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6MGaSlKMS0AuPKsYuo4WMXeZr995LZPWDQ4VUOSKS4=;
	b=9AB8YIfN7dJLjurkpS9idfIlCIeAIKpXhS9YkWAAZhEV2Ks1RQF50avcVjE1e3yDKylqcx
	9EZoIaFCx0WpuxBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 01CCA13240;
	Wed, 13 Dec 2023 09:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vjNmAPR5eWVFYgAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 13 Dec 2023 09:31:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CAE7A07E0; Wed, 13 Dec 2023 10:31:31 +0100 (CET)
Date: Wed, 13 Dec 2023 10:31:31 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.cz, willy@infradead.org,
	akpm@linux-foundation.org, david@fromorbit.com, hch@infradead.org,
	ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@kernel.org
Subject: Re: [RFC PATCH v2] mm/filemap: avoid buffered read/write race to
 read inconsistent data
Message-ID: <20231213093131.zk6rrpdfiwf263as@quack3>
References: <20231213062324.739009-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213062324.739009-1-libaokun1@huawei.com>
X-Spam-Score: 13.39
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KbhyZwP7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9AB8YIfN;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.36 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 R_RATELIMIT(0.00)[to_ip_from(RLipn3kch65fcrhdxgeb98n64p)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(1.87)[0.535];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,mit.edu,dilger.ca,suse.cz,infradead.org,linux-foundation.org,fromorbit.com,gmail.com,huawei.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 9.36
X-Rspamd-Queue-Id: 152FF22571
X-Spam-Flag: NO

On Wed 13-12-23 14:23:24, Baokun Li wrote:
> The following concurrency may cause the data read to be inconsistent with
> the data on disk:
> 
>              cpu1                           cpu2
> ------------------------------|------------------------------
>                                // Buffered write 2048 from 0
>                                ext4_buffered_write_iter
>                                 generic_perform_write
>                                  copy_page_from_iter_atomic
>                                  ext4_da_write_end
>                                   ext4_da_do_write_end
>                                    block_write_end
>                                     __block_commit_write
>                                      folio_mark_uptodate
> // Buffered read 4096 from 0          smp_wmb()
> ext4_file_read_iter                   set_bit(PG_uptodate, folio_flags)
>  generic_file_read_iter            i_size_write // 2048
>   filemap_read                     unlock_page(page)
>    filemap_get_pages
>     filemap_get_read_batch
>     folio_test_uptodate(folio)
>      ret = test_bit(PG_uptodate, folio_flags)
>      if (ret)
>       smp_rmb();
>       // Ensure that the data in page 0-2048 is up-to-date.
> 
>                                // New buffered write 2048 from 2048
>                                ext4_buffered_write_iter
>                                 generic_perform_write
>                                  copy_page_from_iter_atomic
>                                  ext4_da_write_end
>                                   ext4_da_do_write_end
>                                    block_write_end
>                                     __block_commit_write
>                                      folio_mark_uptodate
>                                       smp_wmb()
>                                       set_bit(PG_uptodate, folio_flags)
>                                    i_size_write // 4096
>                                    unlock_page(page)
> 
>    isize = i_size_read(inode) // 4096
>    // Read the latest isize 4096, but without smp_rmb(), there may be
>    // Load-Load disorder resulting in the data in the 2048-4096 range
>    // in the page is not up-to-date.
>    copy_page_to_iter
>    // copyout 4096
> 
> In the concurrency above, we read the updated i_size, but there is no read
> barrier to ensure that the data in the page is the same as the i_size at
> this point, so we may copy the unsynchronized page out. Hence adding the
> missing read memory barrier to fix this.
> 
> This is a Load-Load reordering issue, which only occurs on some weak
> mem-ordering architectures (e.g. ARM64, ALPHA), but not on strong
> mem-ordering architectures (e.g. X86). And theoretically the problem
> doesn't only happen on ext4, filesystems that call filemap_read() but
> don't hold inode lock (e.g. btrfs, f2fs, ubifs ...) will have this
> problem, while filesystems with inode lock (e.g. xfs, nfs) won't have
> this problem.
> 
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the fix. It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> V1->V2:
> 	Change the comment to the one suggested by Jan Kara.	
> 
>  mm/filemap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 71f00539ac00..10c4583c06ce 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2607,6 +2607,15 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
>  			goto put_folios;
>  		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
>  
> +		/*
> +		 * Pairs with a barrier in
> +		 * block_write_end()->mark_buffer_dirty() or other page
> +		 * dirtying routines like iomap_write_end() to ensure
> +		 * changes to page contents are visible before we see
> +		 * increased inode size.
> +		 */
> +		smp_rmb();
> +
>  		/*
>  		 * Once we start copying data, we don't want to be touching any
>  		 * cachelines that might be contended:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

