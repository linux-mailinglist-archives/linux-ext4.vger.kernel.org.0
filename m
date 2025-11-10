Return-Path: <linux-ext4+bounces-11713-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B523C45C53
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036F23AC7F8
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCECC302CBF;
	Mon, 10 Nov 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jSAF2P+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iESxL7B0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jSAF2P+6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iESxL7B0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B267D302163
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768465; cv=none; b=PZnxaCiqgcYsR4Ki0CxYsrGHdBnN0ISCUFcDrWvwPfWYd/9oKzp9bKb7qShPYNnYasBCAS1bvlgAHX8sX8vYCMeHaJXg3+onQSG8PhmI7JRfRGkPiTLUnLg9R0ruKYl/W/CkoXl1YevCCyi22XvmZ1UNbzQOEfFObtFeDRue3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768465; c=relaxed/simple;
	bh=ZhWR3Wrkp+3Z1huRjqAI+OfnCH5SAft4JZ8yHhoE2E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z66FUF3v5XATU0eXqBmHPtpcu2ZJjaHg9+cnEs5ZaIrYj0IIDn7t/6jc5cuLGN1Rur20fiT9ZiHFbVv+e/Y6B3b7H+wT44Ei3C4VnjoOTDZ7WkDRBs/VL4KKmLPM7omm505ARX+UKFP9rULO484/mpc7vDLvpDsuoq2s5+78Ycw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jSAF2P+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iESxL7B0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jSAF2P+6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iESxL7B0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDFB71F397;
	Mon, 10 Nov 2025 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/+mK+newb7k/lcBeTy8j+deEzzj0M/xyHWaI/PHGk=;
	b=jSAF2P+6gq5LuyVFUSDCUKE6WXwE4sjQRbPEFdYJQM3aRhfphbjok3gesBk+UqstsbmjSQ
	p1gmTDTmieeg7KOuhoRg7YROnW7v5SRxTkDb8/5tdwWKU/fEALsPqbd9KaX9r6ekveUKbY
	5+OGNDfyAvfwhzPZ9Ss39lY0rl2pYsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/+mK+newb7k/lcBeTy8j+deEzzj0M/xyHWaI/PHGk=;
	b=iESxL7B0+NzKuRQj0uR794+ud+LXEIhsyfiR3Dy8G9tgkTcid2KL36Iun3fNkhkFYCsqvz
	JlIf2GiNrD3cNuDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jSAF2P+6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iESxL7B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762768461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/+mK+newb7k/lcBeTy8j+deEzzj0M/xyHWaI/PHGk=;
	b=jSAF2P+6gq5LuyVFUSDCUKE6WXwE4sjQRbPEFdYJQM3aRhfphbjok3gesBk+UqstsbmjSQ
	p1gmTDTmieeg7KOuhoRg7YROnW7v5SRxTkDb8/5tdwWKU/fEALsPqbd9KaX9r6ekveUKbY
	5+OGNDfyAvfwhzPZ9Ss39lY0rl2pYsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762768461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM/+mK+newb7k/lcBeTy8j+deEzzj0M/xyHWaI/PHGk=;
	b=iESxL7B0+NzKuRQj0uR794+ud+LXEIhsyfiR3Dy8G9tgkTcid2KL36Iun3fNkhkFYCsqvz
	JlIf2GiNrD3cNuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B19031431D;
	Mon, 10 Nov 2025 09:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZadVK022EWmcAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:54:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 689F4A28B1; Mon, 10 Nov 2025 10:54:21 +0100 (CET)
Date: Mon, 10 Nov 2025 10:54:21 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 22/24] ext4: support verifying data from large folios
 with fs-verity
Message-ID: <tyeh5ds2dezr4hrqxs46riwi3ps7ugwhcx46fqmpzarughiokz@q26eyruagm6v>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-23-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-23-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[huawei.com:email,suse.cz:dkim,huaweicloud.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: BDFB71F397
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Fri 07-11-25 22:42:47, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Eric Biggers already added support for verifying data from large folios
> several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
> data from large folios").
> 
> With ext4 now supporting large block sizes, the fs-verity tests
> `kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.
> 
> Therefore, remove the restriction and allow LBS to be enabled together
> with fs-verity.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice!

> @@ -5175,7 +5173,8 @@ void ext4_set_inode_mapping_order(struct inode *inode)
>  		return;
>  
>  	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
> -	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA))
> +	    ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) ||
> +	    ext4_has_feature_verity(inode->i_sb))
>  		max_order = EXT4_SB(inode->i_sb)->s_min_folio_order;
>  	else
>  		max_order = EXT4_MAX_PAGECACHE_ORDER(inode);

Is there a reason why fsverity needs the folio order to match the block
size? I didn't find any by a quick glance. If yes, please state it in
the changelog. If no, then I'd just use EXT4_MAX_PAGECACHE_ORDER() because
it will give us some performance e.g. for mmapped executables protected by
fsverify...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

