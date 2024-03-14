Return-Path: <linux-ext4+bounces-1619-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A2087B70A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 05:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8930B22D0D
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 04:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F32611A;
	Thu, 14 Mar 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rkU1d0Di"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFB35382;
	Thu, 14 Mar 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710389201; cv=none; b=kTcR4c5KYfeYyI/LAP15yeDJ5eno7YUfJDJ1RwOTp+krLEj+c2AahokY/Ccss821iigo2n1pPWba3q72vxbVX+2jtk8D1/PlcPkg9SgSbCeGM+kczhnkfKbH8M4jLdXku0AuaIuyDSpzSjFMo7iVziLJJGaGumuI7hqzQ69nENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710389201; c=relaxed/simple;
	bh=ufgd4G9b48KP6/AYW5aZuuNu1FugsmOpXYAc//gqWnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKlYuh7ETTy7o2uAqtrwv7Dnn4hqmyCqDouwTEz8hIxI8I0tYZ7taKQIg0Cocnt1km73xpAecs5AbCtCAiSnjpFqj79nEFZkRruHGHubkquEjQ1JGH2f1BuHJvMWYXJIlZ9e3J9Qcgu3ey1vgJUrzZBEwcHQhPyHfXWvLeK7DfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rkU1d0Di; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C2SnZ6uRqrz6YRWBE3ZLWRRBzTGsRd/LevfrcqRDXtE=; b=rkU1d0DiKcZFA4ewMTd5H52M+u
	3gfW+2aq4akg7zzTFL2mkfX3rHZXdDc0qzHwtd0kvBkey15z9SNe499fZ3FBINS6zf/F+SIpK6qSJ
	NG0gd4+9YG/7LwXgEvmjv8PJbGMYBqDx1Lvl4Gyu3NnEPydCmlZS3O+3zzLJ0AUxCP3tHOyH7/v5H
	ojNI0kPobB0jtVw7Me74Xi/I8Aw/QR+WMl/jf+tKkzOitbFVvjLl+bLj+Jpa4zgk/P01K/Siz4GY/
	fOqHGPV4wYz5nhFrg4u+mWzSETOucRPa3lDyWpyTlFbYupd/65YYjn4qV3fiTfLSeKF2amao8wYfy
	wgzhG6pA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkcMR-00000006zYC-11lc;
	Thu, 14 Mar 2024 04:06:31 +0000
Date: Thu, 14 Mar 2024 04:06:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, chengming.zhou@linux.dev,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] ext4: remove SLAB_MEM_SPREAD flag usage
Message-ID: <ZfJ3x4O-M_H3PFxc@casper.infradead.org>
References: <20240224134822.829456-1-chengming.zhou@linux.dev>
 <171038847843.855927.15942631846474053923.b4-ty@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171038847843.855927.15942631846474053923.b4-ty@mit.edu>

On Wed, Mar 13, 2024 at 11:54:42PM -0400, Theodore Ts'o wrote:
> 
> On Sat, 24 Feb 2024 13:48:22 +0000, chengming.zhou@linux.dev wrote:
> > The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> > its usage so we can delete it from slab. No functional change.
> > 
> > 
> 
> Applied, thanks!

Too late: f88c3fb81c4badb46c2fef7d168ff138043e86bb

