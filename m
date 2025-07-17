Return-Path: <linux-ext4+bounces-9049-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE024B09186
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A7E179443
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7452B2F94A2;
	Thu, 17 Jul 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVUNLfi+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF71F9F73;
	Thu, 17 Jul 2025 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769069; cv=none; b=KEXHQ4Zf6gNSFXrz0HJ9Q5vpkUZWd3ZnlF5v0NMzuPw3pHHizo69D14UF/CpNPacKU/2O//6ttKU4hmZ8vk8Ufnfdp3DzP6xdTUXIlmft3gVLReOBTE6gCOmff8b59pQnWsZbRuwFCqK5iuZaHW+0M8oaE7hNFczDZOuQWkTwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769069; c=relaxed/simple;
	bh=5/0GW3qMX+v5dZmKkYORWMeOrUeiQ5jFCrlbFwBqtGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZQRZ1ggKrEgU+/0v1qOoT/bCPtOMtt35zMNDUtsLcyBjfkjpMHWZLk6YnKRTzcI+hpW0QoCxPaX/tVEpfzKyeE9q1cYd0wUwCXYIPsVTT9vlEE7lVfJ0c2bwU0ld0xmybjXJ6Fp7NJYkpla9k/hC4czlQ3n01VAKlTm06uHhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVUNLfi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4D9C4CEFE;
	Thu, 17 Jul 2025 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752769068;
	bh=5/0GW3qMX+v5dZmKkYORWMeOrUeiQ5jFCrlbFwBqtGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVUNLfi+h7dB7+1AiQYuppDpjh0UTMdbI9jg/omd0tsvQ3l0vDeutV8zxnXC9zk24
	 UyDZ+ErX+0zKRY6q8auC4f+SMyIONhnlEWxQWRL/5aBg5HvWLWFV6b7T6+g+ZXuq/e
	 fehuWMQaMa0HjLNDQBzLZSQ2Wap+RudbqctRCdkkXKEInNOHSgTIaFh0tLW7JcDb0y
	 G4t4VrMRcv2OjdTlyZrqiwoKjenw5UufkthtgHsbbVeJM2f2aLXxE/dviY8CTuecy7
	 VITnK18mRvfxw644GgKxx9g/IASeZ6XXu5mdzKr04K/FWcWNMtGY4eVRY68gQcGg+x
	 i2Dp6GSQaiijg==
