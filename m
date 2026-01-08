Return-Path: <linux-ext4+bounces-12634-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBA0D02894
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 13:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36905336AD35
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F104891C3;
	Thu,  8 Jan 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOO/RKDi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A474BC016;
	Thu,  8 Jan 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869011; cv=none; b=eUiVTTyvUshta6SnXz5/pRNTIcRPUbXOSkwXVYN/+3pTyZLmihdS3VZZCdAwuBumOnzpdVSpsAkpxWXwrhnECgXXAbUfY+prF5mEcrydMSRcAMIt25qvQyf6Fmnj29RSsPq7bE3ws96MARp4wqnsZ8k+M3ul5KZ5sYCkgEGDKCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869011; c=relaxed/simple;
	bh=eNnWoer8xPbd2PtWNQwc2mTnJ5n4LBKiTu4kPmFh4T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl0WdFGW5Bw00HpnI4JFlgdeUs+vfM80JwP55RVNAV5KVpxE0xLuOr7kkRQiKy1ZNGD8Mywp3ma5EWFNC98OciA5iZH8widVDjqAB+LwZFxvwT1EWWFn7/VgDj2UVY+8yLu3kxQMyrEo0MH1HEsJtVdpbAU8USTFRy0Tl21dSEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IOO/RKDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925AC19421;
	Thu,  8 Jan 2026 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767869011;
	bh=eNnWoer8xPbd2PtWNQwc2mTnJ5n4LBKiTu4kPmFh4T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IOO/RKDiIlrkMkiIoslhE4/cblnyGo+cE9VK61rI59BTTIJeCACyeGZvMnoUS9aML
	 LiziXEOYud22gAIc+s67Fols9ywNYOCLYWpIuDbRH+Tkw2Eo73Ca8ZejPHKwYqpm48
	 ZjSG+s3ao7i1SUod5CTZr/hb+jrqs6T372rQY2f8=
Date: Thu, 8 Jan 2026 11:43:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, stable@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, patches@lists.linux.dev,
	stable@kernel.org, Zhang Yi <yi.zhang@huawei.com>,
	linux-ext4@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH 6.12 242/262] ext4: fix checks for orphan inodes
Message-ID: <2026010845-undivided-stability-8bba@gregkh>
References: <20251013144326.116493600@linuxfoundation.org>
 <20251013144334.953291810@linuxfoundation.org>
 <ebd61bd3-1160-459f-b3b3-f186719fa5f3@siemens.com>
 <l36p4covbdywhdkmsxqkswww3azubmlew3imqv7acggcd3pm2k@sazu3kvtuzqn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l36p4covbdywhdkmsxqkswww3azubmlew3imqv7acggcd3pm2k@sazu3kvtuzqn>

