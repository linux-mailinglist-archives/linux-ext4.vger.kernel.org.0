Return-Path: <linux-ext4+bounces-6102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7127A11753
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 03:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61BE168BB6
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2025 02:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DAF146A6C;
	Wed, 15 Jan 2025 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/3UFEJf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DD232441;
	Wed, 15 Jan 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908480; cv=none; b=Z/tqL+WnzYzqua+tfV+Bt+sKxAUhBXePl4skkKnrvI7pSYZzLHyvD8a8t6X/ChtkJfNG451uPm2R7J6+xHFniQM7uIuEoAuzAwjPGycYKMZZ1N4GNEWf4hNX9pbklVGMqPLz1JiDqHSbfzAnhUW1QIj7FiEefQGPmtl8plVaHhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908480; c=relaxed/simple;
	bh=z13eQARB2sOm7pkWeVhFE+VabWak+ldT78yGXY6mPCs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SD2T/fj4tyEzMMpvOHjFtTuQTZMCUV+pnEZIsSCOBP3GXHo57ZAA+OncQ/Os+tzSQp+5soJiJvoMcDGstEGiGp5iY79oAgvjENIBSqmq5oayP7SZoMf+tA2KxhzqmQBfXHNV4FWkH8BXEYQPCVQ2DmaLygoJFoyAi/ylQwTckDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/3UFEJf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso75456966b.1;
        Tue, 14 Jan 2025 18:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908477; x=1737513277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z13eQARB2sOm7pkWeVhFE+VabWak+ldT78yGXY6mPCs=;
        b=N/3UFEJfgA8J2727qJR/XXLUIVhzWupsVaQ0hVkbTQ+2YVlME+3vcykucYOlSxD0FL
         APM0FKS1mm2xBNmh3A4DVjih0Pr34YfGZ2WxA7yQXa7mZ/Q+SySex7kyPyKMT/9Lrqs8
         +ABGpULAZRIilYczFoO2IUrG8amIqY/qca8cC+B9mdjEcGS/vBz15INI5HqlQY2rU4yH
         ZsGHt/m70HNQYNBXNmiS4SG/GudrqM3hLy2HmUY3TerE6/PKozxkyfdM+KqQkQ5wc+Zf
         0gfJMs09JpPnEyOQJfrCPQB+tk1S4uH9Znf0hAmARmL3dQuyj4lUgaBAcI1NSwJZdLX9
         606Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908477; x=1737513277;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z13eQARB2sOm7pkWeVhFE+VabWak+ldT78yGXY6mPCs=;
        b=dbKlJdnQt/WlGxLEkg1EzZeGzO8jzAv6Ygdpjhnu1v+ucDJK+vUMY/mdpwvInP4vzx
         fNIAf5eG+swX8wEne5uXBw+aMtI4uvU1cioajQ6BUwg7jMiDsUPt/5UUrweAeHATcsOS
         6sv3BEZhUT+FsZ4eiFs14UQ8jwBiT7rCHKJe2QDmMyrbVacyF5vMrPItWjP7gZHHC0lT
         Z7HY8zsETAwcdbiZuWsHZ4nVWRTmpez+qMt6jUpe0adfE0AC48WQqj6r002L9ZC+hXMn
         IUdTkouzBCDWqOtv3pB53XgBS1DQpnDqHGiJ92ypzxrjx5H5bBRsKAebIHJFuLvuKCft
         5+xA==
X-Forwarded-Encrypted: i=1; AJvYcCU8MN0/cTb6u2mFgG026Kro9sbtI7PKyCm3zg+ipJDNnfChSl5oW5UmajId7qrw1BmkI2ze9S03yOOOXno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbyP/EA5VC1Y44kR0l1IORVscgfdW5DyftXha59c+MNxt16b2
	fFn174Cbb8B+YLvQ2A6VahJJIbdHpD9VC6YBposf92UTASIv0XTn8Cx8EArzC52OHa6mteDZ3rS
	FrzYS1OLi6ysDEIzN0vR5gbOhMZQ=
X-Gm-Gg: ASbGncvqcyxKaxfUP73yimCMNl6m7PXA5IqtnOi6pGnJuT+dMrZezU2T+zMpyPl/tLC
	4Io3LeqCi9O95846VKYBRERPav8wRhJsmM8f18d0=
X-Google-Smtp-Source: AGHT+IF+hDO+sOrWjO6/v35RF2juzC7jSUxsdOxxqnZp0fe0fDbc40BiukrerWUGMyfE685XPETMK1NfpdlqMhJEDVw=
X-Received: by 2002:a17:907:7252:b0:aae:e52f:3d2b with SMTP id
 a640c23a62f3a-ab2c3d1927fmr1585436666b.28.1736908477135; Tue, 14 Jan 2025
 18:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 15 Jan 2025 10:34:24 +0800
X-Gm-Features: AbW1kvZj-trl3hl3b6jH4cfSbCBQn590PL_EbQANUpnutjZIWO0dF9osOTahHCs
Message-ID: <CAKHoSAsxwS1J2fme+6-d84tguJGDYamVCHfcuXZbeGpTGHze0A@mail.gmail.com>
Subject: "WARNING in ext4_destroy_inode" in Linux Kernel v6.12-rc4
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version v6.12-rc4. This vulnerability was discovered
while i was testing the kernel.

Linux Kernel Repository Git Commit:
42f7652d3eb527d03665b09edac47f85fb600924 (tag: v6.12-rc4)

Bug Location: 0010:ext4_destroy_inode+0x1d0/0x270 fs/ext4/super.c:1465

Bug report: https://pastebin.com/YKFyLm5P

Entire Log: https://pastebin.com/fE1tFAUS

Thank you for your time and attention.

Best regards

Wall

