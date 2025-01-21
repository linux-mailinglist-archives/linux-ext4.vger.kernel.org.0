Return-Path: <linux-ext4+bounces-6188-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D14A18744
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 22:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A7B164BB9
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 21:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EFE1E3DE3;
	Tue, 21 Jan 2025 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a0SPBwh1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE01B87FA
	for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737494787; cv=none; b=q1fum5eTnGsaLjf/czz6Ayf+4Th6iLS1t6BLdm+RikQSW3xXF13ep7xQ5gxIUWTQEXVfym+LEL3vfNlDGcJQYgXTT+QAjDHZcNAbX7c+q35EhFxa4tg7v1JQtGk80C9Pp37pxKXcdZoenf8gAz51rTWwWMnXI0H7tJl5QjUaOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737494787; c=relaxed/simple;
	bh=eYLJftNcNkZNuO3ze3NBrhoEa/rOqGsh3IOdS9mgDVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIXRMUzjzzkZMgVjxDKeMueqhmT1BdarGdJmzAg7mjyuNyXlYaE1gyWJMV9ceR2gvPfh6gi131lFBkyO4b28sFJYWoRBZeQIeswRI+0sV0wgERfMVtRvzS3ktVh6tOc/hhfp0B0FbgsD/Ny/9UB49scLmTe7P5V1iJ7tpLUvllI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a0SPBwh1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2164b1f05caso115753115ad.3
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jan 2025 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737494785; x=1738099585; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZyGvJOjyzCu5i01szWjzK25gtgzFBwWXE4I0FY4E38=;
        b=a0SPBwh1OJrbkA6NVlLjxi03Pfo5hPyHAmg5jAlcfyWzxIo3Dy+WYkRDr1C1VSX5BX
         LtLpaHkYjRRcwd99ORXWiLQLdnKb5X7S9tPy+CgHAmhcgZX5DeNsYnvF03mGfG8A/z0n
         rUtmyQyCN2p4eN30mefqhVzbeR98gONbNKYaq5+W2CgkFHhyh0ZEoPuXNZ1QMjjTwJrH
         NFi0X+VuM9apFDlCsUzUWghJMuuNv3n+Bl0P2w1Au2Iids2prr/mwvEXE0zXbGnYU6ul
         xtO2mfJ7GyOOKzdU9La1hnz3ohouOt0cDrLlxHpMam6sjmR5iSPJGN2j9szBJzXwgUSt
         rYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737494785; x=1738099585;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZyGvJOjyzCu5i01szWjzK25gtgzFBwWXE4I0FY4E38=;
        b=nZzjJrvXYhp3eY1xrQgGfTxIH7yHVC/uoejKjH/+pJ0Dfzz2cQ+G8uoJ82CIg9tV5j
         x+HYIUMDlKTEHlur+zvaXKHa9JyAfV3G7C+qgTSDqB7I7lifcmiPNbs/lxKEpTHgeCqW
         +40QeVV16vALGH8LJcKDoRxPeJ3EBmguXCkXrJnZmzrLIywz6GbRmOyok0nK1nQmfFDT
         qWuT73OkL0IVnZa6HhCflyFiDc7qFdLCD66V6gZnl9Q0a2q+QFyczKFU5tGoj+sgk5IM
         P5Jub3WUjRFkqg9kYXrQLz43S9UFGApgqB5PA5qyu/EvojWE6Qf27+9DRcJzYAHb51RN
         01oA==
X-Forwarded-Encrypted: i=1; AJvYcCVc3+0PKBIhlsp5KBrQzXf/57t0i1m4KmjbVXx6ODjj0WoRqA1azNTbqTfnDJYvpDVctKr70u+RF7Ne@vger.kernel.org
X-Gm-Message-State: AOJu0YzsgAoZR5CSA0dMJ2tWCZxTCNbDidzGYeYuAK98OL6Z8Ght1MSq
	72EJeyL7hKiAUKSyNTu6vP8N3vCasEaPMAvsGQf7Fyu3/O752nY8eAuXngknWPgpHwJVzROttFY
	H
X-Gm-Gg: ASbGncvZmpsV+HdLIXvuzI6eS21y4QELjeOiJN/6Tf7wqSPLka45kOFA5+Y77ybQ5Lo
	6oLNJcR8frGHeDkK3T8QrPj96eijnHYEJb7REsTGiDc4tv5yI8FxDass192CQZx+p3J1oXr5bPP
	20lCntgnrYy8xEcNBGhZE/I0pOOrdeLFfCIkClAfZphpjtF2G4uN/xqjf88nRipOBktqPvEriA3
	v3cNr8bWxve5EXHa3m9jusEqmZ9CUqTvLlSyrSXAHVQtxBFcwEgdrTvbzWounDpx7le2i55jaBC
	8NGhAoXPt68g66lUAkIlbtIdj3ei1sB6QGtKbrPsWxpxGQ==
X-Google-Smtp-Source: AGHT+IGZy3KyfJT50Cr1MwX5AigEY+wJTYNcOQvsK8T/cnoCqCq/0+Y8SbHmp1C7Kk3UrGefc0aTAw==
X-Received: by 2002:a17:902:db0a:b0:216:7761:cc49 with SMTP id d9443c01a7336-21c355f70c7mr242395205ad.47.1737494785165;
        Tue, 21 Jan 2025 13:26:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d42d599sm81867525ad.252.2025.01.21.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 13:26:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1taLlN-00000008ouR-2cIY;
	Wed, 22 Jan 2025 08:26:21 +1100
