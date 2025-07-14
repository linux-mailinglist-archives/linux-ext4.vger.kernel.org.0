Return-Path: <linux-ext4+bounces-8977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E0B03F50
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5784116C12F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jul 2025 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F7248F5E;
	Mon, 14 Jul 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Shja++CB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B504A1A
	for <linux-ext4@vger.kernel.org>; Mon, 14 Jul 2025 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498618; cv=none; b=pS1GkHY1LCwAkQOELD85xZ+F2mZwtwmCc/jivfz8rF6d5SMcxbkLgBtweQVYb3bSBVGf8PNpTWhj/bm8OtmjQ8NTX2uJAVtSMCFN+yrZ/JvOeyY58MmrquIj35z8aMolKfWPpqlOdCUUH8ecAGjq8wr/GY1mQYz3OGlD7abNZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498618; c=relaxed/simple;
	bh=H4SKZjEc/u6YTb3HSpbG5NllqvZt9OCpm4YSLVpwxec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2YEww4bJX7i4Xy4Kxd+clWxXi2muO3AgOAyOseSAfUUH7W4WQZORzIHRTdIJvFFoipuCcb2rahiQD34too/VSfCk+Syg1vJuqEuyM0OfcZNJaEj/0ZO84hh4xwm1jqrCms9U7CBWcn67X3l+KKBIdWOMPcMFfvBA+XHFyd0CZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Shja++CB; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56ED9psi012077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 09:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752498593; bh=WsYVfYMkzdtmf/SQ6JphqxXJec6GGSwCJTtBCG2WdWc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Shja++CBENnWHhtMW9kY7QRoa8fJ2eLGJZzq3ruHW9KdSOlE5QmpKUJZsz/q0tNwp
	 mIhZmQWhpVmxy/JatsAKn9wQMO8oEpvKk3Ftjur7xCKhiT+qH7zS/iCSTmDNpEvH0h
	 LSXemODGFek7p4cBYuSH/TdZN4wg1VdpdbyriZZKtNDuDBPWQOrG9Qk/XJXYBUW8U7
	 E5yd1sQTKIEHaAoSL9Fyau1UOgIQWXmFshCB7IWgYZ1VpqBGoXs3EtMd8V+Qs2/XcB
	 8ilwj/srvv8iGeUOkg4jKp39VmmRJciygFsKP82TLCxveoRz7S4H+Xh+Q7PcnAU8UV
	 f2DmOZlHbgOsg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3491E2E00D5; Mon, 14 Jul 2025 09:09:51 -0400 (EDT)
Date: Mon, 14 Jul 2025 09:09:51 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiany Wu <wujianyue000@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, yi.zhang@huawei.com, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: Issue with ext4 filesystem corruption when writing to a file
 after disk exhaustion
Message-ID: <20250714130951.GB41071@mit.edu>
References: <CAJxJ_jhEbHJiP-OzSpp2xqai-n=t2CGKXqkmvqf7T3i37Eki0A@mail.gmail.com>
 <20250711052905.GC2026761@mit.edu>
 <CAJxJ_jhYUqYhNcsLnjPv+2-n83G77zeQ1jppC6YGfo6bHv+vaA@mail.gmail.com>
 <20250711154012.GB4040@mit.edu>
 <20250712042714.GG2672022@frogsfrogsfrogs>
 <20250712143432.GE4040@mit.edu>
 <CAJxJ_jh=4q81OnSXk=yAU3u_7CCHZLGhb31eALF0cSyNv34E1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJxJ_jh=4q81OnSXk=yAU3u_7CCHZLGhb31eALF0cSyNv34E1g@mail.gmail.com>

On Mon, Jul 14, 2025 at 12:37:21PM +0800, Jiany Wu wrote:
> Hello, Ted,
> 
> Good day, thanks indeed for the clarification~
> Yes, previously tried to mount a specific ext4 disk-img to /var/log,
> with /dev/loop1 device, and rsyslogd will write to /var/log/syslog.
> When /tmp directory exhaust manually via fallocate, / dir will be also
> occupied as 100%, and rsyslog write errors in /dev/loop1 happen, later
> mount as read-only. Different from the early scenario, but this
> scenario is not easy to reproduce.
> Tried updating the test case, not fallocate all spaces in disk, now
> alloc 95%, everything is normal now, no related error prints anymore.
> It is confirmed errors are caused by disk exhaust.
> I think the main hesitation part is whether fallocate is allowed to
> use the whole disk space.

The fallocate system call is allowed to use the whole space on the
*file system*.  But it doesn't know about how much free space a
thin-provisioned device's underlying storage is available.  If you are
using a loopback mounted image on a disk, if the underlying file
system on the disk fills up then the block device will have I/O errors
--- and then the file system on the loop device will run into
problems, either data loss or metadata corruption.

So this is working as intended.  If you don't want this, either don't
use a loopback mount with a sparse file; either use fallocate when
creating the image file, or don't use a loopback mount.

				- Ted

