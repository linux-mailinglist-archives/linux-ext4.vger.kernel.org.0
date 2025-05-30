Return-Path: <linux-ext4+bounces-8239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131BAC8756
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 06:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768087B230C
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197D18DB29;
	Fri, 30 May 2025 04:35:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B14685
	for <linux-ext4@vger.kernel.org>; Fri, 30 May 2025 04:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748579736; cv=none; b=af3CT6Gyx2HI8gx14NVUA6TagKh9r8bP1uxEPcgdVOW90d+qRlz4t65jnJ9c6ZTAKyhcpJRsX7xGyletV9GosuOvT6xwStQw4M6kyn7DBdY4rRx0e99HTXZ5pwW3efaBqX/cBrWMSxwBLGz0jrGIWC9Fa0yZ7AJxTIR6sQcNkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748579736; c=relaxed/simple;
	bh=gUkxrJALy1SAUy+uYGJNhJ50tKrIGIVCcOAFinEY/Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKb6bb4beKvcCW/hCIfto2MJ0TJCnuI7qSnSiZBPUrPYP+SeWIDq6nzebzNQC2ExLzl9mGWSLiJJ64KqBC663Zpdaus/ksAoOk2vfhA6oYm7gS2ooZtAqP+ZQXGKAbRcfufKEDvDOzAacTTyAm6JEWAKPcFxU+XXit/+n7ANnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-235.bstnma.fios.verizon.net [173.48.111.235])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54U4ZGWs020446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 00:35:17 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 7B8CD2E00DD; Fri, 30 May 2025 00:35:16 -0400 (EDT)
Date: Fri, 30 May 2025 00:35:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Wang <00107082@163.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext4: use kmem_cache for short fname allocation in readdir
Message-ID: <20250530043516.GD332467@mit.edu>
References: <20250529144256.4517-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529144256.4517-1-00107082@163.com>

On Thu, May 29, 2025 at 10:42:56PM +0800, David Wang wrote:
> When searching files, ext4_readdir would kzalloc() a fname
> object for each entry. It would be faster if a dedicated
> kmem_cache is used for fname.
> 
> But fnames are of variable length.
> 
> This patch suggests using kmem_cache for fname with short
> length, and resorting to kzalloc when fname needs larger buffer.
> Assuming long file names are not very common.
> 
> Profiling when searching files in kernel code base, with following
> command:
> 	# perf record -g -e cpu-clock --freq=max bash -c \
> 	"for i in {1..100}; do find ./linux -name notfoundatall > /dev/null; done"
> And using sample counts as indicator of performance improvement.

I would think a better indicator of performance improvement would be
to measure the system time when running the find commands.  (i.e.,
either using getrusange with RUSAGE_CHILDREN or wait3 or wait4).

We're trading off some extra memory usage and code complexity with
less CPU time because entries in the kmem_cache might be more TLB
friendly.  But this is only really going to be applicable if the
directory is large enough such that the cycles spent in readdir is
significant compared to the rest of the userspace program, *and* you
are reading the directory multiple times (e.g., calling find on a
directory hierarchy many, many times) such that the disk blocks are
cahed and you don't need to read them from the storage device.
Otherwise the I/O costs will completely dominate and swamp the
marginal TLB cache savings.

Given that it's really rare for readdir() to be the bottleneck of many
workloads, the question is, is it worth it?

						- Ted

