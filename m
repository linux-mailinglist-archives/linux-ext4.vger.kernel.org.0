Return-Path: <linux-ext4+bounces-2089-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DEC8A4F16
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 14:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FE3B21564
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Apr 2024 12:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F56CDC5;
	Mon, 15 Apr 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iPdgdq6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMow96Fi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iPdgdq6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mMow96Fi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EF3EA7B;
	Mon, 15 Apr 2024 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184450; cv=none; b=XvT2kxxsbjftesYzXcm1A32ANfLe4HI66rBI0j0vErWMqo0rOkf6ifW2z0yWf9kq3ftZGc1Mvayrd50Xx4Gqo1Uc1zIjybXQxTLBuIkc7QIP/Ow0KrQAitomxvbyXXrGg6ufk32gbrxM4AuYCEzXRBbXNtsJjh9psgP+PCLW62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184450; c=relaxed/simple;
	bh=XISiyAtFHq95w6NCfaJwm5kMhLqyG50dLNVMF8JyFh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYZY32gSheJnlBAqwPSchw8Ux4YP8cls5zXsWEINsrHtkEpzVGbDENaayrQJ6Inoxvovo43ne04xM2dKINmJsR/TGAtEHA+XzBgsOLJpBJjOtNxf9gsuk1e3MMaPncxnfZP0SuwJkpFjjCX20d/SJhirr/Q+R5pYppE7ND4pBGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iPdgdq6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMow96Fi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iPdgdq6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mMow96Fi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 438473538E;
	Mon, 15 Apr 2024 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713184446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaiXC/ENK8z3Mnd08KZm1Mu7rk07z7GW1TMM5mkzT8=;
	b=iPdgdq6f0/qUkhtm/RFw4S3ZS2j0E6xwp33LssCW8rjplPIWeqAMmtZcPEjXGI4W5u4qIV
	Ud64zCrRJJwfcDfgIgR2DaFUHYJ7D32xoUkjpVNTUXFX87yv4Th0tfw18+QyBNddbZvqlL
	O8Rwq68slm2jPGKFdhFoKvPGGr7XyYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713184446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaiXC/ENK8z3Mnd08KZm1Mu7rk07z7GW1TMM5mkzT8=;
	b=mMow96FiaICW5zQpHM4MQE57bjTTIfpgyig1sWRo2jgFEq91i2o9G8NtMaMmVEZYTcZd8e
	w4FL62nO61xG10AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713184446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaiXC/ENK8z3Mnd08KZm1Mu7rk07z7GW1TMM5mkzT8=;
	b=iPdgdq6f0/qUkhtm/RFw4S3ZS2j0E6xwp33LssCW8rjplPIWeqAMmtZcPEjXGI4W5u4qIV
	Ud64zCrRJJwfcDfgIgR2DaFUHYJ7D32xoUkjpVNTUXFX87yv4Th0tfw18+QyBNddbZvqlL
	O8Rwq68slm2jPGKFdhFoKvPGGr7XyYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713184446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZaiXC/ENK8z3Mnd08KZm1Mu7rk07z7GW1TMM5mkzT8=;
	b=mMow96FiaICW5zQpHM4MQE57bjTTIfpgyig1sWRo2jgFEq91i2o9G8NtMaMmVEZYTcZd8e
	w4FL62nO61xG10AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 375C71386E;
	Mon, 15 Apr 2024 12:34:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PImCDb4eHWYTfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Apr 2024 12:34:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6100A0834; Mon, 15 Apr 2024 14:34:05 +0200 (CEST)
Date: Mon, 15 Apr 2024 14:34:05 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, jun.nie@linaro.org,
	ebiggers@kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	yukuai3@huawei.com,
	syzbot+a158d886ca08a3fecca4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix race condition between buffer write and
 page_mkwrite
Message-ID: <20240415123405.htw6vqbzsb3speor@quack3>
References: <20230530134405.322194-1-libaokun1@huawei.com>
 <20230604030445.GF1128744@mit.edu>
 <20230604210821.GA1257572@mit.edu>
 <ZH1BN+H1/Sa4eLQ4@casper.infradead.org>
 <20230605091655.24vl5fjesfskt3o5@quack3>
 <20230605122141.4njwwx3mrapqhvt4@quack3>
 <ZH33ZzwyLFY48tfA@casper.infradead.org>
 <20230605150855.7oaiplp7r57dcww3@quack3>
 <49d5b109-7cc3-6717-b3c6-6858310aa3ba@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49d5b109-7cc3-6717-b3c6-6858310aa3ba@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[a158d886ca08a3fecca4];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,infradead.org,mit.edu,vger.kernel.org,dilger.ca,gmail.com,linaro.org,kernel.org,huawei.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Mon 15-04-24 12:28:01, Baokun Li wrote:
> On 2023/6/5 23:08, Jan Kara wrote:
> > On Mon 05-06-23 15:55:35, Matthew Wilcox wrote:
> > > On Mon, Jun 05, 2023 at 02:21:41PM +0200, Jan Kara wrote:
> > > > On Mon 05-06-23 11:16:55, Jan Kara wrote:
> > > > > Yeah, I agree, that is also the conclusion I have arrived at when thinking
> > > > > about this problem now. We should be able to just remove the conversion
> > > > > from ext4_page_mkwrite() and rely on write(2) or truncate(2) doing it when
> > > > > growing i_size.
> > > > OK, thinking more about this and searching through the history, I've
> > > > realized why the conversion is originally in ext4_page_mkwrite(). The
> > > > problem is described in commit 7b4cc9787fe35b ("ext4: evict inline data
> > > > when writing to memory map") but essentially it boils down to the fact that
> > > > ext4 writeback code does not expect dirty page for a file with inline data
> > > > because ext4_write_inline_data_end() should have copied the data into the
> > > > inode and cleared the folio's dirty flag.
> > > > 
> > > > Indeed messing with xattrs from the writeback path to copy page contents
> > > > into inline data xattr would be ... interesting. Hum, out of good ideas for
> > > > now :-|.
> > > Is it so bad?  Now that we don't have writepage in ext4, only
> > > writepages, it seems like we have a considerably more benign locking
> > > environment to work in.
> > Well, yes, without ->writepage() it might be *possible*. But still rather
> > ugly. The problem is that in ->writepages() i_size is not stable. Thus also
> > whether the inode data is inline or not is not stable. We'd need inode_lock
> > for that but that is not easily doable in the writeback path - inode lock
> > would then become fs_reclaim unsafe...
> > 
> > 								Honza
> Hi Honza!
> Hi Ted!
> Hi Matthew!
> 
> Long time later came back to this, because while discussing another similar
> ABBA problem with Hou Tao, he mentioned VM_FAULT_RETRY, and then I
> thought that this could be used to solve this problem as well.
> 
> The general idea is that if we see a file with inline data in
> ext4_page_mkwrite(),
> we release the mmap_lock and grab the inode_lock to convert the inline data,
> and then return VM_FAULT_RETRY to retry to get the mmap_lock.
> 
> The code implementation is as follows, do you have any thoughts?

So the problem with this is that VM_FAULT_RETRY is not always an option -
in particular the caller has to set FAULT_FLAG_ALLOW_RETRY to indicate it
is prepared to handle VM_FAULT_RETRY return. See how
maybe_unlock_mmap_for_io() is carefully checking this. There are callers
(most notably some get_user_pages() users) that don't set
FAULT_FLAG_ALLOW_RETRY so the escape through VM_FAULT_RETRY is sadly not a
reliable solution.

My long-term wish is we were always allowed to use VM_FAULT_RETRY and that
was actually what motivated some get_user_pages() cleanups I did couple
years ago. But dealing with all the cases in various drivers was too
difficult and I've run out of time. Now maybe it would be worth it to
revisit this since things have changed noticeably and maybe now it would be
easier to achive the goal...

								Honza

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 537803250ca9..e044c11c9cf6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -6056,15 +6056,36 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>      if (unlikely(IS_IMMUTABLE(inode)))
>          return VM_FAULT_SIGBUS;
> 
> +    /*
> +     * The ext4 writeback code does not expect dirty page for a file with
> +     * inline data, so inline data needs to be converted. But it needs to
> +     * hold the inode_lock when converting, and trying to lock the inode
> +     * while holding the mmap_lock may result in an ABBA deadlock. So here
> +     * we release the mmap_lock for conversion and retry after conversion.
> +     * Only one retry is allowed to avoid endless loops.
> +     * Acquire xattr_sem to avoid race with inline data conversion.
> +     */
> +    down_read(&EXT4_I(inode)->xattr_sem);
> +    if (ext4_has_inline_data(inode)) {
> +        up_read(&EXT4_I(inode)->xattr_sem);
> +
> +        if (!fault_flag_allow_retry_first(vmf->flags))
> +            return VM_FAULT_SIGBUS;
> +
> +        release_fault_lock(vmf);
> +
> +        inode_lock(inode);
> +        ext4_convert_inline_data(inode);
> +        inode_unlock(inode);
> +        return VM_FAULT_RETRY;
> +    }
> +    up_read(&EXT4_I(inode)->xattr_sem);
> +
>      sb_start_pagefault(inode->i_sb);
>      file_update_time(vma->vm_file);
> 
>      filemap_invalidate_lock_shared(mapping);
> 
> -    err = ext4_convert_inline_data(inode);
> -    if (err)
> -        goto out_ret;
> -
>      /*
>       * On data journalling we skip straight to the transaction handle:
>       * there's no delalloc; page truncated will be checked later; the
> 
> -- 
> With Best Regards,
> Baokun Li
> .
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

