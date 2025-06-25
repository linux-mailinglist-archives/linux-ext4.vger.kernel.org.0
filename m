Return-Path: <linux-ext4+bounces-8633-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9716AE82A3
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 14:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7271BC1001
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Jun 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2E25DAF4;
	Wed, 25 Jun 2025 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="p/Ed3doL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7C25DAF7
	for <linux-ext4@vger.kernel.org>; Wed, 25 Jun 2025 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750854324; cv=none; b=kvmIiDncWCyJDSrKJzsLsKjPQIGlFXVKp20eZom3EBcvDTUzvEo/gyjRNqU8MLXFBxHtR4QeTc2KaGWR1u+AxRYK3ILdfMLGok/4TDXIhCU0AnRrISUie9/NrLb2uMoZ6CJAWk4vIBKBj86vAs2Kz99sAp5KNcbvvLy+pfb/8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750854324; c=relaxed/simple;
	bh=8dcU5zr0uhc6MvRHTL9XL7oywq+hqqfv698plU+WN+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY57TmVOnDZSt+y3B/ZO6275SCOcypUD4HPLL5r03lyIDVF2OwgcfMS7MqRi4TYPKReVghtf1iPW/zxkxwu67vWi+4CjnVr2hTPrlw4LCvERZ/q/UFykwkWP3HptDQu7IlPzIkpxGII2JOG45z4OvMZ+VfQpBpuAGJOeXurkhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=p/Ed3doL; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bS1HM11m8z9sWp;
	Wed, 25 Jun 2025 14:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750854319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HH4xTr+b1fFFEWlSAGOzke4S6ErqBFOagzC36RgWHSk=;
	b=p/Ed3doLob975AoeCaSI9B4g5WSL5qdDAqqjgQ/Jxdy7PsmARYQNMvC+1cGw+hKNcPTmtB
	1iJExxv+7SO+VbvPsGkpQQxOLs2aL1/mKkq77VdhyYnjRM+nZ7oIHxioP8s+CcLm2N11xf
	6zZdajrvfVGdlWHNotW9JW2Ii2cOvYANoywmuZTNgYWls9QFcZAYMtM06T9yeTLemnotT4
	BzBqOO7pPKsTqbMFYa5a5cXkP9TXUzz2dScg3gDlF+f7bP0o8T9hHEXSVV/BhBdJ6hd7SB
	XiIvrZ1lW3rn5XlJGxUPDVRtRr/PbtkQ0tfj6IjBKK5fqGUUz4QpedPdVfgKSQ==
Date: Wed, 25 Jun 2025 14:25:13 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>, 
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: LBS support for EXT4
Message-ID: <p7ba6n2kgrrmcjlsfcjxuo3xrc6fph4wq6qbwxe6fjur54pt55@pvuxuki43v5r>
References: <6ac7ce67-b54b-437e-9409-7da9402c9de1@pankajraghav.com>
 <jcgnjl6txstun2hcimtz2zdayz7kxw4em6orafu5mfmcl2j5ik@ootfvveenf7j>
 <279f3612-ca02-46e0-a4ae-05052f2b1e50@pankajraghav.com>
 <20250623141753.GA33354@mit.edu>
 <c3ywjnnpfefledcl27qoqvwi4ew7fkrpmneddbxtquazraocrv@5e6l3t5oqap4>
 <dfad7391-e3fe-498d-8d33-55c00d8a3f46@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfad7391-e3fe-498d-8d33-55c00d8a3f46@huawei.com>

On Wed, Jun 25, 2025 at 07:51:56PM +0800, Baokun Li wrote:
> On 2025/6/25 19:13, Pankaj Raghav (Samsung) wrote:
> > Thanks for the reply, Ted.
> > 
> > On Mon, Jun 23, 2025 at 10:17:53AM -0400, Theodore Ts'o wrote:
> > > If you want to review and test the ext4/iomap changes, that would be
> > > great.  Be aware, though, that there are some features of ext4
> > > (example: data journalling, fscrypt, fsverity, etc.) that the current
> > > iomap buffered I/O code may not support today.  The alternatives are
> > > to keep the existing ext4 code paths for those file system features,
> > > or to try to add that functionality into iomap.  There are of course
> > > tradeoffs to both alternatives; one might result in more code that we
> > > have to maintain; the other might require a lot more work.
> > > 
> > > It _might_ be less effort to add LBS support to native ext4 code.  I
> > > think the main thing is to make sure that we always we use a large
> > > folio and not fall back to a sub-blocksize set of pages.  So again,
> > > it's all about tradeoffs and what you consider to be the highest
> > > priority.
> > @Baokun are your LBS patches based on the native ext4 code or on top of
> > Zhang's iomap patches.
> Now that mainline ext4 supports buffer head large folios, we'll first
> focus on LBS support based on buffer heads. The main work involves adapting
> ext4's internal logic (e.g., block allocation, read/write operations,
> defragmentation) and clean up the process related to buffer head.

Makes sense. When we added the LBS support to XFS, the changes in XFS
itself was very minimal. But I can imagine there is a bit more work and
testing involved in adding LBS support to EXT4 with buffer heads.

> This doesn't conflict with iomap buffer write support. The iomap framework
> already supports LBS (as xfs is already using it), so once ext4's internal
> logic is adapted, Zhang Yi's iomap buffer write patches should also support
> LBS upon their merge.

Yes. iomap has all the logic to handle LBS.

Thanks for the clarification. Looking forward to the patches.

-- 
Pankaj Raghav

