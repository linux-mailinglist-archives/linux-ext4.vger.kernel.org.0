Return-Path: <linux-ext4+bounces-6307-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FAA27C91
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 21:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4627A2509
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Feb 2025 20:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F34218EA2;
	Tue,  4 Feb 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="uJpmLWw8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D621767A
	for <linux-ext4@vger.kernel.org>; Tue,  4 Feb 2025 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738699967; cv=none; b=KsJk04IJ5HXcsK0R732KKvs1FUQiTgSWpTTat32+syQ0XQQLgr3CaRUaKPEsfnBQWj7scuQvZ1VSLcoKpyu4QVE7R/MjShQR0T1hwtxNVZV23j41E2Se5P/GjaP80+hBX78uA4bBMS1Uia5GTAm6YzHIebW5TcGBt4ULEUhaGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738699967; c=relaxed/simple;
	bh=gp/qKcceCIBFhzJB5w2WTr0ubjDqbrZuAp3vz+nOqwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJGTBSmQXwP0H1BMdUv0Xmud+tMEEeFAShbISIJkCk4fZkgSiGGmdSQiM73vjy7+bTqZlTCP64TTK1nBQxYAOhSzDKrHtu7rQF4iEfnANaDyvancBHnJIjw6OzQyfdLOR6YbZiAeR6HEEgbJayAkFQZxscRKfKoRA83q1T8y8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=uJpmLWw8; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21619108a6bso101959915ad.3
        for <linux-ext4@vger.kernel.org>; Tue, 04 Feb 2025 12:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738699965; x=1739304765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZakwx3hIZttBtHScOUEbEcec/nTeRPJ+CdcAVEs9PQ=;
        b=uJpmLWw8WyXFev/F2MCx3TLRcnZUZFgRL/0hINC6MC9aFSdmKG6jY//phnFTEIc9yg
         pYIIjOjUhaVzXBM6ter9gw06xjuVGfGystmBCf+mSMojsF+Qze8YWyXM58WntTtS9aAS
         CkZmwlaazJfMzcg+EOvO6nV4BVV9sjvn9h7HZGrnMOzPjOz8mS7MIEAS4DTzObzgXM9E
         vpEwcH+6e/yWjFLpYHoq4EQYMfqK8vIOMesBFCEU/67qipLEDUr+wcVPkEaFoukO+/mR
         HqrxQzLywy/brjDPAxcJiC6gIHanUd14CXgvG4j7WO2HWVrxf6qRZ+ybUMafTQarfLQt
         4NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738699965; x=1739304765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZakwx3hIZttBtHScOUEbEcec/nTeRPJ+CdcAVEs9PQ=;
        b=TSCCak+9XZduDWHb9DW466/JkjUhS4VhpxtCuM6WgEiQVB08xEVHskX334aN5xqlsp
         YwjmOWwwSAY8GlssEaK2C4dG8q5JLsDyb+KV4MJJkDvwFDR+sfocFStWtMQsqdQm+LLt
         mFkzONWe9AsZolhZXRwMSp90hdrnkEwDZcD9gmU5aliGSF6/wZDRP66wTL8ZM95ENLbZ
         69vViQoFAf9nta9jbUWo0h9+rwvXrfUoIyblBn//GaRjsU/FmHz27cEYDP4a8fg0M/R4
         EMRHXseTvu7NG5sUi9RikMTwYsLe8+POBbe6s3h3iBYfqVqmqsm85FCiHtHtEKoDbJ93
         5QqA==
X-Forwarded-Encrypted: i=1; AJvYcCWSvRN2JkNdNHwpKWIk5gCYsy1Zs2Mkx+Ynlm5hkvVykhVHNAGOBkTRqMgUoRXQhXo0ASKsh4WkwZqt@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtMJcd+7nd7BHDHsNzRlBbPqXTUz4fKYftD37Auyp6dcyFPrD
	j224ZxaQAhUEtzxX/kM73SKS1sZwtrhHfHI9D04Eyxnx9yBAF0eSya7VewQl1mQ=
