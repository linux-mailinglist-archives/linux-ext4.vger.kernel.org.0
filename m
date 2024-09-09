Return-Path: <linux-ext4+bounces-4091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953B8972345
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFE47B23A1F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Sep 2024 20:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194E18B47F;
	Mon,  9 Sep 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="b1vQMnmV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33F18B471
	for <linux-ext4@vger.kernel.org>; Mon,  9 Sep 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725912515; cv=none; b=o7aoZXSgVRYJ6DBo5sKZu0mjo17g7LYR28pqQ/RJOKonYVAl+IESp5qdgiI5UBmjdr1lx9QtlCun6f3SzJ0GALM85ddWgg4NIABQhPxiHG8PEqTtrBwJ+IMU9pZsk9bWjk5XTonnMHKrI68T/4Vn5up67RlzTPR78VmUItDG18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725912515; c=relaxed/simple;
	bh=34QsWh9f198UZvhJLxntH+beSYkXiM+Ormr5QFrS280=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQG/AbOME9IaQ/1QftXDTJlZcRf8CUIAlaVIctX1XPMWqT8qlbmwsuOYw4dMIvrUtz255dIqOvvE95cnA4zmvLe2gAUNAE2x0MK4pL0tPYq7GgJq5+WxsYFwY5dh7lCBs6Tjmct1O5p6VTFae8PVtzwrDCMkcYFwy/BF3F2DF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=b1vQMnmV; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-108-26-156-33.bstnma.fios.verizon.net [108.26.156.33])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 489K8Mgn014483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 16:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725912504; bh=5/IN3BhBJbhkdt6Vi9AwrynmKXLjKy3Liah1EEE8+4E=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=b1vQMnmVdXIUk9QGbYU5Zmvbw6hRcE3m1NhHQacHq++UlUiZ55fZp6m6VcbbEZA1U
	 X7Goonfs+WoMWHXSkmAiyC3RQyIpEBQrPmGvYvi2Esjh2zlyEaG+tCKykAqOH4UEuM
	 s1jyIhPi2rSznAuB7Yb8wHcIVeb4trozDfSEwvUwkZQ9lfVHPAhAmmVpxTBD7v5IZA
	 W9SHSoSjv0St2exPmufciKRXY7Y50YipbHiZxFtgcZzA9K5Yv+i9zgxZtrPuffNvqI
	 9o0gZCqf8NivuOrJi29Dw6+guhCEz7iceD1twc1a84kmR/wShG0xZNRDzh78OTJaYv
	 6m4pUbTnexcxA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 783A815C19A9; Mon, 09 Sep 2024 16:08:22 -0400 (EDT)
Date: Mon, 9 Sep 2024 16:08:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: CVE-2024-43898 is invalid?
Message-ID: <20240909200822.GA1509922@mit.edu>
References: <20240909153144.GA1510718@mit.edu>
 <2024090919-eats-countable-1a0d@gregkh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090919-eats-countable-1a0d@gregkh>

On Mon, Sep 09, 2024 at 06:20:08PM +0200, Greg KH wrote:
> 
> "root privileges" are not something that "is this a vulnerability"
> normally takes into account given that there are zillions of ways of
> giving permissions to processes to do things that people do in crazy
> systems, as you know :)
> 
> That being said, the commit message does not document root priviliges
> being needed, also, it looks like the function is called on the "normal"
> shutdown callback for the superblock, which I don't think is required to
> have root permissions, does it?

It's fair that while umount(2) requires root privs, it's absolutely
true that there are a number of ways that an unprivileged user might
be able to request that the system unmount a file system on its
behalf.  However, this particular failure involves a forcible shutdown
(triggered via ext4_force_shutdown() and the FS_IOC_SHUTDOWN ioctl)
without any regard to whether the file system is busy or not.  A
"normal" superblock shutdown via umount(2) would never hit this
scenario because the umount(2) would return EBUSY if there are any
open file descriptors, and the syzkaller reproducer involves doing a
lot of file system operations racing with the FS_IOC_SHUTDOWN ioctl.

The FS_IOC_SHUTDOWN ioctl is used for debugging and testing, and it's
not something that will be triggered by some setuid program or some
root daemon like udisks or udev.  This is why I had intentionally
skipped adding a cc: stable@kernel.org for this particular patch.

It's fair to say that we didn't explicitly say that root was required;
we can try to be a bit more explicit about whether something is
legitimately a security fix or not.  At least in my mind, it was so
obviously not that I didn't bother to say so, other than _not_ cc'ing
stable, which is not necessarily an obvious statement since it could
have been an oversight.  I'll try to be more explicit in the future.

> But as a maintainer, it's up to you if you wish to reject a cve for your
> subsystem/code, so if you really want it rejected, we'll be glad to do
> so.

There are some more borderline cases, such as people who enable their
systems to automount USB thumb drives which users find scattered in a
parking lot by a nation-state attacker.  (Note: both xfsprogs and
e2fsprogs now ship with udev rules which disable this feature by
default; that won't stop a distro product manager for thinking that
user friendliness trumps security.)

But in this case, this is so far outside the normal parameters that
yes, let's reject this particular CVE since it will be a vulnerability
for essentially no one.

Thanks,

						- Ted



