Return-Path: <linux-ext4+bounces-774-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F27282B1B9
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D951F1F22BE8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jan 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794D14CB43;
	Thu, 11 Jan 2024 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AitQAYf4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E14D5AA;
	Thu, 11 Jan 2024 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-467ec031988so736757137.2;
        Thu, 11 Jan 2024 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704986777; x=1705591577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIAyy+z6UYldKOuTvWdH3GAJfQlZGcwrrthZvbRfQPA=;
        b=AitQAYf4KRelNWXE5PKv8C3wwOGEgBpZE22b0Qj/kkvWfbbxkU8GhtTCjHnhud6Qj3
         GomS9Q6a1Kn81ceJNp1oSwyvUqDBaAgkgB/S8AtkbwOePXGkLxFKcAllrjDq2ZbDzZ1+
         qC8ckSEg8/JqpH1C6zdyZ1FbmucPpOSQZDkSZ1vBvcfTPbdSiGKz5IrFLGT1LMSDeKi2
         LUzNxLwhUmkyMVupziJ9tD5juMqgwXnS89eowHGH85v5tdZa8h76B9fjQEn+Tf7PYHkR
         rGFuLMVoFPguW+txiAcmiHPb12NGQyCZ6lg/XWIhJuiBnTWTAUlHPlRugEnFmQ9FJAMS
         EOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704986777; x=1705591577;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIAyy+z6UYldKOuTvWdH3GAJfQlZGcwrrthZvbRfQPA=;
        b=RoHkyCg0WO+8EBjXuVpYE2G/Vy9ZxgQdjL/lOOIrY5XQFvgmpzv4L6sM0Nf9T5L79Q
         xmX2Vu6lj223eLAUfFZhXxgM4tpadnbPYsGRjZVwOJbXYygyJ1LwjjdeeyYGH7vQQ587
         bGrOwqkfZRwghXnpuTqn0sTrwOYNgeCu0EeKkJfTJ9qaMHF8Y0ZpKRlIIhgzZcuW+EAm
         OAn+ANreX4pECnuWpfX1YcA2MdDnTevvFGOoE1ZTziVCR7M0JaWaGIloKbVitNF6lpMz
         y41J/jiM3jP1On2RGbJ4lr1G3jH2EjgbYpxMVXF3V3DWtnzrXr6NIqPQp7+y9a7Lwpa1
         xxHQ==
X-Gm-Message-State: AOJu0YxE4L7jSL7l3/nl1z7qj+B7ixdo6ZwzLflLRN3q5+jTl4HMbfK/
	QNzJuXAYz/90Hl0PSwDoIjrZxbOjQbXBr25fwCak8E/vmcc=
X-Google-Smtp-Source: AGHT+IGTSDl5uJ9mbgdIzjqEw0QmPY8o7XrxvUnQFzfAPE09kqM28vO2a70ynypXQguZMRD2d2gDf0vcO2uPqxwGLZQ=
X-Received: by 2002:ac5:c199:0:b0:4b7:e96b:8b12 with SMTP id
 z25-20020ac5c199000000b004b7e96b8b12mr415581vkb.19.1704986777113; Thu, 11 Jan
 2024 07:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Allen <allen.lkml@gmail.com>
Date: Thu, 11 Jan 2024 07:26:06 -0800
Message-ID: <CAOMdWS+A8-5yT+_O+7xmyVvAfZmEsDr7nDwWHtLWLeefmDFqOA@mail.gmail.com>
Subject: EXT4-fs: Intermitent segfault with memory corruption
To: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Cc: Allen Pais <apais@linux.microsoft.com>, kelseysteele@linux.microsoft.com, 
	tyhicks@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"

Hello Ext4 Developers,

I hope this email finds you well. We are reaching out to report a
persistent issue that we have been facing on Windows Subsystem for
Linux (WSL)[1] with various kernel versions. We have encountered the
problem on kernel versions v5.15, v6.1, v6.6 stable kernels, and also
the current upstream kernel. While the issue takes longer to reproduce
on v5.15, it is consistently observable across these versions.

Issue Description:
Intermittent segfault with memory corruption. The time of segfault and
output can vary, though one of the notable failures manifests as a
segfault with the following error message:

EXT4-fs error (device sdc): ext4_find_dest_de:2092: inode #32168:
block 2334198: comm dpkg: bad entry in directory: rec_len is smaller
than minimal - offset=0, inode=0, rec_len=0, size=4084 fake=0

and

EXT4-fs warning (device sdc): dx_probe:890: inode #27771: comm dpkg:
dx entry: limit 0 != root limit 508
EXT4-fs warning (device sdc): dx_probe:964: inode #27771: comm dpkg:
Corrupt directory, running e2fsck is recommended
EXT4-fs error (device sdc): ext4_empty_dir:3098: inode #27753: block
133944722: comm dpkg: bad entry in directory: rec_len is smaller than
minimal - offset=0, inode=0, rec_len=0, size=4096 fake=0

or we see a segfault message where the source can change depending on
which command we're testing with (dpkg, apt, gcc..):

dpkg[135]: segfault at 0 ip 00007f9209eb6a19 sp 00007ffd8a6a0b08 error
4 in libc-2.31.so[7f9209d6e000+159000] likely on CPU 1 (core 0, socket
0)

Reproduction Steps:
The steps to reproduce the issue are seemingly straightforward: Run an
install or upgrade. The larger the change the better.

Installing Gimp has been a go to for testing, though we have
reproduced the failure with:
- apt upgrade
- apt install
- dpkg install
- gcc building source files

Observations:

The issue occurs consistently across multiple kernel versions.
Reproduction is faster on more recent kernels.
Longer intervals are required for v5.15.
When adding more debugging options that increases processing time,
segfault seems to be harder to hit.

When DX_DEBUG is enabled, during the installation process(dpkg
install), we observed instances where both rlen and de->name_len
values become 0.

We wanted to bring this to your attention and seek guidance on how we
could proceed with debugging and resolving this issue. Your insights
and assistance would be greatly appreciated.

Thank you for your time and consideration.


[1] What is Windows Subsystem for Linux:
    https://learn.microsoft.com/en-us/windows/wsl/about

-- 
       - Allen

