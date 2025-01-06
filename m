Return-Path: <linux-ext4+bounces-5898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5220A02810
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FD8161A58
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF761DE89E;
	Mon,  6 Jan 2025 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l9vt6jKe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="esCQmfph";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l9vt6jKe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="esCQmfph"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE41E487;
	Mon,  6 Jan 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736173952; cv=none; b=qP8qekLUfg3y+wICQYLyErdGPTuZEIxj/xE3aNx1iW7oRwExGNWHRBtFDEvq1U/ck8MRowshgvV31N8rR0I+lHMeOgy9Z5xXlGhKW01Squur2ZwJ8V+0yOoMntC7cAe5UTLqB0nAVY2+QRp5nFB2W3i6O8kVicFNfo7AsXg9hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736173952; c=relaxed/simple;
	bh=QrrOB2f73BsrnS2G30s7ADYvbEI1qiLnrQ6OySzBEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENE5kDhxs8bXzoGonaYwdcxqGt+mRw0INaH5wIe8EKm1uNKY793IoI4YjvGfdiZAPuUocJLY9phT83KDH0TYsWjHwYIXnupD6DFv8s4dm/aDZoKOzm0etAXgQX42sPxsvY6b+AvdcEBHQU1JAIiOXJ3aVDum4zql8oE2kCVebr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l9vt6jKe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=esCQmfph; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l9vt6jKe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=esCQmfph; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CEDF21163;
	Mon,  6 Jan 2025 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736173948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBNwz4doWhKuALPyF+u85rmGJ1HtQTNVvzD4E906yrA=;
	b=l9vt6jKeUmudqEf/zJfMpyLOm8hJ5s34tpIoXDTND1KL8RLsLRb/MRI0Udsbyc1MWJ13zu
	eh38w1tz89Xf+sXbwrodXugl1pq3dKmUKEOXbo2j3eTnZT03focAEJjaOvyxdEBRNHdZGO
	194en2Gkqun8it+zH4O940+oPaLVNik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736173948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBNwz4doWhKuALPyF+u85rmGJ1HtQTNVvzD4E906yrA=;
	b=esCQmfphv3ugI8i2ts7akneBOaONH81482AUbRGvxDhb51a2bWbfFtc8JcWB+frApUQ/T0
	syE12lZEEowhdNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736173948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBNwz4doWhKuALPyF+u85rmGJ1HtQTNVvzD4E906yrA=;
	b=l9vt6jKeUmudqEf/zJfMpyLOm8hJ5s34tpIoXDTND1KL8RLsLRb/MRI0Udsbyc1MWJ13zu
	eh38w1tz89Xf+sXbwrodXugl1pq3dKmUKEOXbo2j3eTnZT03focAEJjaOvyxdEBRNHdZGO
	194en2Gkqun8it+zH4O940+oPaLVNik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736173948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBNwz4doWhKuALPyF+u85rmGJ1HtQTNVvzD4E906yrA=;
	b=esCQmfphv3ugI8i2ts7akneBOaONH81482AUbRGvxDhb51a2bWbfFtc8JcWB+frApUQ/T0
	syE12lZEEowhdNCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5094C137DA;
	Mon,  6 Jan 2025 14:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sYScE3zpe2cuOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 14:32:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03376A0924; Mon,  6 Jan 2025 15:32:27 +0100 (CET)
Date: Mon, 6 Jan 2025 15:32:27 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 3/5] ext4: abort journal on data writeback failure if in
 data_err=abort mode
Message-ID: <zdn3gam6vhbbo2abj2n4ij6mpflqlrkon6ho67md6aze5ycfhk@in5hdqq2n3ic>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-4-libaokun@huaweicloud.com>
 <20241220103617.xkqmwkmk5inlq3dz@quack3>
 <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
X-Spam-Score: -3.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hello!

