Return-Path: <linux-ext4+bounces-12633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ECBD02416
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53802300E4FF
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 10:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B6E74BE1;
	Thu,  8 Jan 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="alYlFbPQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tr/YeV5R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="alYlFbPQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tr/YeV5R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D14B714F
	for <linux-ext4@vger.kernel.org>; Thu,  8 Jan 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868276; cv=none; b=t7rACs4IxR9eQ0wPu4LgDDDjZJyd3+yqq2Hk4ZcNWxaXwN2pAHU8hQu/uEaiU6RuQQ3hvVj1as2+mC7/hsLzcr0B8CdRG+dzqRnYKNVb/AN+iKNq9raDBOJ1WCWsoLp2bPt91lvfNIE5JfE5oKfIyK4NJwbzCilW33cZIz9pOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868276; c=relaxed/simple;
	bh=iBMw/RJj9iwmDAi/lvFN8ttntoRw+A3gkxGjufUpJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMoP8W5uyMyhdSWcLF4BmmnHqG/PRcuwMWAXNkEBce4Sh3s+/GE2gV3m8/WXg8AmGaBUPQh0T7Fic9N4hSHiBXGDN6dSIxnVAfS//zq6gvwuzQXPx1XTXRE7nG+Fy1oV5vRcdpR6t3bal3UmSsCJYYDPBXR3yuTxBAjwDBIiAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=alYlFbPQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tr/YeV5R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=alYlFbPQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tr/YeV5R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71F8C5C233;
	Thu,  8 Jan 2026 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767868270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc/8UweH1KXkNtf1Zo+N7epaeaRttQeib88OYaVFsjM=;
	b=alYlFbPQ8z0qtZ6fTDFad3H6ROpCWF7aB/GruY6sRGdWe49S6eTIL7KNNbylKQdbmBqxaH
	Qtx0bdywawa4hiyhrsNG4R4mH78jf134pjLs1qb4ERDQkHvzjqrL0jvBWwbrXa1bRHOl48
	IUH56ukcJqdaUGobfJT38o2kga3P/84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767868270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc/8UweH1KXkNtf1Zo+N7epaeaRttQeib88OYaVFsjM=;
	b=tr/YeV5RBuajTW4lZtp8L/rpSvlN1bYKR3BpgBribwCtU3LhpgM2pa5ryRCtAf6w/R3ddB
	GMMiB9co9ExYBKCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=alYlFbPQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tr/YeV5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767868270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc/8UweH1KXkNtf1Zo+N7epaeaRttQeib88OYaVFsjM=;
	b=alYlFbPQ8z0qtZ6fTDFad3H6ROpCWF7aB/GruY6sRGdWe49S6eTIL7KNNbylKQdbmBqxaH
	Qtx0bdywawa4hiyhrsNG4R4mH78jf134pjLs1qb4ERDQkHvzjqrL0jvBWwbrXa1bRHOl48
	IUH56ukcJqdaUGobfJT38o2kga3P/84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767868270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc/8UweH1KXkNtf1Zo+N7epaeaRttQeib88OYaVFsjM=;
	b=tr/YeV5RBuajTW4lZtp8L/rpSvlN1bYKR3BpgBribwCtU3LhpgM2pa5ryRCtAf6w/R3ddB
	GMMiB9co9ExYBKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6663A3EA63;
	Thu,  8 Jan 2026 10:31:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PgD+GG6HX2lBWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 10:31:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19748A0CF3; Thu,  8 Jan 2026 11:31:10 +0100 (CET)
Date: Thu, 8 Jan 2026 11:31:10 +0100
From: Jan Kara <jack@suse.cz>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>, 
	patches@lists.linux.dev, stable@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-ext4@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
