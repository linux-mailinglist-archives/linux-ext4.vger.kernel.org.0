Return-Path: <linux-ext4+bounces-8399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7DAD786B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4829B188B655
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C429AAEC;
	Thu, 12 Jun 2025 16:43:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDF299AB1
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749746605; cv=none; b=lt4apNTZGaDulC+xDxzpmZDd9PCZiUDo6jrhFPrrPCEM8KRLlbujTFJNnwPFkYlNWvkdj8ZjDFJz535CyjqAYdNp2nfFTv8Dn6n6D1WO/RJih1WVp+9RO0BYHE15a20OtuNcN/Bst6xRChG54nylkL3ydX2skwbyuZ6B8cCRoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749746605; c=relaxed/simple;
	bh=Aly4l9gOAprdUf8wI8qqdw/3PWNNjaBK4PBCcSmMMKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sibUCC3CDfgEwEEehk2asXhXYlSYuZtpvHbIsCq6B5q9TDbiu1g3SSrTW72CBCjeVw7xVW0mUoFy6MYhfVwu9jSw/falCDssqKDa1zzgsitmx7KrlMZA63u/MBbyMUwA1D2SOSOItqvbXviRIOa7fDoyspEO/masHGr/v9cA/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([154.16.192.111])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55CGh5xI027732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 12:43:07 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 482BB346B55; Thu, 12 Jun 2025 12:43:04 -0400 (EDT)
Date: Thu, 12 Jun 2025 14:13:04 -0230
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse2fs: catch positive errnos coming from libext2fs
Message-ID: <20250612164304.GQ784455@mit.edu>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
 <174966018106.3972888.12154557537002504919.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174966018106.3972888.12154557537002504919.stgit@frogsfrogsfrogs>

On Wed, Jun 11, 2025 at 09:44:17AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Something in libext2fs is returning EOVERFLOW (positive) to us.  We need
> to pass negative errnos back to the fuse driver, so perform this
> translation.

This isn't actually the best way to fix things.  The way the com_err
architecture works is that errcode_t is a 32-bit unsigned integer,
where the the top 24-bits is a subsystem identifier.  If the subsystem
identifier is zero, then the low 8 bits is presumed to be an errno
value.  Otherwise, the subsystem identifier is formed by taking a 4
character identifier from 62 valid code points A-Z, a-z, 0-9, and _,
where A is 1, and _ is 63.

Error table subsystems that are in common use and used by packages
shipped by most Linux distributions include "krb5" and "kadm" from the
MIT Kerberos implementation, and "ext2" and "prof" which ship as part
of e2fsprogs.  The original design came from Multics, and the idea is
that a library might call other libraries, and having a single unified
error code namespace can be super-useful.  Top-level callers can check
to see if an error is non-zero, and if so, call error_message(retval)
and get back a human-friendly string regardless of which library might
have originally generated the error.

CMU has a handy-dandy registry of the various libraries that use the
common error infrastructure here[1].

[1] https://www.central.org/frameless/numbers/errors.html

In the case of the ext2fs library, it doesn't actually call any AFS,
Kerberos, ASN.1, etc. libraries, so in practice the only valid error
codes that we should get back are either in the range 0..255 and
EXT2_ET_BASE..EXT2_ET_BASE+255.  But at least in theory, it's possible
that in the future, libext2fs might call some other library that might
return com_err error codes.

So a better, more idiomatic fix would be something like this below.

       	       		      	      	- Ted

P.S.  By the way, I'm not entirely convinced by the is_err vs !is_err
logic.  I get the idea is that we want to not log certain error cases
resulting from looking up a non-existing file name, but for example,
EXT2_ET_NO_MEMORY or any of the EXT2_TDB_* error messages should never
happen under normal circumstances, so if they do happen, they probably
should be logged, and so perhaps is_err=1 should be set for those
errors.  Similarly, I suspect that any MMP errors should probably also
be logged, but we can handle that as a separate commit.


commit 71f046a788adbae163c9398fccf50fff89bb9083
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Thu Jun 12 14:03:44 2025 -0230

    fuse2fs: correctly handle system errno values in __translate_error()
    
    Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
    Reported-by: "Darrick J. Wong" <djwong@kernel.org>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bc49edfe..97b1c5b5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4659,9 +4659,9 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 	int is_err = 0;
 
 	/* Translate ext2 error to unix error code */
-	if (err < EXT2_ET_BASE)
-		goto no_translation;
 	switch (err) {
+	case 0:
+		break;
 	case EXT2_ET_NO_MEMORY:
 	case EXT2_ET_TDB_ERR_OOM:
 		ret = -ENOMEM;
@@ -4755,11 +4755,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
 		break;
 	default:
 		is_err = 1;
-		ret = -EIO;
+		ret = (err < 256) ? -err : -EIO;
 		break;
 	}
 
-no_translation:
 	if (!is_err)
 		return ret;
 


