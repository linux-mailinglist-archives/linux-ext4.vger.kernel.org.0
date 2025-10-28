Return-Path: <linux-ext4+bounces-11119-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9204DC173A2
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27116348E80
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49E36A5E7;
	Tue, 28 Oct 2025 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W30sudym"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F92369977
	for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691682; cv=none; b=mMY+pRAJo7ZaCPtuDGTEGDpxjSCzS8XSMZWzpa1mp190I+UUQRk2AIvhiFg18eLzAiM4hedf6DTWkjcrSvuyn/lkWMvTzzvnIJcFVjrwcUeTQuQFMBuHnNtxuBq/jTDCWTacrhOcm8Nf8PElwRfQsVKl6W0YY6KaMXpOIkoLcUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691682; c=relaxed/simple;
	bh=1/WE+xbvc6Dal5pEAP6nQ5I9Rm9+W8PbrmOyYOyQAU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vECH3NiuA5BNFgieWdUtGA3p7TTfzn9W7qdayIHiNpI61XsPgqLrOdskeD0c9HWrYBltGs2rIfqRfrRmFGHNId48jXUzLpOunN40EmT7q181Ub135CzDZkT/+mXIgO4iOR0t2ZPnzMVucI3t4n+eJR/1WncRKK7WDCiVNYiz3MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W30sudym; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290da96b37fso49475ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 Oct 2025 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761691680; x=1762296480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=W30sudymZZrp4ynjftUHozOz2HuSQFvA/SRpYciZNEHK9RVgbZgYBBZ8W1sK0FSLz3
         GOUTFmW2eBvBklT+YTI0bBWHn+t+3xdwwtZc7j7ORSbELnpUw+uq88Vi1ywFkF+0FrZo
         5WBb/LecWkBKHxMB///Xs+yY6b8a0zx0ORcbhLkaxXB0sao9IE1fnM/EFUwfWcfB8Uwd
         tqTtCTb/h77fdJ+X5DzOw/ZqpIz87V5aPE0ameONgc0T7bP6XxUI3KYVgIQ0IAvt7gv0
         Lt7GJBAtjtB8vI1nvrLUswp7Rm+ey1+6VmxdG+g1AICdR/8x18p5ixQpdcCRYZMlYkZ+
         vtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761691680; x=1762296480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDTzcXmi62N+bAdKsA9MM3K6VkUn2QF2TaFyCxaOopA=;
        b=SDfb/MRYD7MJyTOUXnv53TWH9qNRKWXMA05BiY++xAOSAJFgEsvtArpRokK/RTBTuR
         /txim+uVo/9b88zKrvNz01QbCPFUHDIT8p8tB6lDd4I13bipsnyUr5egebdXoLm6comw
         q8gQZaIAo82ilj9sGpwxWiwJSI9abB5h7E2SEsqpECu9/MdXEusd9s+Gw6qH0FACbwdC
         sqNEsgB43Jl2zENlq6jgw98auldzjgT5o/iVlj6phxU9rkUXN0EeNacmHrbmNXEliXQv
         f8rBA4/B/bRfy4KWjBUqzdKjF9DNhQYl3o91EjgGToLSM84NU4V0gFaqCnAoXM69m/4E
         wrpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcX+Od2U3uCDsZEIXQClATb5nCsOwDkkFBEp2J4LNIZquQAxeK0nTk4+sq48ntiny/QhX2r53NghhR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx95kydWDB9soeXI0Co0C/blRuIKns5/xR9I/jD606Sm/C8452t
	w8cZDP5Sg4BOTt3rnMfiaOrPKEWgQ6p2FHzESxKphRzRnOL4bV+2PKBsRpxg4/t9qQ==
