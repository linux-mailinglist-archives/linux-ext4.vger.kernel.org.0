Return-Path: <linux-ext4+bounces-14692-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDWuDn/GqmnVWwEAu9opvQ
	(envelope-from <linux-ext4+bounces-14692-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 13:20:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1402206EE
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Mar 2026 13:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E607F306DFD4
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2026 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE63659E4;
	Fri,  6 Mar 2026 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UYkMh+9c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xv2f40NE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UYkMh+9c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xv2f40NE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1835F170
	for <linux-ext4@vger.kernel.org>; Fri,  6 Mar 2026 12:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799545; cv=none; b=e6Nfw+ktZqA9F+vPpeLYh2Fl2TaryDvmJA8IKxa8hSRMlkVNRyyMsKDk9+TOOGh/C6pvaki3REBSReyiYpx+MnG+Zt1FrtFNvnsfa8nfbe9QU8OPIsN1pGH3GEpb+Chod6IwBEG3fza2Al68v72t1HJAfX2IBmXyVs01r0+dGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799545; c=relaxed/simple;
	bh=LCC7J/h5b++rn5nF+GMJnm+f9PI2LrhYFABtKkMZvuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMYozTHxPuDw0ctoSqRTDJtC2gSHaG+yMxpwvLNPThfzCoBrh5YirbnYzf3eHQOGZXnoi3zLDlpxPU/ThrjnyaYvJk3y5LEVFyP9bfZMBsRTJuVJ/7ySrTxvkYd8EtwZx5v+LQhzrhk+Gb7OQ7TFMDV5z7m6cdgjlen7Sh21p88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UYkMh+9c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xv2f40NE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UYkMh+9c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xv2f40NE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A6CE3E7F0;
	Fri,  6 Mar 2026 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772799542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt4nl9ne4qIzBZODffLLX9iNOga67tehke/LTcSxmE=;
	b=UYkMh+9cJIdB7QoOjLQp56y5Z0uF2eZAefdRWxMGvHOKU08t+sHIWOJujm5LftrKT8gzNa
	a2Wo9QzFrApL7LNa/Ofa9s8l96QhN0VNGjg2UYW1otLC30xa6BZUoPxbb/AWRUJ+E2fu7u
	//yOhYGV40diX7Hvzd8noqdHU4hlO0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772799542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt4nl9ne4qIzBZODffLLX9iNOga67tehke/LTcSxmE=;
	b=xv2f40NEhvtcg7ncuiEg2A7WdRU0Ik0vsbs329RjIKH+djpuWWbEIUUfVKr8W0T5GeCZ0R
	MiCmuri2pYywKQAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UYkMh+9c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xv2f40NE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772799542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt4nl9ne4qIzBZODffLLX9iNOga67tehke/LTcSxmE=;
	b=UYkMh+9cJIdB7QoOjLQp56y5Z0uF2eZAefdRWxMGvHOKU08t+sHIWOJujm5LftrKT8gzNa
	a2Wo9QzFrApL7LNa/Ofa9s8l96QhN0VNGjg2UYW1otLC30xa6BZUoPxbb/AWRUJ+E2fu7u
	//yOhYGV40diX7Hvzd8noqdHU4hlO0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772799542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RLt4nl9ne4qIzBZODffLLX9iNOga67tehke/LTcSxmE=;
	b=xv2f40NEhvtcg7ncuiEg2A7WdRU0Ik0vsbs329RjIKH+djpuWWbEIUUfVKr8W0T5GeCZ0R
	MiCmuri2pYywKQAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E020D3EA75;
	Fri,  6 Mar 2026 12:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCBiNTXGqmloLgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Fri, 06 Mar 2026 12:19:01 +0000
Date: Fri, 6 Mar 2026 13:19:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lkp@intel.com, oe-lkp@lists.linux.dev, linux-ext4@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [LTP] [linux-next:master] [ext4]  81d2e13a57: ltp.fanotify22.fail
Message-ID: <20260306121900.GB519430@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <202602042124.87bd00e3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602042124.87bd00e3-lkp@intel.com>
X-Spam-Flag: NO
X-Spam-Score: -3.71
X-Spam-Level: 
X-Rspamd-Queue-Id: AF1402206EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,intel.com,lists.linux.dev,vger.kernel.org,lst.de,lists.linux.it,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14692-lists,linux-ext4=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:dkim,suse.cz:replyto,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[pvorel@suse.cz];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvorel@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action

Hi all,

[ Cc Amir, although this might be more related to ext4 than fanotify ]

Kind regards,
Petr

> Hello,

> kernel test robot noticed "ltp.fanotify22.fail" on:

> commit: 81d2e13a57c9d73582527966fae24d4fd73826ca ("ext4: convert to new fserror helpers")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

> [test failed on linux-next/master 33a647c659ffa5bdb94abc345c8c86768ff96215]

> in testcase: ltp
> version: 
> with following parameters:

> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-02/fanotify22


> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

> (please refer to attached dmesg/kmsg for entire log/backtrace)


> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202602042124.87bd00e3-lkp@intel.com


> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20260204/202602042124.87bd00e3-lkp@intel.com


> user  :notice: [  423.546026] [    T265] 	Hostname:   lkp-ivb-d04

> user  :notice: [  423.554417] [    T265] 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]

