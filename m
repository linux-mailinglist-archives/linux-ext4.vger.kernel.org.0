Return-Path: <linux-ext4+bounces-8677-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3AFAEBEDC
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 20:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F27C3A93D7
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jun 2025 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0C92EACEE;
	Fri, 27 Jun 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YS++Qu2l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWlrRViq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YS++Qu2l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWlrRViq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31692D9780
	for <linux-ext4@vger.kernel.org>; Fri, 27 Jun 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047583; cv=none; b=a27z8Wq93fCPjRq40RY6cMzSm7ri+hV0EVbjjIS6A1ZwWguX15K733ZDo6ePO5jyLd8XoxQ/bpr+b5w5+uG0ZQL0I6vh71hH2KKub7O8kzUxhL4LKhQh/6POueDewicqTWqO3PrVxH8OO22nT0JtVRCNnawdP03JEG7MzRFO3/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047583; c=relaxed/simple;
	bh=k9acKslD9jPCw7632YWKm9wCcd9Ld1Vjx3/wu7Q35zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EverKr1z/w7NaoZsY9jfdlntn21Sm/ci5d8PD8bQ2TfbEzLIL4iI7LILi6xoebAI38bygrGpcINYVO3GviwIOAmCNMYjgUWlSwka60VPcmpWmD13kYevVS+MV6DYFiQm1cCbndMn3flxxACQv/X/oPliJSX3wAw4IQCOwP7/Obg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YS++Qu2l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWlrRViq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YS++Qu2l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWlrRViq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB0F02115E;
	Fri, 27 Jun 2025 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751047579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwrMu8yjl305hbt75EjtDwFEqcIyCVwfNcrY4BJDivE=;
	b=YS++Qu2l9d0l433QnUfUQp5efW6Qg8IQvbMUL1KH61ciMeueVhGdNLQuplaZfaHrSanXVZ
	nUhOztuUSNZLOMM9v8uec7yV7qvaCtt7HLeELy5PcfO0zunqjWDtj8xfqmduEnMBrsTF+g
	zJ+/IsG+Ek8o0Y0dEAgahsvpuoR0xIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751047579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwrMu8yjl305hbt75EjtDwFEqcIyCVwfNcrY4BJDivE=;
	b=wWlrRViqyfBpg6PIGTniamWH5/LT7oqD4dv6H6WzkMnFzEPWwcFblxfCk/W/r3JvdYwpE0
	UNXOOcpqxOTBEVDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751047579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwrMu8yjl305hbt75EjtDwFEqcIyCVwfNcrY4BJDivE=;
	b=YS++Qu2l9d0l433QnUfUQp5efW6Qg8IQvbMUL1KH61ciMeueVhGdNLQuplaZfaHrSanXVZ
	nUhOztuUSNZLOMM9v8uec7yV7qvaCtt7HLeELy5PcfO0zunqjWDtj8xfqmduEnMBrsTF+g
	zJ+/IsG+Ek8o0Y0dEAgahsvpuoR0xIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751047579;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iwrMu8yjl305hbt75EjtDwFEqcIyCVwfNcrY4BJDivE=;
	b=wWlrRViqyfBpg6PIGTniamWH5/LT7oqD4dv6H6WzkMnFzEPWwcFblxfCk/W/r3JvdYwpE0
	UNXOOcpqxOTBEVDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB34313786;
	Fri, 27 Jun 2025 18:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IA1vLZvdXmiDDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 18:06:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FC84A08D2; Fri, 27 Jun 2025 20:06:15 +0200 (CEST)
Date: Fri, 27 Jun 2025 20:06:15 +0200
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 01/16] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <bdrtjnhl6hdmevg42uh4b5k3c7hyugeyyk7s3xzhnm75sh2nz3@wzh4hqn3hmjr>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623073304.3275702-2-libaokun1@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 23-06-25 15:32:49, Baokun Li wrote:
> When ext4 allocates blocks, we used to just go through the block groups
> one by one to find a good one. But when there are tons of block groups
> (like hundreds of thousands or even millions) and not many have free space
> (meaning they're mostly full), it takes a really long time to check them
> all, and performance gets bad. So, we added the "mb_optimize_scan" mount
> option (which is on by default now). It keeps track of some group lists,
> so when we need a free block, we can just grab a likely group from the
> right list. This saves time and makes block allocation much faster.
> 
> But when multiple processes or containers are doing similar things, like
> constantly allocating 8k blocks, they all try to use the same block group
> in the same list. Even just two processes doing this can cut the IOPS in
> half. For example, one container might do 300,000 IOPS, but if you run two
> at the same time, the total is only 150,000.
> 
> Since we can already look at block groups in a non-linear way, the first
> and last groups in the same list are basically the same for finding a block
> right now. Therefore, add an ext4_try_lock_group() helper function to skip
> the current group when it is locked by another process, thereby avoiding
> contention with other processes. This helps ext4 make better use of having
> multiple block groups.
> 
> Also, to make sure we don't skip all the groups that have free space
> when allocating blocks, we won't try to skip busy groups anymore when
> ac_criteria is CR_ANY_FREE.
> 
> Performance test data follows:
> 
> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
>                    | Kunpeng 920 / 512GB -P80| AMD 9654 / 1536GB -P96  |
>  Disk: 960GB SSD   |-------------------------|-------------------------|
>                    | base  |    patched      | base  |    patched      |
> -------------------|-------|-----------------|-------|-----------------|
> mb_optimize_scan=0 | 2667  | 4821  (+80.7%)  | 3450  | 15371 (+345%)   |
> mb_optimize_scan=1 | 2643  | 4784  (+81.0%)  | 3209  | 6101  (+90.0%)  |
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

