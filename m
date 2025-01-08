Return-Path: <linux-ext4+bounces-5985-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DBDA0601A
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E993A3FC9
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB11FE451;
	Wed,  8 Jan 2025 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DZcAGp9t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QVDNxzt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DZcAGp9t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QVDNxzt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EA1FDE2E;
	Wed,  8 Jan 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350096; cv=none; b=jYMd7AOCF6IUdDpjWD91qXSbKXSFnQJqMWjwgp0QbrwwBZDOdq9UMSsO6LmtbFWSwDERLhan8VcedCJJP1SQvdkF3DL7nj/yOko1Vw/gLfX8F2fDxMcdRwKAFeccKibF1bORjqzKsrBWr5V5b0OU7m/7v6P6fo5H06zIzDkVB58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350096; c=relaxed/simple;
	bh=h08dl22TTmniblgjVcZxptBiVgDMxFyGMkegBBO0kMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KieXEx5M5m3/Fc1hhqZwdm9Yf1m/XAfehf+Z+pjxV60d8yaJ4NrKsJA/wJx7LaboAeN4KfgAjTc2vLuweBnBzRouFWhckU0xFPkGaVwKvx2yM0kUQhw+9Zb8IflNUZWRb2XQXCvmT9P8y2u+mwRaE73jmGccXIxOWLqEQGVHEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DZcAGp9t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QVDNxzt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DZcAGp9t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QVDNxzt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEE97210FB;
	Wed,  8 Jan 2025 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736350091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64TCXlsHK6BohCTr7angBy/qd0ylOTGX8h9TOt5oEXk=;
	b=DZcAGp9tSzEVQroSVDsget+0I4QnJdv6Off3on2TMeqse3fc95nqr4CBtnppuUWTZuiB6r
	2Yb5stO1mcdewT1L6PLIgZZGZnGyIk5s9MmSSK0Yoeb7oJR3z2rW8gWxrQW8CaCFlrpc9Q
	cCHlvclxXWvYDtZnDw7/J2VwFwjA6Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736350091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64TCXlsHK6BohCTr7angBy/qd0ylOTGX8h9TOt5oEXk=;
	b=0QVDNxztPqm0XRyxCJ2h9ySWWkcbh0fIqZw/2oAnRUcfL7A6nrkLx1h/ylE+HC8JrYf/+D
	7/y3loQw0EF5f/CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736350091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64TCXlsHK6BohCTr7angBy/qd0ylOTGX8h9TOt5oEXk=;
	b=DZcAGp9tSzEVQroSVDsget+0I4QnJdv6Off3on2TMeqse3fc95nqr4CBtnppuUWTZuiB6r
	2Yb5stO1mcdewT1L6PLIgZZGZnGyIk5s9MmSSK0Yoeb7oJR3z2rW8gWxrQW8CaCFlrpc9Q
	cCHlvclxXWvYDtZnDw7/J2VwFwjA6Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736350091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=64TCXlsHK6BohCTr7angBy/qd0ylOTGX8h9TOt5oEXk=;
	b=0QVDNxztPqm0XRyxCJ2h9ySWWkcbh0fIqZw/2oAnRUcfL7A6nrkLx1h/ylE+HC8JrYf/+D
	7/y3loQw0EF5f/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A47BA137DA;
	Wed,  8 Jan 2025 15:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EH4jKIuZfmelXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Jan 2025 15:28:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B9F9A0889; Wed,  8 Jan 2025 16:28:11 +0100 (CET)
Date: Wed, 8 Jan 2025 16:28:11 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH 3/5] ext4: abort journal on data writeback failure if in
 data_err=abort mode
Message-ID: <dxjefcbxm2essvlxvheecpmeit56qdh6trruhxicho7qcs3kjk@s7mhqwhuej7m>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
 <20241220060757.1781418-4-libaokun@huaweicloud.com>
 <20241220103617.xkqmwkmk5inlq3dz@quack3>
 <47a46888-064f-4c7d-a554-30ba49c45bab@huawei.com>
 <zdn3gam6vhbbo2abj2n4ij6mpflqlrkon6ho67md6aze5ycfhk@in5hdqq2n3ic>
 <cbbce761-4f58-492f-a5b0-dee22391d24a@huawei.com>
 <dfoxg4aaolu6wknvh4644acbo3pvbtacwiztianjaol7zuf7vb@hbb7x2zitvwf>
 <0820379d-7ed2-4aff-a243-0c92957331a6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0820379d-7ed2-4aff-a243-0c92957331a6@huawei.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 08-01-25 22:44:42, Baokun Li wrote:
