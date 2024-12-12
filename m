Return-Path: <linux-ext4+bounces-5598-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE759EFC2E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 20:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB3218900DA
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 19:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069A81922EF;
	Thu, 12 Dec 2024 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="J1cc5F/S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EE18CBFB
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030973; cv=none; b=Ehvws+CEVAeKubBzqQw7epr+qyL9PSAkz5fUO7sQ/daL1iahsJFTq4fduZwTBme265S1hjSj96c3pCsVpBNMYVOnZB7kBCSq6U+rIv3KICBPvz2F3uaGf1hHpWn0CSiVpGvIueTZ3rKQpK9gnAgs1m5A73puLXlXHVqPl+bBU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030973; c=relaxed/simple;
	bh=skFXEL+76fVYihCVs35mdgzhvYE7ko0uc9dr8XUt/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5iO8Tdd8QD5LV7XwSascmfZlzdEKpDNCGdnoHhjpEEC2H2YxbSetN/aDYHop7LvAwJDqtftKBcAIV4g5zDBUkWQ20wahxk+C8LMy8jPuCrSIIBxg1L+SWndf1Q4eSsBLVOxQRN81bgwAkYSAPfMry4NP50X2lhf9GjxyYI+Vac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=J1cc5F/S; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BCJG3PQ030704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 14:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734030965; bh=1/K7UU6w6q8URFOfA+h9O8es187FoqkuT4UwjnFhREI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=J1cc5F/S6r4ewPx4wx11OO/yUhwFd7clXo1lQJHsVk5sRdppkHMehYMtMLOYJ38BE
	 5ekavEUDDYPUlattBs2umwb8PHH/uPiOafi5Oev8ZVV3UweSjCDn4NzeQwFY/5+vig
	 veBS5LzFBy216eZRIFtuj+9igycjddnIS0IFSpzSDWx2fHlZdrlUyDFtCT7xv89PP8
	 cTXlOOPnwQE/S7zweU94TST0ZhjXQSjY87+oN8H3ofSbObT6t3xJdigTsG8BjwCB8X
	 /wioPFiWTIp5IAKI8/u5jFTUf/N8isOFY9z7Y4bQKdXHQa6PQn4FApDtIDtBnrnR7E
	 nf0+w0LucUVfQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id CD98015C028A; Thu, 12 Dec 2024 14:16:03 -0500 (EST)
Date: Thu, 12 Dec 2024 14:16:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nikolai Zhubr <zhubr.2@gmail.com>
Cc: linux-ext4@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
Message-ID: <20241212191603.GA2158320@mit.edu>
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>

On Thu, Dec 12, 2024 at 09:31:05PM +0300, Nikolai Zhubr wrote:
> This is to report that after jumping from generic kernel 5.15.167 to
> 5.15.170 I apparently observe ext4 damage.

Hi Nick,

In general this is not something that upstream kernel developers will
pay a lot of attention to try to root cause.  If you can come up with
a reliable reproducer, not just a single one-off, it's much more
likely that people will pay attention.  If you can demonstrate that
the reliable reproducer shows the issue on the latest development HEAD
of the upstream kernel, they will definitely pay attention.

People will also pay more attention if you give more detail in your
message.  Not just some vague "ext4 damage" (where 99% of time, these
sorts of things happen due to hardware-induced corruption), but the
exact message when mount failed.

Also helpful when reporting ext4 issues, it's helpful to include
information about the file system configuration using "dumpe2fs -h
/dev/XXX".  Extracting kernel log messages that include the string
"EXT4-fs", via commands like "sudo dmesg | grep EXT4-fs", or "sudo
journalctl | grep EXT4-fs", or "grep EXT4-fs /var/log/messages" are
also helpful, as is getting a report from fsck via a command like
"fsck.ext4 -fn /dev/XXX >& /tmp/fsck.out"

That way they can take a quick look the information and do an initial
triage over the most likely cause.

> And because there are apparently 0 commits to ext4 in 5.15 since
> 5.15.168 at the moment, I thought I'd report.

Did you check for any changes to the md/dm code, or the block layer?
Also, if you checked for I/O errors in the system logs, or run
"smartctl" on the block devices, please say so.  (And if there are
indications of I/O errors or storage device issues, please do
immediate backups and make plans to replace your hardware before you
suffer more serious data loss.)

Finally, if you want more support than what volunteers in the upstream
linux kernel community can provide, this is what paid support from
companies like SuSE, or Red Hat, can provide.

Cheers,

							- Ted

