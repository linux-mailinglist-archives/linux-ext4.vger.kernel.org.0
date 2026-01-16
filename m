Return-Path: <linux-ext4+bounces-12948-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E353FD38A5B
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 00:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E591300EA26
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 23:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205033101D0;
	Fri, 16 Jan 2026 23:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Eeq+06pE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95714A4F9
	for <linux-ext4@vger.kernel.org>; Fri, 16 Jan 2026 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607064; cv=none; b=d+yEqVnX7azw6TlqHzZ0qP4GH6jg8ZBEBgT+YzA87eIWrfaZuBCm9kzORmu4fDSvxbkHybcTn97XD+LjT7qXGi/gZ6it2b5oxoAEuSpxLRafKwK+Hyb5SW1kxZV7fU5Gg4aYHGD/AeN8GClH4QCpIq9n05yExCYPbuDPVi1o5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607064; c=relaxed/simple;
	bh=leMK973I3XZ6DVLBg8rfe1cmMJfMAiYbsmg2F8LGQPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfvRGAk/LA5APhnRpz2sWhZqIQjEUuMFzD0rHvEodfz6E0NeArPdIuDoq6gm0+1qyW18wOsloEjxIcdEVuzxzJuN7nqHt0YZbQuzmRezOVKtilhF41OG7VVGFny3CZfzivU7DNEZnLCPy9/3kRfFiMosUdn7NxIX+JxYS3NOsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Eeq+06pE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([193.36.225.166])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60GNi6tv022520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Jan 2026 18:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768607050; bh=jZaLHVybgFnxJOpCBsVw5YHuvvD73xD90zfnHhtDDmI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Eeq+06pE5Xo6ZK6fXtnlhuY8c5QnwzBGonmF7iQa5XzbOBk8NlH4aIrMBFa2lHXPU
	 rq0NQi9RY9CTuITxUhhr4VAGq7zrSChzYXLjveivJHiCjlnRHKTzWQdY5QPKctdpTm
	 iwstbVhLZsXz+2efhggMOqVOFMBR1tMFPA5c0B+X1lZiY5G+yHDDCKsHPC/ruN8Rwn
	 2dyerOddYX5tUKg5jmTmNWVwAWmoNxfDeXH0hw+W+qauTQYGez/vqNzqyw7CpmBfzR
	 0OENftuWOadBPXER0RaPUsYP8KeRbdlvUZ/8sKhv4Hony1LK6jA9C+OVMRNC0bjWWe
	 uWhxSM5KVCOsw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 87A7F54FE54D; Fri, 16 Jan 2026 13:44:05 -1000 (HST)
Date: Fri, 16 Jan 2026 13:44:05 -1000
From: "Theodore Tso" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] e4defrag inline data segfault fix
Message-ID: <20260116234405.GG19200@macsyma.local>
References: <4378305.GUtdWV9SEq@daniel-desktop3>
 <20260116172139.GB15522@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116172139.GB15522@frogsfrogsfrogs>

On Fri, Jan 16, 2026 at 09:21:39AM -0800, Darrick J. Wong wrote:
> On Fri, Jan 16, 2026 at 05:25:35AM -0500, Daniel Tang wrote:
> > Please sign-off on, and apply, the patch at
> > https://gist.github.com/tytso/609572aed4d3f789742a50356567e929 . It
> > fixes the bug at https://github.com/tytso/e2fsprogs/issues/260 .
> 
> Perhaps that patch should get posted to the list for a proper review?

The context was that Daniel had proposed a pull request on github:

   https://github.com/tytso/e2fsprogs/pull/261

I had reviewed the change on github, and counter-proposed a better
fix, which was what Daniel was referring to on the gist.github.com,
and asked him to confirm that this fixed the issue that he was
concerned about.

This took place in early Ddecember, and I lost track of it because of
the holidays.  (Daniel, that's because my primary workflow is e-mail,
and github issues and pull requests are things that I look at on a
best-efforts basis, whereas with e-mail I have things like Patchwork
to make sure I don't lose track of patch discussions.  It also means
that other people can more easily review proposed fixes.)

Anyway, for folks on the ext4 list who might be curious, here's the
fix.  As it turns out, this is one where the description of the fix
takes a lot more space than the actual fix itself.  Which is why I
hadn't bothered to write it all up before asking Daniel to test it to
make sure it fixed the issue that he had run into.

      	    	       	    	       - Ted

commit 23785e90554b301b90076568fd33eb76dc930fba
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Fri Jan 16 18:01:09 2026 -0500

    e4defrag: don't try to defragment files which have 0 or 1 blocks
    
    This fixes a crash in e4defrag when the file is using the inline_data
    feature, and so the file data is stored in the inode table.
    Technically speaking, such a file does not consume any data blocks,
    but when an application program calls stat(2) on such a file, and
    st_blocks is set to 0, it might confuse the program into thinking the
    file did not contain any data.  For this reason, ext4 returns 1 in
    st_blocks.  (For other files or directories, st_blocks will be a
    multiple of the file system block size divided by 512, since st_blocks
    is denominated in units of 512 sectors on Linux --- and most other Unix
    systems with the notable exception of HP-UX.)
    
    Unfortunately, when e4defrag tries to defragment a inline data file,
    it divides st_blocks by (fs->block_size / 512), and this results in
    e4defrag thinking that the file 0 data blocks --- and since the file
    is not skipped because st_blocks != 0, this results in crash when
    dividing by zero.
    
    As it turns out, it's pointless to try to defrag a file with 0 or 1
    data blocks.  So fix this by skipping any file where st_blocks <=
    block_size / 512.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/misc/e4defrag.c b/misc/e4defrag.c
index bbeb5b167..68e937fdb 100644
--- a/misc/e4defrag.c
+++ b/misc/e4defrag.c
@@ -1091,11 +1091,11 @@ static int file_statistic(const char *file, const struct stat64 *buf,
 		return 0;
 	}
 
-	/* Has no blocks */
-	if (buf->st_blocks == 0) {
+	/* Has 0 or 1 blocks, no point to defragment */
+	if (buf->st_blocks <= buf->st_blksize / 512) {
 		if (mode_flag & DETAIL) {
 			PRINT_FILE_NAME(file);
-			STATISTIC_ERR_MSG("File has no blocks");
+			STATISTIC_ERR_MSG("# of file blocks <= 1");
 		}
 		return 0;
 	}
@@ -1452,11 +1452,11 @@ static int file_defrag(const char *file, const struct stat64 *buf,
 		return 0;
 	}
 
-	/* Has no blocks */
-	if (buf->st_blocks == 0) {
+	/* Has 0 or 1 blocks, no point to defragment */
+	if (buf->st_blocks <= buf->st_blksize / 512) {
 		if (mode_flag & DETAIL) {
 			PRINT_FILE_NAME(file);
-			STATISTIC_ERR_MSG("File has no blocks");
+			IN_FTW_PRINT_ERR_MSG("# of file blocks <= 1");
 		}
 		return 0;
 	}

