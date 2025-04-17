Return-Path: <linux-ext4+bounces-7324-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCEA922D9
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 18:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232DA7A4D33
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Apr 2025 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE173254B11;
	Thu, 17 Apr 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYRzyi5U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF2254874;
	Thu, 17 Apr 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744907901; cv=none; b=RIC+96YVgg5z5zhj7uAg3r7hZRrpnU1+76nWgjq2977fY7OwsuO31nyHnDKGeF5FxOLJMMEbBzXzWMjm84hXD+l4Tohhcl2hMp/iHYRQvmrqc1ht3FfadgkApACNaqkBmu9HB/DT7dUP/5NRU6ZeTdJtWobdkcSALo3nu/UbkRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744907901; c=relaxed/simple;
	bh=8u1hXwMdXir2SLE0egp2yv68e6ydmvfY49SNR06fEW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkTbHRUJsaYYxnlOZpGXomhXtAZ/bT75HPxQ5lCZp0bp18f/Rir318wrWdn+8hx6yL5j7AyzceZgYgxLOjNYJU4pQiXkKW0Ko5s/8ot+zBuptnvKqztNPBy9p9kfR+2yQJ6MpsV66F2Ba0GTYqJeE122KGSJYMPWt0H36FgZtg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYRzyi5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E061EC4CEEE;
	Thu, 17 Apr 2025 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744907900;
	bh=8u1hXwMdXir2SLE0egp2yv68e6ydmvfY49SNR06fEW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYRzyi5UxINQ/Aly/B4crAvRbABsATvbivoLQ5RxvNoUcHU8WKZbuhD3Dhtzas5QT
	 qbxaSXKpY6IWf6WiX9QVIA51DIqdw80ZVidoB1klwRhsyK85F37A6mTwGw7AyDKxMY
	 Y8GjqxCamyid35RagqeEGdPSpHu5M3GsBhlYHhFYQ/mh7/DIeB2hWGWcjX5n3IbYZg
	 tOpzf+kILQDnWKNdEEaPLRmFUETdvbI0cM5oFJqiqJr6S8YiaR4CKdDCOtXxEPoV29
	 2UOjDPi5wHwMsaA4DSu0y6VY6MpSeaguCGl87oNY5evaM18UG48wuYqqF0kVZL5BWG
	 jR5Tjnaos1DzQ==
Date: Thu, 17 Apr 2025 09:38:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Luis Chamberlain <mcgrof@kernel.org>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, kdevops@lists.linux.dev,
	dave@stgolabs.net, jack@suse.cz
Subject: Re: ext4 v6.15-rc2 baseline
Message-ID: <20250417163820.GA25655@frogsfrogsfrogs>
References: <Z__vQcCF9xovbwtT@bombadil.infradead.org>
 <20250416233415.GA3779528@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416233415.GA3779528@mit.edu>

On Wed, Apr 16, 2025 at 06:34:15PM -0500, Theodore Ts'o wrote:
> TESTRUNID: ltm-20250414133140
> KERNEL:    kernel 6.15.0-rc2-xfstests #22 SMP PREEMPT_DYNAMIC Mon Apr 14 12:18:46 EDT 2025 x86_64
> CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c ext4/all -g auto
> CPUS:      2
> MEM:       7680
> 
> ext4/4k: 587 tests, 55 skipped, 5340 seconds

Hum.  My tests show:

Kernel: 6.15.0-rc2-xfsx
Format: mkfs.ext4
Mount: -o acl,user_xattr
Testing: -r -g all -x dangerous_fuzzers,recoveryloop,broken,deprecated
Failures: generic/045, generic/046, ext4/043, ext4/053, generic/697, generic/633, generic/696, generic/044
Status: Failed 8 of 553 (1.4%) tests, covering 40% of 2,077 in 2.2 hours.

mke2fs.conf has:

[defaults]
	base_features = sparse_super,filetype,resize_inode,dir_index,ext_attr
	default_mntopts = acl,user_xattr,block_validity
	enable_periodic_fsck = 0
	blocksize = 4096
	cluster_size = 32768
	inode_size = 256
	inode_ratio = 16384

[fs_types]
	ext2 = {
		inode_size = 128
	}
	ext3 = {
		features = has_journal
		inode_size = 128
	}
	ext4 = {
		features = has_journal,extent,huge_file,flex_bg,uninit_bg,dir_nlink,extra_isize,64bit,metadata_csum,quota
		inode_size = 256
		quotatype=usrquota:grpquota:prjquota:
	}


generic/04[456] fail with a bunch of:

--- /run/fstests/bin/tests/generic/045.out	2025-01-30 10:00:16.774276934 -0800
+++ /var/tmp/fstests/generic/045.out.bad	2025-04-16 14:44:41.434069835 -0700
@@ -1 +1,1000 @@
 QA output created by 045
+corrupt file /opt/1 - non-zero size but no extents
+corrupt file /opt/2 - non-zero size but no extents
+corrupt file /opt/3 - non-zero size but no extents
+corrupt file /opt/4 - non-zero size but no extents

ext4/043 seems to fail because it tries to create 128b inodes with
project ids and fails.

ext4/053 I suspect fails because built-in quota conflicts with the quota
mount options.

generic/{633,697,696} fails with:

--- /run/fstests/bin/tests/generic/697.out	2025-01-30 10:00:16.953276275 -0800
+++ /var/tmp/fstests/generic/697.out.bad	2025-04-16 15:54:39.173837150 -0700
@@ -1,2 +1,4 @@
 QA output created by 697
+utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create
+utils.c: 928: openat_tmpfile_supported - Invalid argument - failure: create
 Silence is golden

No idea what that's about.

--D

