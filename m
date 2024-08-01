Return-Path: <linux-ext4+bounces-3589-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F549440E6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1D42836FB
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264445030;
	Thu,  1 Aug 2024 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pVCgTy2n"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41C11EB4A9
	for <linux-ext4@vger.kernel.org>; Thu,  1 Aug 2024 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477224; cv=none; b=p42QYDyS26N8z7FUAwGeuOQtV0XsMSzPfCC5Y8h+ypkwh3sxxsW/wvg86NfqA8reEN8gV209PBRyA/1QgdQQOPriIL/h7Jvl68dWCZ74X/xJ6VlQn6IgIjgY3son/oZzPvGq6ixwRDuzFQ6gcOC0JkcE6QsQvl/PBqcNiz6pEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477224; c=relaxed/simple;
	bh=y0J1KWvQUR0aocLIOF2pPQMWyW3yeN9LyqVOMNdzmcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5RGR5feGgsas9rTyAbxrKgeMIpOD/XYyWR1Vh5O5FGxDkG96CLoSHuUXDVGZqRmPxBQdHOUPDPtUtzZJ+Kpzs0oA4i0SZSMzsthDLs5+5FWqrEKBsy4WNsZDad3+LRmJkqv4gPiH7XPmSozDneckL/RjZCP+6zGienTzf852y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pVCgTy2n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc611a0f8cso46674925ad.2
        for <linux-ext4@vger.kernel.org>; Wed, 31 Jul 2024 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1722477222; x=1723082022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uLmOVmu2fXsynV0AqtSvW9BETIpLkLkWNmHFlIbYIr4=;
        b=pVCgTy2nQVOB7luo7bcv/vTx8Wy5X/skOb28qyjeNeN9wgdNjGx9FAN8bdCVLr7124
         e0nkmbklEFw0RR0p2qMkdHauY2acOmKrhiUSeLGllHTSWXQ98ziBtHsHApVI16B1o7Kr
         0usrAFs3bEHcehLxflbbGbRlBFR92xeQUUYkFYnnKJIVf3R4W+1rgjzot/FJs3fcPKlh
         2BZ+KkDOguV3J0PUVs4pP9Y5DC/6L1jYAfNqt8hCJ6hsw1yxnXtnXMz8AfPdr9Ym+Cpk
         PoXCx7K71i7hzF9S8sCyHACEfpOsF09kjTGvKMgRW5hpCzI+pDU//erbEhYPrOpRbmzr
         0/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722477222; x=1723082022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLmOVmu2fXsynV0AqtSvW9BETIpLkLkWNmHFlIbYIr4=;
        b=MbofENbMSBykXGfhYvdk4exzUvh/VlusH5B3HLNCfZoqR8bbYosww3e082YMjXxCv9
         Q9kN2Sm4YadfpPamzbfB+x4NYGjFVHctx19gkWpW9rVp4EQb7dLNhu00S/LAXTp4xhGG
         QFQOZyLCcLK4ATW1A70y5RZB5ioIJ/vN/4QjfvsaGscil63nYjFlXMMrhgt+SzQgnkKG
         tzHQolInuy89+LZQUySJJEiY6ppMozAteGvjRGSuRpjZy4mHwPX47tq6ZH5Dm/wyo5E3
         v1UNaUUJ3+WhM7yJlKKpC9X1sArWrRBnTal9sfjfRxqxKQflMZNBKdbpKNj5dvvTadDt
         jk6g==
X-Gm-Message-State: AOJu0YwxBBzAuveVu4d9aMdz12PFwhevqUEOR8U8C7QUMPPzZW3MOCsI
	B2hm/sRQVfjY0GNsBxRsZ8OZz6vp2Q/J7y9R84kKJHMWhkxoz9HDJMc3i1wRHoCHOQiitg704Q3
	O
X-Google-Smtp-Source: AGHT+IEq4xnmzu9K7n12mxaWA9qzQSfvpRqdDTuHMyO/4MaFS9Y5Gt9SISBWF9tECiZdKT4/BW0D6w==
X-Received: by 2002:a17:902:7c06:b0:1fd:a0ec:2f4c with SMTP id d9443c01a7336-1ff4cea877dmr11144205ad.33.1722477221999;
        Wed, 31 Jul 2024 18:53:41 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4d16sm126773075ad.146.2024.07.31.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:53:41 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sZL0d-000xWb-0g;
	Thu, 01 Aug 2024 11:53:39 +1000
Date: Thu, 1 Aug 2024 11:53:39 +1000
From: Dave Chinner <david@fromorbit.com>
To: Johannes Bauer <canjzymsaxyt@spornkuller.de>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Modification of block device by R/O mount
Message-ID: <Zqrqo1lIrsxdm7AP@dread.disaster.area>
References: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>

On Wed, Jul 31, 2024 at 01:16:26PM +0200, Johannes Bauer wrote:
> Is this expected behavior?

Yes. A read-only mount doesn't mean the filesystem cannot write to
the block device. All it means is that users cannot make
modifications to the filesystem contents once the filesystem is
mounted.

The filesystem may still have to do things like journal recovery on
a read-only mount which requires writing to the block device, or
maybe other house-keeping things that happen at mount time which
require writing updates to the superblock or other metadata.

This is not ext4 specific. XFS behaves the same way on read-only
mounts and, IIRC, JFS, Reiser and most other journalling filesystems
will also behave the same way.

> Is there a way to mitigate it?

If you want to stop the filesystem writing to the block device, you
have to set the -block device- to be read only. At this point, the
filesystem will refuse to mount if it needs to write to the block
device during mount.

Hence you may need to use "-ro,norecovery" on journalled filesystems
when the block device is read only to get them to mount. However,
this can expose inconsistent metadata to userspace and weird stuff
can happen because the journal will not have been recovered...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