On Thu, Jan 08, 2026 at 11:31:10AM +0100, Jan Kara wrote:
> On Thu 08-01-26 09:19:23, Jan Kiszka wrote:
> > On 13.10.25 16:46, Greg Kroah-Hartman wrote:
> > > 6.12-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Jan Kara <jack@suse.cz>
> > > 
> > > commit acf943e9768ec9d9be80982ca0ebc4bfd6b7631e upstream.
> > > 
> > > When orphan file feature is enabled, inode can be tracked as orphan
> > > either in the standard orphan list or in the orphan file. The first can
> > > be tested by checking ei->i_orphan list head, the second is recorded by
> > > EXT4_STATE_ORPHAN_FILE inode state flag. There are several places where
> > > we want to check whether inode is tracked as orphan and only some of
> > > them properly check for both possibilities. Luckily the consequences are
> > > mostly minor, the worst that can happen is that we track an inode as
> > > orphan although we don't need to and e2fsck then complains (resulting in
> > > occasional ext4/307 xfstest failures). Fix the problem by introducing a
> > > helper for checking whether an inode is tracked as orphan and use it in
> > > appropriate places.
> > > 
> > > Fixes: 4a79a98c7b19 ("ext4: Improve scalability of ext4 orphan file handling")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> > > Message-ID: <20250925123038.20264-2-jack@suse.cz>
> > > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  fs/ext4/ext4.h   |   10 ++++++++++
> > >  fs/ext4/file.c   |    2 +-
> > >  fs/ext4/inode.c  |    2 +-
> > >  fs/ext4/orphan.c |    6 +-----
> > >  fs/ext4/super.c  |    4 ++--
> > >  5 files changed, 15 insertions(+), 9 deletions(-)
> > > 
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -1970,6 +1970,16 @@ static inline bool ext4_verity_in_progre
> > >  #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
> > >  
> > >  /*
> > > + * Check whether the inode is tracked as orphan (either in orphan file or
> > > + * orphan list).
> > > + */
> > > +static inline bool ext4_inode_orphan_tracked(struct inode *inode)
> > > +{
> > > +	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> > > +		!list_empty(&EXT4_I(inode)->i_orphan);
> > > +}
> > > +
> > > +/*
> > >   * Codes for operating systems
> > >   */
> > >  #define EXT4_OS_LINUX		0
> > > --- a/fs/ext4/file.c
> > > +++ b/fs/ext4/file.c
> > > @@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup
> > >  	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
> > >  	 * now.
> > >  	 */
> > > -	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > > +	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
> > >  		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > >  
> > >  		if (IS_ERR(handle)) {
> > > --- a/fs/ext4/inode.c
> > > +++ b/fs/ext4/inode.c
> > > @@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct in
> > >  		 * old inodes get re-used with the upper 16 bits of the
> > >  		 * uid/gid intact.
> > >  		 */
> > > -		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
> > > +		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
> > >  			raw_inode->i_uid_high = 0;
> > >  			raw_inode->i_gid_high = 0;
> > >  		} else {
> > > --- a/fs/ext4/orphan.c
> > > +++ b/fs/ext4/orphan.c
> > > @@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, st
> > >  
> > >  	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
> > >  		     !inode_is_locked(inode));
> > > -	/*
> > > -	 * Inode orphaned in orphan file or in orphan list?
> > > -	 */
> > > -	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
> > > -	    !list_empty(&EXT4_I(inode)->i_orphan))
> > > +	if (ext4_inode_orphan_tracked(inode))
> > >  		return 0;
> > >  
> > >  	/*
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(stru
> > >  
> > >  static void ext4_destroy_inode(struct inode *inode)
> > >  {
> > > -	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
> > > +	if (ext4_inode_orphan_tracked(inode)) {
> > >  		ext4_msg(inode->i_sb, KERN_ERR,
> > > -			 "Inode %lu (%p): orphan list check failed!",
> > > +			 "Inode %lu (%p): inode tracked as orphan!",
> > >  			 inode->i_ino, EXT4_I(inode));
> > >  		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
> > >  				EXT4_I(inode), sizeof(struct ext4_inode_info),
> > > 
> > > 
> > 
> > Since this patch, I'm getting "inode tracked as orphan" warnings on ARM 
> > 32-bit boards (not qemu, other archs not tested yet) when rebooting or 
> > shutting down. The affected partition is used as backing storage for an 
> > overlayfs (Debian image built from [1]). Still, systemd reports to have 
> > sucessfully unmounted the partition.
> > 
> > [  OK  ] Stopped systemd-journal-flush.serv…lush Journal to Persistent Storage.
> > [  OK  ] Unmounted run-lock.mount - Legacy Locks Directory /run/lock.
> > [  OK  ] Unmounted tmp.mount - Temporary Directory /tmp.
> > [  OK  ] Stopped target swap.target - Swaps.
> >          Unmounting var.mount - /var...
> > [  OK  ] Unmounted var.mount - /var.
> > [  OK  ] Stopped target local-fs-pre.target…Preparation for Local File Systems.
> > [  OK  ] Reached target umount.target - Unmount All Filesystems.
> > [  OK  ] Stopped systemd-remount-fs.service…mount Root and Kernel File Systems.
> > [  OK  ] Stopped systemd-tmpfiles-setup-dev…Create Static Device Nodes in /dev.
> > [  OK  ] Stopped systemd-tmpfiles-setup-dev…ic Device Nodes in /dev gracefully.
> > [  OK  ] Reached target shutdown.target - System Shutdown.
> > [  OK  ] Reached target final.target - Late Shutdown Services.
> > [  OK  ] Finished systemd-poweroff.service - System Power Off.
> > [  OK  ] Reached target poweroff.target - System Power Off.
> > [   52.948231] watchdog: watchdog0: watchdog did not stop!
> > [   53.440970] EXT4-fs (mmcblk0p6): Inode 1 (b6b2dba9): inode tracked as orphan!
> > [   53.449709] CPU: 0 UID: 0 PID: 412 Comm: (sd-umount) Not tainted 6.12.52-00240-gf50bece98c66 #12
> > [   53.449728] Hardware name: ti TI AM335x BeagleBone Black/TI AM335x BeagleBone Black, BIOS 2025.07 07/01/2025
> > [   53.449740] Call trace: 
> > [   53.449757]  unwind_backtrace from show_stack+0x18/0x1c
> > [   53.449807]  show_stack from dump_stack_lvl+0x68/0x74
> > [   53.449839]  dump_stack_lvl from ext4_destroy_inode+0x7c/0x10c
> > [   53.449870]  ext4_destroy_inode from destroy_inode+0x5c/0x70
> > [   53.449897]  destroy_inode from ext4_mb_release+0xc8/0x268
> > [   53.449936]  ext4_mb_release from ext4_put_super+0xe4/0x308
> > [   53.449962]  ext4_put_super from generic_shutdown_super+0x84/0x154
> > [   53.449996]  generic_shutdown_super from kill_block_super+0x18/0x34
> > [   53.450023]  kill_block_super from ext4_kill_sb+0x28/0x3c
> > [   53.450059]  ext4_kill_sb from deactivate_locked_super+0x58/0x90
> > [   53.450086]  deactivate_locked_super from cleanup_mnt+0x74/0xd0
> > [   53.450113]  cleanup_mnt from task_work_run+0x88/0xa0
> > [   53.450136]  task_work_run from do_work_pending+0x394/0x3cc
> > [   53.450156]  do_work_pending from slow_work_pending+0xc/0x24
> > [   53.450175] Exception stack(0xe093dfb0 to 0xe093dff8)
> > [   53.450190] dfa0:                                     00000000 00000009 00000000 00000000
> > [   53.450205] dfc0: be9e0b2c 004e2aa0 be9e0a20 00000034 be9e0a04 00000000 be9e0a20 00000000
> > [   53.450218] dfe0: 00000034 be9e095c b6ba609b b6b0f736 00030030 004e2ac0
> > [   53.730379] reboot: Power down
> > 
> > I'm not getting the warning with the same image but kernels 6.18+ or 
> > also 6.17.13 (the latter received this as backport as well). I do get 
> > the warning with 6.1.159 as well, and also when moving up to 6.12.63 
> > which received further ext4 backports. I didn't test 6.6 or 5.15 so far, 
> > but I suspect they are equally affected.
> > 
> > Before digging deep into this to me unfamiliar subsystem: Could we miss 
> > some backport(s) to 6.12 and below that 6.17+ have? Any suggestions to 
> > try out first?
> 
> I suspect you're missing 4091c8206cfd ("ext4: clear i_state_flags when
> alloc inode") (which BTW has Fixes tag to this commit).

That is queued up for the next round of stable releases.  Hopefully the
-rc releases for them will go out in a day or so.

thanks,

greg k-h

