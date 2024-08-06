Return-Path: <linux-ext4+bounces-3642-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC859491C5
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BFC1C20DDA
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Aug 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2DA1D2F4C;
	Tue,  6 Aug 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="inoP7DaF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLy9YuYX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I3BOQiUx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IPr6ZZl9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68971C9EB2;
	Tue,  6 Aug 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951629; cv=none; b=Mjz46990kVVYXhYQ3d18ATL3LqYpXSnWcXxOMITqOoKuMYZ4Ila92hgg1VXRgolmCxRTEPPma1bBXKo9waihvK65qeHLvLpVQcLdDKcNLavXrJEmgUTADE9WZSnK2+PCO1lhs54p+WSimdqwFKbz0Fv2Ds0nW1k2GhzqCQrIKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951629; c=relaxed/simple;
	bh=L2lRD+ifAtj1ErWSRuGb2tmmFh7+d2PfbAYCS6+4V8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUyaFy7i7Qcnor9ZXHBMZO78kqb17qhPaguJjNTlZqY74k+B3ewtBycPvrVYovH9kVVjVNN11mJOVLSiEIC5g06VwVwOYcARvZg7TzgPravkgpqtPwzjTYB6M5w4uYiuAqbPEZiH+xnwOGEAIyeT9WpRIDSuRtnqo9sL+7MR/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=inoP7DaF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLy9YuYX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I3BOQiUx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IPr6ZZl9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1138F1FB47;
	Tue,  6 Aug 2024 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722951625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnTs3+DWE8G/JX7dW/n1r4wmWMOR57NvCPPAJDCIcds=;
	b=inoP7DaFXueiYZe5EqIUU5oM1uJxbGAMeA+q12+7jK5ouNvhhjm7jv6YCPDgLqoeepXtYJ
	ew5ebRncmYmm9pHJH5M0YIlKFOoBE0OCVmkBP7CD1bbD/XJrQYnkE+v85p69jK3sksXA9v
	/ipOtAaLHTLKVPnbOzk3/1z6HNqRXqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722951625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnTs3+DWE8G/JX7dW/n1r4wmWMOR57NvCPPAJDCIcds=;
	b=jLy9YuYX2xdqM/U2SLmFmLvJpfWS2G/6gMI0DPhvGQhSwAuVqOVM/bfD6Kh7b6fxwavxaP
	i6k6Uai42K9T33BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722951624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnTs3+DWE8G/JX7dW/n1r4wmWMOR57NvCPPAJDCIcds=;
	b=I3BOQiUxK43fdpawqbLcYJk33xlgDojEsg8h2flAoYKgjxKHcJg+Vo+eTLmAwHSkAKRzqD
	oKOGqYpq0j9d8sETyWu4bwhcFcmpPiNX+vWCm07hXIHl9+AP8K/5fRWzLAkPlCN9IayAfe
	XuwYfRVs6CCE40Ln2Bb5A+CRMd/Yvbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722951624;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnTs3+DWE8G/JX7dW/n1r4wmWMOR57NvCPPAJDCIcds=;
	b=IPr6ZZl9zhMZQtAAvVbKlHMawhsKq8MMQ9yIoZuQpoPqtJkC/1m8tDLiGzeiwIGqvBjVhK
	qDGPqG3lmh7tXJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0558B13981;
	Tue,  6 Aug 2024 13:40:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V21KAcgnsmZrSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Aug 2024 13:40:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A394DA0762; Tue,  6 Aug 2024 15:40:23 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:40:23 +0200
From: Jan Kara <jack@suse.cz>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [RFC PATCH] jbd2: fix a potential assertion failure due to
 improperly dirtied buffer
Message-ID: <20240806134023.rm2ggd7swopryqci@quack3>
References: <20240720062356.2522658-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240720062356.2522658-1-zhangshida@kylinos.cn>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,kylinos.cn:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

Hello!

On Sat 20-07-24 14:23:56, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> On an old kernel version(4.19, ext3, journal=data, pagesize=64k),
> an assertion failure will occasionally be triggered by the line below:

OK, just out of curiosity, why are you using data=journal mode? It doesn't
really get that much testing and the performance is quite bad...

> jbd2_journal_commit_transaction
> {
> ...
> J_ASSERT_BH(bh, !buffer_dirty(bh));
> /*
> * The buffer on BJ_Forget list and not jbddirty means
> ...
> }
> 
> AFAIC, that's how the problem works:
> --------
> journal_unmap_buffer
> jbd2_journal_invalidatepage
> __ext4_journalled_invalidatepage
> ext4_journalled_invalidatepage
> do_invalidatepage
> truncate_inode_pages_range
> truncate_inode_pages
> truncate_pagecache
> ext4_setattr
> --------
>
> First try to truncate and invalidate the page.
> Sometimes the buffer and the page won't be freed immediately.
> the buffer will be sent to the BJ_Forget list of the currently
> committing transaction. Maybe the transaction knows when and how
> to free the buffer better.
> The buffer's states now: !jbd_dirty !mapped !dirty
> 
> Then jbd2_journal_commit_transaction(）will try to iterate over the
> BJ_Forget list:
> --------
> jbd2_journal_commit_transaction()
> 	while (commit_transaction->t_forget) {
> 	...
> 	}
> --------
> 
> At this exact moment, another write comes:
> --------
> mark_buffer_dirty
> __block_write_begin_int
> __block_write_begin
> ext4_write_begin
> --------
> it sees a unmapped new buffer, and marks it as dirty.

This should not happen. When ext4_setattr() truncates the file, we do not
allow reallocating these blocks for other purposes until the transaction
commits. Did you find this using some tracing or just code analysis?

There have been quite some fixes to data=journal mode since 4.19 so it may
quite well be that your problem is actually already fixed in current
kernels...

								Honza

> Finally, jbd2_journal_commit_transaction(）will trip over the assertion
> during the BJ_Forget list iteration.
> 
> After an code analysis, it seems that nothing can prevent the
> __block_write_begin() from dirtying the buffer at this very moment.
> 
> The same condition may also be applied to the lattest kernel version.
> 
> To fix it:
> Add some checks to see if it is the case dirtied by __block_write_begin().
> if yes, it's okay and just let it go. The one who dirtied it and the
> jbd2_journal_commit_transaction() will know how to cooperate together and
> deal with it in a proper manner.
> if no, try to complain as we normally will do.
> 
> Reported-by: Baolin Liu <liubaolin@kylinos.cn>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/jbd2/commit.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 75ea4e9a5cab..2c13d0af92d8 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -1023,7 +1023,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>  			if (is_journal_aborted(journal))
>  				clear_buffer_jbddirty(bh);
>  		} else {
> -			J_ASSERT_BH(bh, !buffer_dirty(bh));
> +			bool try_to_complain = 1;
> +			struct folio *folio = NULL;
> +
> +			folio = bh->b_folio;
> +			/*
> +			 * Try not to complain about the dirty buffer marked dirty
> +			 * by __block_write_begin().
> +			 */
> +			if (buffer_dirty(bh) && folio && folio->mapping
> +			    && folio_test_locked(folio))
> +				try_to_complain = 0;
> +
> +			if (try_to_complain)
> +				J_ASSERT_BH(bh, !buffer_dirty(bh));
>  			/*
>  			 * The buffer on BJ_Forget list and not jbddirty means
>  			 * it has been freed by this transaction and hence it
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

