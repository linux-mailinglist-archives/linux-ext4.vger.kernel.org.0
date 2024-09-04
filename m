Return-Path: <linux-ext4+bounces-4051-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE696C7F4
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 21:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D9B23036
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD01E6DDB;
	Wed,  4 Sep 2024 19:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DUi4XQrq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310C40C03
	for <linux-ext4@vger.kernel.org>; Wed,  4 Sep 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479460; cv=none; b=haR4FVFGRGIjPrFSlC6gQWCwXDBW/BPpzoe+6M1LXDlz9fNXdGiAsoAZU95ePxALkwIN8JEchsNLQj10qfvt3jI544LQ0GQtz9/i5wdCJS8vbj4V0ytVNIftnSzmRmNrU+BqSwzlDaJOWtTfXhYKVPZg2LPprk3tfvl3p7BNBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479460; c=relaxed/simple;
	bh=YC4DFCNe7X6BtbrmVfUItUT1RH0dNQCpb2Z3+GnqeBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgwDmQi7xt2+rFk/l+SyHdH5/8/IQvfsYYwqe8OthAN2XQUzaoGZexKhRF4Y+YpKuROXGD16gLO+tp3sKKlg4XsD78WQgB47PXlbQm8Yvb17wGE1z3vVlmW/zxvElAsTtKgVAtQHidcNyTYodWMWh9VKrPvD1EfSBHioEQN1bSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DUi4XQrq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lRlEYAuB/b3a6T2n4mlWtclU2IW0wM6KBVv3hPFyURg=; b=DUi4XQrqFFz8/iEXR0Ze3/GBsu
	JhaM0SoKd0XFzVpseaA0C/pQ9DqKVy6vhee/CgKa7eUSIEHO8C+cS++Om6B3JACTPIw4XjA1oxKjR
	edM6ef4dqi57BJ8r5zuMsOLD2qk4jdBpK3JrtCexdwUVs6JtbC/eGDCR35XnIg/ph76wyj4kNou+m
	qQgtBT7ModGseQhdqLeV/kJNhmlYLtdPwF6Jqbc8kyV+lILWqDENXgdxC+Gid/AC1GPI+l6v8Btlv
	6rEoe674f+7+gOWt8/SmIgTjeiVrXMjvdOGAE1VugH/tLR58YaSi+HQJrfZGc9LEL8lxuidaz9VpK
	2amEI1IA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57126)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1slw1m-0001bd-1n;
	Wed, 04 Sep 2024 20:50:54 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1slw1j-00040i-2z;
	Wed, 04 Sep 2024 20:50:51 +0100
Date: Wed, 4 Sep 2024 20:50:51 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: BUG: 6.10: ext4 mpage_process_page_bufs() BUG_ON triggers
Message-ID: <Zti6G4Wq3pQHcs++@shell.armlinux.org.uk>
References: <ZtirReiX7J+MDhuh@shell.armlinux.org.uk>
 <Zti1Y5fthhgiL5Xb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zti1Y5fthhgiL5Xb@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 04, 2024 at 08:30:43PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 04, 2024 at 07:47:33PM +0100, Russell King (Oracle) wrote:
