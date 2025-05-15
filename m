Return-Path: <linux-ext4+bounces-7912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F706AB8920
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 16:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0827AB352
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 14:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37251E47AD;
	Thu, 15 May 2025 14:17:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F029F153800
	for <linux-ext4@vger.kernel.org>; Thu, 15 May 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318621; cv=none; b=h2SSUWB/4SF/K74WlBpBNoPbUl7i+4gnp7xbFb9AHP5PR12TxeTUod7OmkAYQjNLyfuqd81n2+Q5iAgqzIn1AMM4ggN/RvI8bN4MFgQ2IXOVftKvAUiMab4WJWkWSczStuEa1ugEWsSFbFpcR71KEHqDfnjrVSHCnRpwEp2DCh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318621; c=relaxed/simple;
	bh=BVd2RztjNgT0w+aQ7oqX9kXk1wjJeyeqN/PC+LJOO4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYn7JKQYxZTnjRKSamlVW424z5lUSZB7QKxakCcxkF2Fxbvbne3bc9Uer7IsmKvlXRbs9KbkJCcPqwazpvsfxuk/dVLLEbQZ4OUPf/kl7YAjTRmbqNTq2nBnr3E8AdocoINdSptmuVdx+WqwOuf4a2q4UvQjEdPnC7h8Vg3pbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-120.bstnma.fios.verizon.net [108.26.156.120])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54FEGhU8009390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 10:16:45 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C3EF82E00DC; Thu, 15 May 2025 10:16:43 -0400 (EDT)
Date: Thu, 15 May 2025 10:16:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Guoyu Yin <y04609127@gmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] kernel BUG in ext4_mb_release_inode_pa
Message-ID: <20250515141643.GB325737@mit.edu>
References: <CAJNGr6t6cpo3zjANpYObZaWOSeGKdGW4B4+k1Bh2ZWQZBbJrBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNGr6t6cpo3zjANpYObZaWOSeGKdGW4B4+k1Bh2ZWQZBbJrBg@mail.gmail.com>

On Thu, May 15, 2025 at 05:58:40PM +0800, Guoyu Yin wrote:
> 
> I discovered a kernel crash described as "kernel BUG in
> ext4_mb_release_inode_pa." This issue occurs in the EXT4 filesystem's
> ext4_mb_release_inode_pa function (fs/ext4/mballoc.c:5339), where a
> BUG() assertion fails due to a mismatch between the calculated free
> block count free and the expected value pa->pa_free during
> preallocated block release.

I can't reproduce the BUG using qemu,with the kernel config, kernel
commit, and C reproducer that you have provided.  This is why I
strongly suggest that if people really feel the need to set up their
own syzkaller instances, perhaps because they are maing changes to
syzkaller, that they replicate the full syzkaler setup, including the
web dashboard and e-mail responder so that people can request that the
reproducer be run on your setup so we can figure out how easily
reproducible the report might be, and whether it has been fixed in a
more recent kernel version, or via a proposed bug fix.

You are most likely correct that it is caused by a corrupted file
system, and this is why I strongly recommend that users run fsck -y on
any file system image of uncertain provenance before trying to mount
said file system.  In addition, note that if the file system had been
mounted with errors=remount-ro, the problem wouldn't have resulted in
a BUG.  For this reason, especially when the C reprducer doesn't
reproduce the reported issue, this sorts of issues are a very low
priority to investigate.

Best regards,

					- Ted

