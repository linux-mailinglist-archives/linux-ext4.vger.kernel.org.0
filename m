Return-Path: <linux-ext4+bounces-652-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF74822A82
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CC741F23F72
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8911864D;
	Wed,  3 Jan 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8P8zG8C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/fKllMD4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8P8zG8C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/fKllMD4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95F18C0A;
	Wed,  3 Jan 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F2FCC1F79E;
	Wed,  3 Jan 2024 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704275348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnPIKVKxjrIDV5LFkirY1wff/M3w9KFC9+Wa8KZeRQ8=;
	b=x8P8zG8C0mDJVtFSUt4Xn+/VfYundICbGSrOcYeKuK1/8iwVsbJZ2z27Nosg9Ikx4STUE3
	x/ax8DwdtQrtDcvnV5GymvDTFSGqRXWlEJY59qTJwGFxvPkhqudV5nm5WWDi3PbFlZIWkm
	yXQe86KBYjEO4oh9kdbftb9tuox/YhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704275348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnPIKVKxjrIDV5LFkirY1wff/M3w9KFC9+Wa8KZeRQ8=;
	b=/fKllMD4/s8PFyjOM4JLxuqYrROFv+YH9haTkG93Ue9CMuH9ua9dglRKJvk6+9S/CbFUvt
	5jM2Ng5LWxrcHHCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704275348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnPIKVKxjrIDV5LFkirY1wff/M3w9KFC9+Wa8KZeRQ8=;
	b=x8P8zG8C0mDJVtFSUt4Xn+/VfYundICbGSrOcYeKuK1/8iwVsbJZ2z27Nosg9Ikx4STUE3
	x/ax8DwdtQrtDcvnV5GymvDTFSGqRXWlEJY59qTJwGFxvPkhqudV5nm5WWDi3PbFlZIWkm
	yXQe86KBYjEO4oh9kdbftb9tuox/YhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704275348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HnPIKVKxjrIDV5LFkirY1wff/M3w9KFC9+Wa8KZeRQ8=;
	b=/fKllMD4/s8PFyjOM4JLxuqYrROFv+YH9haTkG93Ue9CMuH9ua9dglRKJvk6+9S/CbFUvt
	5jM2Ng5LWxrcHHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE6F213AA6;
	Wed,  3 Jan 2024 09:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qjLpNZMtlWU+dAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 09:49:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DE3CA07EF; Wed,  3 Jan 2024 10:49:07 +0100 (CET)
Date: Wed, 3 Jan 2024 10:49:07 +0100
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huawei.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com, yukuai3@huawei.com
Subject: Re: [linus:master] [jbd2] 6a3afb6ac6: fileio.latency_95th_ms 92.5%
 regression
Message-ID: <20240103094907.iupboelwjxi243h3@quack3>
References: <202401021525.a27b9444-oliver.sang@intel.com>
 <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcc72d34-89e1-6181-3556-a1a981256cc6@huawei.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x8P8zG8C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/fKllMD4"
X-Spam-Score: -2.81
X-Rspamd-Queue-Id: F2FCC1F79E

Hello!

On Wed 03-01-24 11:31:39, Zhang Yi wrote:
> On 2024/1/2 15:31, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 92.5% regression of fileio.latency_95th_ms on:
> 
> This seems a little weird, the tests doesn't use blk-cgroup, and the patch
> increase IO priority in WBT, so there shouldn't be any negative influence in
> theory.

I don't have a great explanation either but there could be some impact e.g.
due to a different request merging of IO done by JBD2 vs the flush worker or
something like that. Note that the throughput reduction is only 5.7% so it
is not huge.

> I've tested sysbench on my machine with Intel Xeon Gold 6240 CPU,
> 400GB memory with HDD disk, and couldn't reproduce this regression.
> 
> ==
> Without 6a3afb6ac6 ("jbd2: increase the journal IO's priority")
> ==
> 
>  $ sysbench fileio --events=0 --threads=128 --time=600 --file-test-mode=seqwr --file-total-size=68719476736 --file-io-mode=sync --file-num=1024 run
> 
>   sysbench 1.1.0-df89d34 (using bundled LuaJIT 2.1.0-beta3)
> 
>   Running the test with following options:
>   Number of threads: 128
>   Initializing random number generator from current time
> 
> 
>   Extra file open flags: (none)
>   1024 files, 64MiB each
>   64GiB total file size
>   Block size 16KiB
>   Periodic FSYNC enabled, calling fsync() each 100 requests.
>   Calling fsync() at the end of test, Enabled.
>   Using synchronous I/O mode
>   Doing sequential write (creation) test
>   Initializing worker threads...
> 
>   Threads started!
> 
> 
>   Throughput:
>            read:  IOPS=0.00 0.00 MiB/s (0.00 MB/s)
>            write: IOPS=31961.19 499.39 MiB/s (523.65 MB/s)
>            fsync: IOPS=327500.24

Well, your setup seems to be very different from what LKP was using. You
are achieving ~500 MB/s (likely because all the files fit into the cache
and more or less even within the dirty limit of the page cache) while LKP
run achieves only ~54 MB/s (i.e., we are pretty much bound by the rather
slow disk). I'd try running with something like 32GB of RAM to really see
the disk speed impact...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

