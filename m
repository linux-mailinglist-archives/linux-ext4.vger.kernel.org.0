Return-Path: <linux-ext4+bounces-8740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF0AEF79C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 14:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA9F175527
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 12:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2492741D6;
	Tue,  1 Jul 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OoBENp7n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPXZg+2O";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OoBENp7n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vPXZg+2O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C342741B0
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370829; cv=none; b=fZJbsBgHDQfihIvEPlRnrUvVVuzvgFIQo9o5NPU7ZZOsHCWYjuJIgal72vnpAqdPgCR7324laePv8pb6KxaYJFi8CYytw7BTfWm8jhUkJOUVnWXZWCc3xzY7NcW4G2t4bIFM5TCVTpQ51IWuH6jAyS1xKBMxcdOuvyryVdhPFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370829; c=relaxed/simple;
	bh=rjrY0UcfYzhGh3nptymPMyVZaoTcDeUStqnL3Fj+Oww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjDocDZsaPqDZtY0aZVfMEs/zqOHYgc8YXBh8Atosj5DZwjXumtbb8ushNJ0tpDrVQcWx30Z0NZp974MAZzTyEZqvtm/EIn+sENM+H/zeb+iGgk+jBBzh4u3oXfSc72+jDNRRzAxZUi4tqx1DKVPouL/tO+2NmSpM1bIEDN/MpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OoBENp7n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPXZg+2O; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OoBENp7n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vPXZg+2O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 238D81F393;
	Tue,  1 Jul 2025 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751370826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt9j52YdjlIgYtCP79xXhGZK0KZ5GBrDVyKMwfSQnOQ=;
	b=OoBENp7n9l+w/rbijUgz1E9cmGSgu2dTPy60vpbh7Hh2PFW7Zfu3Z2RE6cK3R3uRhmMWKn
	pJ+xnbLq8xYvo6DKwS7jGNojKgiwAR0kdssfaqAhIPsqKgwzU+pRZ7tyUgGCfbbgs4sqJt
	pze1s1+PQH2h0Y7RcLzZybJRBNUBqok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751370826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt9j52YdjlIgYtCP79xXhGZK0KZ5GBrDVyKMwfSQnOQ=;
	b=vPXZg+2OFrWHstzHqqLoVKKuFa2lYLsuPrqnbt5/S1TEACmVOrcDk7f8Qadn+V+Wd8PapO
	bvbdsduATi01lOAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751370826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt9j52YdjlIgYtCP79xXhGZK0KZ5GBrDVyKMwfSQnOQ=;
	b=OoBENp7n9l+w/rbijUgz1E9cmGSgu2dTPy60vpbh7Hh2PFW7Zfu3Z2RE6cK3R3uRhmMWKn
	pJ+xnbLq8xYvo6DKwS7jGNojKgiwAR0kdssfaqAhIPsqKgwzU+pRZ7tyUgGCfbbgs4sqJt
	pze1s1+PQH2h0Y7RcLzZybJRBNUBqok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751370826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gt9j52YdjlIgYtCP79xXhGZK0KZ5GBrDVyKMwfSQnOQ=;
	b=vPXZg+2OFrWHstzHqqLoVKKuFa2lYLsuPrqnbt5/S1TEACmVOrcDk7f8Qadn+V+Wd8PapO
	bvbdsduATi01lOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 176C11364B;
	Tue,  1 Jul 2025 11:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hOqxBUrMY2g0XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 11:53:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65800A0A23; Tue,  1 Jul 2025 13:53:45 +0200 (CEST)
Date: Tue, 1 Jul 2025 13:53:45 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 04/16] ext4: utilize multiple global goals to reduce
 contention
Message-ID: <36bqxyj7gbozrewg2vk5mbfa4vwetwrl4iyae4h47eb5mlcs4s@ms56slymlwn4>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-5-libaokun1@huawei.com>
 <xmhuzjcgujdvmgmnc3mfd45txehmq73fiyg32vr6h7ldznctlq@rosxe25scojb>
 <77077598-45d6-43dd-90a0-f3668a27ca15@huawei.com>
 <qtdxe2rmnvrxdjmp26ro4l5erwq5lrbvmvysxfgqddadnpr7x4@xrkrdjkgsh67>
 <4f15d0aa-39e0-42ef-a9ca-ddbb3ff36060@huawei.com>
 <trjf7lqckchx6bc3p4lwh5yy3bqczo6yvdll7ujguhvvezwtja@cpfhj6ai7gzp>
 <4cbb9bc3-617d-43f7-a1cd-9afbd864fc68@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbb9bc3-617d-43f7-a1cd-9afbd864fc68@huawei.com>
X-Spam-Flag: NO
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
X-Spam-Level: 

On Tue 01-07-25 11:32:23, Baokun Li wrote:
> On 2025/7/1 1:41, Jan Kara wrote:
> > On Mon 30-06-25 18:02:49, Baokun Li wrote:
> > > On 2025/6/30 16:38, Jan Kara wrote:
> > > > We could make streaming goal to be ext4_fsblk_t so that also offset of the
> > > > last big allocation in the group is recorded as I wrote above. That would
> > > > tend to pack big allocations in each group together which is benefitial to
> > > > combat fragmentation even with higher proportion of groups that are streaming
> > > > goals (and likely becomes more important as the blocksize and thus group
> > > > size grow). We can discuss proper number of slots for streaming allocation
> > > > (I'm not hung up on it being quarter of the group count) but I'm convinced
> > > > sb->s_groups_count is too much :)
> > > > 
> > > > 								Honza
> > > I think sbi->s_groups_count / 4 is indeed acceptable. However, I don't
> > > believe recording offsets is necessary. As groups become larger,
> > > contention for groups will intensify, and adding offsets would only
> > > make this contention worse.
> > I agree the contention for groups will increase when the group count goes
> > down. I just thought offsets may help to find free space faster in large
> > groups (and thus reduce contention) and also reduce free space
> > fragmentation within a group (by having higher chances of placing large
> > allocations close together within a group) but maybe that's not the case.
> > Offsets are definitely not requirement at this point.
> > 
> > 								Honza
> > 
> Thinking this over, with LBS support coming, if our block size jumps from
> 4KB to 64KB, the maximum group size will dramatically increase from 128MB
> to 32GB (even with the current 4GB group limit). If free space within a
> group gets heavily fragmented, iterating through that single group could
> become quite time-consuming.
> 
> Your idea of recording offsets to prevent redundant scanning of
> already-checked extents within a group definitely makes sense. But with
> reference to the idea of optimizing linear traversal of groups, I think it
> might be better to record the offset of the first occurrence of each order
> in the same way that bb_counters records the number of each order.

Yes, something like that makes sense. But I guess that's a material for the
next patch set :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

