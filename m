Return-Path: <linux-ext4+bounces-4107-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07278972A5D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2024 09:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391701C24180
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Sep 2024 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4671E53A;
	Tue, 10 Sep 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NFbCx1s+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D8117BB3F
	for <linux-ext4@vger.kernel.org>; Tue, 10 Sep 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952567; cv=none; b=hkUtB/AmtKVXf6T3AxqqMYkuKML4iSUGkbqmo3jxpWtJwy6JukGech/vBwl2RiJ0retWM2YjWZyUfLMvMR6kryI4m97Qa5vU4QV7TzI/+ucMi+TfDGEqi6a7wJzCdXnjqTKsHzvck2eGBs+KQwLeYQ9z80/47PSmCSj+/Km81UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952567; c=relaxed/simple;
	bh=G0ZFg3s+ksaOwXSN/E2qWB+xx0gWbsIN07cDTRBTIac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jckAdrXg5xMBDkdYSCMR3TqkoV0lIR8X5LrX3vOTw+SK5NWWC2G43KTSSVCWdcwgz3dk4g8sVSdw/CB+09A3BZEqZ5Sr+OQPl8nrM7uXyQKfOWahbWAQXvjit1+KZY62L/atgdQT/rZghxXdmvFKDGAcxR9oYP3fK4WiVcnw4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NFbCx1s+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D309CC4CEC3;
	Tue, 10 Sep 2024 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725952567;
	bh=G0ZFg3s+ksaOwXSN/E2qWB+xx0gWbsIN07cDTRBTIac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFbCx1s+TRlfhbdaexe9C3v2pts+Y1UVqPcg+alF9s+Mz4Y5wda5/XEPquAJaIAEz
	 KqCsKIXP8hCyZ5Lbu45dozFQ3WpDzDcLMk7kWVxevi3l+cKP1ASWNjLboGEfoMNMbD
	 mWjDgX5tUgnhFkaYwlgLXSxbDYz0AxqiBK8tE7W0=
Date: Tue, 10 Sep 2024 09:16:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: cve@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: CVE-2024-43898 is invalid?
Message-ID: <2024091012-deputize-acquaint-fb62@gregkh>
References: <20240909153144.GA1510718@mit.edu>
 <2024090919-eats-countable-1a0d@gregkh>
 <20240909200822.GA1509922@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909200822.GA1509922@mit.edu>

On Mon, Sep 09, 2024 at 04:08:22PM -0400, Theodore Ts'o wrote:
> On Mon, Sep 09, 2024 at 06:20:08PM +0200, Greg KH wrote:
> > 
> > "root privileges" are not something that "is this a vulnerability"
> > normally takes into account given that there are zillions of ways of
> > giving permissions to processes to do things that people do in crazy
> > systems, as you know :)
> > 
> > That being said, the commit message does not document root priviliges
> > being needed, also, it looks like the function is called on the "normal"
> > shutdown callback for the superblock, which I don't think is required to
> > have root permissions, does it?
> 
> It's fair that while umount(2) requires root privs, it's absolutely
> true that there are a number of ways that an unprivileged user might
> be able to request that the system unmount a file system on its
> behalf.  However, this particular failure involves a forcible shutdown
> (triggered via ext4_force_shutdown() and the FS_IOC_SHUTDOWN ioctl)
> without any regard to whether the file system is busy or not.  A
> "normal" superblock shutdown via umount(2) would never hit this
> scenario because the umount(2) would return EBUSY if there are any
> open file descriptors, and the syzkaller reproducer involves doing a
> lot of file system operations racing with the FS_IOC_SHUTDOWN ioctl.
> 
> The FS_IOC_SHUTDOWN ioctl is used for debugging and testing, and it's
> not something that will be triggered by some setuid program or some
> root daemon like udisks or udev.  This is why I had intentionally
> skipped adding a cc: stable@kernel.org for this particular patch.
> 
> It's fair to say that we didn't explicitly say that root was required;
> we can try to be a bit more explicit about whether something is
> legitimately a security fix or not.  At least in my mind, it was so
> obviously not that I didn't bother to say so, other than _not_ cc'ing
> stable, which is not necessarily an obvious statement since it could
> have been an oversight.  I'll try to be more explicit in the future.

You don't have to be more explicit, except maybe for things that "look"
like they should be backported and are fixes needed but really should
not be, like this one.

> > But as a maintainer, it's up to you if you wish to reject a cve for your
> > subsystem/code, so if you really want it rejected, we'll be glad to do
> > so.
> 
> There are some more borderline cases, such as people who enable their
> systems to automount USB thumb drives which users find scattered in a
> parking lot by a nation-state attacker.  (Note: both xfsprogs and
> e2fsprogs now ship with udev rules which disable this feature by
> default; that won't stop a distro product manager for thinking that
> user friendliness trumps security.)
> 
> But in this case, this is so far outside the normal parameters that
> yes, let's reject this particular CVE since it will be a vulnerability
> for essentially no one.

Now rejected, thanks!

greg k-h

