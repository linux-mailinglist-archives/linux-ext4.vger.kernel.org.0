Return-Path: <linux-ext4+bounces-11732-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D82C4863C
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA618879C3
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 17:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29542DCBE6;
	Mon, 10 Nov 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="BuSh24v7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4D2DC76A
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796500; cv=none; b=ZI1Wwbimtf9i3QWV62NnmtKkLl99kkSjIBHLTSlVG90gHyayXiVdPeKHrKqGAGAA9IYI0TrRwNc4Qm3gLr6083QimFJ7YKU9VACKaxDn9vbjskNw3OwDHpAj8XGIpZ7SgIu6AXM6jVsxbNQ8O4T9LJKxVqex44paFqqbKX2l2Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796500; c=relaxed/simple;
	bh=XhCKUCy23CuX+6pfArVHtFf6irpSlx/Gp3WJKNoHLV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGsSK0oZie6ej5MkA8YkaQkKdBzdTrLFOJvTwkNvca6RRIM89U9gMx7B6llKf4/PaN7hMuhFs1TMjAjRFlmjNrcBenux50kgEZmH3J+iuICECKWCZ0bMrDdETZCR4o2XXBs9SUltYUlvdixUIms/P9zOlI8+2dnYbc5DQCHORwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=BuSh24v7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AAHeXSF025124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 12:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762796438; bh=yI+di0AizPVgtIWeC5MbrX09XfkEfG1CLfLslP8R+mI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=BuSh24v7eWzJ3FwhfiwMA0emBmjnT0LTs+vi+bhyHRT3hkzdiWae8Hjk8lLKWJyYO
	 XXgCuWj0kQBkQPGHwspWoaXP5KOycgNhUdvVX3tJ5v029Lm+P+tCT7EozVFVmj3pnw
	 uXHZoEQMgAljxAUG/PifnBk/mEj8Ex3Fqnxv2l4hJXW7eXTm84HEejHD9G0vWZLwbo
	 366tQlPwjjvpA5fkXRgs/2Z3uAT2gLjNDqfV2HvNAlux26ReVQj065fFmapbfSaDPW
	 D8EJ29UdFQf6RCc+Qf8WtFWcw6lSmBEsS/MPat2NSYpk1PkiLxGRUzcbvKWifzQWs/
	 BGSisPIv0c2Lw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 818632E00D9; Mon, 10 Nov 2025 12:40:33 -0500 (EST)
Date: Mon, 10 Nov 2025 12:40:33 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 00/24] ext4: enable block size larger than page size
Message-ID: <20251110174033.GG2988753@mit.edu>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251110043226.GD2988753@mit.edu>
 <4bbea425-e896-4047-b30d-6598ff7e9165@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bbea425-e896-4047-b30d-6598ff7e9165@pankajraghav.com>

On Mon, Nov 10, 2025 at 04:34:47PM +0100, Pankaj Raghav wrote:
> 
> I added something similar for block devices[1]. Probably we might need something
> here as well as a stop gap.
>
> [1] https://lore.kernel.org/all/20250704092134.289491-1-p.raghav@samsung.com/

Yeah, this is the precisely code that I ran into; it's good that we're
not triggering a panic if we try mounting a file system with a large
block size, but when trying to mount file system with a large
blocksize w/o CONFIG_TRANSPARENT_HUGEPAGE, we get:

[   33.211382] XFS (vdc): block size (65536 bytes) not supported; Only block size (4096) or less is supported
mount: /vdc: fsconfig() failed: Function not implemented.
       dmesg(1) may have more information after failed mount system call.

or

[   78.537420] EXT4-fs (vdc): bad block size 65536

Pity the poor user who is trying to use large block sizes, and who
didn't bother to enabl transparent hugepages because they didn't need
it.  Fortunately most distributions tend to enable THP.

> Funny that you mention this because I have talk about this topic:
> Decoupling Large Folios from Transparent Huge Pages in LPC under MM MC [2].
> You are more than welcome to come to the talk :)

Cool!  So if we're going to change it, perhaps we should have an
explicit CONFIG option, say, CONFIG_FS_LARGE_BLOCKSIZE which enables
bs > ps.  This might allow us to remove smount of code for those
embedded applications who don't need large block sizes, but more
importantly, we can have it automatically enable whatever depedencies
that are needed --- and if it changes later, we can have the kernel
config DTRT automatically.

						- Ted

