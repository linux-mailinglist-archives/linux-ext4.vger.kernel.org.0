Return-Path: <linux-ext4+bounces-2630-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AF8CCA47
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 03:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43461F22391
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 01:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C068485;
	Thu, 23 May 2024 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Dji7+uYF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031BC63AE
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 01:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426670; cv=none; b=QsP4zukdMZq/C+aa6K0FwiYwc98O+k8jzHd/IqBhNzwQV7m9ts3bTLc1UHQWBZCuwvaKwkbuntC4NZRmnIruUJZV9yYjAEGKJki+KGXPF5XJTEtlOqxhap3zjgZYlIOB6FkG62S2qJn07zvu9A5Ro7YX94DLFyyA8nw+VW5h210=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426670; c=relaxed/simple;
	bh=irmPEB0EJHZap0scHqXlwAoFaMpePoW3FnqN7BaOryk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBYVtnvsRtj1aHgfH2YeEnmYslfO9diwt82rrQDZ9AtoJjKqrowK23aFDOwKWFveJq1Ed9GC78US47pGpqLi0tMRDUZFf1Z2+fhqrJbjKx8mCV3+nG2hyfWF/TYOutXjiKkjDAmVDESnzfM3F4BBSrZWb8nQWbhytaVFYasyK7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Dji7+uYF; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b296194ac1so4182856eaf.2
        for <linux-ext4@vger.kernel.org>; Wed, 22 May 2024 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716426668; x=1717031468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmvUqD+Lw4cLCsEe0vSwF972lL7nlr8Q3vsLBnKUsoc=;
        b=Dji7+uYFTPtSdPwm2cXr8wjncXPx+e1dWVj7qrpHYjJ7T6l3XIVsCUkv/UDMwtOFQ/
         KpXm3NRTkB9POaEAxRUcvzQ8uAN6o6ALv5WzfQTDjkFT/i6/MKPCt8zb1QwMNbpKGmSs
         1WBO6JHhNfHnlWA4AXwS4++xG79uNrQcFSAbIujB0AbaP08cYlVPLF7kMRQmc8EZSCvP
         loyIyNqq06i46/mxIGKcCoPwh4NU/S9ZsqtMITsfu7M9cYkAPu9Ku1va5nV7ycQsEeYd
         m5KjCXfIlacnd3CMEjT7imUxPlb2n+E4wWv1EHOUE58lxlT3f8HeqRXrOWlm9hqsCOSM
         +UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426668; x=1717031468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmvUqD+Lw4cLCsEe0vSwF972lL7nlr8Q3vsLBnKUsoc=;
        b=Ahu6500bQ+w0Kvgwc3x9lZyLyfWPOGrA2FWU0vZiYSz/ICuUIboUrl21yWJTt3kyrT
         rmLgYaosSFUTHUpALLHNnNANJ4KSpbupou/VQMSW7PrDK/RMBSaLurT5q0+NTcZZ3Doz
         WR1QEuMC/t29OwAXPOEZ+KrD+x1Srk+slUtPmMAhAwnQZo0W+dB7gy7oXFl/7e8A4JzL
         wB8Q2dN0wdEuyJGIsJnK85EifPL6Hu3T7e8xXJJwPiIYpF4NU+LhjEDA0KRGCacjbY84
         LTOp1ZL59d0HxNNkd/FVSC0TUMl+nfBl6wCzRpK5EqD9sVNLqSsiW+68imh78Dm2ELqB
         YsnA==
X-Forwarded-Encrypted: i=1; AJvYcCUbX52mvDiVDjmk5Zn4Ix6MeAXcuRvOvwopLxl0L5/YsYEoR282Ll/lPhPfNd7g4AvQL8u9qb6AgDHrPYYdK9bcB9G/C7AmKp26Tw==
X-Gm-Message-State: AOJu0YzXktwMQf1KSZlPdbOGhiLLIYojUWBx7X6E9RnJoMRbR+9Svsdb
	t08BRNY6Hq+pXTZmuLsFTtl/6hWDN+BLLPKpreziJ+YqCyMyBOChplEebN+aPAo=
X-Google-Smtp-Source: AGHT+IHLpQjpY/ZDizwGZZhnZO6kNpcNVrezvsSVGVdrwzcu/g7Obm3i7DB5DFERDBG9ikNNOGjsXw==
X-Received: by 2002:a05:6358:614b:b0:183:a0ac:b638 with SMTP id e5c5f4694b2df-19791b6fceemr296203455d.11.1716426667893;
        Wed, 22 May 2024 18:11:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6341180dc5csm20062714a12.93.2024.05.22.18.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:11:07 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s9wz2-007786-19;
	Thu, 23 May 2024 11:11:04 +1000
Date: Thu, 23 May 2024 11:11:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	djwong@kernel.org, hch@infradead.org, brauner@kernel.org,
	chandanbabu@kernel.org, jack@suse.cz, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
Message-ID: <Zk6XqIcO+7+VPn35@dread.disaster.area>
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
 <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>

On Wed, May 22, 2024 at 09:57:13AM +0800, Zhang Yi wrote:
> On 2024/5/21 10:38, Dave Chinner wrote:
> > We can do all this with a single writeback operation if we are a
> > little bit smarter about the order of operations we perform and we
> > are a little bit smarter in iomap about zeroing dirty pages in the
> > page cache:
> > 
> > 	1. change iomap_zero_range() to do the right thing with
> > 	dirty unwritten and cow extents (the patch I've been working
> > 	on).
> > 
> > 	2. pass the range to be zeroed into iomap_truncate_page()
> > 	(the fundamental change being made here).
> > 
> > 	3. zero the required range *through the page cache*
> > 	(iomap_zero_range() already does this).
> > 
> > 	4. write back the XFS inode from ip->i_disk_size to the end
> > 	of the range zeroed by iomap_truncate_page()
> > 	(xfs_setattr_size() already does this).
> > 
> > 	5. i_size_write(newsize);
> > 
> > 	6. invalidate_inode_pages2_range(newsize, -1) to trash all
> > 	the page cache beyond the new EOF without doing any zeroing
> > 	as we've already done all the zeroing needed to the page
> > 	cache through iomap_truncate_page().
> > 
> > 
> > The patch I'm working on for step 1 is below. It still needs to be
> > extended to handle the cow case, but I'm unclear on how to exercise
> > that case so I haven't written the code to do it. The rest of it is
> > just rearranging the code that we already use just to get the order
> > of operations right. The only notable change in behaviour is using
> > invalidate_inode_pages2_range() instead of truncate_pagecache(),
> > because we don't want the EOF page to be dirtied again once we've
> > already written zeroes to disk....
> > 
> 
> Indeed, this sounds like the best solution. Since Darrick recommended
> that we could fix the stale data exposure on realtime inode issue by
> convert the tail extent to unwritten, I suppose we could do this after
> fixing the problem.

We also need to fix the truncate issue for the upcoming forced
alignment feature (for atomic writes), and in that case we are
required to write zeroes to the entire tail extent. i.e. forced
alignment does not allow partial unwritten extent conversion of
the EOF extent.

Hence I think we want to fix the problem by zeroing the entire EOF
extent first, then optimise the large rtextsize case to use
unwritten extents if that tail zeroing proves to be a performance
issue.

I say "if" because the large rtextsize case will still need to write
zeroes for the fsb that spans EOF. Adding conversion of the rest of
the extent to unwritten may well be more expensive (in terms of both
CPU and IO requirements for the transactional metadata updates) than
just submitting a slightly larger IO containing real zeroes and
leaving it as a written extent....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