Date: Thu, 17 Jul 2025 09:17:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 04/13] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20250717161747.GG2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <5bbd19e1615ca2a485b3b430c92f0260ee576f5e.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbd19e1615ca2a485b3b430c92f0260ee576f5e.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:46PM +0530, Ojaswin Mujoo wrote:
> Implement atomic write support to help fuzz atomic writes
> with fsx.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  ltp/fsx.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 5 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 163b9453..ea39ca29 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -40,6 +40,7 @@
>  #include <liburing.h>
>  #endif
>  #include <sys/syscall.h>
> +#include "statx.h"
>  
>  #ifndef MAP_FILE
>  # define MAP_FILE 0
> @@ -49,6 +50,10 @@
>  #define RWF_DONTCACHE	0x80
>  #endif
>  
> +#ifndef RWF_ATOMIC
> +#define RWF_ATOMIC	0x40
> +#endif
> +
>  #define NUMPRINTCOLUMNS 32	/* # columns of data to print on each line */
>  
>  /* Operation flags (bitmask) */
> @@ -110,6 +115,7 @@ enum {
>  	OP_READ_DONTCACHE,
>  	OP_WRITE,
>  	OP_WRITE_DONTCACHE,
> +	OP_WRITE_ATOMIC,
>  	OP_MAPREAD,
>  	OP_MAPWRITE,
>  	OP_MAX_LITE,
> @@ -200,6 +206,11 @@ int	uring = 0;
>  int	mark_nr = 0;
>  int	dontcache_io = 1;
>  int	hugepages = 0;                  /* -h flag */
> +int	do_atomic_writes = 1;		/* -a flag disables */
> +
> +/* User for atomic writes */
> +int awu_min = 0;
> +int awu_max = 0;
>  
>  /* Stores info needed to periodically collapse hugepages */
>  struct hugepages_collapse_info {
> @@ -288,6 +299,7 @@ static const char *op_names[] = {
>  	[OP_READ_DONTCACHE] = "read_dontcache",
>  	[OP_WRITE] = "write",
>  	[OP_WRITE_DONTCACHE] = "write_dontcache",
> +	[OP_WRITE_ATOMIC] = "write_atomic",
>  	[OP_MAPREAD] = "mapread",
>  	[OP_MAPWRITE] = "mapwrite",
>  	[OP_TRUNCATE] = "truncate",
> @@ -422,6 +434,7 @@ logdump(void)
>  				prt("\t***RRRR***");
>  			break;
>  		case OP_WRITE_DONTCACHE:
> +		case OP_WRITE_ATOMIC:
>  		case OP_WRITE:
>  			prt("WRITE    0x%x thru 0x%x\t(0x%x bytes)",
>  			    lp->args[0], lp->args[0] + lp->args[1] - 1,
> @@ -1073,6 +1086,25 @@ update_file_size(unsigned offset, unsigned size)
>  	file_size = offset + size;
>  }
>  
> +static int is_power_of_2(unsigned n) {
> +	return ((n & (n - 1)) == 0);
> +}
> +
> +/*
> + * Round down n to nearest power of 2.
> + * If n is already a power of 2, return n;
> + */
> +static int rounddown_pow_of_2(int n) {
> +	int i = 0;
> +
> +	if (is_power_of_2(n))
> +		return n;
> +
> +	for (; (1 << i) < n; i++);
> +
> +	return 1 << (i - 1);
> +}
> +
>  void
>  dowrite(unsigned offset, unsigned size, int flags)
>  {
> @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
>  	offset -= offset % writebdy;
>  	if (o_direct)
>  		size -= size % writebdy;
> +	if (flags & RWF_ATOMIC) {
> +		/* atomic write len must be inbetween awu_min and awu_max */
> +		if (size < awu_min)
> +			size = awu_min;
> +		if (size > awu_max)
> +			size = awu_max;
> +
> +		/* atomic writes need power-of-2 sizes */
> +		size = rounddown_pow_of_2(size);
> +
> +		/* atomic writes need naturally aligned offsets */
> +		offset -= offset % size;

I don't think you should be modifying offset/size here.  Normally for
fsx we do all the rounding of the file range in the switch statement
after the "calculate appropriate op to run" comment statement.

--D

> +
> +		/* Skip the write if we are crossing max filesize */
> +		if ((offset + size) > maxfilelen) {
> +			if (!quiet && testcalls > simulatedopcount)
> +				prt("skipping atomic write past maxfilelen\n");
> +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> +			return;
> +		}
> +	}
>  	if (size == 0) {
>  		if (!quiet && testcalls > simulatedopcount && !o_direct)
>  			prt("skipping zero size write\n");
> @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
>  		return;
>  	}
>  
> -	log4(OP_WRITE, offset, size, FL_NONE);
> +	if (flags & RWF_ATOMIC)
> +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> +	else
> +		log4(OP_WRITE, offset, size, FL_NONE);
>  
>  	gendata(original_buf, good_buf, offset, size);
>  	if (offset + size > file_size) {
> @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
>  		       (monitorstart == -1 ||
>  			(offset + size > monitorstart &&
>  			(monitorend == -1 || offset <= monitorend))))))
> -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> +		    (flags & RWF_ATOMIC) != 0);
>  	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
>  	if (iret != size) {
>  		if (iret == -1)
> @@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
>  }
>  #endif
>  
> +int test_atomic_writes(void) {
> +	int ret;
> +	struct statx stx;
> +
> +	ret = xfstests_statx(AT_FDCWD, fname, 0, STATX_WRITE_ATOMIC, &stx);
> +	if (ret < 0) {
> +		fprintf(stderr, "main: Statx failed with %d."
> +			" Failed to determine atomic write limits, "
> +			" disabling!\n", ret);
> +		return 0;
> +	}
> +
> +	if (stx.stx_attributes & STATX_ATTR_WRITE_ATOMIC &&
> +	    stx.stx_atomic_write_unit_min > 0) {
> +		awu_min = stx.stx_atomic_write_unit_min;
> +		awu_max = stx.stx_atomic_write_unit_max;
> +		return 1;
> +	}
> +
> +	fprintf(stderr, "main: IO Stack does not support "
> +			"atomic writes, disabling!\n");
> +	return 0;
> +}
> +
>  #ifdef HAVE_COPY_FILE_RANGE
>  int
>  test_copy_range(void)
> @@ -2356,6 +2437,12 @@ have_op:
>  			goto out;
>  		}
>  		break;
> +	case OP_WRITE_ATOMIC:
> +		if (!do_atomic_writes) {
> +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> +			goto out;
> +		}
> +		break;
>  	}
>  
>  	switch (op) {
> @@ -2385,6 +2472,11 @@ have_op:
>  			dowrite(offset, size, 0);
>  		break;
>  
> +	case OP_WRITE_ATOMIC:
> +		TRIM_OFF_LEN(offset, size, maxfilelen);
> +		dowrite(offset, size, RWF_ATOMIC);
> +		break;
> +
>  	case OP_MAPREAD:
>  		TRIM_OFF_LEN(offset, size, file_size);
>  		domapread(offset, size);
> @@ -2511,13 +2603,14 @@ void
>  usage(void)
>  {
>  	fprintf(stdout, "usage: %s",
> -		"fsx [-dfhknqxyzBEFHIJKLORWXZ0]\n\
> +		"fsx [-adfhknqxyzBEFHIJKLORWXZ0]\n\
>  	   [-b opnum] [-c Prob] [-g filldata] [-i logdev] [-j logid]\n\
>  	   [-l flen] [-m start:end] [-o oplen] [-p progressinterval]\n\
>  	   [-r readbdy] [-s style] [-t truncbdy] [-w writebdy]\n\
>  	   [-A|-U] [-D startingop] [-N numops] [-P dirpath] [-S seed]\n\
>  	   [--replay-ops=opsfile] [--record-ops[=opsfile]] [--duration=seconds]\n\
>  	   ... fname\n\
> +	-a: disable atomic writes\n\
>  	-b opnum: beginning operation number (default 1)\n\
>  	-c P: 1 in P chance of file close+open at each op (default infinity)\n\
>  	-d: debug output for all operations\n\
> @@ -3059,9 +3152,13 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0b:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
> +		case 'a':
> +			prt("main(): Atomic writes disabled\n");
> +			do_atomic_writes = 0;
> +			break;
>  		case 'b':
>  			simulatedopcount = getnum(optarg, &endp);
>  			if (!quiet)
> @@ -3475,6 +3572,8 @@ main(int argc, char **argv)
>  		exchange_range_calls = test_exchange_range();
>  	if (dontcache_io)
>  		dontcache_io = test_dontcache_io();
> +	if (do_atomic_writes)
> +		do_atomic_writes = test_atomic_writes();
>  
>  	while (keep_running())
>  		if (!test())
> -- 
> 2.49.0
> 
> 

