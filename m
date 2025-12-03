Return-Path: <linux-ext4+bounces-12148-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A4CA1C09
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 23:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576363055BBB
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 21:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40C3328F4;
	Wed,  3 Dec 2025 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rWjVIn2u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D40331A67;
	Wed,  3 Dec 2025 21:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798900; cv=none; b=AuxecEmmVdjnQS1Gr6+RJRZs7XB7j5XZc3IeLD2R2B0tomOI+fAuheualdHO5pC/kIASrjsBem+Ry5q1xZPSu/mug0bxosTzlV8I4uco2sM7YG7TGOkz1BE0F9T9u3lB7IBymPAQv9orcgYXUOm3QqzyxkeoSbzTKSiCZUB3qo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798900; c=relaxed/simple;
	bh=dFQBj4nnwAEXTVe3CR2ETQXpj8qO7jkvBAMKik02MrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfzZgEKTr3X0kjuKOqwiIxruqdr4GV0QrD8DaA4IxgUnUbPjplXRYhAnKWAi23EuCDO0QMAtj6YN1m5tn/++H8dG397LGsD7ijq+Cc7OWMIlUKGmtU4nsThYgXzFlGH73XqzrDo4sZh5vPwUaYVIQyi2jDaY0kFUOUGCUKWXRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rWjVIn2u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e+ZH0tBmHUfIlvAQX+Zj6Wc1sW/lZ1N3JU5BNGq10ps=; b=rWjVIn2utABvQDqKg2lDicq6qO
	qRX570jBKeciAJSiJlckaW+dhc8x5YalariGIPj9w1JSPeXc1Ik6rGAMfV8k1s/WHKHeBR94V+nL/
	vrRldEFeUkeimymDrt1KKjTQpUbygP+0mVI4PUpRUELhrhvYWJZL6jUljLpcKLWh4Z+sbNtp2zdHL
	Zby255bSAXr1yL5Fo4wXvaqAZfU3JBnAxEboFolA+qc4ejABASF69R5Ydgwe9tJW5qP/a1cPlRHTD
	WdxJkGjGTZYmMWOXGXcOMU00OPYhsF+LQTyC4jITHK8QuEMXz+NhRtOIULj3GtxvqrgTsTMb+UAEg
	Y2NonPFA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQuoI-00000003I9r-04mO;
	Wed, 03 Dec 2025 21:54:54 +0000
Date: Wed, 3 Dec 2025 21:54:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
	adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <aTCxrXtrtB0x9C8X@casper.infradead.org>
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

On Wed, Dec 03, 2025 at 10:46:57AM -0500, Theodore Tso wrote:
> Matthew, as the page cache maintainer, do we actually need this extra
> rigamarole.  Or can we just skip taking the lock before checking to
> see if the folio is uptodate in ext4_page_mkwrite()?

Oh, this triggered a memory.  Looks like you missed my reply in that
thread.  This patch is bogus.  You need to prevent !uptodate folios from
being referenced by the page tables.

https://groups.google.com/g/syzkaller-bugs/c/kjaCOwdrWVg/m/6Li1dROPBQAJ

