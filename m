Return-Path: <linux-ext4+bounces-14482-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJUQAX6jpmkcSQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14482-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 10:01:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A90101EB5E2
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 10:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA245301BD65
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FD4374E7E;
	Tue,  3 Mar 2026 09:01:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E771019ADB0
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528491; cv=none; b=AiDyuO012yPaCz1ftKB/1XPV/V/Z+cVNGi+j+pSPgsLR/5Fe4xtBECb/IC1Buj0ghDRWdHvrQ6v9bZrh7Qt87bOvflbDlZTtS9gjgnQHBhuT3CCWxg+mR5aVhsTudvhpQ2aeJ9rW+JMKGReBdXOL6UPcqJ8HsKPEm2wWC1VKFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528491; c=relaxed/simple;
	bh=SqolDP/2cxY+C4DHde1HJANDsmEu2pVj+cipWx3TG6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8UnL+CvHnm7njWgmrWwlcyuUbViTuBrSXkCJR5rvsiG597Snzzn/obQ4ZX+zxjiDhKTpZKSRIzmLac7dO7lF8uL0OK8MlpJeZJ3V9n/ToF3Q0JGskGQg4Hnr+8xM8o125Ljx27P7G2KLvrUx7+fTdbiZm9K3RvfPb+EfK9VwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E0BA5BDEA;
	Tue,  3 Mar 2026 09:01:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54F793EA69;
	Tue,  3 Mar 2026 09:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dqu4FGijpmnVLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 09:01:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10A80A0A1B; Tue,  3 Mar 2026 10:01:28 +0100 (CET)
Date: Tue, 3 Mar 2026 10:01:28 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Mark Fasheh <mark@fasheh.com>, linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] jbd2: store jinode dirty range in PAGE_SIZE units
Message-ID: <jekg3rqfscaashwrnzisjjwpcyep2d4w6niyiahcastic4gmcz@3lgz3oqsfavk>
References: <20260224092434.202122-1-me@linux.beauty>
 <20260224092434.202122-5-me@linux.beauty>
 <6oexp6kpanvquzjn3nnqqg6wyyhh6og7jjb7fitlj7vzlj5vzp@cobcxovcgzg5>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6oexp6kpanvquzjn3nnqqg6wyyhh6og7jjb7fitlj7vzlj5vzp@cobcxovcgzg5>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: A90101EB5E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[me.linux.beauty:server fail];
	TAGGED_FROM(0.00)[bounces-14482-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.831];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon 02-03-26 19:27:13, Jan Kara wrote:
> On Tue 24-02-26 17:24:33, Li Chen wrote:
> > jbd2_inode fields are updated under journal->j_list_lock, but some paths
> > read them without holding the lock (e.g. fast commit helpers and ordered
> > truncate helpers).
> > 
> > READ_ONCE() alone is not sufficient for the dirty range fields when they
> > are stored as loff_t because 32-bit platforms can observe torn loads.
> > Store the dirty range in PAGE_SIZE units as pgoff_t instead.
> > 
> > Use READ_ONCE() on the read side and WRITE_ONCE() on the write side for the
> > dirty range and i_flags to match the existing lockless access pattern.
> > 
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Li Chen <me@linux.beauty>
> ...
> > @@ -2654,15 +2655,20 @@ static int jbd2_journal_file_inode(handle_t *handle, struct jbd2_inode *jinode,
> >  	jbd2_debug(4, "Adding inode %lu, tid:%d\n", jinode->i_vfs_inode->i_ino,
> >  			transaction->t_tid);
> >  
> > +	start_page = (pgoff_t)(start_byte >> PAGE_SHIFT);
> > +	end_page = (pgoff_t)(end_byte >> PAGE_SHIFT);
> 
> MAX_LFS_SIZE on 32-bit is ULONG_MAX << PAGE_SHIFT and that's maximum file
> size. So we could do here end_page = DIV_ROUND_UP(end_byte, PAGE_SIZE) and
> just use end_page as exclusive end of a range to flush and get rid of
> special JBD2_INODE_DIRTY_RANGE_NONE value.
> 
> The problem with the scheme you use is that files of MAX_LFS_SIZE would be
> treated as having empty flush range...

Or perhaps even easier might be to set start_page to ULONG_MAX and end_page
to 0 and use start_page > end_page as an indication of empty range.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

