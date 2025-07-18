Return-Path: <linux-ext4+bounces-9096-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1DB09A13
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574707B6E88
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 03:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435061A0BE1;
	Fri, 18 Jul 2025 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="gEM4GJ2U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F00F1400C
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 03:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808195; cv=none; b=epE2Wwom4xFwt48g1prXS6OBU1SMcSUq2cguRED8/xelt8gwv8ka1EjSs0B6WBW8KFAW0vX8xkeulv0RFqEaFfq/SXSqWfUT03ikjdYChgQLOLKpQ8qAB7F9AOOxKqApzCXOTVLfBEe46jw/HFplmXDiRCDfgtzGHF2s0XSJlf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808195; c=relaxed/simple;
	bh=GqTcIgOld/defhlNDEiJ366p6xek9MAf/gJImSXXyso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUCJHOJa4p3lXqYCxwmkWc56WOPQcKAAdhyZoWjQvvRHn/xtMmYdApCqFHyCydLFCmb7ooo/u0AcR5FFixxNgGX6RzJiias0ouoIcQrr/EwvsSd/W9h0CgaO0pOKiE5Xw+7+PY9Q4ZVrmFsIxhloQhwGWWJxmHtx7RHuipYict8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=gEM4GJ2U; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-131.bstnma.fios.verizon.net [108.26.156.131])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56I39WUu031617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 23:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752808174; bh=m1vp9kQR6Q+/C4r2HeJmk31XxekP54s/mI79hwQFir8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=gEM4GJ2Uh6fBXzX8WDgHvLLpZGR6GDuiErXaFb0xSCwX8/sb6Pe7AduKUE9LfO8BS
	 PyITrz8Pd1wCIAMbbezTMp2lM+WRQ6PqNrN0CteAIEWprF6vOHs7xuhEGHtmHGAm5f
	 iplSmw6NU45JcvXckyrundGwrWmXjCwT8d5YhcOFHNXnGKJES34StX1sn1nQKPc71C
	 J6DFNhJO+9fcWCmljIFxWqV/vkPsB0aZT9qCUZLiI0Z3xusAPM2cw63fgydmpY7S/r
	 08kDAr3mcAaqocUuOUzmr2BHQmow8C5fCc5zveliRqa5rgZFsokqwxhU7bOyMZ5vRg
	 ziGtoUtnHH86w==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 6C53A2E00D5; Thu, 17 Jul 2025 23:09:32 -0400 (EDT)
Date: Thu, 17 Jul 2025 23:09:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andi Kleen <ak@linux.intel.com>
Cc: libaokun1@huawei.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/17] ext4: add ext4_try_lock_group() to skip busy
 groups
Message-ID: <20250718030932.GE112967@mit.edu>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-2-libaokun1@huawei.com>
 <87pldy78qc.fsf@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pldy78qc.fsf@linux.intel.com>

On Thu, Jul 17, 2025 at 03:28:27PM -0700, Andi Kleen wrote:
> 
> It seems this makes block allocation non deterministic, but depend on
> the system load. I can see where this could cause problems when
> reproducing bugs at least, but perhaps also in other cases.
> 
> Better perhaps just round robin the groups?
> Or at least add a way to turn it off.

Ext4 has never guareanteed deterministic allocation; in particular,
there are times when we using get_random_u32 whens selecting the block
group used when allocating a new inode, and since the block alocation
is based on block group of the inode, therefore the block allocation
isn't deterministic.

In any case, given there many workloads are doing multi-threaded
allocations, in practice, even without these calls to get_random,
things tend not to be deterministic anyway.

       	    	      		    - Ted

