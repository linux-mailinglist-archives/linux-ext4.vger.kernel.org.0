Return-Path: <linux-ext4+bounces-3318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B1934E90
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB201C21E06
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 13:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAB13E41D;
	Thu, 18 Jul 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5feDivd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHyKkc3b";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J5feDivd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WHyKkc3b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEDA80BEC;
	Thu, 18 Jul 2024 13:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310694; cv=none; b=uCrsPvSCOMuDvYh5WEg/TpX7EdrDh5mgftuuopSGymqO3Rwwmop9klTF46QYU2IHPLS1MkjGFpTJ/wEuzmPK6ePE1BaObfPnOpC/D6GwR4G4X6ANUkXZi9kivla7BaaICzAygSFahCII8qhgYQJq4T/AIml/skW7+uxcfIKe3Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310694; c=relaxed/simple;
	bh=RzuXx05ybI/R8AdT0EnwE/8jXJFlFVswWsOu2oN/k6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMfmQ9RvR5l27aVPi1gTJ1OQ9GSoN4PmdcNl7wwEmSy5sHMABK1V16TMav/LoHCfFVdwtPAk92ifErZ+Cx16plb2mecI9TpLvk64D5aq6Qy5P4zdK96cqwHX5hn66TvDwArhLVE41Hzpc5HjhJq0p9Nk/FBMreU6RKC28s3OSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5feDivd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHyKkc3b; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J5feDivd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WHyKkc3b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C23B1F399;
	Thu, 18 Jul 2024 13:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721310690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXaUhHZQgoxLB+eJAc5mN7DGCwGfrd46wc2sjHmdlIs=;
	b=J5feDivdzq5LshkQzWrhoPticDuojtnHoaxGvnjZn/VxJ0cqzpFW6bKfsGWJu5DbYTgPDQ
	MIeaAgwXaRlphMLfJRhlJtp58A5fKJoPJsNHBjEPiD7S72QRJPxSZa3dI3DLQYfiwDenRm
	+RG+mCH1DzQ81XTA2inZDqbzv9j+i5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721310690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXaUhHZQgoxLB+eJAc5mN7DGCwGfrd46wc2sjHmdlIs=;
	b=WHyKkc3besCWPd4+lPKZvtDLvlzubY73uwxdsB2SJKZgnbwzbOXFtB2oBNS9BCH5tK4wDU
	AJM48sQHVJWYpTCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721310690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXaUhHZQgoxLB+eJAc5mN7DGCwGfrd46wc2sjHmdlIs=;
	b=J5feDivdzq5LshkQzWrhoPticDuojtnHoaxGvnjZn/VxJ0cqzpFW6bKfsGWJu5DbYTgPDQ
	MIeaAgwXaRlphMLfJRhlJtp58A5fKJoPJsNHBjEPiD7S72QRJPxSZa3dI3DLQYfiwDenRm
	+RG+mCH1DzQ81XTA2inZDqbzv9j+i5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721310690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXaUhHZQgoxLB+eJAc5mN7DGCwGfrd46wc2sjHmdlIs=;
	b=WHyKkc3besCWPd4+lPKZvtDLvlzubY73uwxdsB2SJKZgnbwzbOXFtB2oBNS9BCH5tK4wDU
	AJM48sQHVJWYpTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 414411379D;
	Thu, 18 Jul 2024 13:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u3rpD+IdmWZRDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Jul 2024 13:51:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03182A0987; Thu, 18 Jul 2024 15:51:29 +0200 (CEST)
Date: Thu, 18 Jul 2024 15:51:29 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org
Subject: Re: [PATCH] jbd2: stop waiting for space when
 jbd2_cleanup_journal_tail() returns error
Message-ID: <20240718135129.jzhxdh5ejtwkqehr@quack3>
References: <20240718115336.2554501-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718115336.2554501-1-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 18-07-24 19:53:36, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In __jbd2_log_wait_for_space(), we might call jbd2_cleanup_journal_tail()
> to recover some journal space. But if an error occurs while executing
> jbd2_cleanup_journal_tail() (e.g., an EIO), we don't stop waiting for free
> space right away, we try other branches, and if j_committing_transaction
> is NULL (i.e., the tid is 0), we will get the following complain:
> 
> ============================================
> JBD2: I/O error when updating journal superblock for sdd-8.
> __jbd2_log_wait_for_space: needed 256 blocks and only had 217 space available
> __jbd2_log_wait_for_space: no way to get more journal space in sdd-8
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 139804 at fs/jbd2/checkpoint.c:109 __jbd2_log_wait_for_space+0x251/0x2e0
> Modules linked in:
> CPU: 2 PID: 139804 Comm: kworker/u8:3 Not tainted 6.6.0+ #1
> RIP: 0010:__jbd2_log_wait_for_space+0x251/0x2e0
> Call Trace:
>  <TASK>
>  add_transaction_credits+0x5d1/0x5e0
>  start_this_handle+0x1ef/0x6a0
>  jbd2__journal_start+0x18b/0x340
>  ext4_dirty_inode+0x5d/0xb0
>  __mark_inode_dirty+0xe4/0x5d0
>  generic_update_time+0x60/0x70
> [...]
> ============================================
> 
> So only if jbd2_cleanup_journal_tail() returns 1, i.e., there is nothing to
> clean up at the moment, continue to try to reclaim free space in other ways.
> 
> Note that this fix relies on commit 6f6a6fda2945 ("jbd2: fix ocfs2 corrupt
> when updating journal superblock fails") to make jbd2_cleanup_journal_tail
> return the correct error code.
> 
> Fixes: 8c3f25d8950c ("jbd2: don't give up looking for space so easily in __jbd2_log_wait_for_space")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 951f78634adf..7b593591273a 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -86,8 +86,11 @@ __releases(&journal->j_state_lock)
>  			write_unlock(&journal->j_state_lock);
>  			if (chkpt) {
>  				jbd2_log_do_checkpoint(journal);
> -			} else if (jbd2_cleanup_journal_tail(journal) == 0) {
> -				/* We were able to recover space; yay! */
> +			} else if (jbd2_cleanup_journal_tail(journal) <= 0) {
> +				/*
> +				 * We were able to recover space or the
> +				 * journal was aborted due to an error.
> +				 */
>  				;
>  			} else if (tid) {
>  				/*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