X-Gm-Gg: ASbGncvFoCzU47/ei3hh8H3TZpeSn7/tznrTtjJ7twtpTagq1TiWlaiZSBjcXxNpIan
	rpCC0lIevmoEHBwyDFFxAERZAP+J1CKp9JTI+lEiKXPDo9GPLvOr09X1RFmCbR1LXiiurhMHZpI
	6Dyf/bmZCVGFhc/YiFxUCpxJ+r1tSMXRlvpiZFqYtFlwXtNMRL1QyRqXUx784Souqsr1AjtoowM
	DaxxGrdjBR5e28Zuu70r8pG1hlhlaDaH6VCIshDsZmjx4+95KjU6QxgXcsmTe6J5LQ6SM6x5EDb
	SBwaqbl0p7tn7+hVzgLLC540ObV9WWwrUvJbTP4/FBg6lkgf8r8uXypWqT77KcpctLXxdOFi6hm
	0kvBLP04OfJtjfDtDAp4eppDx04RzWqSrwrHAa6puFRehk7YaeXSDLu2UQ4GXeYYH0qc+nWGPVW
	pAgTjL0/OQ7w4HuCOSLR1znXJTFQZhKIzSJUOaNI7JscOByVk5oTkDzthkp86xUMIedli8mclNh
	EOPa3sMifOB5B3ySjonut2KswD7NW5IT5c=
X-Google-Smtp-Source: AGHT+IGVgm4/IjLLQT0cmQiv9nPeepYGw4HODw55Q9JYgkuJimkY420lDMBroEQm+to1DoESC9iCmA==
X-Received: by 2002:a17:902:f693:b0:291:6488:5af5 with SMTP id d9443c01a7336-294dffb2cecmr1077105ad.1.1761691679356;
        Tue, 28 Oct 2025 15:47:59 -0700 (PDT)
Received: from google.com (235.215.125.34.bc.googleusercontent.com. [34.125.215.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4287bsm131385965ad.80.2025.10.28.15.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 15:47:58 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:47:53 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCHv4 5/8] iomap: simplify direct io validity check
Message-ID: <aQFIGaA5M4kDrTlw@google.com>
References: <20250827141258.63501-1-kbusch@meta.com>
 <20250827141258.63501-6-kbusch@meta.com>
 <aP-c5gPjrpsn0vJA@google.com>
 <aP-hByAKuQ7ycNwM@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-hByAKuQ7ycNwM@kbusch-mbp>

On Mon, Oct 27, 2025 at 10:42:47AM -0600, Keith Busch wrote:
> On Mon, Oct 27, 2025 at 04:25:10PM +0000, Carlos Llamas wrote:
> > Hey Keith, I'be bisected an LTP issue down to this patch. There is a
> > O_DIRECT read test that expects EINVAL for a bad buffer alignment.
> > However, if I understand the patchset correctly, this is intentional
> > move which makes this LTP test obsolete, correct?
> > 
> > The broken test is "test 5" here:
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/read/read02.c
> > 
> > ... and this is what I get now:
> >   read02.c:87: TFAIL: read() failed unexpectedly, expected EINVAL: EIO (5)
> 
> Yes, the changes are intentional. Your test should still see the read
> fail since it looks like its attempting a byte aligned memory offset,
> and most storage controllers don't advertise support for byte aligned
> DMA. So the problem is that you got EIO instead of EINVAL? The block
> layer that finds your misaligned address should have still failed with
> EINVAL, but that check is deferred to pretty low in the stack rather
> than preemptively checked as before. The filesystem may return a generic
> EIO in that case, but not sure. What filesystem was this using?

Cc: Eric Biggers <ebiggers@google.com>

Ok, I did a bit more digging. I'm using f2fs but the problem in this
case is the blk_crypto layer. The OP_READ request goes through
submit_bio() which then calls blk_crypto_bio_prep() and if the bio has
crypto context then it checks for bio_crypt_check_alignment().

This is where the LTP tests fails the alignment. However, the propagated
error goes through "bio->bi_status = BLK_STS_IOERR" which in bio_endio()
get translates to EIO due to blk_status_to_errno().

I've verified this restores the original behavior matching the LTP test,
so I'll write up a patch and send it a bit later.

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 1336cbf5e3bd..a417843e7e4a 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -293,7 +293,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 