> On 2025/1/8 21:43, Jan Kara wrote:
> > On Wed 08-01-25 11:43:08, Baokun Li wrote:
> > > On 2025/1/6 22:32, Jan Kara wrote:
> > > > > But as you said, we don't track overwrite writes for performance reasons.
> > > > > But compared to the poor performance of journal_data and the risk of the
> > > > > drop cache exposing stale, not being able to sense data errors on overwrite
> > > > > writes is acceptable.
> > > > > 
> > > > > After enabling ‘data_err=abort’ in dioread_nolock mode, after drop_cache
> > > > > or remount, the user will not see the unexpected all-zero data in the
> > > > > unwritten area, but rather the earlier consistent data, and the data in
> > > > > the file is trustworthy, at the cost of some trailing data.
> > > > > 
> > > > > On the other hand, adding a new written extents and converting an
> > > > > unwritten extents to written both expose the data to the user, so the user
> > > > > is concerned about whether the data is correct at that point.
> > > > > 
> > > > > In general, I think we can update the semantics of “data_err=abort” to,
> > > > > “Abort the journal if the file fails to write back data on extended writes
> > > > > in ORDERED mode”. Do you have any thoughts on this?
> > > > I agree it makes sense to make the semantics of data_err=abort more
> > > > obvious. Based on the usecase you've described - i.e., rather take the
> > > > filesystem down on write IO error than risk returning old data later - it
> > > > would make sense to me to also do this on direct IO writes.
> > > Okay, I will update the semantics of data_err=abort in the next version.
> > > For direct I/O writes, I think we don't need it because users can
> > > perceive errors in time.
> > So I agree that direct IO users will generally notice the IO error so the
> > chances for bugs due to missing the IO error is low. But I think the
> > question is really the other way around: Is there a good reason to make
> > direct IO writes different? Because if I as a sysadmin want to secure a
> > system from IO error handling bugs, then having to think whether some
> > application uses direct IO or not is another nuissance. Why should I be
> > bothered?
> This is not quite right. Regardless of whether it is a BIO write or a DIO
> write, users will check the return value of the write operation, because
> errors can occur not only when data is written to disk.

Yes, they *should* check the return value of write(2) and take appropriate
action. But do all of them check and mainly do they do something meaningful
with the error? That's what I'm not so sure about :).

> It's just that when a DIO write returns successfully, users can be sure
> that the data has been written to the disk.
> 
> However, when a BIO write returns successfully, it only means that the
> data has been copied into the buffer. Whether it has been successfully
> written back to the disk is unknown to the user.
> 
> That's why we need data_err=abort to ensure that users are aware when the
> page writeback fails and to prevent data corruption from spreading.

I understand including DIO need not be interesting for your usecase but I
still think it may be more consistent overall decision. But perhaps I'll
ask Ted what he thinks about it.

> > > >    Also I would do
> > > > this regardless of data=writeback/ordered/journalled mode because although
> > > > users wanting data_err=abort behavior will also likely want the guarantees
> > > > of data=ordered mode, these are two different things
> > > For data=journal mode, the journal itself will abort when data is abnormal.
> > > However, as you pointed out, the above bug may cause errors to be missed.
> > > Therefore, we can perform this check by default for journaled files.
> > > > and I can imagine use
> > > > cases for setups with data=writeback and data_err=abort as well (e.g. for
> > > > scratch filesystems which get recreated on each system startup).
> > > Users using data=writeback often do not care about data consistency.
> > > I did not understand your example. Could you please explain it in detail?
> > Well, they don't care about data consistency after a crash. But they
> > usually do care about data consistency while the system is running. And
> > unhandled IO errors can lead to data consistency problems without crashing
> > the system (for example if writeback fails and page gets evicted from
> > memory later, you have lost the new data and may see old version of it).
> I see your point. I concur that it is indeed meaningful for
> data_err=abort to be supported in data=writeback mode.
> 
> Thank you for your explanation!
> > And I see data_err=abort as a way to say: "I don't trust my applications to
> > handle IO errors well. Rather take the filesystem down in that case than
> > risk data consistency issues".
> > 
> > 								Honza
> 
> I still prefer to think of this as a supplement for users not being able
> to perceive page writeback in a timely manner. The fsync operation is
> complex, requires frequent waiting, and may have omissions.

I agree properly checking for errors from buffered writes is much more
painful.

> In addition, because ext4_end_bio() runs in interrupt context, we can't
> abort the journal directly there due to potential locking issues.
> 
> Instead, we now add write-back error checks and journal abortion logic
> to ext4_end_io_end(), which is called by a kworker during unwritten
> extent conversion.
> 
> Consequently, for modes that don't support unwritten extents (e.g.,
> nodelalloc, journal_data, see ext4_should_dioread_nolock()), only the
> check in journal_submit_data_buffers() will be effective. Should we
> call the kworker for all files in ext4_end_bio()?

So how I imagined this would work is that if we get error in ext4_end_bio()
and data_err=abort is set, we will queue work (probably stored in the
superblock) to abort the filesystem. Alternatively, a bit more generic
approach might be to store the error state in the io_end and implement
something like:

static bool ext4_io_end_need_defered_completion(ext4_io_end_t *io_end)
{
	return io_end->flag & (EXT4_IO_END_UNWRITTEN | EXT4_IO_END_ERROR);
}

and use it in ext4_end_bio() and ext4_put_io_end_defer() to determine
whether the io_end needs processing in the workqueue or not. And
ext4_put_io_end() can then abort the filesystem if EXT4_IO_END_ERROR is
set.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

