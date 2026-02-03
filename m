Return-Path: <linux-ext4+bounces-13511-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM3XCkoLgmmCOQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13511-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 15:50:50 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 95426DACD9
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Feb 2026 15:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71D5B3063B92
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Feb 2026 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5833A1CF4;
	Tue,  3 Feb 2026 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDgRFGqX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Yny2qzQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDgRFGqX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Yny2qzQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231F1E487
	for <linux-ext4@vger.kernel.org>; Tue,  3 Feb 2026 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130247; cv=none; b=oeajLJdOrLpTUTdwzi6LRi8J8j/jLPbJnK77as2CQMxaSsQOQbUXDHNgU+9zBWhJksnFZrPCarcixRqDNyfAa9PiNMDLjy+1CMyPRvrCm//q1MqkFHleiwAi3hba3TMMPe/CZrqtdrj8D0rgw27FzypJnrEg5Y31G7ITPgHf9BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130247; c=relaxed/simple;
	bh=pH7aguUyl752/wAdz0ZJ60xBADwB0yyPS+Lqpl9dO/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTydoCxmewf20CHfshg2HzMAw6nPYvDj2Fm+pS9H6wlsuQ5QfhJEU5dr22w2DxgVR5jEqfPdKZ3JItbZrriNvW2DuEIichPh/cPfJ0xVwwPENEVvlY/9mFJ3kt9nfHaLUQBKdCqzHZtE/C2kKCP8+tpHPa8Tjlf2jO+Wicca1xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDgRFGqX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Yny2qzQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tDgRFGqX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Yny2qzQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 933DE5BCC6;
	Tue,  3 Feb 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770130243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERkrjzuQK7Aa/7UCcxP4OZ4zW+9Awu+eZyIVuFg7Mwc=;
	b=tDgRFGqX0S8pyUOfoM2PpFSS98TXM35RwqOSJxlvLvxGxBYqHyYIBt6nENl+ohM+C8gG6K
	9LwM0ABDAe2+Qi0crt2g6fyqZGE26w1gZUx8Ry5u3mXxEQafqXT2DjVu7i1HAo3BwGjGwp
	p7bumf0bFDxgSxNIJUmYCqVUFxMsodo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770130243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERkrjzuQK7Aa/7UCcxP4OZ4zW+9Awu+eZyIVuFg7Mwc=;
	b=2Yny2qzQuHXFbqxZYy7cDo8wIRmVHVatiNar7z9erKeMhzE5bWZcxzOvvyhXliAHadMbuG
	sufK+tsWlBVhY9DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tDgRFGqX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Yny2qzQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770130243; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERkrjzuQK7Aa/7UCcxP4OZ4zW+9Awu+eZyIVuFg7Mwc=;
	b=tDgRFGqX0S8pyUOfoM2PpFSS98TXM35RwqOSJxlvLvxGxBYqHyYIBt6nENl+ohM+C8gG6K
	9LwM0ABDAe2+Qi0crt2g6fyqZGE26w1gZUx8Ry5u3mXxEQafqXT2DjVu7i1HAo3BwGjGwp
	p7bumf0bFDxgSxNIJUmYCqVUFxMsodo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770130243;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERkrjzuQK7Aa/7UCcxP4OZ4zW+9Awu+eZyIVuFg7Mwc=;
	b=2Yny2qzQuHXFbqxZYy7cDo8wIRmVHVatiNar7z9erKeMhzE5bWZcxzOvvyhXliAHadMbuG
	sufK+tsWlBVhY9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DD063EA62;
	Tue,  3 Feb 2026 14:50:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vs+4HkMLgmmiDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 14:50:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 347DBA09E1; Tue,  3 Feb 2026 15:50:43 +0100 (CET)
Date: Tue, 3 Feb 2026 15:50:43 +0100
From: Jan Kara <jack@suse.cz>
To: Gerald Yang <gerald.yang@canonical.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, gerald.yang.tw@gmail.com
Subject: Re: [PATCH] ext4: Fix call trace when remounting to read only in
 data=journal mode
Message-ID: <gluj62pw5pu7ag2juf5ejwsr3ghvckag7wh4zunwyk57slcrmg@42of57gybigz>
References: <20260128074515.2028982-1-gerald.yang@canonical.com>
 <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
 <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
 <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
 <CAMsNC+ve3dRwT1xGWB0pvBJXqBpeksf7PgbEeihcnfs=AmwVRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMsNC+ve3dRwT1xGWB0pvBJXqBpeksf7PgbEeihcnfs=AmwVRQ@mail.gmail.com>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13511-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,mit.edu,dilger.ca,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 95426DACD9
X-Rspamd-Action: no action

Hello,

On Fri 30-01-26 19:38:55, Gerald Yang wrote:
> Thanks for sharing the findings, I'd also like to share some findings:
> I tried to figure out why the buffer is dirty after calling sync_filesystem,
> in mpage_prepare_extent_to_map, first I printed folio_test_dirty(folio):
> 
> while (index <= end)
>     ...
>     for (i = 0; i < nr_folios; i++) {
>         ...
>         (print if folio is dirty here)
> 
> and actually all folios are clean:
> if (!folio_test_dirty(folio) ||
>     ...
>     folio_unlock(folio);
>     continue;       <==== continue here without writing anything
> 
> Because the call trace happens before going into the above while loop:
> 
> if (ext4_should_journal_data(mpd->inode)) {
>     handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
> 
> it checks if the file system is read only and dumps the call trace in
> ext4_journal_check_start, but it doesn't check if there are any real writes
> that will happen later in the loop.
> 
> To confirm this, first I added 2 more lines in the reproduce script before
> remounting read only:
> sync      <==== it calls ext4_sync_fs to flush all dirty data same as what's
>                          called during remount read only
> echo 1 > /proc/sys/vm/drop_caches       <==== drop clean page cache
> mount -o remount,ro ext4disk mnt
> 
> Then I can no longer reproduce the call trace.

OK, but ext4_do_writepages() has a check at the beginning:

        if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
                goto out_writepages;

So if there are no dirty pages, mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)
should be false and so we shouldn't go further?

It all looks like some kind of a race because I'm not always able to
reproduce the problem... I'll try to look more into this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

