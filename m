Return-Path: <linux-ext4+bounces-11830-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B26C53E69
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F7144E2490
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F418E34A76A;
	Wed, 12 Nov 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3TehXnr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73124347BCA;
	Wed, 12 Nov 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971334; cv=none; b=nHydcTr/ooTQl6HJ0/mdJ9Fpi12o4YHPt3BwEqZt9a6NfkmZ5LuMNbq4/v4W/L1BNU4rfdsPMsFsvlEhIv2ds/vsUp7EGA4pdZCFuyKr50bZFr3plSF78dBTGIaFQ+KUwYyLW2/KooQXKZGH/5zFB+QDseJEtxF+KZe706KZQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971334; c=relaxed/simple;
	bh=5sj5AT6ZW1JYcc0GL5ougXifFuChNyhoOoOgCYfR5YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kshuiQEyGd8wwgkdRHL75QcImMBmZ+hvHQh5nEWx7OrQOjIXd3kWzyXbXu+kq7mz3k9sSOCK1lSe5f83tn4ggvsnZCSStwVAB8rdupUcPx/woA3qUthkTTYEJ3Ha/fq2N/LDzFiWn5Z51hfOc4PRFDlEg3j5uQ83PqwLo3Rhblg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3TehXnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0053FC4CEF1;
	Wed, 12 Nov 2025 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762971334;
	bh=5sj5AT6ZW1JYcc0GL5ougXifFuChNyhoOoOgCYfR5YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3TehXnrBlZslNgtOhB6Uwj+KoVHRdcP9DjQlwK+NbRrr/nCm+0pdm5Da0rOKoyST
	 mqVhD4rtF3PqSLC/mtJDda5wVrOAsVYnZKMDFrouxeYPn1PZr7EzVw0VLlN5CwTAG2
	 kOgs+0HzPXSfv5qI7LFK7OW4Za5bfCwLcQx1HsIgU0ZYcyGJCT9yDr4gFdZPg+eVA/
	 bLM0Ijtyq3LQwkiS0Uk8h0hdejnKyZM+FwAW1CIX9x7+gL0tU4IvdF89Ed1JRDYC9m
	 zuPrh5BOyyIkHv2wVS1AsM6S7CBm76VaXHI0yFFVkx5W8AAMGHWRFRRTUe8u1eJ9yc
	 ok3tbtJjabpEg==
Date: Wed, 12 Nov 2025 10:15:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] generic/774: turn off lfsr
Message-ID: <20251112181533.GE196366@frogsfrogsfrogs>
References: <176279908967.605950.2192923313361120314.stgit@frogsfrogsfrogs>
 <176279909135.605950.17114455316765178991.stgit@frogsfrogsfrogs>
 <8d9dc58f-ba64-4abe-91b9-251636527a65@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9dc58f-ba64-4abe-91b9-251636527a65@oracle.com>

On Tue, Nov 11, 2025 at 09:01:59AM +0000, John Garry wrote:
> On 10/11/2025 18:27, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > This test fails mostly-predictably across my testing fleet with:
> > 
> >   --- /run/fstests/bin/tests/generic/774.out	2025-10-20 10:03:43.432910446 -0700
> >   +++ /var/tmp/fstests/generic/774.out.bad	2025-11-10 01:14:58.941775866 -0800
> >   @@ -1,2 +1,11 @@
> >   QA output created by 774
> >   +fio: failed initializing LFSR
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 0, length 33554432 (requested block: offset=0, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 33554432, length 33554432 (requested block: offset=33554432, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 67108864, length 33554432 (requested block: offset=67108864, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 100663296, length 33554432 (requested block: offset=100663296, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 134217728, length 33554432 (requested block: offset=134217728, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 167772160, length 33554432 (requested block: offset=167772160, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 201326592, length 33554432 (requested block: offset=201326592, length=33554432)
> >   +verify: bad magic header 0, wanted acca at file /opt/test-file offset 234881024, length 33554432 (requested block: offset=234881024, length=33554432)
> >   Silence is golden
> > 
> > I'm not sure why the linear feedback shift register algorithm is
> > specifically needed for this test.
> > 
> > Cc: <fstests@vger.kernel.org> # v2025.10.20
> > Fixes: 9117fb93b41c38 ("generic: Add atomic write test using fio verify on file mixed mappings")
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> BTW, if you would like to make further tidy ups, then I don't think that
> verify_write_sequence=0 is required (for verify config). That is only
> relevant when we have multiple threads writing to the same region, which I
> don't think is the case here.

No I would not.  Send a separate patch with a separate justification
please.

--D

> cheers
> 
> > ---
> >   tests/generic/774 |    4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > 
> > diff --git a/tests/generic/774 b/tests/generic/774
> > index 28886ed5b09ff7..86ab01fbd35874 100755
> > --- a/tests/generic/774
> > +++ b/tests/generic/774
> > @@ -56,14 +56,12 @@ group_reporting=1
> >   ioengine=libaio
> >   rw=randwrite
> >   io_size=$((filesize/3))
> > -random_generator=lfsr
> >   # Create unwritten extents
> >   [prep_unwritten_blocks]
> >   ioengine=falloc
> >   rw=randwrite
> >   io_size=$((filesize/3))
> > -random_generator=lfsr
> >   EOF
> >   cat >$fio_aw_config <<EOF
> > @@ -73,7 +71,6 @@ ioengine=libaio
> >   rw=randwrite
> >   direct=1
> >   atomic=1
> > -random_generator=lfsr
> >   group_reporting=1
> >   filename=$testfile
> > @@ -93,7 +90,6 @@ cat >$fio_verify_config <<EOF
> >   [verify_job]
> >   ioengine=libaio
> >   rw=read
> > -random_generator=lfsr
> >   group_reporting=1
> >   filename=$testfile
> > 
> 
> 

