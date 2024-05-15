Return-Path: <linux-ext4+bounces-2529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D18F8C6ECB
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 00:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCF21F22443
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1913FB1B;
	Wed, 15 May 2024 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DDMDkBCi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DC2101C8
	for <linux-ext4@vger.kernel.org>; Wed, 15 May 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715813389; cv=none; b=hcSzPmOvAgO5HBeAg/AHyHsgEZvQnqFcAwlEDxPZHMA61D9AAH+9phe8HlHOD+Ec2Vk9jePNTOGuS9ijDRzAKa64Ikc+9dI564IKM4fVMxMU7XvFEVIba22CKhn6Tvv0D4WJtFsnE7tf8rT8mkwm/ehHgQpUTBAohmBuWHlv0Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715813389; c=relaxed/simple;
	bh=nFx0SdOMLkM+nsMfxxNhWM1sBx8raudMXU3lIbaOfXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmaN5r2vOoFFzLULfKfBHRD5/AvOwoOIiT8NpqXXUOeOQdaEawThBYJlQu86d/7ePV7r+8rzc+2iWNfGmoBFq5AIC4R114UzkACACmdSE2Awje3+VG1cDBjDfSvrj3Ym478UhM4qHGX8L6IrPbUDnCxbEO2+R5D/KTPORKXrE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DDMDkBCi; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.89.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44FMnWA5003065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 18:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715813375; bh=IDp9awHqMdDqb4AZiCirIR/+Tlisixd9MYsSbbqvk/o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DDMDkBCijJfJz6LNdQSsfnTLjA5NjATipndgHyE50ZDJzCoeobrHjRHZ1C99OZ1xI
	 Isx/QGbjba03MVFDpPUkk6JcLsHzWu5FC4hECd3hqXrnKSGrsIjiKxUp6SKZvrBTnQ
	 F/ESw0a52evMwugfec5Vncsv5M25TnTnvL1pDy2/IRpkcSEBsUqa519pm9xT7v7I/+
	 HHxfJuBW5k70yrUwSC3aIEVZkI/TFik+93O63ztEa5nRZam2mXGB4FkqaqrhHVtgC4
	 JH0Feir7vDHiEUnjeQA/i4921s9HlT90cFMf4N1Dnay/iem4kHbNLmP/XTfv+pr4HJ
	 NhdvUaSd+DRug==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6A5043407D2; Wed, 15 May 2024 16:49:32 -0600 (MDT)
Date: Wed, 15 May 2024 16:49:32 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Shuangpeng Bai <shuangpengbai@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: KASAN: use-after-free in ext4_find_extent in v6.9
Message-ID: <20240515224932.GA202157@mit.edu>
References: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B9F0C1F-C804-4A9C-8597-4E1A7D16B983@gmail.com>

On Tue, May 14, 2024 at 08:40:36PM -0400, Shuangpeng Bai wrote:
> Hi Kernel Maintainers,
> 
> Our tool found a kernel bug KASAN: use-after-free in ext4_find_extent. Please see the details below.
> 
> Kernel commit: v6.9 (Commits on May 12, 2024)
> Kernel config: attachment
> C/Syz reproducer: attachment
> 
> We find this bug was reported and marked as fixed. (https://syzkaller.appspot.com/bug?extid=7ec4ebe875a7076ebb31)
> 
> Our reproducer can trigger this bug in v6.9, so the bug may have not been fixed correctly.

The reason why it was marked as fixed is because the reproducer no
longer reproduces with CONFIG_BLK_DEV_WRITE_MOUNTED disabled.
Upstream syzkaller unconditionally disables this config, and we don't
consider reproducers that have CONFIG_BLK_DEV_WRITE_MOUNTED enabled to
be a bug.

If the reproducer is actively modifying the block device (or the
underlying file for a loop device) while it is mounted, we don't
consider this a bug.  This is requires root, and it's no more a
"security bug" than someone complaining that root can execute a
reboot(2) system call and calling it a "security bug".

I've looked at your "reproducer" and it does appear to be modifying
the block device while it is mounted, and the config does have
CONFIG_BLK_DEV_WRITE_MOUNTED enabled.  So I don't care (tm).  If you
want to put an engineer to work on addressing the bug, and the patch
is a clean and maintable code fix, I'll certainly consider the change.
But it's not something that upstream will work on a volunteer basis;
no company I am aware of is willing to pay for engineers to work on
this sort of issue.

Cheers,

						- Ted

