Return-Path: <linux-ext4+bounces-318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55142806A98
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA731C20932
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Dec 2023 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D021A718;
	Wed,  6 Dec 2023 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zdO2H/GF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0BBFA;
	Wed,  6 Dec 2023 01:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ESwEwJpMWsb1q1d00f+KoCLpSfEhMR+fcQ8QnG0nZoY=; b=zdO2H/GFM5zuA/L5PBl09vu4SX
	Nj1NPCIO6UpL1CS1ZiK7pZAgkEAouwfOHdWjaB/UIFvNCMcmrJzg3APPhDLPBs5EBJHDMwWrzKYQb
	YXmIEu+cyobQvPWugKFg1wrytc6fzHyAchYm/YclQc5hNhlB1ejYW+R8HC3rcO0QbfJf4IupBinJb
	o+Gy9bIuZuAG6iUsl02KdeBjw/2gDvuFrRBxpaGBlugOAhNAcWn79lMAgdFOOf4MKaZvaz1hA7gqT
	RXkliwsSHWURz6Sp/+N0ZdxyHmni68VHPgNY1K1gj2ixWQQJ7CDTkUboZgKMJM5GlVA+YZxcOIEjZ
	I8v77+EA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAnnn-009VGi-1H;
	Wed, 06 Dec 2023 09:02:43 +0000
Date: Wed, 6 Dec 2023 01:02:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, willy@infradead.org,
	akpm@linux-foundation.org, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXA4swgzsHbkm/uB@infradead.org>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAyV/rlfvBBuDL1@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 06, 2023 at 07:35:35PM +1100, Dave Chinner wrote:
> Mixing overlapping buffered read with direct writes - especially partial block
> extending DIO writes - is a recipe for data corruption. It's not a
> matter of if, it's a matter of when.
> 
> Fundamentally, when you have overlapping write IO involving DIO, the
> result of the overlapping IOs is undefined. One cannot control
> submission order, the order that the overlapping IO hit the
> media, or completion ordering that might clear flags like unwritten
> extents. The only guarantee that we give in this case is that we
> won't expose stale data from the disk to the user read.

Btw, one thing we could do to kill these races forever is to track if
there are any buffered openers for an inode and just fall back to
buffered I/O for that case.  With that and and inode_dio_wait for
when opening for buffered I/O we'd avoid the races an various crazy
workarounds entirely.

nfs and ocfs2 do (or did, I haven't checked for a while) something
like that.


