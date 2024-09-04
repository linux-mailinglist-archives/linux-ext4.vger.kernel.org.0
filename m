Return-Path: <linux-ext4+bounces-4049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6FB96C6AA
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 20:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DDF1C2223A
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2024 18:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DFA1E4111;
	Wed,  4 Sep 2024 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zGAF7sRr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F321E2006
	for <linux-ext4@vger.kernel.org>; Wed,  4 Sep 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725475668; cv=none; b=iv4/2brP0R+NUajPNUh32nhycY67JxBmJOjGnk8t47BnoXSohmQ7wuMQP0k3IDtPC1keHVf0+uciV9WuyxU+wxWXfrIedryqmeI14bbTGqN4XGrhuUBgiYiKzCq4pAK5qsXMcO6MSGxorIaFYOmFGL5g571ukt3nXluU/L+jWTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725475668; c=relaxed/simple;
	bh=qlSKN2wgV6ev5aSb4wy+tYrHQbFDfkDI6sX3acAVpJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=izRPphXp1qFwGx9CS8dX3a/3iQoHUwDmTEJpyBDESlhwIvksZZih1DUo2DWE2maDZhln4xZ7EQsvWhmKsyiJXkhMkoZtGOBJlDdi5qxn9+0OX674x39R4Py75O9QBbKaklJGRT0ub7JAeD5+LEjSAQzEUyIRqUeRMH0C4HsDLcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zGAF7sRr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JBHbEbXsO108FDxsMj5RxjlsWKsmPmPGxQLdOtdXFwU=; b=zGAF7sRrMGbNaQbqU99LLietiG
	8gW8DuinosShFOkyAMH17i+uAosCyt0mocBJlXnbBWNqx9EtkP+bnz1ejz4B+JiA2BxDLUACJI8df
	UHCl4mrwILWZx9YyfizLQREE+hKXotVW31Hjnvvn7ld6ZnPUCRyKUM+zIVkspDLbVSLfkbw3pUFK+
	ZssH+72yDhAID7e6K0shLC6ddxJNt5yh2/lOp3/BhR3hFk2lwPqWg9uLdsgnlEh77rpvDliVaTbI2
	60PiUlmNMk+73qKxzjYTCt6CDotXQye+4sY0XXlY+YDrIl+NQL1qnb5sdtTyR5x0893Olxb5xBn1a
	RklDMC/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52838)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1slv2V-0001Wv-37;
	Wed, 04 Sep 2024 19:47:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1slv2T-0003x0-1E;
	Wed, 04 Sep 2024 19:47:33 +0100
Date: Wed, 4 Sep 2024 19:47:33 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Subject: BUG: 6.10: ext4 mpage_process_page_bufs() BUG_ON triggers
Message-ID: <ZtirReiX7J+MDhuh@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

With a 6.10 based kernel, no changes to filesystem/MM code, I'm
seeing a reliable BUG_ON() within minutes of booting on one of my
VMs. I don't have a complete oops dump, but this is what I do
have, cobbled together from what was logged by journald, and
what syslogd was able to splat on the terminals before the VM
died.

Sep 04 15:51:46 lists kernel: kernel BUG at fs/ext4/inode.c:1967!

[ 1346.494848] Call trace:
[ 1346.495409] [<c04b4f90>] (mpage_process_page_bufs) from [<c04b938c>] (mpage_prepare_extent_to_map+0x410/0x51c)
[ 1346.499202] [<c04b938c>] (mpage_prepare_extent_to_map) from [<c04bbc40>] (ext4_do_writepages+0x320/0xb94)
[ 1346.502113] [<c04bbc40>] (ext4_do_writepages) from [<c04bc5dc>] (ext4_writepages+0xc0/0x1b4)
[ 1346.504662] [<c04bc5dc>] (ext4_writepages) from [<c0361154>] (do_writepages+0x68/0x220)
[ 1346.506974] [<c0361154>] (do_writepages) from [<c0354868>] (filemap_fdatawrite_wbc+0x64/0x84)
[ 1346.509165] [<c0354868>] (filemap_fdatawrite_wbc) from [<c035706c>] (__filemap_fdatawrite_range+0x50/0x58)
[ 1346.511414] [<c035706c>] (__filemap_fdatawrite_range) from [<c035709c>] (filemap_flush+0x28/0x30)
[ 1346.513518] [<c035709c>] (filemap_flush) from [<c04a8834>] (ext4_release_file+0x70/0xac)
[ 1346.515312] [<c04a8834>] (ext4_release_file) from [<c03f8088>] (__fput+0xd4/0x2cc)
[ 1346.517219] [<c03f8088>] (__fput) from [<c03f3e64>] (sys_close+0x28/0x5c)
[ 1346.518720] [<c03f3e64>] (sys_close) from [<c0200060>] (ret_fast_syscall+0x0/0x5c)

From a quick look, I don't see any patches that touch fs/ext4/inode.c
that might address this.

I'm not able to do any debugging, and from Friday, I suspect I won't
even be able to use a computer (due to operations on my eyes.)

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

