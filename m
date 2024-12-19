Return-Path: <linux-ext4+bounces-5774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F199F7E30
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 16:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB237A340F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FF22579F;
	Thu, 19 Dec 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eC1zI5hl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A962315252D
	for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622658; cv=none; b=rerFpmCDzkkCbn9yiSZ6YvpMOfG3qpsXu17rsqqVtRgX0U3ovXje0x3GKMbrGOnOftSWgcsWsL9Rs3z/+RWyVANsL3UXEMP6hbDgGBsbf/1jv+ac1L58iNS+pS34Rznt3pTFCKnk1qMBiZ9TKQQOpxekiDCh4OoVpcpEoWv1YRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622658; c=relaxed/simple;
	bh=p4HdxpZ+MrdAxtJhCL+kaFnR1t6S75QHdOZVDGbndeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoUM90VikbUp6RXL2kdkpg5aZSe2Gf0uvMGeF0fGfD/tHWIgOIIAn7PXKirlVFax1/rz1BBaB5F/AHJ02fmOQGieN8mW+M1HXYVh1WocR8fAbnDYVQoG0PqHA9b+cMfsGenw3UV3wjMpbRafRNBZFmrqrAocjED+tGZBzql7IOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eC1zI5hl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso169477866b.1
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734622655; x=1735227455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PUel+go/CfHo5w+Jm9alc/L9kT7jqDV+xMlQDoVR8Gw=;
        b=eC1zI5hl8N7f8gBIN849Su5gDx2YdN18PVRcfee9dae6ZLon8L01Xnt7KOLePqepdG
         N1KmsNnCYHJlUc+XvlQTNxMdwNscCGMViBrnhvgLdGCQIs7qBUXwmRO0fkr5iqpfoYcO
         WkqsqTlKIGnOA4hYtucLVDDF2+zEqUlrCdLDohsiSO3uesSfE95bJi6Bz3ETIlYzJyLP
         YfJDrfyUWC9t0mVQ7zZF2ZQBOfDSkMppsyhjY7yQHzUWn+3eZmh7yaD9m7lmD4dAEFg0
         taMy+Xe4N6Y1DZZhzMuLoPlJla12TiSuRoJww6PBKJjbU5e5JmUVKBFC0MbW5HE81Gr4
         nagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622655; x=1735227455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUel+go/CfHo5w+Jm9alc/L9kT7jqDV+xMlQDoVR8Gw=;
        b=At0W0dFaKC3gHeiXItmfOYbmme/MCgh7Mof3Uouk8pS/higR4A/sAcHZhE/Wf9+xd9
         TLBtH9wWZuC/z56BynaM0Levxykfqg0yGIVjMC0V76BALNoiKYz9IZZdCodWh88hidT0
         oK8o3x/40CDj9pBHmey+kwv5N0twsl/UDad1x2MzrEBqKbWpgQim0YI2m0NoXACdSzPO
         4q3dIVGplTcP+AxSTA19U7i2vPNWvYjYIuUr5lK6Pd1g9ojcPUt3UGwZZn6CWK8ln7/D
         X7b1i4/4yXyn8SrbQqTOE0ZMKv2inuMm9n7ds3N4nlVUfMHGTZGJZzcZURftwiTlBVqi
         Dk2A==
X-Forwarded-Encrypted: i=1; AJvYcCVUWlfTP5gpGgqY4oXBa3HCzB1eNz95VUV6LINpTJW3aJfyNAlke4cYmfG9R9HpHufwXnHjba3ZldYX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8stGvF90dLQzHg5+4nz62pU67/susztOpQigPWTEVNbUW0wvQ
	9GD2GQDBqDlYthGbVHCS3tdROmE2DVgsI3nB0HLMjmlHZcjA6X9fvgM+zcomQi4=
X-Gm-Gg: ASbGnctnOg8/aufZWgjC0Izj0CrCtOOisVGJ2aVMls689dba3kY8wqoG+GldzEhmTPT
	YsVGYoeSL9LN4Pw5gufzAArjsI2JbDlO+ngCvmTjRxPc8ko6huvfVblHtDurMZLEN71lI9Cpibq
	c/yuUOSM7LnESnNb7yMA1/Sf1U/txs0mnc+5VDxJpaVmJ7cZ0dhNlTFOwF+FRSlsYZcREh/bd0n
	op6179hyv8kcBjjpeIzmx6/nZdzNn6QM3/Yfrcy+aPM/25hrqBT3l3JsMrqjQ==
