Return-Path: <linux-ext4+bounces-9169-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A8B0F67C
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 17:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD69AC72FD
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jul 2025 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C59302052;
	Wed, 23 Jul 2025 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncdZE9zn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027AF2EE26A;
	Wed, 23 Jul 2025 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282658; cv=none; b=tFF/5/MdiM35copmUZ+vOCTIAhYww3QhHPxwhuwgTzcFt8qEg22ZB8rPGyk/Uj42ifp7b/j82RKdR7vp0ZcGYBcINIVapO/0ZbJkHAiiP8tsz+ok99504Cvw4rZrfqiiTjScHFX/MU/LM8SQpdW7p4CDM1BlfmLTc+Yq2YTJ6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282658; c=relaxed/simple;
	bh=C69RAJehd2lMk3GX7I7sTjlCMaen8Xc7ti/mQhnB0fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy+oW+z7zNuiHtA1mcqmXvDjCht0E/8dbk2dozw4LkGqBStew6t/ebt7tEMG/CPuRtNBqvLOc77wj5DstpquGQQPI6RldIQ8L1zAGaIzrbgZV1BEt0/2/L9ruoRhG1lz1H3auTTuVX4Ccg73JwfqEnzMmhg7uz4ACTX7IIDDQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncdZE9zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2EAC4CEF1;
	Wed, 23 Jul 2025 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282653;
	bh=C69RAJehd2lMk3GX7I7sTjlCMaen8Xc7ti/mQhnB0fE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ncdZE9zne8Cx2+ZUnrXWSnuz/l/uwNOT3xB0xoTHGm+HwbFzxt6b0SfXft1FfnEe0
	 OsJB4RtuxgEo6aOG8bap20BR1pahMJoAeMSF53bwh9Mq/Ir4kg3jOUlVf2iKf3Jsia
	 ei3cwCKpW2po5hUV6hpjtdmqOuLzvr00H+vtQC5akSqzPq8tCG718D+iqad6a1+Epi
	 XzfXB3Jev8dQBqcKebN+eGfea+uzAmTGTpn+sAqYrGMfKLvUKch8XmdcXPr8L7HWVf
	 YqpkDBUyVCLu2wabcD+EFLgfwoxyNcfB7wLmSoBMP8FtI9ZDOVEUWYksONGPU0Jb+7
	 t9w4N2QI997Gw==
Date: Wed, 23 Jul 2025 07:57:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 04/13] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <20250723145733.GP2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <5bbd19e1615ca2a485b3b430c92f0260ee576f5e.1752329098.git.ojaswin@linux.ibm.com>
 <20250717161747.GG2672039@frogsfrogsfrogs>
 <aH9g5jkwnXAkQUJl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH9g5jkwnXAkQUJl@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Tue, Jul 22, 2025 at 03:29:02PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jul 17, 2025 at 09:17:47AM -0700, Darrick J. Wong wrote:
> 
> <snip>
> 
> > > +
> > > +/*
> > > + * Round down n to nearest power of 2.
> > > + * If n is already a power of 2, return n;
> > > + */
> > > +static int rounddown_pow_of_2(int n) {
> > > +	int i = 0;
> > > +
> > > +	if (is_power_of_2(n))
> > > +		return n;
> > > +
> > > +	for (; (1 << i) < n; i++);
> > > +
> > > +	return 1 << (i - 1);
> > > +}
> > > +
> > >  void
> > >  dowrite(unsigned offset, unsigned size, int flags)
> > >  {
> > > @@ -1081,6 +1113,27 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  	offset -= offset % writebdy;
> > >  	if (o_direct)
> > >  		size -= size % writebdy;
> > > +	if (flags & RWF_ATOMIC) {
> > > +		/* atomic write len must be inbetween awu_min and awu_max */
> > > +		if (size < awu_min)
> > > +			size = awu_min;
> > > +		if (size > awu_max)
> > > +			size = awu_max;
> > > +
> > > +		/* atomic writes need power-of-2 sizes */
> > > +		size = rounddown_pow_of_2(size);
> > > +
> > > +		/* atomic writes need naturally aligned offsets */
> > > +		offset -= offset % size;
> > 
> > I don't think you should be modifying offset/size here.  Normally for
> > fsx we do all the rounding of the file range in the switch statement
> > after the "calculate appropriate op to run" comment statement.
> > 
> > --D
> 
> Yes, I noticed that but then I saw we make size/offset adjustments in
> do write for writebdy and I wanted atomic writes adjustments to be done
> after that.

<nod> ok then, I forgot that we already tweak the file range for
write...
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


> Regads,
> ojaswin
> 
> > 
> > > +
> > > +		/* Skip the write if we are crossing max filesize */
> > > +		if ((offset + size) > maxfilelen) {
> > > +			if (!quiet && testcalls > simulatedopcount)
> > > +				prt("skipping atomic write past maxfilelen\n");
> > > +			log4(OP_WRITE_ATOMIC, offset, size, FL_SKIPPED);
> > > +			return;
> > > +		}
> > > +	}
> > >  	if (size == 0) {
> > >  		if (!quiet && testcalls > simulatedopcount && !o_direct)
> > >  			prt("skipping zero size write\n");
> > > @@ -1088,7 +1141,10 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  		return;
> > >  	}
> > >  
> > > -	log4(OP_WRITE, offset, size, FL_NONE);
> > > +	if (flags & RWF_ATOMIC)
> > > +		log4(OP_WRITE_ATOMIC, offset, size, FL_NONE);
> > > +	else
> > > +		log4(OP_WRITE, offset, size, FL_NONE);
> > >  
> > >  	gendata(original_buf, good_buf, offset, size);
> > >  	if (offset + size > file_size) {
> > > @@ -1108,8 +1164,9 @@ dowrite(unsigned offset, unsigned size, int flags)
> > >  		       (monitorstart == -1 ||
> > >  			(offset + size > monitorstart &&
> > >  			(monitorend == -1 || offset <= monitorend))))))
> > > -		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d\n", testcalls,
> > > -		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0);
> > > +		prt("%lld write\t0x%x thru\t0x%x\t(0x%x bytes)\tdontcache=%d atomic_wr=%d\n", testcalls,
> > > +		    offset, offset + size - 1, size, (flags & RWF_DONTCACHE) != 0,
> > > +		    (flags & RWF_ATOMIC) != 0);
> > >  	iret = fsxwrite(fd, good_buf + offset, size, offset, flags);
> > >  	if (iret != size) {
> > >  		if (iret == -1)
> > > @@ -1785,6 +1842,30 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
> > >  }
> > >  #endif
> > >  
> > > +int test_atomic_writes(void) {
> > > +	int ret;
> > > +	struct statx stx;
> > > +
> 

