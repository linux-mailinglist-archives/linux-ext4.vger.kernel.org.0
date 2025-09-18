Return-Path: <linux-ext4+bounces-10241-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE368B8621F
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E363B76F3
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Sep 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4904225484B;
	Thu, 18 Sep 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CGn3DpdB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459C25393C
	for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214549; cv=none; b=qIRlc6SB0fK8lDd44eVWODcgJVnhKL2h4FL+P3DPAcnvmh0EpxsFnxoBxuFlsruxwyuLtPJ5rl9wdsBfEILp/DwJ5UBvMRhRakuu9D9kKvku4lpZcSViaJwyI6rINVr8mvEPUSHkEqd4ZX8OibW8jpHT7u0NdH9EdaVZLoQYdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214549; c=relaxed/simple;
	bh=MASchgYv5VOh/mIvB9osCMyX3k6SdQfLZs+Kw4Qej9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONdnGJbpL5BuIwbmWeyOs22aXAq/L2/xxSIgTQrWx1rL0wNp2Bd7/skPNg4xyKDSEPuybatMCfTM5dG9kL8nN3wHWmTUL7LzvuUM4E1R19UbLYSa/SuXRyZMMEb/YvwJkcPk6VFDA1Y6im39V9TuPZ7FME5bghhu7CLqYLbxHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CGn3DpdB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-243.bstnma.fios.verizon.net [173.48.102.243])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58IGtWiP000915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 12:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758214535; bh=yxtOtQO+oo+3kw7zlMr/d1LafBZvXddBZpCA/OENHwc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CGn3DpdB8aRx9h+cITIu9m0W3GOdIL+jYw1jxEqyV+zOBfPoXpZVyPjAIGWw+m9kk
	 mS25fv4R6FJY4qs4c9M0KRD8Ca3sEZujB3Um/VI/RBZQKF+xQtxFZ7F97yDJVPqqaj
	 zk/35SwDD5oGZROtYZtob2rxqN3IzGTR5b/r4EW+ol21dha6dmg5maTwzdKgvwrB6I
	 Mi+xdYoIlRStb0zgxSfb3nc3CwY3z/bMUsJzA54lRsbPBHCAesr+JZjTrPs4kg/KeE
	 bQOWtMyamkbwDhmNmN3zo9nF4ciLiurJTh/xcR9YDYbwu0tyQtgbKO4+XefKFRbe5w
	 5C6HxZ0MTYU8g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C38EC2E00D9; Thu, 18 Sep 2025 12:55:32 -0400 (EDT)
Date: Thu, 18 Sep 2025 12:55:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 0/3] E2fsprogs: tune2fs: use an ioctl to update mounted fs
Message-ID: <20250918165532.GC416742@mit.edu>
References: <20250917032814.395887-1-tytso@mit.edu>
 <C2130E9A-7467-4AC6-A0FE-0C4F4093DE20@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C2130E9A-7467-4AC6-A0FE-0C4F4093DE20@dilger.ca>

On Wed, Sep 17, 2025 at 12:26:18AM -0600, Andreas Dilger wrote:
> On Sep 16, 2025, at 21:28, Theodore Ts'o <tytso@mit.edu> wrote:
> > 
> > ﻿Teach tune2fs to try use the new EXT4_IOC_SET_TUNE_SB_PARAM ioctl
> > interface to update mounted file systems.  This will allow us to
> > disallow read/write access to the block device while the file system
> > is mounted, once we are sure the updated e2fsprogs is in use.
> 
> Have you considered to use a mount option (eg. mount.ext4) or a flag
> stored in the sb to indicate that a new e2fsprogs is installed in
> userspace?

For better or for worse, currently whether writes to mounted block
devices are blocked is a global switch, controlled by the
bdev_allow_write_mounted boot command-line option and
CONFIG_BLK_DEV_WRITE_MOUNTED (which controls the default).  That's
because it was designed solely to reduce syzbot noise.

As far as I know, ext2 and ext4 are the only file sysetms which
require sysadmins to need write access to mounted file systems (for
tune2fs).  Most other file systems don't actually allow mounted file
system reconfiguration, or they have ioctl's to allow this.  So I
believe that if a system has a newer version of e2fsprogs, it should
be sufficient for the sysadmin to include
bdev_allow_write_mounted=false in the boot options.  (Or for a
distribution to set CONFIG_BLK_DEV_WRITE_MOUNTED if they can guarantee
that a sufficiently new version of e2fsprogs will be installed with a
particular kernel.)

I don't object to having a per-file sytstem mount option, but it would
require changes in block/bdev.c.  And it might involve more complexity
that would be exposed to the system adinistrators.  So unless there is
some other file system type beyond ext4 which might need write access
while the file system is mounetd, maybe we don't need a per-fs switch.
Maybe ext2, but I think most distributions are using
CONFIG_EXT4_USE_FOR_EXT2 so in practice I don't think it's necessary.

Cheers,

						- Ted

