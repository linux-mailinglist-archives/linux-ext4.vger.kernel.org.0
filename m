Return-Path: <linux-ext4+bounces-3891-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0359600FC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 07:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED6751C21A50
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2024 05:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA575476B;
	Tue, 27 Aug 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guXIZHzl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3A171AF
	for <linux-ext4@vger.kernel.org>; Tue, 27 Aug 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735877; cv=none; b=DzwLKLt8SI0uXgWksXED8TEPNTc9+XOjNw75jk961f6FuplkngA4/OmZPI+BOzbCHzixWt9cMX9CCqsoZaa06/6EwrH6Ygg19w07p0d2dsrTsKUjk1VM7qgMzeUAXOAXmRjO3v9XdFguKJaQpZmXMFwgK4Bm7+D153RMiqlH4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735877; c=relaxed/simple;
	bh=U5MOs/IuPu1TXIzSrR+qInCecxlfoR6ahJOuaMSgqpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFxg/0V2rRNFyrvcLB/6a8ty3e/G9gPT4ls9R+WWQrFd24ru6sHfGrTWnAVRv6KboqRaX/qM4ajkBwc5TpP6+xQPqlhKUbmh2RD55oxP1P1dEHb1LE746VkfNXmAy2Ztq5ODuxHj20X3oQ5e2ic9ZBKhJhggP0uUZ5sZ1QDfdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guXIZHzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09C3C8B7A3;
	Tue, 27 Aug 2024 05:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724735877;
	bh=U5MOs/IuPu1TXIzSrR+qInCecxlfoR6ahJOuaMSgqpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guXIZHzl+67jEtq+XSguM8wACfoD1Bfbbwj9t/Amb3MxzgWWqflGO4YVn9+7aEbsB
	 RE49cH4Fmgl5Dd1ej8fl8yNEcprYpI1AzIRgRKbPO43cYAUK5Le+FzRTk3SitdT2yT
	 YF1EBmCzQqtjQubmh2d+EtH0BXCF5yyQc9IgJk0tRzQI5jUOT1Cwq8cMgE2hOkcU/p
	 mXZHdwX/26lLdgQMI8X9M0kiA/pmETVBuBJZxniGYJdg/5Q/0BZ0qHAzBJhStNLunY
	 d7HhjFVKLutTctGHaX/uas6Pn+Pk/9j6LHK+I1YBON9dYF0H/cw+4lRGeMSju2IU/y
	 V6DkW4mUdVVEA==
Date: Mon, 26 Aug 2024 22:17:55 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: bugzilla-daemon@kernel.org
Cc: linux-ext4@vger.kernel.org
Subject: Re: [Bug 219200] New: update from 6.11.0-rc1 to 6.11.0-rc5 causes
 file system check every boot
Message-ID: <20240827051755.GA7473@sol.localdomain>
References: <bug-219200-13602@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bug-219200-13602@https.bugzilla.kernel.org/>

On Tue, Aug 27, 2024 at 12:04:56AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219200
> 
>             Bug ID: 219200
>            Summary: update from 6.11.0-rc1 to 6.11.0-rc5 causes file
>                     system check every boot
>            Product: File System
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: ext2
>           Assignee: fs_ext2@kernel-bugs.osdl.org
>           Reporter: publiccontact2020@protonmail.com
>         Regression: No
> 
> Reverting from 6.11.0-rc5 to 6.11.0-rc1 resolves the issue of file system check
> at every boot.
> 
> This issue is observed accross Debian, Gentoo, Arch and Fedora Rawhide.
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

This was already fixed by the following commit:

    commit 232590ea7fc125986a526e03081b98e5783f70d2
    Author: Christian Brauner <brauner@kernel.org>
    Date:   Mon Aug 19 10:38:23 2024 +0200

        Revert "pidfd: prevent creation of pidfds for kthreads"

