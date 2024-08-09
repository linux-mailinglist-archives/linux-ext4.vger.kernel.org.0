Return-Path: <linux-ext4+bounces-3676-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54494C846
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 03:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405CD1C22BC2
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2024 01:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE22D515;
	Fri,  9 Aug 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kN+kOpx5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2878C8C7
	for <linux-ext4@vger.kernel.org>; Fri,  9 Aug 2024 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168236; cv=none; b=fSAhr+mgndlu86P54dWiZgJKZqRjhRxfcKlGlMVjQ2db0S7GEYGMnhiEsMSc5q42F086VkjoLt+9WXjUB84CKc2qiRdd8F4KGm8LmmKc6k1CaD06MrUlU9IvCqRzhgPdw5TevJtj3yo1uRq5zm/I3Uj6vuAiG/WJqWohWln262o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168236; c=relaxed/simple;
	bh=joGCoSxzSjZ1MjUscEs9LhTFMMuebICMRZx+2aKHjBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxYTc89Qpr7eIBUBIUPUKL44iJuZjMacpjGppPoeFxlGvP7Vhb1ulCXYDwHZmvIWNcjeJh2l4QrV1l1Hppe1W1lxIdnbZDU1LPlkvUBrL24iBgQcs6PUfogyOgS5dRbuNa8mcxrNJFiisGjLBvel/GvSHkm2JaABMJC/0LRb8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kN+kOpx5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so1276101a91.0
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2024 18:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1723168234; x=1723773034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHPkgooowMRi94dfUdVo6Bw8yuzTOQFjC3nKJRfZkzU=;
        b=kN+kOpx5CX7Omcl9rWjgecRafTc59An3q+GZpjs4UHsPSuTnHHjxwIRPOn3v4z4KkC
         +dA4Os0tLIU1QUUwVVztm8T/3hj31QhQhzDvqpHWMfSrxNUC+hJcIdPpBkE2x2xn7O4F
         9NT2J0zvSVOxeUJbu5/WcV1wzai5bS5AOEzUFfla9KMc3R2qlwwrb+ynwDrc+GnF38Rw
         g7rhfb+N9e3WPqTi7C+gQYR5S+EKR92vODNY/Up19rAGa2r9aZYej7mn9bfsr6rOJmlC
         s4N44ZC1rZisafyQiD4zsE6GcIYL/mJ5kLAxp32aaqgZp2j+7hTReYvFWtLSsbLQ4itA
         xSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168234; x=1723773034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHPkgooowMRi94dfUdVo6Bw8yuzTOQFjC3nKJRfZkzU=;
        b=aWjR6Da9tDEw2gomrrgC5CkygtxtESIeTdByC769XsDo9Syj27ShYt2aeJEe4tDlKB
         +ebZaWCrEQa5+5ACqSn710fbB9Z/BAyCD60hrzfYnJ2CdodH15IIqilnYcFpqyIPaxKy
         F2Vy1iGh2dmfXS5X3vAv1apD5WfDA08A3e6R690OXIDHZrW+kJrnN2p8j0k5NO+mtlG5
         DkC4LnahgqmznNq8cCAbygAzph91pDYpCX8xwC918gyvQ8+xLKvDNzCr9HMI+SjJzRUx
         UtPdXyWMECgRg7cT0KbN9WsAsa2xnCBm4DzooJdqJqhLbOo3cAqTMRnRCFROyKNVHgYA
         +4sA==
X-Gm-Message-State: AOJu0YzZKax3vR5yCLjTvvYARlwyxtPCjc1HabmDPaETE7jdpUw6g7Za
	EPsJNTWWN2vE4PbDrXYFArmDc5j+XqnIWg1ZKSiYYc0lhvft2CceZBCQdAhY7Qo=