> user  :notice: [  423.570800] [    T265] 	Directory:  /tmp/kirk.root/tmpefuyb6o0



> user  :notice: [  423.584852] [    T265] Connecting to SUT: default

> user  :warn  : [  423.586640] [   T5587] /lkp/benchmarks/ltp/kirk[5563]: fanotify22: start (command: fanotify22)


> user  :notice: [  423.605665] [    T265] Starting suite: temp_single_test

> user  :notice: [  423.613894] [    T265] ---------------------------------

> kern  :info  : [  423.633832] [   T5592] loop: module loaded
> kern  :info  : [  423.657047] [   T5591] loop0: detected capacity change from 0 to 614400
> kern  :err   : [  423.821741] [   T5591] /dev/zero: Can't lookup blockdev
> kern  :info  : [  424.033575] [   T5591] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :info  : [  424.098309] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> kern  :info  : [  424.345598] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :crit  : [  424.414068] [   T5607] EXT4-fs error (device loop0): __ext4_remount:6794: comm fanotify22: Abort forced by user
> kern  :err   : [  424.423984] [   T5607] Aborting journal on device loop0-8.
> kern  :crit  : [  424.463989] [   T5607] EXT4-fs (loop0): Remounting filesystem read-only
> kern  :info  : [  424.470416] [   T5607] EXT4-fs (loop0): re-mounted 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 ro.
> kern  :info  : [  424.479591] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> kern  :warn  : [  424.490528] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
> kern  :info  : [  424.539426] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :crit  : [  424.552662] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
> kern  :info  : [  424.617262] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> kern  :warn  : [  424.703481] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
> kern  :info  : [  424.752431] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :crit  : [  424.765440] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1777: inode #32385: comm fanotify22: bad inode number: 1
> kern  :crit  : [  424.776331] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
> kern  :info  : [  424.845037] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> kern  :warn  : [  424.928434] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
> kern  :info  : [  424.985535] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :crit  : [  424.998543] [   T5607] EXT4-fs error (device loop0): ext4_lookup:1785: inode #32386: comm fanotify22: iget: bogus i_mode (377)
> kern  :crit  : [  425.115411] [   T5607] EXT4-fs error (device loop0): __ext4_remount:6794: comm fanotify22: Abort forced by user
> kern  :err   : [  425.125337] [   T5607] Aborting journal on device loop0-8.
> kern  :crit  : [  425.191808] [   T5607] EXT4-fs (loop0): Remounting filesystem read-only
> kern  :info  : [  425.198225] [   T5607] EXT4-fs (loop0): re-mounted 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 ro.
> kern  :info  : [  425.207311] [   T5607] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> kern  :warn  : [  425.218247] [   T5607] EXT4-fs (loop0): warning: mounting fs with errors, running e2fsck is recommended
> kern  :info  : [  425.255422] [   T5607] EXT4-fs (loop0): mounted filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9 r/w with ordered data mode. Quota mode: none.
> kern  :info  : [  425.300422] [   T5591] EXT4-fs (loop0): unmounting filesystem 6b5acef8-3cdb-48f2-8af0-b27b5ee321e9.
> user  :notice: [  425.421952] [    T265] \x1b[1;37mfanotify22: \x1b[0m\x1b[1;31mfail\x1b[0m | \x1b[1;33mtainted\x1b[0m  (1.808s)

> user  :warn  : [  425.427743] [   T5635] /lkp/benchmarks/ltp/kirk[5563]: fanotify22: end (returncode: 1)
> user  :notice: [  425.447575] [    T265]                                                                                                                                 

> user  :notice: [  425.463971] [    T265] Execution time: 1.866s



> user  :notice: [  425.476018] [    T265] 	Suite:       temp_single_test

> user  :notice: [  425.483786] [    T265] 	Total runs:  1

> user  :notice: [  425.490690] [    T265] 	Runtime:     1.808s

> user  :notice: [  425.497330] [    T265] 	Passed:      3

> user  :notice: [  425.503518] [    T265] 	Failed:      1

> user  :notice: [  425.509637] [    T265] 	Skipped:     0

> user  :notice: [  425.515735] [    T265] 	Broken:      0

> user  :notice: [  425.521820] [    T265] 	Warnings:    0

> user  :notice: [  425.529960] [    T265] 	Kernel:      Linux 6.19.0-rc1-00006-g81d2e13a57c9 #1 SMP PREEMPT_DYNAMIC Sat Jan 31 20:49:54 CST 2026

> user  :notice: [  425.543805] [    T265] 	Machine:     unknown

> user  :notice: [  425.550576] [    T265] 	Arch:        x86_64

> user  :notice: [  425.557336] [    T265] 	RAM:         6899604 kB

> user  :notice: [  425.564451] [    T265] 	Swap:        0 kB

> user  :notice: [  425.571112] [    T265] 	Distro:      debian 13



> user  :notice: [  425.582858] [    T265] Disconnecting from SUT: default

> user  :notice: [  425.590377] [    T265] Session stopped

