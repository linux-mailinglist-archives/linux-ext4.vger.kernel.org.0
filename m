Return-Path: <linux-ext4+bounces-12158-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A83CA5E58
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 03:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1320304F11D
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 02:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C3128467D;
	Fri,  5 Dec 2025 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IVxV0IBI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D91448D5
	for <linux-ext4@vger.kernel.org>; Fri,  5 Dec 2025 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764901258; cv=none; b=QWWHkSi4onhRDArjKpvlDbqg8+ph9MHR4CCaImufRpVhIxFkkYdPy9MKzVYgXJ5SGJDOwMRCH+DVmOI32xEf6TiHkgHXnK/Qq6H9IIE+0m3fNrFIIokhrtPFWlLQsJJ3s09XoiPBIRnFm4yo0EitFXKyHKO1yHVdcz0QZGt0eHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764901258; c=relaxed/simple;
	bh=5UyubtE1rEUpscGvD60LnLHFafRq3hNFUNA/EDp0QHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+ilJM520S+/nBUu5bxTcF0hTvg7RQbrIAmOoZvpZCep//O5NOhutNALaNXP1XMcSMDaGaGQLgtorJugDjDg0qRu4Ibc8zHfKzdIXUWB5DEBiFdKsR92HZAuryo5INOoTZgsGvIwMDj/900xwScB0V8fVyHkaLidzAcMXVGWyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IVxV0IBI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-102-187.bstnma.fios.verizon.net [173.48.102.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B52JIPm008310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Dec 2025 21:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764901161; bh=csXeN1Bz1gMnpe84St82baBkMzHhmVVlUHhZVO7IN1U=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IVxV0IBIgpA4vMRoe67sSjDq8u8mXtLz2riSRez9HPIT0RREMirwAgfMnSy1saYnS
	 AjxVis2mFVZZVRxs+H8oHBkVn8bGDuTyuTUocdc57QjFknExTWGX4x2KVZH5EDw6Hm
	 gtKiueKiUGbSS914qMsckntDvlTESrV2eFzTKOu3UCbluUPN8wCd5+fCqWHP5QTXi+
	 sPFHoqzhJ8IvN8tL9dbTfA4U61hjnHQ+p9OtK8ibxKUc9JRP1NWVOYLw4TH8n9vybe
	 agx2W5p8xHv9zhUpY/H285vlDrrwOfbJk/q1aU1Pr7KVUnl0ykp2fDvcX0uivGuFSo
	 csOkZfslv8LYg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 4325B4E78093; Thu,  4 Dec 2025 21:18:18 -0500 (EST)
Date: Thu, 4 Dec 2025 21:18:18 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Zhang Yi <yi.zhang@huaweicloud.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+b0a0670332b6b3230a0a@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, djwong@kernel.org
Subject: Re: [PATCH v2] ext4: check folio uptodate state in
 ext4_page_mkwrite()
Message-ID: <20251205021818.GF71988@macsyma.lan>
References: <20251122015742.362444-1-kartikey406@gmail.com>
 <CADhLXY5k9nmFGRLLxguWB9sQ4_B6-Cxu=xHs71c5kCEyj49Vuw@mail.gmail.com>
 <7b2fafab-a156-47e3-b504-469133b8793d@huaweicloud.com>
 <CADhLXY7AVVfxeTtDfEJXsYvk66CV7vsRMVw4P8PEn3rgOuSOLA@mail.gmail.com>
 <aadd43df-3df4-4dcc-a0b3-e7bfded0dff8@huaweicloud.com>
 <CADhLXY4Pk60+sSLtOOuR2QdTKbYXUAjwhgb7nH8qugf4DROT7w@mail.gmail.com>
 <20251203154657.GC93777@macsyma.lan>
 <aTCtITpW9yLNm2hz@casper.infradead.org>
 <20251203223300.GB71988@macsyma.lan>
 <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADhLXY4_yYdGQCYxq3=gQ6ZTJ7y_=dGsEBqdJ4g7JizX+ocVYA@mail.gmail.com>

On Thu, Dec 04, 2025 at 03:24:50PM +0530, Deepanshu Kartikey wrote:
> Based on Matthew's earlier feedback that we need to "prevent !uptodate
> folios from being referenced by the page tables," I believe the
> correct fix is not in ext4_page_mkwrite() at all, but rather in
> mpage_release_unused_pages().
> 
> When we invalidate folios due to writeback failure, we should also
> unmap them from page tables....

Hmm.... if the page is mmap'ed into the user process, on a writeback
failure, the page contents will suddenly and without any warning,
*disappear*.

So the other option is we could simply *not* invalidate the folio, but
instead leave the folio dirty.  In some cases, where a particular
block group is corrupted, if we retry the block allocation, the
corrupted block group will be busied out, and so when the write back
is retried, it's possible that the data will be actually be persisted.

We do need to make sure the right thing we unmount the filesystem,
since at that point, we have no choice but the invalidate the page and
the data will get lost when the file system is unmounted.  So it's a
more complicated approach.  But if this is happening when the file
system is corrupted, especially if it was maliciously corrupted, all
bets are off anyway, so maybe it's not worth the complexity.

     	     	     	      	       - Ted