Message-ID: <l36p4covbdywhdkmsxqkswww3azubmlew3imqv7acggcd3pm2k@sazu3kvtuzqn>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
 <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 71F8C5C233
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu 08-01-26 09:19:23, Jan Kiszka wrote:
> On 13.10.25 16:46, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Jan Kara <jack@suse.cz>
> > 
> > commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
> > 
> > When orphan file feature is enabled, inode can be tracked as orphan
> > either in the standard orphan list or in the orphan file. The first can
> > be tested by checking ei->i_orphan list head, the second is recorded by
> > EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> > we want to check whether inode is tracked as orphan and only some of
> > them properly check for both possibilities. Luckily the consequences are
> > mostly minor, the worst that can happen is that we track an inode as
> > orphan although we don't need to and e2fsck then complains (resulting in
> > occasional ext4/307 xfstest failures). Fix the problem by introducing a
> > helper for checking whether an inode is tracked as orphan and use it in
> > appropriate places.
> > 
> > Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
> > Cc: stable@kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> > Message-ID: <20250925123038.20264-2-jack@suse.cz>
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  fs/ext4/ext4.h   |   10 ++++++++++
> >  fs/ext4/file.c   |    2 +-
> >  fs/ext4/inode.c  |    2 +-
> >  fs/ext4/orphan.c |    6 +-----
> >  fs/ext4/super.c  |    4 ++--
> >  5 files changed, 15 insertions(+), 9 deletions(-)
> > 
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
> >  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
> >  
> >  /*
> > + * Check whether the inode is tracked as orphan (either in orphan file or
> > + * orphan list).
> > + */
> > +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
> > +{
> > +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> > +		!list_empty(&EXT4_I(inode)->i_orphan);
> > +}
> > +
> > +/*
> >   * Codes for operating systems
> >   */
> >  #define EXT4_OS_LINUX		0
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
> >  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
> >  	 * now.
> >  	 */
> > -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
> >  		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> >  
> >  		if (IS_ERR(handle)) {
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
> >  		 * old inodes get re-used with the upper 16 bits of the
> >  		 * uid/gid intact.
> >  		 */
> > -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
> > +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
> >  			raw_inode->i_uid_high = 0;
> >  			raw_inode->i_gid_high = 0;
> >  		} else {
> > --- a/fs/ext4/orphan.c
> > +++ b/fs/ext4/orphan.c
> > @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
> >  
> >  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
> >  		     !inode_is_locked(inode));
> > -	/*
> > -	 * Inode orphaned in orphan file or in orphan list?
> > -	 */
> > -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> > -	    !list_empty(&EXT4_I(inode)->i_orphan))
> > +	if (ext4_inode_orphan_tracked(inode))
> >  		return 0;
> >  
> >  	/*
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
> >  
> >  static void ext4_destroy_inode(struct inode *inode)
> >  {
> > -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
> > +	if (ext4_inode_orphan_tracked(inode)) {
> >  		ext4_msg(inode->i_sb, KERN_ERR,
> > -			 "Inode %lu (%p): orphan list check failed!",
> > +			 "Inode %lu (%p): inode tracked as orphan!",
> >  			 inode->i_ino, EXT4_I(inode));
> >  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
> >  				EXT4_I(inode), sizeof(struct ext4_inode_info),
> > 
> > 
> 
> Since this patch, I'm getting "inode tracked as orphan" warnings on ARM 
> 32-bit boards (not qemu, other archs not tested yet) when rebooting or 
> shutting down. The affected partition is used as backing storage for an 
> overlayfs (Debian image built from [1]). Still, systemd reports to have 
> sucessfully unmounted the partition.
> 
> [  OK  ] Stopped systemd-journal-flush.serv…lush Journal to Persistent Storage.
> [  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
> [  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
> [  OK  ] Stopped target swap.target - Swaps.
>          Unmounting var.mount - /var...
> [  OK  ] Unmounted var.mount - /var.
> [  OK  ] Stopped target local-fs-pre.target…Preparation for Local File Systems.
> [  OK  ] Reached target umount.target - Unmount All Filesystems.
> [  OK  ] Stopped systemd-remount-fs.service…mount Root and Kernel File Systems.
> [  OK  ] Stopped systemd-tmpfiles-setup-dev…Create Static Device Nodes in /dev.
> [  OK  ] Stopped systemd-tmpfiles-setup-dev…ic Device Nodes in /dev gracefully.
> [  OK  ] Reached target shutdown.target - System Shutdown.
> [  OK  ] Reached target final.target - Late Shutdown Services.
> [  OK  ] Finished systemd-poweroff.service - System Power Off.
> [  OK  ] Reached target poweroff.target - System Power Off.
> [   52.948231] watchdog: watchdog0: watchdog did not stop!
> [   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked as orphan!
> [   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.12.52-00240-gf50bece98c66 #12
> [   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x BeagleBone Black, BIOS 2025.07 07/01/2025
> [   53.449740] Call trace: 
> [   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
> [   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
> [   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
> [   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
> [   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
> [   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
> [   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
> [   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
> [   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
> [   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
> [   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
> [   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
> [   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
> [   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
> [   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
> [   53.450190] dfa0:                                     00000000 00000009 00000000 00000000
> [   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000000 be9e0a20 00000000
> [   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2ac0
> [   53.730379] reboot: Power down
> 
> I'm not getting the warning with the same image but kernels 6.18+ or 
> also 6.17.13 (the latter received this as backport as well). I do get 
> the warning with 6.1.159 as well, and also when moving up to 6.12.63 
> which received further ext4 backports. I didn't test 6.6 or 5.15 so far, 
> but I suspect they are equally affected.
> 
> Before digging deep into this to me unfamiliar subsystem: Could we miss 
> some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to 
> try out first?

I suspect you're missing 4091c8206cfd ("ext4: clear i_state_flags when
alloc inode") (which BTW has Fixes tag to this commit).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