X-Google-Smtp-Source: AGHT+IFyvRFi8uE3temgWWuPNItBvqEvrJirHgHJEA6k2kzQkz8HZ4GZLC4u+lt9i0qxaBKRxo1Kdw==
X-Received: by 2002:a17:90a:7346:b0:2c9:a56b:8db6 with SMTP id 98e67ed59e1d1-2d1c3472430mr4339933a91.37.1723168233873;
        Thu, 08 Aug 2024 18:50:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9c5dbaesm1824878a91.10.2024.08.08.18.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 18:50:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1scEly-00ANZH-2l;
	Fri, 09 Aug 2024 11:50:30 +1000
Date: Fri, 9 Aug 2024 11:50:30 +1000
From: Dave Chinner <david@fromorbit.com>
To: Johannes Bauer <canjzymsaxyt@spornkuller.de>
Cc: linux-ext4@vger.kernel.org
Subject: Re: Modification of block device by R/O mount
Message-ID: <ZrV15hAK0Lawyl+8@dread.disaster.area>
References: <39c23608-8e20-40ad-84a3-4d4c0f9468c0@spornkuller.de>
 <Zqrqo1lIrsxdm7AP@dread.disaster.area>
 <bdf2626f-580a-4af2-9fb0-5e3ebe944f95@spornkuller.de>
 <1cd11635-4015-43e6-8c8c-db5e2f029536@spornkuller.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cd11635-4015-43e6-8c8c-db5e2f029536@spornkuller.de>

On Thu, Aug 01, 2024 at 08:32:18AM +0200, Johannes Bauer wrote:
> Am 01.08.24 um 08:18 schrieb Johannes Bauer:
> 
> > But my point is, that is what I am doing -- creating the losetup mapping
> > R/O:
> > 
> > # losetup --read-only --show -f image.img
> > /dev/loop35
> > 
> > # echo foo >/dev/loop35
> > bash: echo: write error: Operation not permitted

Oh, I missed that critical detail buried in the example code.  Most
people who report "writes occuring on RO mounts" have no clue that
writes are actually allowed on RO mounts, and you made no mention
that you were also setting the block device read only and that's why
you were expecting writes to fail....

As it is, I don't think the filesystem is actually writing anything
to disk. There's a couple of individual metadata fields that have
been changed in the block device page cache in some metadata at
offset 0x8000:

$ diff -u img.t bdev.t
--- img.t	2024-08-09 11:41:20.358217508 +1000
+++ bdev.t	2024-08-09 11:41:29.966289011 +1000
@@ -103,10 +103,11 @@
 007ff0 0000 0000 0000 0000 000c de00 0eb9 b0b0
 008000 3bc0 9839 0000 0400 0000 0000 0000 0004
 008010 0000 0004 0000 0100 0000 0100 0000 0000
-008020 0000 0000 0000 0000 0000 0000 0000 0000
+008020 0000 0000 0000 0000 0000 1200 0000 0000
 008030 9f03 d923 77f8 9748 64af 1176 1b28 9959
 008040 0000 0100 0000 0000 0000 0000 0000 0000
-008050 0000 0000 0000 0000 0000 0000 0000 0000
+008050 0004 0000 0000 0000 0000 0000 0000 0000
+008060 0000 0000 0000 0000 0000 0000 0000 0000
 *
 008800 0fff 0000 0000 0000 0000 0000 0000 0000
 008810 0000 0000 0000 0000 0000 0000 0000 0000

This does not mean a write was done, however. The filesystem may
have changed metadata directly in the page cache so that it is
correct for a RO mount on a RO block device without actually writing
anything to disk. There's nothing wrong with doing this - it isn't a
bug at all even though such modifications will be visible to
userspace via block device page cache reads.

You'll need someone who actually knows what metadata ext4 needs to
modify directly on read-only mounts to tell you exactly what the
mount is modifying and whether or not it should actually be doing
that or not. However, I personally wouldn't consider this behaviour
a bug if it necessary to allow read-only mounts on read-only block
devices to work reliably...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

