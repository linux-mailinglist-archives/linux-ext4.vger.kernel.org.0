Return-Path: <linux-ext4+bounces-12120-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A51CC99F67
	for <lists+linux-ext4@lfdr.de>; Tue, 02 Dec 2025 04:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B9194E21F9
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Dec 2025 03:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D922A7E0;
	Tue,  2 Dec 2025 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YP5MbotM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6DB128395
	for <linux-ext4@vger.kernel.org>; Tue,  2 Dec 2025 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764645935; cv=none; b=G1Q5rCRFhW/+f4pyMWyVa+BYPNOgR+Gpb4lr67Yvcwu/20n6SORwer6prXuj/s6jndJ56NJF9GxOFwzr31zhQSKOaUXnY9uHKcGqJ61M2qs+MpCovPq7rVyqQl8aBqqq1fzSXNoPDSBQSJ3YXjtYh9RkJsWri05PSOmMw9Xlq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764645935; c=relaxed/simple;
	bh=I1neRmC+05myJG9I83trZ8DBXe2KEWaK4DzOyKZdYhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn6bx6gWx7d/u9hDU3A33Jia1Cdd8GwxtzzY7nSGImTaP25W/gNHxHB994ancfVgQW787fF9Oy3ta+WjvAbhPx9smlg89UgTu98XNNP6qjo5tZa5f0toJl3B68MgOp/hChV0xXQsjtv9zMMKgJRBL3BDnhTrnDwWlnlaHc9OCJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YP5MbotM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B23PNCf031520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 22:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764645927; bh=MrWYUwuMQWwzZZNZhsGF0wDwxb0+B4i3vFOtct8V02w=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YP5MbotMuTJf7ISNqMBSStp1smSdG9fvQzWWrMEqNREAkngTYXWwcO1IQT4ehajvP
	 5ToXc4yP8Q9ThgQoe0eanuu4tiKegGxydSC+WfX49UhnVRKemz0vsjb7vs4Nw8RJcI
	 uB9MZQlSqcZQ6Bh38HlMwksV4xmDIT88cFfgImUJEhp0rkfMZ5fKSrsp3v5av/fI6X
	 1w4kCYztrsU/iNsvv5nLrZ0RnnEmznp7Pc8CZaXtUBOvtv3vpcL1HCotzIvYnCp1QJ
	 BzbhNKotyk3G4MNT1y+G/AeLTufSKKQc2uAjfZv4BpLs7GPsEHpEmKpb/gEW1YPvRB
	 CePUexjWteKdw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 557FF4DC1DE5; Mon,  1 Dec 2025 22:24:23 -0500 (EST)
Date: Mon, 1 Dec 2025 22:24:23 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: ????????? <haochengyu@zju.edu.cn>
Cc: security@kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix KASAN slab-use-after-free in ext4_find_extent
 due to corrupted eh_entries
Message-ID: <20251202032423.GC29113@macsyma.lan>
References: <1975626f.37736.19ada7d3de4.Coremail.haochengyu@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1975626f.37736.19ada7d3de4.Coremail.haochengyu@zju.edu.cn>

On Mon, Dec 01, 2025 at 11:17:12PM +0800, ????????? wrote:
> Hello,
> 
> I would like to report a potential security issue in the Linux
> kernel ext4 filesystem, which I found using a modified
> syzkaller-based kernel fuzzing tool that I developed.

Thank you for submitting this bug report, and thank you for doing the
work to create a simplified reproducer and doing the initial analysis.
It is much appreciated.  Unfortunately, I haven't been able to
reproduce the issue.  You didn't send me the exact kernel config that
you used, so I used my default kernel config that I use by testing
via:

% install-kconfig --kasan
% kbuild

... using the kvm-xfstests utilities that can be found at [1], in the
kernel-build directory.

       https://github.com/tytso/xfstests-bld

I tried using both the latest mainline kernel, as well as 6.12.51,
this that was your reported that you were doing your testing.

% kvm-xfstests shell
    ...
root@kvm-xfstests:~# uname -a 
Linux kvm-xfstests 6.18.0-rc7-xfstests-kasan-01168-g7b2a79c93971 #312 SMP PREEMPT_DYNAMIC Mon Dec  1 21:30:56 EST 2025 x86_64 GNU/Linux
root@kvm-xfstests:~# cd /vtmp/   
root@kvm-xfstests:/vtmp# ./repro_simplified 
[*] Using loop device: /dev/loop0
[   14.949088] loop0: detected capacity change from 0 to 512
[   14.953285] EXT4-fs warning (device loop0): ext4_multi_mount_protect:324: MMP interval 42 higher than expected, please wait.
[   14.953285] 
[   59.461261] EXT4-fs (loop0): warning: mounting unchecked fs, running e2fsck is recommended
[   59.463299] EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
[*] Mounted image.img to ./mnt
[*] Triggering bug...
[*] sendfile returned: 170
[*] Done. If kernel didn't crash, the repro finished.
root@kvm-xfstests:/vtmp# 

So I then took a look at the code in question, and at your proposed
patch.  If you could do some more analysis, please take a look at all
of the checks done by the function __ext4_ext_check(), which
implements the checks in the functions ext4_ext_check_inode() and
ext4_ext_check().  These functions get called when the inode is read
into memory (for the root extent tree in the inode) or when an extent
tree block is read into memory.

So I'm not sure why your patch would make a difference --- and given
that your simplified reproducer isn't triggering the crash, even when
KASAN is enabled, I can't validate whether your patch *would* make a
difference.

Could you try to do a deeper analysis?   Thanks,

						- Ted

