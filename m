Return-Path: <linux-ext4+bounces-319-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B862806C05
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B270FB20DB8
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3091D2DF67;
	Wed,  6 Dec 2023 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="w2M98COF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66F112B
	for <linux-ext4@vger.kernel.org>; Wed,  6 Dec 2023 02:34:52 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28865456abbso434284a91.1
        for <linux-ext4@vger.kernel.org>; Wed, 06 Dec 2023 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701858892; x=1702463692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Z8EdhyaZRP7j5Yaa3EE9onKgRz+Z4MfKus85WrUrY=;
        b=w2M98COFigB8GmX+JPVFQJX+JoktYohW1NTF5APcxmW8HtWDwEcXI4/ejjjv8pnI4Q
         OVTHe4PWqDGQ7hVUxo4NA04B1ACVRFWeVh5UIrgyGv6dJ+v2XTp9RGVYLsbZ0FgkCZaC
         A1GPQSClac7cEK3YY2y2JSell9df5B/Ib+zKrtUWuK+3ySo/rs9TSF/BW95nYAQR70nO
         2abijId72/rE/z0NWfV1quElPlS1QcJlcH41iuG1w0k+p3aqSv8tQCfL2TRx2+ACjREd
         sUq4JvEsImU5lDsjcu6pg7fKVB0BuVVlzCpwX6J30twUB1pF0PYFmP/9qGpTVRNlUzE9
         rdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858892; x=1702463692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Z8EdhyaZRP7j5Yaa3EE9onKgRz+Z4MfKus85WrUrY=;
        b=Vhndq0ZutiFkYvc0AVsuO5u69qeCUlvIM/x1kj+hNzG0ZLcNRcT6WbOXWXVl+Nf73L
         4BOcjCObDn1+B7MYZcD/eWIZC5KWIdxlQ4JViiO/GpwNOkIpDQLthf1c6Xqjf+Z+Xcb9
         Ou22VDKHbppHRE8+1mrfJPmtTUr7Joa7T/aq+7SBp0oZk8ixvglW3WdWaaJ8/7Jzwivv
         2oYxYcqEnF3QNdOxQkK1zuiuoAG8s8nbi9dXWiq0LiOtShXHWY3jVysQIOByE4AhZFML
         ZY28Kg9QCH4cA5gp0dEbstQsbBNj1RzgaDfVSizNJmghu4bAJnZYCDaz2kNoTPqvWuC2
         kx1A==
X-Gm-Message-State: AOJu0YyystSUqbyLpTPgTrR14W4uQECDGDbFTovOFE5gU8jAj9n6kF3q
	Y5NvZSHv3gEDmXlAh94P9w6/iQ==
X-Google-Smtp-Source: AGHT+IG+r05DW+YG20wT0zMSUQjc8wthXzTPHXekABeetwsDcjq3ngyrW/IXXGOyDC8eXSbIvaBSMQ==
X-Received: by 2002:a17:90b:1249:b0:286:6cc1:866d with SMTP id gx9-20020a17090b124900b002866cc1866dmr475002pjb.82.1701858892359;
        Wed, 06 Dec 2023 02:34:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001cc1dff5b86sm10987117pla.244.2023.12.06.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:34:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rApEv-004aa5-1z;
	Wed, 06 Dec 2023 21:34:49 +1100
Date: Wed, 6 Dec 2023 21:34:49 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, willy@infradead.org,
	akpm@linux-foundation.org, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXBOSRhm11DtGO+K@dread.disaster.area>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
 <ZXA4swgzsHbkm/uB@infradead.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXA4swgzsHbkm/uB@infradead.org>

On Wed, Dec 06, 2023 at 01:02:43AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 06, 2023 at 07:35:35PM +1100, Dave Chinner wrote:
> > Mixing overlapping buffered read with direct writes - especially partial block
> > extending DIO writes - is a recipe for data corruption. It's not a
> > matter of if, it's a matter of when.
> > 
> > Fundamentally, when you have overlapping write IO involving DIO, the
> > result of the overlapping IOs is undefined. One cannot control
> > submission order, the order that the overlapping IO hit the
> > media, or completion ordering that might clear flags like unwritten
> > extents. The only guarantee that we give in this case is that we
> > won't expose stale data from the disk to the user read.
> 
> Btw, one thing we could do to kill these races forever is to track if
> there are any buffered openers for an inode and just fall back to
> buffered I/O for that case.  With that and and inode_dio_wait for
> when opening for buffered I/O we'd avoid the races an various crazy
> workarounds entirely.

That's basically what Solaris did 20-25 years ago. The inode held a
flag that indicated what IO was being done, and if the "buffered"
flag was set (either through mmap() based access or buffered
read/write syscalls) then direct IO would do also do buffered IO
until the flag was cleared and the cache cleaned and invalidated.

That had .... problems.

Largely they were performance problems - unpredictable IO latency
and CPU overhead for IO meant applications would randomly miss SLAs.
The application would see IO suddenly lose all concurrency, go real
slow and/or burn lots more CPU when the inode switched to buffered
mode.

I'm not sure that's a particularly viable model given the raw IO
throughput even cheap modern SSDs largely exceeds the capability of
buffered IO through the page cache. The differences in concurrency,
latency and throughput between buffered and DIO modes will be even
more stark itoday than they were 20 years ago....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

