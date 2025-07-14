Return-Path: <linux-ext4+bounces-8970-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13DB034F8
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 05:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A40173ECB
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DA41E1DFC;
	Mon, 14 Jul 2025 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qT65dSIe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A22D76026
	for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752463961; cv=none; b=MrThggQYUPKcOzqw24HKYrWMc1/t7obRJAaalJcQPxopNHPffo7dp0jdl7OmDcJjdkge7RH6/MJ5vozBIDRBDNHs7yYB3N0m5is+AG1dcZPXdx0wnpd3cT6WUfEGArnL/Nub8/FRIqmIPDRfiffL7cBXKsW5s/lvOejMkrAt/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752463961; c=relaxed/simple;
	bh=OsOTxHzLsnGDZkMcWq2qO4SMG5Lk7mq/R12d0Pyindk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B98k/YHJziO+lmiI2/tzsHpKkp4oR7kiwNo3pMwfGuzrGSf66vldboQFgmnMFzaVfctHDaXEEBtqf31TtWU75MQrYP+6qtwytN4uuhTbwXbdcULgG8zfVkecVfTFBMJovns6AWSxWso9kfaiy+7MgxbjIxlYD/HDN8ebBS/9K14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qT65dSIe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56E3WLTh024679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 23:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752463944; bh=JcFQGAeS14Tp17h5zvMmhgayMu28ieVle0e4AGi+wwY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qT65dSIeDwKgFr4iJV3PTWgJKjKMW6gtqMvwJ2ffuz3t18LmmrjAKP6SEkpr69+4P
	 GMIiw7GrqHkXuco1gKJWf1JXP9yr7czm54iF+3C0u0StzGnCIp2vbSL4Uu9Ia23MXo
	 fd/Ea1rAH2LSWjucgXMWT7XBIWyERcfXvzozAdkBibm2yemg1QPAm2hBOkMImzu1k0
	 Wj5nTnadQfuIHzw2zTCNPJkGacN2fgh678MK3NBiNayxeBmjhFqdHI8HwdlL+ii37R
	 14ZsLo8336cx3VoJhWaEJHWAellyyeqXXADznfprw5G5TJJzWSpmpA0S5Et8CdgQGn
	 tbT67K7Gbqr3g==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BC9632E00D5; Sun, 13 Jul 2025 23:32:21 -0400 (EDT)
Date: Sun, 13 Jul 2025 23:32:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: verify dirent offset in ext4_readdir()
Message-ID: <20250714033221.GB23343@mit.edu>
References: <20250701141141.55938-1-dmantipov@yandex.ru>
 <20250702152304.GM9987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702152304.GM9987@frogsfrogsfrogs>

On Wed, Jul 02, 2025 at 08:23:04AM -0700, Darrick J. Wong wrote:
> 
> Why wouldn't you encode this check in __ext4_check_dir_entry and solve
> this problem for all the callsites?

More to the point, why wasn't this caught when checking the previous
directory entry in __ext4_check_ir_entry() via this:

	else if (unlikely(next_offset > size - ext4_dir_rec_len(1,
						  has_csum ? NULL : dir) &&
			  next_offset != size))
		error_msg = "directory entry too close to block end";

This patch claims to address a syzbot report, but it currently
doesn't have a C reprducer.  Are we sure that this change actually
makes a difference?

					- Ted