X-Gm-Gg: ASbGncuyExggu+HO82at2C8E5kYy66DybE4WCNUDgLrLvm1YV1dDPZM7JeVRkZUnjQr
	CMvex2JJNDd7gZ8cTNeGGGJmimZUanRoE0ked4aXO1HWng2tQoniIO3S87bFEuzNLPv7jcYaa7N
	TaMidtoMdgdK+oTNubGDv42Wv59nurjH/bJoF9nJEVJ/pbHWmxe2C3MJRF3S6Fqe5c0ye6pxsEP
	g6wWPMEGhWtMVxzL4ADbrg4v6LTznPdHc2NbA/386ScqrfWr5X69lgRRi54ghGdr2E10eFh5QFu
	RBsAdbDy3x6dq0LzCAC0SIpC/WlIdmMnfNuQobQzJK6gyiSUF+5WXEIdCQ0//M46C8w=
X-Google-Smtp-Source: AGHT+IGwLEGhvYlXmhivElW8iATNfxvrwUqd0N+S0un/akZ8NPdnmS/kHtUzgFQDwkzSpzERucIPaw==
X-Received: by 2002:a05:6a21:9011:b0:1e8:a14a:7b67 with SMTP id adf61e73a8af0-1ede88ad432mr106482637.26.1738699965334;
        Tue, 04 Feb 2025 12:12:45 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe384685sm10442964a12.17.2025.02.04.12.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 12:12:44 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfPHl-0000000EeLL-1z56;
	Wed, 05 Feb 2025 07:12:41 +1100
Date: Wed, 5 Feb 2025 07:12:41 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org,
	dchinner@redhat.com, hch@lst.de, ritesh.list@gmail.com,
	jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z6J0uZdSqv3gJEbA@dread.disaster.area>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>

On Tue, Feb 04, 2025 at 12:20:25PM +0000, John Garry wrote:
> On 01/02/2025 07:12, Ojaswin Mujoo wrote:
> 
> Hi Ojaswin,
> 
> > > For my test case, I am trying 16K atomic writes with 4K FS block size, so I
> > > expect the software fallback to not kick in often after running the system
> > > for a while (as eventually we will get an aligned allocations). I am
> > > concerned of prospect of heavily fragmented files, though.
> > Yes that's true, if the FS is up long enough there is bound to be
> > fragmentation eventually which might make it harder for extsize to
> > get the blocks.
> > 
> > With software fallback, there's again the point that many FSes will need
> > some sort of COW/exchange_range support before they can support anything
> > like that.
> > 
> > Although I;ve not looked at what it will take to add that to
> > ext4 but I'm assuming it will not be trivial at all.
> 
> Sure, but then again you may not have issues with getting forcealign support
> accepted for ext4. However, I would have thought that bigalloc was good
> enough to use initially.
> 
> > 
> > > > I agree that forcealign is not the only way we can have atomic writes
> > > > work but I do feel there is value in having forcealign for FSes and
> > > > hence we should have a discussion around it so we can get the interface
> > > > right.
> > > > 
> > > I thought that the interface for forcealign according to the candidate xfs
> > > implementation was quite straightforward. no?
> > As mentioned in the original proposal, there are still a open problems
> > around extsize and forcealign.
> > 
> > - The allocation and deallocation semantics are not completely clear to
> > 	me for example we allow operations like unaligned punch_hole but not
> > 	unaligned insert and collapse range, and I couldn't see that
> > 	documented anywhere.
> 
> For xfs, we were imposing the same restrictions as which we have for
> rtextsize > 1.
> 
> If you check the following:
> https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.garry@oracle.com/
> 
> You can see how the large allocunit value is affected by forcealign, and
> then check callers of xfs_is_falloc_aligned() -> xfs_inode_alloc_unitsize()
> to see how this affects some fallocate modes.
> 
> > 
> > - There are challenges in extsize with delayed allocation as well as how
> > 	the tooling should handle forcealigned inodes.
> 
> Yeah, maybe. I was only testing my xfs forcealign solution for dio (and no
> delayed alloc).

XFS turns off delalloc when extsize hints are set. See
xfs_buffered_write_iomap_begin() - it starts with:

	/* we can't use delayed allocations when using extent size hints */
        if (xfs_get_extsz_hint(ip))
                return xfs_direct_write_iomap_begin(inode, offset, count,
                                flags, iomap, srcmap);

and so it treats the allocation like a direct IO write and so
force-align should work with buffered writes as expected.

This delalloc constraint is a historic relic in XFS - now that we
use unwritten extents for delalloc we -could- use delalloc with
extsize hints; it just requires the delalloc extents to be aligned
to extsize hints.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