X-Google-Smtp-Source: AGHT+IGOfjBlXmb85ooSC48O2PP6uDSwvgb94XqQqZFbgj/syi0wA374X0g0G+01L7MUNMWSd0nROw==
X-Received: by 2002:a17:906:328a:b0:aa6:800a:1291 with SMTP id a640c23a62f3a-aabf470a0b4mr637938366b.7.1734622655089;
        Thu, 19 Dec 2024 07:37:35 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm76965466b.91.2024.12.19.07.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:37:34 -0800 (PST)
Date: Thu, 19 Dec 2024 18:37:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: qemu-arm64: CONFIG_ARM64_64K_PAGES=y kernel crash on qemu-arm64
 with Linux next-20241210 and above
Message-ID: <0c46224b-ed2b-4c8e-aa96-d8f657f59b9f@stanley.mountain>
References: <CA+G9fYvf0YQw4EY4gsHdQ1gCtSgQLPYo8RGnkbo=_XnAe7ORhw@mail.gmail.com>
 <CA+G9fYv7_fMKOxA8DB8aUnsDjQ9TX8OQtHVRcRQkFGqdD0vjNQ@mail.gmail.com>
 <ac1e1168-d3af-43c5-9df7-4ef5a1dbd698@gmx.com>
 <feecfdc2-4df6-47cf-8f96-5044858dc881@gmx.com>
 <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3406049-7ab5-45b9-80bf-46f73ef73a4f@stanley.mountain>

On Thu, Dec 19, 2024 at 06:10:56PM +0300, Dan Carpenter wrote:
> > > Mind to test it with KASAN enabled?
> > 
> 
> Anders is going to try that later and report back.
> 

Anders ran it and emailed me.  I was going to tell him to respond to
the thread but I decided to steal the credit.  #GreatArtists

 BTRFS info (device loop0): using crc32c (crc32c-arm64) checksum algorithm
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in __bitmap_set+0xf8/0x100
 Read of size 8 at addr fff0000020e4a3c8 by task chdir01/479
 
 CPU: 1 UID: 0 PID: 479 Comm: chdir01 Not tainted 6.13.0-rc3-next-20241218 #1
 Hardware name: linux,dummy-virt (DT)
 Call trace:
  show_stack+0x20/0x38 (C)
  dump_stack_lvl+0x8c/0xd0
  print_report+0x118/0x5e0
  kasan_report+0xb4/0x100
  __asan_report_load8_noabort+0x20/0x30
  __bitmap_set+0xf8/0x100
  btrfs_subpage_set_uptodate+0xd8/0x1d0 [btrfs]
  set_extent_buffer_uptodate+0x1ac/0x288 [btrfs]
  __alloc_dummy_extent_buffer+0x2cc/0x488 [btrfs]
  alloc_dummy_extent_buffer+0x4c/0x78 [btrfs]
  btrfs_check_system_chunk_array+0x30/0x308 [btrfs]
  btrfs_validate_super+0x7e8/0xd40 [btrfs]
  open_ctree+0x958/0x3c98 [btrfs]
  btrfs_get_tree+0xce4/0x13d8 [btrfs]
  vfs_get_tree+0x7c/0x290
  fc_mount+0x20/0xa8
  btrfs_get_tree+0x72c/0x13d8 [btrfs]
  vfs_get_tree+0x7c/0x290
  path_mount+0x748/0x1518
  __arm64_sys_mount+0x234/0x4f8
  invoke_syscall.constprop.0+0x78/0x1f0
  do_el0_svc+0xcc/0x1d8
  el0_svc+0x38/0xa8
  el0t_64_sync_handler+0x10c/0x138
  el0t_64_sync+0x198/0x1a0

Here are the full logs.
https://people.linaro.org/~anders.roxell/next-20241218-issue-arm64-64k+kasan/

regards,
dan carpenter

