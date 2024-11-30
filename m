Return-Path: <linux-ext4+bounces-5443-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA29DF390
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 23:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D51281584
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Nov 2024 22:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA3B1AAE34;
	Sat, 30 Nov 2024 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Icx7zvLe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C6E19307D
	for <linux-ext4@vger.kernel.org>; Sat, 30 Nov 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733006582; cv=none; b=jljPD2MMTeEI1+cYi2NTzNbBF+40MTlRxMMAIEG878LetBdIMrHA4Ygge5/SBlUpQ8gsHuBWdq3Hn/J2MVYjhK7TFW9MDrjO9niibsKbUlSaF9jvMeRNPofWBWUhs+KhzoguUmwaB90I2j05dZcBagd8wmNRvb1jDGfvSnTjv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733006582; c=relaxed/simple;
	bh=Dzx07YiM0kiSUl/v347ethXqAc91eSOf/n2obmCG1uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIrgb0BkfrQ9rK+1Q1MIgaY9VI822Q8L6ByWTdLck8q7se/da2h4+6jjLQtNP4mQZ0XM1X4dZAsQiHjh7YUNOJB7p4xzzWfvTmJJSHvaPOK32z8o9wv0l+K2vKcAUwHnylgf9n+ktClwMpOy6zTn8M9f7gKYNnOHqHmDy4/cOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Icx7zvLe; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-132.bstnma.fios.verizon.net [173.48.113.132])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AUMgkhH017167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 17:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1733006568; bh=URFmkBQwt8UZCMCPsKxHz7x8XLLiyw9jPOomafdVnFU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Icx7zvLeB/jhfLZ7/DR978Dh5upUdgrW7u/gl09S64vySdqD5kFAyo9SFpkSgdlWY
	 ayqIxnOqPyyVtNOvK7Y2JFOcvxFZO5VLNV3PQMmXLte4NZJvwmlHCPbVnQ8y9HI7KU
	 NxkoxcBUGSeki9vH/9pcfPYpAuYIdkAF/wgTMsogSy/c2F0B1tIEOh32NAT4E4FAK+
	 cvcpFEJNe6xEpDntnPEzzIdwC5f4Rf/LTgCzzd6u0VXh6mukDuSuRomRxVz5Rut/Uc
	 NBou3rjd2ZcHHFaOUt3aW9tuORx5AMoorruuSsLO8nHuJ8H4c2Tzw5VFjzZtWxKvct
	 Gml6qbKTpIksQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 93D7815C035D; Sat, 30 Nov 2024 17:42:46 -0500 (EST)
Date: Sat, 30 Nov 2024 17:42:46 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Release candidate for e2fsprogs 1.47.2 is available
Message-ID: <20241130224246.GB1745339@mit.edu>
References: <20241130013429.GA812025@mit.edu>
 <20241130203607.GC9417@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130203607.GC9417@frogsfrogsfrogs>

On Sat, Nov 30, 2024 at 12:36:07PM -0800, Darrick J. Wong wrote:
> > A known issue is that f_clear_orphan_file is failing on s390x,
> > powerpc, and ppc64 which is why Debian packages haven't been built on
> > those architectures:
> > 
> >     https://buildd.debian.org/status/package.php?p=e2fsprogs
> 
> IOWs, the big endian architectures.
> 
> Hmmm, why does ext2fs_do_orphan_file_block_csum claim to return a __u32
> yet the actual return statement returns an __le32:
> 
> 	return ext2fs_cpu_to_le32(crc);

Yeah, I noticed this when I was taking look a bit earlier.  The
fundamental problem is indeed that ext2fs_orphan_file_block_csum() is
returning an on-disk checksum, and on little endian systems, this
confusion is harmless, but it's a problem on big endian systems.  It
doesn't help that in the e2fsprogs's headers, we have:


struct ext4_orphan_block_tail {
	__u32 ob_magic;
	__u32 ob_checksum;
};

... but in the kernel'sheader files we have:

struct ext4_orphan_block_tail {
	__le32 ob_magic;
	__le32 ob_checksum;
};

... and although e2fsprogs had been set up to use sparse as a static
code checker some number of years ago, no one has used it in a while,
and right now compiling with make C=1 generates a huge amount of
noise.  (For example, sparse is now warning about unused functions
which are delcared "static inline" in header files, and short of just
squeching all unusedFunction warnings, there doesn't seem to be an
obvious way to get it to shut up about inline functions.

So to fix things on big endian systems, we'll need to clean up the
ambiguities.  The simplest way to fix things is just to do this:

(sid_ppc64-dchroot)tytso@perotto:~/e2fsprogs/e2fsprogs$ git diff
diff --git a/lib/ext2fs/orphan.c b/lib/ext2fs/orphan.c
index 913eb9a0..14b83b74 100644
--- a/lib/ext2fs/orphan.c
+++ b/lib/ext2fs/orphan.c
@@ -271,5 +271,5 @@ int ext2fs_orphan_file_block_csum_verify(ext2_filsys fs, ext2_ino_t ino,
        if (retval)
                return 0;
        tail = ext2fs_orphan_block_tail(fs, buf);
-       return ext2fs_le32_to_cpu(tail->ob_checksum) == crc;
+       return tail->ob_checksum == crc;
 }

But it's not clear this is the cleanest way to fix things.  I tend to
agree with your suggestion as probably the better one, and that we
should be making things explicit with the use of __le32 annotations.

I should also try to see what needs to be done to make using "make
C=1" more useful....

					- Ted

