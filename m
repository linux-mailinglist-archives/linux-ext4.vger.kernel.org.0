Return-Path: <linux-ext4+bounces-6627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF2A49AA8
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E661898698
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 13:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988424A045;
	Fri, 28 Feb 2025 13:35:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89409254AE2
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749705; cv=none; b=qGtWahq7ShVv58aG+PiJBBTReu9FFvJCzItzRbOZSVgRhUZtoAbt6vfqnup0uT7yk6S+WBen6CqdBx5cZwxZUv6VcVS5/pKTPjmDA7DwdJC6clx8nE8QbIzTCPZ1R/S7yp7anaYFalO79izEVshSpoBR4Naka4ZeryGvdOIamfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749705; c=relaxed/simple;
	bh=4infdWoCK4tObwNXKz4gbubXnThJcRRrOAbiK7dwTQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UX0gyue2+8FhX80K1+Zb5zx5z0HSrHVVl99n8jJ4huIJJb+hE2RwN+u4VDQjCqhZ7sl4FD9pEn7DKeJMdPXbuvMV/TB1bcmE2w0cqe1t0nE29dxss/yoMpQNAxOP26L4b8jJIlVlyT/iPwVmI9pPRktGVift9xaQePKBPlUt5m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-92.bstnma.fios.verizon.net [173.48.112.92])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51SDYeS6010975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 08:34:41 -0500
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 470642E010B; Fri, 28 Feb 2025 08:34:40 -0500 (EST)
Date: Fri, 28 Feb 2025 08:34:40 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz,
        Yang Erkun <yangerkun@huawei.com>
Subject: Re: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL
 allocation.
Message-ID: <20250228133440.GB15240@mit.edu>
References: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
 <9be439b3-fd43-4a4b-96e5-0d0ec5fb1509@huawei.com>
 <CAHB1NaigQx0HW3Oxd2P9uujGk221WjxeKOgaNj-p2WqMJaQZiA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NaigQx0HW3Oxd2P9uujGk221WjxeKOgaNj-p2WqMJaQZiA@mail.gmail.com>

On Fri, Feb 28, 2025 at 05:30:06PM +0800, Julian Sun wrote:
> > Actually, even with __GFP_NOFAIL set, kcalloc() can still return NULL,
> > such as when the input parameters overflow.
> >
> Yeah, agreed. But IMO an overflow shouldn’t happen in this situation.
> 
> If there's something I'm missing, please let me know.

It's not a matter of missing something; or even Right vs Wrong.
Different maintainers have different tastes about this sort of thing.

The mm folks have changed the meaning of __GFP_NOFAIL in the past
(TL;DR: they *hate* that concept, and I wouldn't be surprised if they
try to change its behavior in the future) and especially in large code
bases such as the Linux Kernel, I'm a big believer in defensive
programming.

As Linus has said in a different thread, when a compiler adds warnings
because of what it thinks are "unnecessary" range checks, that's a bad
warning.  Adding extra range checks is never a bad thing, and compiler
behaviour that whine about that sort of thing are.... unfortunate.
Similarly, I'd much rather keep the extra check.

(Also, there exist static program checkers, such as Coverity, that
don't know about the semantics of the GFP_* flags, and so removing the
check would actually cause those tools to complain.)

Cheers,

					- Ted