On Fri 20-12-24 21:39:39, Baokun Li wrote:
> On 2024/12/20 18:36, Jan Kara wrote:
> > On Fri 20-12-24 14:07:55, libaokun@huaweicloud.com wrote:
> > > From: Baokun Li <libaokun1@huawei.com>
> > > 
> > > If we mount an ext4 fs with data_err=abort option, it should abort on
> > > file data write error. But if the extent is unwritten, we won't add a
> > > JI_WAIT_DATA bit to the inode, so jbd2 won't wait for the inode's data
> > > to be written back and check the inode mapping for errors. The data
> > > writeback failures are not sensed unless the log is watched or fsync
> > > is called.
> > > 
> > > Therefore, when data_err=abort is enabled, the journal is aborted when
> > > an I/O error is detected in ext4_end_io_end() to make users who are
> > > concerned about the contents of the file happy.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> 
> Thank you for your review and feedback!
> > I'm not opposed to this change but I think we should better define the
> > expectations around data_err=abort.
> Totally agree, the definition of this option is a bit vague right now.
> It's semantics have changed implicitly with iterations of the version.
> 
> Originally in v2.6.28-rc1 commit 5bf5683a33f3 (“ext4: add an option to
> control error handling on file data”) introduced “data_err=abort”, the
> implementation of this mount option relies on JBD2_ABORT_ON_ SYNCDATA_ERR,
> and this flag takes effect when the journal_finish_inode_data_buffers()
> function returns an error. At this point in ext4_write_end(), in ordered
> mode, we add the inode to the ordered data list, whether it is an append
> write or an overwrite write. Therefore all write failures in ordered mode
> will abort the journal. This is also the semantics in the documentation
> - “Abort the journal if an error occurs in a file data buffer in ordered
> mode.”.

Well, that is not quite true. Normally, we run in delalloc mode and use
ext4_da_write_end() to finish writes. Thus normally inode was not added to
the transaction's list of inodes to flush (since 3.8 where this behavior
got implemented by commit f3b59291a69d ("ext4: remove calls to
ext4_jbd2_file_inode() from delalloc write path")). Then the commit
06bd3c36a733 (“ext4: fix data exposure after a crash”) in 4.7 realized this
is broken and fixed things to properly flush blocks when needed.

Actually the data=ordered mode always guaranteed we will not expose stale
data but never guaranteed all the written data will be flushed. Thus
data_err=abort always controlled "what should jbd2 do when it spots error
when flushing data" rather than any kind of guarantee that IO error on any
data writeback results in filesystem abort. After all page writeback can
easily try to flush the data before a transaction commit and hit IO error
and jbd2 then won't notice the problem (the page will be clean already) and
it was always like that.

> > For example the dependency on
> > data=ordered is kind of strange and the current semantics of data_err=abort
> > are hard to understand for admins (since they are mostly implementation
> > defined). For example if IO error happens on data overwrites, the
> > filesystem will not be aborted because we don't bother tracking such data
> > as ordered (for performance reasons). Since you've apparently talked to people
> > using this option: What are their expectations about the option?
>
> As was the original intent of introducing "data_err=abort", users who
> use this option are concerned about corruption of critical data spreading
> silently, that is, they are concerned that the data actually read does
> not match the data written.

OK, so you really want any write IO error to result in filesystem abort?
Both page writeback and direct IO writes?
 
> But as you said, we don't track overwrite writes for performance reasons.
> But compared to the poor performance of journal_data and the risk of the
> drop cache exposing stale, not being able to sense data errors on overwrite
> writes is acceptable.
> 
> After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
> or remount, the user will not see the unexpected all-zero data in the
> unwritten area, but rather the earlier consistent data, and the data in
> the file is trustworthy, at the cost of some trailing data.
> 
> On the other hand, adding a new written extents and converting an
> unwritten extents to written both expose the data to the user, so the user
> is concerned about whether the data is correct at that point.
> 
> In general, I think we can update the semantics of “data_err=abort” to,
> “Abort the journal if the file fails to write back data on extended writes
> in ORDERED mode”. Do you have any thoughts on this?

I agree it makes sense to make the semantics of data_err=abort more
obvious. Based on the usecase you've described - i.e., rather take the
filesystem down on write IO error than risk returning old data later - it
would make sense to me to also do this on direct IO writes. Also I would do
this regardless of data=writeback/ordered/journalled mode because although
users wanting data_err=abort behavior will also likely want the guarantees
of data=ordered mode, these are two different things and I can imagine use
cases for setups with data=writeback and data_err=abort as well (e.g. for
scratch filesystems which get recreated on each system startup).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

