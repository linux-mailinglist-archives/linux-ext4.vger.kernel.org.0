Return-Path: <linux-ext4+bounces-5983-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F745A05D16
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 14:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381767A25DE
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA961FC7C7;
	Wed,  8 Jan 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3b8SZcU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5ZzYVmD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r3b8SZcU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5ZzYVmD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB91FBE89;
	Wed,  8 Jan 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736343822; cv=none; b=Tx4ciIGPw4P9FD3vw1B3ZnOe5bDXtR3fbMUzagfTEVtuxIPOVudyI5cj6ZXGCOhLDnGFvT7mNc1370GhvDHgflfhdcXeqhk7JRG00OtcrxuaO2ffgUZv8viRdfzauNOr+/eR1PRpC/lqF1PLG4M8MTp2BpR27qUhH1mY1bEiStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736343822; c=relaxed/simple;
	bh=EVLQDmCfm/JJJWKtq5NcBMrDeulFj5QVEEcb0TJzzc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG86wrSK9N8Ox6lY4oPSremV6AugZRuuae0SQbTqpOkQFEg3m3IDWLcRchlGYbOzBUijkV64ZLXZbAHQYOgUSRC1WmePXb6vqHkhxOYdU9KdEvJdcpfREwceilalZl5LTrRjjBBRlxfq9age2OFNoR0blgeBJP+u7oBUehChjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3b8SZcU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5ZzYVmD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r3b8SZcU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5ZzYVmD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03A391F385;
	Wed,  8 Jan 2025 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736343813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDwyNawk+m6ljb+F1zaa1V1AQBOVjmrqKdNOQtQTzg=;
	b=r3b8SZcUJ9JMWzA+Av6kl3etvs7+1Nc3Ro+wTOuY89NqWCmtDaJhxZ9Tfr8t2iyhvKsyJ5
	mTMK7Rs98mGs1Z3pIeFgDgAND93Pc6UNXevIwTigkr6nRv9hYNstfOdIurgp2J18Zq0eRI
	rgP16irfGtepCUv4iyaKiE6vU7u3tQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736343813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDwyNawk+m6ljb+F1zaa1V1AQBOVjmrqKdNOQtQTzg=;
	b=f5ZzYVmD5sHigVx6/8UDRxDedf/K622+idl0B0AlMD2j4yB+yq7+LgFjDCQap42I5PVykI
	05FQpwOqLacu2/BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r3b8SZcU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f5ZzYVmD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736343813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDwyNawk+m6ljb+F1zaa1V1AQBOVjmrqKdNOQtQTzg=;
	b=r3b8SZcUJ9JMWzA+Av6kl3etvs7+1Nc3Ro+wTOuY89NqWCmtDaJhxZ9Tfr8t2iyhvKsyJ5
	mTMK7Rs98mGs1Z3pIeFgDgAND93Pc6UNXevIwTigkr6nRv9hYNstfOdIurgp2J18Zq0eRI
	rgP16irfGtepCUv4iyaKiE6vU7u3tQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736343813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WGDwyNawk+m6ljb+F1zaa1V1AQBOVjmrqKdNOQtQTzg=;
	b=f5ZzYVmD5sHigVx6/8UDRxDedf/K622+idl0B0AlMD2j4yB+yq7+LgFjDCQap42I5PVykI
	05FQpwOqLacu2/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7455137DA;
	Wed,  8 Jan 2025 13:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3ZoOASBfmdcOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Jan 2025 13:43:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8CE24A0889; Wed,  8 Jan 2025 14:43:17 +0100 (CET)
Date: Wed, 8 Jan 2025 14:43:17 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 3/5] ext4: abort journal on data writeback failure if in
 data_err=abort mode
Message-ID: <dfoxg4aaolu6wknvh4644acbo3pvbtacwiztianjaol7zuf7vb@hbb7x2zitvwf>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-4-libaokun@huaweicloud.com>
 <20241220103617.xkqmwkmk5inlq3dz@quack3>
 <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
 <zdn3gam6vhbbo2abj2n4ij6mpflqlrkon6ho67md6aze5ycfhk@in5hdqq2n3ic>
 <cbbce761-4f58-492f-a5b0-dee22391d24a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbbce761-4f58-492f-a5b0-dee22391d24a@huawei.com>
X-Rspamd-Queue-Id: 03A391F385
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 08-01-25 11:43:08, Baokun Li wrote:
> On 2025/1/6 22:32, Jan Kara wrote:
> > > But as you said, we don't track overwrite writes for performance reasons.
> > > But compared to the poor performance of journal_data and the risk of the
> > > drop cache exposing stale, not being able to sense data errors on overwrite
> > > writes is acceptable.
> > > 
> > > After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
> > > or remount, the user will not see the unexpected all-zero data in the
> > > unwritten area, but rather the earlier consistent data, and the data in
> > > the file is trustworthy, at the cost of some trailing data.
> > > 
> > > On the other hand, adding a new written extents and converting an
> > > unwritten extents to written both expose the data to the user, so the user
> > > is concerned about whether the data is correct at that point.
> > > 
> > > In general, I think we can update the semantics of “data_err=abort” to,
> > > “Abort the journal if the file fails to write back data on extended writes
> > > in ORDERED mode”. Do you have any thoughts on this?
> > I agree it makes sense to make the semantics of data_err=abort more
> > obvious. Based on the usecase you've described - i.e., rather take the
> > filesystem down on write IO error than risk returning old data later - it
> > would make sense to me to also do this on direct IO writes.
> 
> Okay, I will update the semantics of data_err=abort in the next version.
> For direct I/O writes, I think we don't need it because users can
> perceive errors in time.

So I agree that direct IO users will generally notice the IO error so the
chances for bugs due to missing the IO error is low. But I think the
question is really the other way around: Is there a good reason to make
direct IO writes different? Because if I as a sysadmin want to secure a
system from IO error handling bugs, then having to think whether some
application uses direct IO or not is another nuissance. Why should I be
bothered?

> >   Also I would do
> > this regardless of data=writeback/ordered/journalled mode because although
> > users wanting data_err=abort behavior will also likely want the guarantees
> > of data=ordered mode, these are two different things
> For data=journal mode, the journal itself will abort when data is abnormal.
> However, as you pointed out, the above bug may cause errors to be missed.
> Therefore, we can perform this check by default for journaled files.
> > and I can imagine use
> > cases for setups with data=writeback and data_err=abort as well (e.g. for
> > scratch filesystems which get recreated on each system startup).
> 
> Users using data=writeback often do not care about data consistency.
> I did not understand your example. Could you please explain it in detail?

Well, they don't care about data consistency after a crash. But they
usually do care about data consistency while the system is running. And
unhandled IO errors can lead to data consistency problems without crashing
the system (for example if writeback fails and page gets evicted from
memory later, you have lost the new data and may see old version of it).
And I see data_err=abort as a way to say: "I don't trust my applications to
handle IO errors well. Rather take the filesystem down in that case than
risk data consistency issues".

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