> > With a 6.10 based kernel, no changes to filesystem/MM code, I'm
> > seeing a reliable BUG_ON() within minutes of booting on one of my
> > VMs. I don't have a complete oops dump, but this is what I do
> > have, cobbled together from what was logged by journald, and
> > what syslogd was able to splat on the terminals before the VM
> > died.
> > 
> > Sep 04 15:51:46 lists kernel: kernel BUG at fs/ext4/inode.c:1967!
> > 
> > [ 1346.494848] Call trace:
> > [ 1346.495409] [<c04b4f90>] (mpage_process_page_bufs) from [<c04b938c>] (mpage_prepare_extent_to_map+0x410/0x51c)
> > [ 1346.499202] [<c04b938c>] (mpage_prepare_extent_to_map) from [<c04bbc40>] (ext4_do_writepages+0x320/0xb94)
> > [ 1346.502113] [<c04bbc40>] (ext4_do_writepages) from [<c04bc5dc>] (ext4_writepages+0xc0/0x1b4)
> > [ 1346.504662] [<c04bc5dc>] (ext4_writepages) from [<c0361154>] (do_writepages+0x68/0x220)
> > [ 1346.506974] [<c0361154>] (do_writepages) from [<c0354868>] (filemap_fdatawrite_wbc+0x64/0x84)
> > [ 1346.509165] [<c0354868>] (filemap_fdatawrite_wbc) from [<c035706c>] (__filemap_fdatawrite_range+0x50/0x58)
> > [ 1346.511414] [<c035706c>] (__filemap_fdatawrite_range) from [<c035709c>] (filemap_flush+0x28/0x30)
> > [ 1346.513518] [<c035709c>] (filemap_flush) from [<c04a8834>] (ext4_release_file+0x70/0xac)
> > [ 1346.515312] [<c04a8834>] (ext4_release_file) from [<c03f8088>] (__fput+0xd4/0x2cc)
> > [ 1346.517219] [<c03f8088>] (__fput) from [<c03f3e64>] (sys_close+0x28/0x5c)
> > [ 1346.518720] [<c03f3e64>] (sys_close) from [<c0200060>] (ret_fast_syscall+0x0/0x5c)
> > 
> > From a quick look, I don't see any patches that touch fs/ext4/inode.c
> > that might address this.
> > 
> > I'm not able to do any debugging, and from Friday, I suspect I won't
> > even be able to use a computer (due to operations on my eyes.)
> 
> After rebooting the VM, the next oops was:
> 
> Sep 04 19:33:41 lists kernel: Unable to handle kernel paging request at virtual address 5ed304f3 when read
> Sep 04 19:33:42 lists kernel: [5ed304f3] *pgd=80000040005003, *pmd=00000000
> Sep 04 19:33:42 lists kernel: Internal error: Oops: 206 [#1] PREEMPT SMP ARM
> 
>  kernel:[  205.583038] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>  kernel:[  205.630530] Process kworker/u4:2 (pid: 33, stack limit = 0xc68f8000)
> ...
>  kernel:[  205.661017] Call trace:
>  kernel:[  205.661997] [<c04d9060>] (ext4_finish_bio) from [<c04d931c>] (ext4_release_io_end+0x48/0xfc)
>  kernel:[  205.664523] [<c04d931c>] (ext4_release_io_end) from [<c04d94d8>] (ext4_end_io_rsv_work+0x88/0x188)
>  kernel:[  205.666628] [<c04d94d8>] (ext4_end_io_rsv_work) from [<c023f310>] (process_one_work+0x178/0x30c)
>  kernel:[  205.669924] [<c023f310>] (process_one_work) from [<c023fe48>] (worker_thread+0x25c/0x438)
>  kernel:[  205.671679] [<c023fe48>] (worker_thread) from [<c02480b0>] (kthread+0xfc/0x12c)
>  kernel:[  205.673607] [<c02480b0>] (kthread) from [<c020015c>] (ret_from_fork+0x14/0x38)
>  kernel:[  205.682719] Code: e1540005 0a00000d e5941008 e594201c (e5913000)
> 
> This corresponds with:
> 
> c04d9050:       e1540005        cmp     r4, r5
> c04d9054:       0a00000d        beq     c04d9090 <ext4_finish_bio+0x208>
> c04d9058:       e5941008        ldr     r1, [r4, #8]
> c04d905c:       e594201c        ldr     r2, [r4, #28]
> c04d9060:       e5913000        ldr     r3, [r1] ;<<<==== faulting instruction
> 
> This code is:
> 
>                 /*
>                  * We check all buffers in the folio under b_uptodate_lock
>                  * to avoid races with other end io clearing async_write flags
>                  */
>                 spin_lock_irqsave(&head->b_uptodate_lock, flags);
>                 do {
>                         if (bh_offset(bh) < bio_start ||
>                             bh_offset(bh) + bh->b_size > bio_end) {
> 
> where r4 is "bh", r4+8 is the location of the bh->b_page pointer.
> 
> static inline unsigned long bh_offset(const struct buffer_head *bh)
> {
>         return (unsigned long)(bh)->b_data & (page_size(bh->b_page) - 1);
> }
> 
> static inline unsigned long compound_nr(struct page *page)
> {
>         struct folio *folio = (struct folio *)page;
> 
>         if (!test_bit(PG_head, &folio->flags))
>                 return 1;
> 
> where PG_head is bit 6. Thus, bh->b_page was corrupt.
> 
> I've booted back into 6.7 on the offending VM, and it's stable, so it
> appears to be a regression between 6.7 and 6.10.

So.. I decided to stop the VM, and run e2fsck, first not allowing it
to fix stuff. It identified only one error:

e2fsck 1.46.2 (28-Feb-2021)
Pass 1: Checking inodes, blocks, and sizes
Inode 657, i_blocks is 8, should be 0.  Fix<y>? no
Inode 657 passes checks, but checksum does not match inode.  Fix<y>? no
Pass 2: Checking directory structure
ext2fs_read_inode: Inode checksum does not match inode while reading
inode 657 in process_bad_inode

/dev/loop0p1: ********** WARNING: Filesystem still has errors **********

e2fsck: aborted

/dev/loop0p1: ********** WARNING: Filesystem still has errors **********

Booting the VM again and tracking that down (debugfs refused to do the
inode number->name translation for some absurd reason... surely the
inode checksum doesn't _need_ to be correct to find which directory
entry has the inode number?)

Interestingly, when I hit the bad inode:

vdir: cannot access '/var/lib/dpkg/info/libacl1:armhf.triggers': Bad message
vdir: '/var/lib/dpkg/info/libgdbm-compat4:armhf.list': Input/output error
vdir: '/var/lib/dpkg/info/libldap-2.5-0:armhf.shlibs': Input/output error

and any further accesses to the filesystem gave -EIO! As it's the root
filesystem, no further commands could be run, not even those which
I'd just run. The only solution was to destroy the VM via libvirt.
This, despite the filesystem mounted:

/dev/vda1 on / type ext4 (rw,relatime,errors=remount-ro)

So why it started spitting out -EIO errors I've no idea. That seems
utter madness.

Anyway, I re-ran e2fsck, fixing the errors:

e2fsck 1.46.2 (28-Feb-2021)
/dev/loop0p1: recovering journal
Pass 1: Checking inodes, blocks, and sizes
Inode 657, i_blocks is 8, should be 0.  Fix<y>? yes
Pass 2: Checking directory structure
Inode 657 (/var/lib/dpkg/info/libacl1:armhf.triggers) has invalid mode
(0171223).
Clear<y>? yes
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -88667
Fix<y>? yes
Free blocks count wrong for group #2 (21314, counted=21315).
Fix<y>? yes
Free blocks count wrong (862994, counted=862964).
Fix<y>? yes
Free inodes count wrong (292360, counted=292352).
Fix<y>? yes

/dev/loop0p1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/loop0p1: 38272/330624 files (0.4% non-contiguous), 459276/1322240 blocks

before restarting the VM back into 6.7.0.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

