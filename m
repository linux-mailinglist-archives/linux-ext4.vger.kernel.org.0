Return-Path: <linux-ext4+bounces-5861-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B389FE3BA
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168747A14C4
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 08:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E31A08D1;
	Mon, 30 Dec 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N828ODK9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C41A0730;
	Mon, 30 Dec 2024 08:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547616; cv=none; b=cScdG36YpVc/V8uMtrTnm66i4SWO7UydS7pBHVE/IopFYrWKEUIXYuOsYKeMqKx/MoZBODcJnyxeYpypXtttZpbAw+rKLAT08obC9d74OS2pO0iKnNJCDuEUFytO5TFgjdUpKaJVnvlR83U07iR+LGWd3Wg7k9tidAzsWmeH51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547616; c=relaxed/simple;
	bh=7JoDoBa86H+5Ecv9BuKrocOyjEw0bR4PeUzwhNswrLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIpT7AB7LpEYdc9gv6uMNu47lAxTH4ztp9b2xW2iuIU/EbkUa7+ofU0/ivnqdbDpHASvuibFhVfuAMy6J1u130CnasbaMTS+x2hMrO0pnF2OE06mqA7Xlt8NbHP+NWVw/bx2dIU5qliw2DxZkxcHpmqXr6ZxGfQ91ZQloT71opM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N828ODK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E77FC4CED0;
	Mon, 30 Dec 2024 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547615;
	bh=7JoDoBa86H+5Ecv9BuKrocOyjEw0bR4PeUzwhNswrLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N828ODK9GplmwNi6CoZqDQHvZYzwVyUgLap6Rqo/8e5HAUnaZK1L9ZpQpQX5I3sQH
	 Yqe7jQ5Z2Z4MEbJZLty5s2jhlehi3L1GE28F0I1UltZfNH1mYCzcPSg8ikKMxk+FaS
	 zWLA7kiMKOE5qrptCI81zwF1nC4SEL6S22hnnyrw=
Date: Mon, 30 Dec 2024 09:33:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-cve-announce@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Yang Erkun <yangerkun@huawei.com>
Subject: Re: CVE-2024-50191: ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <2024123032-sarcasm-properly-b955@gregkh>
References: <2024110851-CVE-2024-50191-f31c@gregkh>
 <cbbdac31-c63c-418e-ba00-bb82b96144ee@huawei.com>
 <2024123021-goatskin-mushroom-208e@gregkh>
 <8222b5dd-5ee5-4ee6-9763-d1c21b9804db@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8222b5dd-5ee5-4ee6-9763-d1c21b9804db@huawei.com>

On Mon, Dec 30, 2024 at 04:21:00PM +0800, Baokun Li wrote:
> On 2024/12/30 15:54, Greg KH wrote:
> > On Mon, Dec 30, 2024 at 03:27:45PM +0800, Baokun Li wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > ext4: don't set SB_RDONLY after filesystem errors
> > > > 
> > > > When the filesystem is mounted with errors=remount-ro, we were setting
> > > > SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> > > > proper locking (sb->s_umount) and does not go through proper filesystem
> > > > remount procedure but it has been the way this worked since early ext2
> > > > days and it was good enough for catastrophic situation damage
> > > > mitigation. Recently, syzbot has found a way (see link) to trigger
> > > > warnings in filesystem freezing because the code got confused by
> > > > SB_RDONLY changing under its hands. Since these days we set
> > > > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > > > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > > > stop doing that.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2024-50191 to this issue.
> > > > 
> > > > 
> > > > Affected and fixed versions
> > > > ===========================
> > > > 
> > > >      Fixed in 5.15.168 with commit fbb177bc1d64
> > > >      Fixed in 6.1.113 with commit 4061e07f040a
> > > Since 6.1 and 5.15 don't have backport
> > >      commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag"),
> > > we won't set the EXT4_FLAGS_SHUTDOWN bit in ext4_handle_error() yet. So
> > > here these two commits cause us to repeatedly get the following printout:
> > > 
> > > [   42.993195] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993351] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993483] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993597] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993638] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993718] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993866] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993874] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.993874] EXT4-fs error (device sda) in __ext4_new_inode:1089: Journal
> > > has aborted
> > > [   42.994059] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> > > fsstress: Detected aborted journal
> > > [   42.999893] EXT4-fs: 58002 callbacks suppressed
> > > [   42.999895] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000110] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000274] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000421] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000569] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000701] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.000869] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.001094] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.001229] EXT4-fs (sda): Remounting filesystem read-only
> > > [   43.001365] EXT4-fs (sda): Remounting filesystem read-only
> > > 
> > > Perhaps we should revert both commits.
> > Maybe, if so, please send the needed info to the stable list with the
> > backports that have been tested.  cve@kernel.org isn't the place for
> > this :)
> 
> I replied to this thread on lore, which automatically CC's cve@kernel.org.

Yes, which is fine, but you are responding to a CVE report, NOT to a
stable kernel patch that has been backported, which is what I think you
want to respond to, right?

> We don't use these two versions, we just happened to find the issue.
> If you feel that reporting issue is bothering you, then I won't do it.🙂

It's fine, I'm just trying to get you to route it to a group of people
that can do something about it.  Again, try responding to the stable
patch that was merged there, that would be better, along with perhaps
providing a patch showing what you feel should be done.

If patches that are assigned CVEs later get reverted, the CVEs should
semi-automatically be rejected (I swept the CVE tree for this last
week), so you don't need to worry about that happening.

thanks,

greg k-h

