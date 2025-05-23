Return-Path: <linux-ext4+bounces-8176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0EEAC1E66
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284311BA33EB
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 08:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244728751B;
	Fri, 23 May 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxxy7rh5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075420C482;
	Fri, 23 May 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747987928; cv=none; b=K9rDeFMoxvLVTXIIivkoLqzLLv53IeiUJf+hBzo4bs+Xrg4kLV13hT8q4x41KeoHBgY+1fRIvLcCRk0DKbMcQk36m8L0mDmOq7SgXZoIEci8YgF8majbcJC/9fGRlvcZ27zS6Xp0C2ekFoCM1QjOaxRL6igo6+KeaFNV41ct4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747987928; c=relaxed/simple;
	bh=+TDhoikyMIzmEsOgdHd9FVrqZYGX201X7Z53Q9q6+I0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SPFERqH35maa8SPPIRL2E0NQnaYpYnchRqYscMXm2795T1nkszARTk3XHZu2doESnvFUfHUPGgPDLhaxJBozI4apkBagXMu55xN1t4rbwhMRHQOrF+fs83ldmuzr6j4BAvp3IZ3x7KCF8+UaFz6i5UQO24tRF12yr461Ou+sPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxxy7rh5; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-52dc131419cso2047494e0c.2;
        Fri, 23 May 2025 01:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747987925; x=1748592725; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+TDhoikyMIzmEsOgdHd9FVrqZYGX201X7Z53Q9q6+I0=;
        b=hxxy7rh5fFGYYcjM5veatCSAIgl6Yq0YLc7nOVEHZKjqhZwIJyeAh8H00gP3B/+IIP
         IWKM6EKxh+vWck3naXE/3vvjbkBdEK2mv9SYjiuwRJkpyevgpVOmeJ9orrXbL7Z31FNA
         +GlYqwCMC7vyXUSR1jOuGaCUvPESDdKCWgSTZtPguD3selqbKIPJkn3P+Zpzh6Z4YgSf
         7Vo/C0gLjLHAusDBfvJFpUPGOBqNMKCOKN8Z0KpM1LP7tyAk9n6pyEYwV0cHzZqtMdHL
         yJ5iw71u0KjVn7GUYCDFKoC9jF+loC9zO1M8ieo6bcpJgsBmhCdvJ+RFdcRQloONigJC
         RJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747987925; x=1748592725;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TDhoikyMIzmEsOgdHd9FVrqZYGX201X7Z53Q9q6+I0=;
        b=iYW/W6ILAerhF16R9rqtM/q8DeafbHlohXYnP4DmvbcPUC2mQhUbu5w8r5r58GcZ1E
         JbirghnmXnMIP4Ntu2uvsvHdTFR8C6SCTZPBai7YzCXjcDph6yVV75yVIIJfMd90Ikq+
         sBB5L+JgtA905wM7azMfN6UabkZ8bUgH9A0Zh+kHqdmtY2TgBeg2ZxAlS06MbC+UEdqi
         i+/6wWE3z5TV64YyuJ1lav7wj2HnOrJjhWDYFK5JD0PCiQHRTvssyNq2V4tG0Q6VqT/9
         WoCgzZ9EPB+mVhIk3pyUuVfMsptyUuNKaxLCCycjvOhQMcICPvGqERh93VzPCACjooA7
         1s8g==
X-Forwarded-Encrypted: i=1; AJvYcCW0l2jvr7gzD04jvCcrF0l5rvRMFDu51rQv6oKhp+09dM8X2QmC7Pap0ihCG/MrL02G+MAIILhkejamRNoN@vger.kernel.org, AJvYcCW6eLpEmNHc+UkQ9czQ0fgD2eCIa0DZhvMeYi++U9zXUMMLw2b08hH1KP8z8dPXLgVo/OwnBg47npuz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Q3KIe8hV5PV/5in2svsLZo0UhHx+YhgmEt/eiw37AvEhaxmb
	3R5rawOA/cT7mOPSyafCW33XDbFHjjyVDZFYHEbn7EQfV7/FfE15tk+F8n3Woti4NkUUxKbR9c1
	NMtPWsPcrHcEkS6NShVY9EH3XKUIO4mvj7kdM
X-Gm-Gg: ASbGncsz6GPxChuNmqHI88D4f1C5wG49wbeUxmjIouDST4GtXmCj4IzmQ0jJ2I36ocC
	tL48JO0poMlIB0m5MNp+sTLo7iNYqaaExnbi/1pHHzRF2aB2VV8vQS8+wE+hMY4OE/bFmU4AzL+
	ddEy8/NMCWsdCLwByuJAv9HfWvw/SNyvW5sw==
X-Google-Smtp-Source: AGHT+IHeC+WH5oaa1bydeoZxnMwXnoppTQct5XbOcd+9ZdMreh4NTLcst9yDwsInfTNHI8dMCKV+xWG4GROCik1hZGs=
X-Received: by 2002:a05:6122:ec9:b0:52a:c0db:29e3 with SMTP id
 71dfb90a1353d-52dbce1e5a3mr21773108e0c.10.1747987924729; Fri, 23 May 2025
 01:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Fri, 23 May 2025 16:11:53 +0800
X-Gm-Features: AX0GCFs4P0QyWh7o-IpM0QozTogBYkENxUA3Fz5fk7j9rV2GGl50AAblpywsG-0
Message-ID: <CAOU40uBdtsGgG9mi1sZvLSa9rdh_SVAeQkv6B5gjMubcmTDgTQ@mail.gmail.com>
Subject: [BUG] kernel BUG in mb_mark_used
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel crash described as "kernel BUG in mb_mark_used",
which is triggered by a BUG_ON() in the ext4 function
mb_mark_used()(fs/ext4/mballoc.c:2051). The crash occurs when the
expression start + len > (e4b->bd_sb->s_blocksize << 3) evaluates
true, indicating that the block range to be marked as used exceeds the
size of the bitmap. This suggests that an invalid or corrupted block
extent was passed to the allocator, potentially due to inconsistent
internal state or a logic flaw in the extent calculation.

The call trace shows the crash is triggered via a direct I/O write
operation (ext4_dio_write_iter), which ultimately invokes
ext4_mb_new_blocks() and its subroutine mb_mark_used(). The crash is
reproducible using a crafted workload involving mounting an ext4
loopback device and issuing writes.

This may indicate a latent inconsistency in ext4's multiblock
allocation logic (mballoc.c), especially under specific block size or
extent configurations. Further investigation is recommended in the
validation of input to mb_mark_used() and in protecting against block
range overflows.

This can be reproduced on:

HEAD commit:

commit e8f897f4afef0031fe618a8e94127a0934896aba

report: https://pastebin.com/raw/EHJyW2Ev

console output : https://pastebin.com/raw/vKPznSCn

kernel config : https://pastebin.com/raw/aJ9rUnhG

C reproducer : https://pastebin.com/raw/rZ5xcbt5

Best regards,

Xianying

