Return-Path: <linux-ext4+bounces-11546-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE935C3D8EC
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6382834E0B4
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776132FB0B2;
	Thu,  6 Nov 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4F/+tbg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B975284693
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467282; cv=none; b=ASyZOml1a00yf7ICiZ7FxcM+aASK3IL8/LaO1ehHhoz07YaYZOLIUpwTAQvc7/Gu8L7iiJp+ftbWGFFhXEkw0ZphgyXb6/1gFuKcsihc2lfUP4yjPUlkQ8XsGTAPf4VChbUdB51cbaj+zfuFb6rRoZlgBRJxsUWj4M+KyyEsQHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467282; c=relaxed/simple;
	bh=Hif963Rcu61YfdM/sYWmktpTrUypzbKb2Nu+CSEpb0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OomnPp3QFQHf5omUpMkWs+kJSN27hXXUtklH+xCR4I5PetopKen0MipIUPjSFXSad4X/5ZL1b6J8q/6u9l2E03S3nj3YYTAo8yVc7jEMW5mLMjvjP3GYkk3XYiIYjG/2zZiSr922E1TMlxqpuWD/1LZWULMghOCQ39jlgRq9joo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4F/+tbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC58C4CEF7;
	Thu,  6 Nov 2025 22:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762467281;
	bh=Hif963Rcu61YfdM/sYWmktpTrUypzbKb2Nu+CSEpb0Y=;
	h=Date:From:To:Cc:Subject:From;
	b=a4F/+tbgCqJDDjQO4vISSZgpn9je9z85mHKzD85V3Wc3aqnic/N5M7riso0j7RhLy
	 ibEtJJwcv+CX5Clhl4YBG0vALftgwlucNlJovFfXrsedQd5Zc0GRq3JMDO0ukvoEYq
	 FySyfcyQ7JIhH8+90rC7QMYXDhOHmbAStZHL3Tz7fSMGeyjkedSEg70T88KgvkV+et
	 E4QI4P3By/y2zDKD86/PXovZa3B6sxd1j2nAxZV2CDYxVa8qi+M0I5aUu+EJLKycpK
	 XW5j5dl34zU6st7hD141wrmcXw/WijW+SZWHsQyMFFSfrCNY6DnbO4GuYOKDWzfeVb
	 8QaUyqF4WwDhg==
Date: Thu, 6 Nov 2025 14:14:40 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCHBOMB 1.48] fuse2fs: new features, new server
Message-ID: <20251106221440.GJ196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ted,

As promised, this large patchbomb contains all the improvements that I'd
like to make to fuse2fs before integrating iomap.  Major new features
include:

 - Fix locking of the block device (or image file) to prevent multiple
   fuse2fs instances.
 - Initializing the htree index in a growing directory so that directory
   lookups aren't horrifyingly slow.
 - Implementing MMP for cluster support.
 - Use file handles to reduce directory path lookups.
 - Implement directory seeking, readdir plus (the fuse version), and
   dirsync.
 - Fix differences in nlink overflow handling vs the kernel.
 - Cache symlinks when possible.
 - Refactor startup and shutdown to reduce main() complexity.
 - Add tracing for file operations.
 - Add the shutdown ioctl for better recovery testing.
 - Drop fuse 2.xx support.

At the end of this series, I create a new fuse ext* server (fuse4fs)
which uses the lowlevel FUSE API instead of the high level one.  The
major advantage of using the lowlevel API is that all file operations
are performed in terms of inodes instead of paths.  As a result, fuse4fs
has MUCH less overhead than fuse2fs because we avoid the overhead of
having libfuse translate inode numbers to paths only to have fuse2fs
translate paths back into inode numbers.

Obviously, this stuff should go into e2fsprogs 1.48, not a 1.47.x stable
release.

--D

