Return-Path: <linux-ext4+bounces-5806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273E9F9059
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 11:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D425C1896D63
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0941C2DB4;
	Fri, 20 Dec 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FVDi45ii";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jHWaDDWW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XuK3g+Hw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MsuQdrm3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37319F116;
	Fri, 20 Dec 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734690984; cv=none; b=XtVLpXRySyerQScQO697PLwMh5PARXyRYaPxn8SEvGn1i/URbL7py26PsTyQrDDGgNOG7d5l4Y68+rLnTZJgWnYNxhwx4um8w1xHlNyYEN8AAF2IwIyuddBP5Hz/whoFqatjuTygRJeceKOI2BvgtwlMskq0uo1l+lmbnDs+1Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734690984; c=relaxed/simple;
	bh=znLBA08/M1oMhGNdvQ45s+Vf8uhsduRLeGK5bk6YVg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG9S7Jm0xe8uexNN+wj5laSba0kBcxtKVwKCTLRtHhv3cNvCqUevwrgFEM0eTpV72tUs14UuyfvVqrRjubDzufESqmuLPPY7zijttH5JD/jYKHilUVHblMBF+Nqscb2EiiJbd0xGexxcH7jCBrDPcQKlkTfSKDQIC1xcVDiBZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FVDi45ii; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jHWaDDWW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XuK3g+Hw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MsuQdrm3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 595341F365;
	Fri, 20 Dec 2024 10:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSWz0QM8ImJr82BppdarKUemeTPUc/jJJlQT5xSJt3Q=;
	b=FVDi45iishLoNtKkMLG2+dhGNI0wYf7V6FWzz6Vf98VguLPF983Vpa10j4JyjJ5T3i72pl
	sxKDZyUtGFzNKlsHnkOzHHxcj3MH++G+SvQiLWJaT+6P1mOqxxBwjgE8Pq6OoB2LwOHfYx
	fegvKHkytttxMNHxmjDx9GMiU2StUUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSWz0QM8ImJr82BppdarKUemeTPUc/jJJlQT5xSJt3Q=;
	b=jHWaDDWWgLBRkoQJISlJ+VVSgtjhbEGROwhfZvgaNV6AHTMXzCen86Ce5d0m9304KevKBv
	zIDDlfVUDDbZ2kBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XuK3g+Hw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MsuQdrm3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734690978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSWz0QM8ImJr82BppdarKUemeTPUc/jJJlQT5xSJt3Q=;
	b=XuK3g+Hwev9sUpMBSOBXwowY2TAdFgA5G4t9nvUR/Go4IkA1TfAWiWUB3Wp+QC4R7+5yy7
	sukMgA6cI6t4vyGqrL7uhSe+t+U7/AU+zASc9LHsjxu9Dbe/Ril6gfL65pdUirDRLzU3bF
	jh0UetWhJOo3P2XiAtfSbpVqjf6S9/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734690978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cSWz0QM8ImJr82BppdarKUemeTPUc/jJJlQT5xSJt3Q=;
	b=MsuQdrm3yZUP3ykExgR4xDmoRpWfBlWqBCE2XtTbhDWxv7VeKSHVX+4AciTs40IBJ7dGR6
	+f7NB6/CAx7ZlqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CDDA13A63;
	Fri, 20 Dec 2024 10:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fi3CEqJIZWeCCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Dec 2024 10:36:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0579EA08CF; Fri, 20 Dec 2024 11:36:17 +0100 (CET)
Date: Fri, 20 Dec 2024 11:36:17 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 3/5] ext4: abort journal on data writeback failure if in
 data_err=abort mode
Message-ID: <20241220103617.xkqmwkmk5inlq3dz@quack3>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-4-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220060757.1781418-4-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: 595341F365
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huawei.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 20-12-24 14:07:55, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> If we mount an ext4 fs with data_err=abort option, it should abort on
> file data write error. But if the extent is unwritten, we won't add a
> JI_WAIT_DATA bit to the inode, so jbd2 won't wait for the inode's data
> to be written back and check the inode mapping for errors. The data
> writeback failures are not sensed unless the log is watched or fsync
> is called.
> 
> Therefore, when data_err=abort is enabled, the journal is aborted when
> an I/O error is detected in ext4_end_io_end() to make users who are
> concerned about the contents of the file happy.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I'm not opposed to this change but I think we should better define the
expectations around data_err=abort. For example the dependency on
data=ordered is kind of strange and the current semantics of data_err=abort
are hard to understand for admins (since they are mostly implementation
defined). For example if IO error happens on data overwrites, the
filesystem will not be aborted because we don't bother tracking such data
as ordered (for performance reasons). Since you've apparently talked to people
using this option: What are their expectations about the option?

								Honza


> ---
>  fs/ext4/page-io.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 6054ec27fb48..058bf4660d7b 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -175,6 +175,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  {
>  	struct inode *inode = io_end->inode;
>  	handle_t *handle = io_end->handle;
> +	struct super_block *sb = inode->i_sb;
>  	int ret = 0;
>  
>  	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
> @@ -190,11 +191,15 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  		ret = -EIO;
>  		if (handle)
>  			jbd2_journal_free_reserved(handle);
> +		if (test_opt(sb, DATA_ERR_ABORT) &&
> +		    !ext4_is_quota_file(inode) &&
> +		    ext4_should_order_data(inode))
> +			jbd2_journal_abort(EXT4_SB(sb)->s_journal, ret);
>  	} else {
>  		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
>  	}
> -	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
> -		ext4_msg(inode->i_sb, KERN_EMERG,
> +	if (ret < 0 && !ext4_forced_shutdown(sb)) {
> +		ext4_msg(sb, KERN_EMERG,
>  			 "failed to convert unwritten extents to written "
>  			 "extents -- potential data loss!  "
>  			 "(inode %lu, error %d)", inode->i_ino, ret);
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

