Return-Path: <linux-ext4+bounces-12149-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E835DCA1D63
	for <lists+linux-ext4@lfdr.de>; Wed, 03 Dec 2025 23:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E1C3027E06
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Dec 2025 22:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433EA2E62C4;
	Wed,  3 Dec 2025 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BQoctaGK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE72E1C63
	for <linux-ext4@vger.kernel.org>; Wed,  3 Dec 2025 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801275; cv=none; b=NcnXl7hVmGo/MqUz5xOiZIuIcxvi0A6xdVEIRmEoTHnZnAE79pihV2ItA7xZD4cJpxCVr3JUANzySXmSFaFSxnOW6WB6r8WE2aATLAzsIsiR7c3jrdkK1JK4qhFufk23OquMdAdIEzCckpTi+eqe9UYxQo3CjrJdLHw3hecdbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801275; c=relaxed/simple;
	bh=N0fSa6ocmfVxjCKvPmIh0JwDfHIw6X0MEubUXtnMliA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgUBe6uA1YmAGx3p1a5MO6+dh8xBgEUYG8+BEqnL2xE6VNXaCfAwWoRHniP3jowjmSdU4YHQgpAwB9d0L43TjaLbw/50hm4w8ZLTpmapOqxxQkM+aSqm3A6aRxpl5V9Y5xUfkD1hSDU+zX4tvmlg+fzPm8mrKS3N8JOmKc3RW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BQoctaGK; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B3MY0gm006793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Dec 2025 17:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764801243; bh=NCJynnJQDBNDphiEN7pW0gNbM0WzRejvmJlfBMMfHow=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BQoctaGKVU5Uv+ytFKVmm2QCT/6fWOWBSIQrRo98xgDXLvDMpA/DIZRRAC0MsM2pz
	 C/anSZ4tVeJSXNAOmtV7iX+2T3wV0J6jN817ad9e5H7CZhbJhLOAg4Nv0p1ttTUG5a
	 if/mVLWmGfxWRbRy8wn+yPQwzeFPj8mvb84KC+BJjtKmUYwQUvS1toJMh1HAw6pR1W
	 UJ/6Tr/uvud7WjOf0+God7VWJClzFSgvVMa6ZO+r2L02klqLtt4x+KR2fWCz6WTwl2
	 8lQEsxMItMBqTw+jnDuhu4Q/j0xF577Mtgy0QJJLJchyKmbe6fa3nPBjoK9qSt61M7
	 4+97CRUDNO+wA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 5A8DC4E258A2; Wed,  3 Dec 2025 17:33:00 -0500 (EST)
Date: Wed, 3 Dec 2025 17:33:00 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
        Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <20251203223300.GB71988@macsyma.lan>
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
 <aTCtITpW9yLNm2hz@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTCtITpW9yLNm2hz@casper.infradead.org>

On Wed, Dec 03, 2025 at 09:35:29PM +0000, Matthew Wilcox wrote:
> You snipped out all the context when adding me to the cc, and I'm on
> holiday until after Plumbers, so I'm disinclined to go looking for
> context.

Sorry about that.  A quick summary.  Deepanshu was attempting to
address a Syzbot complaint[1].

[1] https://syzkaller.appspot.com/bug?extid=b0a0670332b6b3230a0a

The TL;DR summary is that the syzbot complaint involved a maliciously
corrupted file system which resulted file system getting detected when
delayed allocation writeback attempts to do a block allocation.  Error
handling calls mpage_release_unused_pages(invalidate=true), which
clears the uptodate flag via folio_clear_uptodate().

Because syzbot mounts the file system using errors=continue (which is
the worst case; we're not panic'ing the kernel or forcing the file
system to be read-only), we now have a situation where we have a folio
which can be mapped, but !uptodate, but the file system can still be
subject to changes.

In the syzkaller reproducer, the potential malware might call
ftruncate on the file, and this results ext4_truncate() calling
ext4_block_truncate_page() which thentries to zero the page tail,
which triggers a write fault, resulting in ext4_page_mkwrite() on a
page/folio which is not uptodate.  It then tries to mark the folio
dirty, mapped but !uptdate, and then __folio_mark_dirty() triggers:
WARN_ON_ONCE(!folio_test_uptodate()).

Since in Syzkaller assumes users are stupid enough to panic on warn,
this is an urgent security issue because it's a denial of service
attack which is CVE worthy --- where the system admiinstrator is
stupid enough to allow an untrusted user to mount an untrusted,
maliciously crafted file system, instead of using fuse2fs.  The
security people thinkt his is super-duper important.  Personally, I
don't think it's all that urgent, so by all means, don't feel obliged
to think about this while on vacation.  :-)

Anyway, that's the context.  Deepanshu has a proposed fix here[2]
which puts a folio_lock() into every single write page fault for ext4:

+	folio_lock(folio);
+	if (!folio_test_uptodate(folio)) {
+		folio_unlock(folio);
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+	folio_unlock(folio);

[2] https://lore.kernel.org/r/20251122015742.362444-1-kartikey406@gmail.com

This seems.... unfortunate to me, so the first question is, "is
locking the folio really necessary"?  (I suspect the answer is no),
and two, should this check be done in the mm layer calling
page_mkwrite(), or in ext4_page_mkwrite()?

Presumably, this might happen for other file systems, with either
syzkaller coming up with this rather implausible scenario of really
stupid, unfortunately system adminsitrator choices --- or in real
life, if we do have some system adminisrtators making really stupid,
unfortunate life choices.  So maybe we should this check should be
done above the file system layer?

						- Ted







> 
> On Wed, Dec 03, 2025 at 10:46:57AM -0500, Theodore Tso wrote:
> > My main concern with your patch is folio_lock() is *incredibly*
> > heavyweight and is going to be a real scalability concern if we need
> > to take it every single time we need to make a page writeable.
> > 
> > So could we perhaps do something like this?  So the first question is
> > do we need to take the lock at all?  I'm not sure we need to worry
> > about the case where the page is not uptodate because we're racing
> > with the page being brought into memory; if we that could happen under
> > normal circumstances we would be triggering the warning even without
> > these situations such as a delayed allocaiton write failing due to a
> > corrupted file system image.   So can we just do this?
> > 
> > 	if (!folio_test_uptodate(folio)) {
> > 		ret = VM_FAULT_SIGBUS;
> > 		goto out;
> > 	}
> > 
> > If it is legitmate that ext4_page_mkwrite() could be called while the
> > page is still being read in (and again, I don't think it is), then we
> > could do something like this:
> > 
> > 	if (!folio_test_uptodate(folio)) {
> > 		folio_lock(folio);
> > 		if (!folio_test_uptodate(folio)) {
> > 			folio_unlock(folio);
> > 			ret = VM_FAULT_SIGBUS;
> > 			goto out;
> > 		}
> > 		folio_unlock(folio);
> > 	}
> > 
> > Matthew, as the page cache maintainer, do we actually need this extra
> > rigamarole.  Or can we just skip taking the lock before checking to
> > see if the folio is uptodate in ext4_page_mkwrite()?
> > 
> > 							- Ted

