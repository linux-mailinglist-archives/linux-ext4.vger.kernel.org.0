Return-Path: <linux-ext4+bounces-663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634E823B8A
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 05:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F241F23BC6
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 04:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0134111B4;
	Thu,  4 Jan 2024 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="ZDjbWKkZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6A10A16
	for <linux-ext4@vger.kernel.org>; Thu,  4 Jan 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-86.bstnma.fios.verizon.net [173.48.116.86])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4044cDd9012434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Jan 2024 23:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1704343094; bh=OLa9SLMUhfelyfQ13Opvu7FGSY/uf0P8QvLfSmxH90A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=ZDjbWKkZ1LG0EcOZeFaPsmWoO/nrtvHP7/YtMji/nCcmsWAPxln27eg8c95DpMaxa
	 oNyioOHL5s/HxnGfP4G2n6nm31x1raTHPNH5cHgDaX8Ar2gi3huHxGFjN4ayQr4cTq
	 KTiBRngbgFHMsbQyFFdCv/NwcXOJvNCRdj4/Gr+pkfPCJjDWKUGqCCbJ3lK3TdDtnw
	 GPu/8A6FpFM9r3z9YGHX81yRYeH8+G7TyOKwiR474F4VWlmzXgd4hpL1WwHcTHuS0M
	 lZS5KwykL0xgCnJHpvrCUyu/Bq8Uje8epJFAKlFzTpI4RcHecxrTF3DZy+mNT9YtXc
	 NPBi+wMjjOP2A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4847A15C17F9; Wed,  3 Jan 2024 23:38:13 -0500 (EST)
Date: Wed, 3 Jan 2024 23:38:13 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-ext4@vger.kernel.org
Subject: Re: e2scrub finds corruption immediately after mounting
Message-ID: <20240104043813.GC108362@mit.edu>
References: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <536d25b24364eaf11a38b47e853008c3115d82b8.camel@interlinx.bc.ca>

On Wed, Jan 03, 2024 at 04:14:36PM -0500, Brian J. Murrell wrote:
> I am trying to migrate from lvcheck
> (https://github.com/BryanKadzban/lvcheck) to using the officially
> supported e2scrub[_all] kit.

What distribution are you using, and what version of the kernel are
you using?  I note that you are using e2fsprogs 1.45.6, and Debian
Stable is shipping with e2fsprogs 1.47.0.

That being said, this is the first time I've seen any report of an
issue like what you've reported..

> # e2scrub /dev/rootvol_tmp/almalinux8_opt 
>   Logical volume "almalinux8_opt.e2scrub" created.
> e2fsck 1.45.6 (20-Mar-2020)
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
> /dev/rootvol_tmp/almalinux8_opt.e2scrub: 1698/178816 files (86.9% non-
> contiguous), 482404/716800 blocks
> /dev/rootvol_tmp/almalinux8_opt: Scrub FAILED due to corruption!

This error means that e2fsck exited with a non-zero exit status.
Which is strange because there is no report of any kind of problem
from e2fsck in its output.  From the e2scrub script:

check() {
	# First we recover the journal, then we see if e2fsck tries any
	# non-optimization repairs.  If either of these two returns a
	# non-zero status (errors fixed or remaining) then this fs is bad.
	E2FSCK_FIXES_ONLY=1
	export E2FSCK_FIXES_ONLY
	${DBG} "@root_sbindir@/e2fsck" -E journal_only -p ${e2fsck_opts} "${snap_dev}" || return $?
	${DBG} "@root_sbindir@/e2fsck" -f -y ${e2fsck_opts} "${snap_dev}"
}

...

check
case "$?" in
"0")
	# Clean check!
	echo "${arg}: Scrub succeeded."
  ...

"8")
	# Operational error, what now?
	echo "${arg}: e2fsck operational error."
  ...	

*)
	# fsck failed.  Check if the snapshot is invalid; if so, make a
	# note of that at the end of the log.  This isn't necessarily a
	# failure because the mounted fs could have overflowed the
	# snapshot with regular disk writes /or/ our repair process
	# could have done it by repairing too much.
	#
	# If it's really corrupt we ought to fsck at next boot.
	is_invalid="$(lvs -o lv_snapshot_invalid --noheadings "${snap_dev}" | awk '{print $1}')"
	if [ -n "${is_invalid}" ]; then
		echo "${arg}: Scrub FAILED due to invalid snapshot."
		ret=8
	else
		echo "${arg}: Scrub FAILED due to corruption!  Unmount and run e2fsck -y."
		mark_corrupt
		ret=6
	fi
	...

My best guess is that e2fsck from 1.45.6 is somehow returning a
non-zero exit status for some reason.  So the first thing I'd suggest
is upgrading to e2fsprogs 1.47.0 and see if that causes the problem to
resolve itself.

Cheers,

						- Ted

