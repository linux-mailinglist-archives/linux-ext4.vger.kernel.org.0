Return-Path: <linux-ext4+bounces-12147-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A13CA1AF5
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCAC43018995
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDB2D77E6;
	Wed,  3 Dec 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P2hjjzUG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91F12D1925;
	Wed,  3 Dec 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764797744; cv=none; b=NmUEWNKV0PBGcSx+HKRz4FRO6auEFdXxpzjVxjp3/FOkzo5i6amuYPF/M4kbLnPIF5XJmfACNkL4C3tP4VRZFrkGT+5cTiZLJGd6U0GsCdSi3DspkuQgO7dlyQQWmVtL2x7JgF5TPnY7q77AyBNF/Vyl2EsLiBFgYI2w281tT4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764797744; c=relaxed/simple;
	bh=355SWXt8MDdoJaZiEyG+0yBBBvc2g4W1mTmfKrZNIO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAei9Us42q3GRVL+IcGIqrvGlCezYar0B6RkMerGZvy+255kbsmkyC0MQVArddIMXj7q1ye7ck63QOGIpi0A9PhcmCDqGXeFwPrtOHwzbzJDytKbR2mJIj5iwFvk3VzXYdl+1+Cb/UP8yhFl25ASS7Q2es+Bmi52vW34IAPj5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P2hjjzUG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AvdSkYNqWG2f8viPwa08KcjkMZRdgbgqPem3n5NAMak=; b=P2hjjzUGHj5wdDPe3rbLik9sLg
	bRie3U5tW926/mPXtU7NcM+oBv1ZtQhFlSI2Br8/7rws8+VuOEIJD+DLQwmkT0E+C6iftFwjFuuhP
	gEzYo5plrmZ27aF8xNgiAGUECCLfxwK5P7rh6YWlL9EOpmFmlB+kPhaAdNCciTkprsenOUavFCi3E
	nPMIcHXAPQEgOBotHy/jhBXl9lpLxmD8OgaCWQ9jVmxw1Bd0AXZk0PjU5CupBjJZ+jDVpbj8T858j
	ZBWU4fx1wFYj1R8FyEp29Yxv9ETE8Oa8tLm+9+aMmEdDRgiH3bOpd3pqqihDBuD/EpvPkSXOcBVMO
	PXDjzE5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQuVV-00000003H6W-2rsv;
	Wed, 03 Dec 2025 21:35:29 +0000
Date: Wed, 3 Dec 2025 21:35:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <aTCtITpW9yLNm2hz@casper.infradead.org>
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203154657.GC93777@macsyma.lan>

You snipped out all the context when adding me to the cc, and I'm on
holiday until after Plumbers, so I'm disinclined to go looking for
context.

On Wed, Dec 03, 2025 at 10:46:57AM -0500, Theodore Tso wrote:
> My main concern with your patch is folio_lock() is *incredibly*
> heavyweight and is going to be a real scalability concern if we need
> to take it every single time we need to make a page writeable.
> 
> So could we perhaps do something like this?  So the first question is
> do we need to take the lock at all?  I'm not sure we need to worry
> about the case where the page is not uptodate because we're racing
> with the page being brought into memory; if we that could happen under
> normal circumstances we would be triggering the warning even without
> these situations such as a delayed allocaiton write failing due to a
> corrupted file system image.   So can we just do this?
> 
> 	if (!folio_test_uptodate(folio)) {
> 		ret = VM_FAULT_SIGBUS;
> 		goto out;
> 	}
> 
> If it is legitmate that ext4_page_mkwrite() could be called while the
> page is still being read in (and again, I don't think it is), then we
> could do something like this:
> 
> 	if (!folio_test_uptodate(folio)) {
> 		folio_lock(folio);
> 		if (!folio_test_uptodate(folio)) {
> 			folio_unlock(folio);
> 			ret = VM_FAULT_SIGBUS;
> 			goto out;
> 		}
> 		folio_unlock(folio);
> 	}
> 
> Matthew, as the page cache maintainer, do we actually need this extra
> rigamarole.  Or can we just skip taking the lock before checking to
> see if the folio is uptodate in ext4_page_mkwrite()?
> 
> 							- Ted