Date: Wed, 22 Jan 2025 08:26:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: Gerhard Wiesinger <lists@wiesinger.com>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Transparent compression with ext4 - especially with zstd
Message-ID: <Z5AQ_Sq5CdsRb2i-@dread.disaster.area>
References: <8cb4d855-6bd8-427f-ac8f-8cf7b91547fb@wiesinger.com>
 <20250121040125.GC3761769@mit.edu>
 <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213343dc-3911-45de-8195-469da9dd1a91@wiesinger.com>

On Tue, Jan 21, 2025 at 07:47:24PM +0100, Gerhard Wiesinger wrote:
> On 21.01.2025 05:01, Theodore Ts'o wrote:
> > On Sun, Jan 19, 2025 at 03:37:27PM +0100, Gerhard Wiesinger wrote:
> > > Are there any plans to include transparent compression with ext4 (especially
> > > with zstd)?
> > I'm not aware of anyone in the ext4 deveopment commuity working on
> > something like this.  Fully transparent compression is challenging,
> > since supporting random writes into a compressed file is tricky.
> > There are solutions (for example, the Stac patent which resulted in
> > Microsoft to pay $120 million dollars), but even ignoring the
> > intellectual property issues, they tend to compromise the efficiency
> > of the compression.
> > 
> > More to the point, given how cheap byte storage tends to be (dollars
> > per IOPS tend to be far more of a constraint than dollars per GB),
> > it's unclear what the business case would be for any company to fund
> > development work in this area, when the cost of a slightly large HDD
> > or SSD is going to be far cheaper than the necessary software
> > engineering investrment needed, even for a hyperscaler cloud company
> > (and even there, it's unclear that transparent compression is really
> > needed).
> > 
> > What is the business and/or technical problem which you are trying to
> > solve?
> > 
> Regarding necessity:
> We are talking in some scenarios about some factors of diskspace. E.g. in my
> database scenario with PostgreSQL around 85% of disk space can be saved
> (e.g. around factor 7).

So use a database that has built-in data compression capabilities.

e.g. Mysql has transparent table compression functionality.
This requires sparse files and FALLOC_FL_PUNCH_HOLE support in the
filesystem, but there is no need for any special filesystem side
support for data compression to get space gains of up to 75% on
compressible data sets with the default database (16kB record size)
and filesystem configs (4kB block size).

The argument that "application level compression is hard, so we want
the filesystem to do it for us" ignores the fact that it is -much
harder- to do efficient compression in the filesystem than at the
application level.

The OS and filesystem doesn't have the freedom to control
application level data access patterns nor tailor the compression
algorithms to match how the application manages data, so everything
the filesystem implements is a compromise. It will never be optimal
for any given workload, because we have to make sure that it is
not complete garbage for any given workload...

> In cloud usage scenarios you can easily reduce that amount of allocated
> diskspace by around a factor 7 and reduce cost therefore.

Same argument: cloud applications should be managing their data
sets appropriately and efficiently, not relying on the cloud storage
infrastructure to magically do stuff to "reduce costs" for them.

Remeber: there's a massive conflict of interest on the vendor side
here - the less efficient the application (be it CPU, RAM or storage
capacity), the more money the cloud vendor makes from users running
that application. Hence they have little motivation to provide
infrastructure or application functionality that costs them money to
implement and has the impact of reducing their overall revenue
stream...

> You might also get a performance boost by using caching mechanism more
> efficient (e.g. using less RAM).

Not true. Linux caches uncompressed data in the page cache - caching
compressed data will significantly increase the memory footprint and
CPU consumption as it has to be constantly uncompressed and
recompressed as the data changes. This is not a viable caching
strategy for a general purpose OS.

> Also with precompressed files (e.g. photo, videos) you can safe around 5-10%

Video and photos do not compress sufficiently to be a viable runtime
compression target for filesystem based compression. It's a massive
waste of resources to attempt compression of internally compressed
data formats for anything but cold data storage. And even then, if
it's cold storage then the data should be compressed and checksummed
by the cold storage application before it is written to the
filesystem.

> The technical topic is that IMHO no stable and practical usable Linux
> filesystem which is included in the default kernel exists.
> - ZFS works but is not included in the default kernel
> - BTRFS has stability and repair issues (see mailing lists) and bugs with
> compression (does not compress on the fly in some scenarios)

I hear this sort of generic "btrfs is not stable/has bugs" complaint
as a reason for not using btrfs all the time.

I hear just as many, if not more, generic "XFS is unstable and loses
data" claims as a reason for not using XFS, too.

Anecdotal claims are not proof of fact, and I don't see any real
evidence that btrfs is unstable.  e.g. Fedora has been using btrfs
as the root filesystem (and has for quite a while now) and there has
been no noticable increase in bug reports (either for fs
functionality or data loss) compared to when ext4 or XFS was used as
the default filesystem type...

IOWs, I redirect generic "btrfs is unstable" complaints to /dev/null
these days, just like I do with generic "XFS is unstable"
complaints.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

