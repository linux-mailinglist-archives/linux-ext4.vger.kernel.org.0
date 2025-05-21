Return-Path: <linux-ext4+bounces-8063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7DABF6E6
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD2916DAC3
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98A50276;
	Wed, 21 May 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0tLzMuZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1570830;
	Wed, 21 May 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836069; cv=none; b=MTwYCUkqI6TEWUulNTnHM2Q1QmWUSJV14yafkWLV3yN06JuDM/WSp5VS72enhsOnI1lOs+HGKkJXDyHksoFYh5MmOz90dKEVwDwppGWu2jm3w6aA9qCIDMiN1tA6tLNhKyVu7yULibA53tazoyDeNXGv/NPcnDzU9kRalAU05j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836069; c=relaxed/simple;
	bh=ONFUsLHSa7vkUiHilg2/DdNQnH53B+UdBapmF3QMSKQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bpXjmGqSiMrbNPo++aRdLEdMdhK5n7MWY8qnbOePElknGJMfAmu1dRbyrHVdS90g6hrlGqbb5cpb91Qv/0tGrB8vGA5YGg4ARheO8hL+zV8bO3AApighg/5orlWnou3/UBzDKYi7Dutka0wTXB9nAO8xDsqDmcY1IGO1Aev+3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0tLzMuZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54b166fa41bso10378267e87.0;
        Wed, 21 May 2025 07:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747836066; x=1748440866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ONFUsLHSa7vkUiHilg2/DdNQnH53B+UdBapmF3QMSKQ=;
        b=a0tLzMuZsbyE/+k46F8THn/mzR3N+053i8tm/hmRRENvGvDHz/O6jvGRB87eoWKLLs
         qRf7kkQ35ab6ScZdmUgXIRzirciUYTfPWFaa+aU9C8Gjr6nvoHnWoWnSBNmrNl3yBUNq
         IqzQAqSPOWHRAsGkfPv6oMKd+a8Yi4Pxlj4oQIe5k1Ce+6QcQf6WJYx3gFQoA17+6zjR
         hVf7NnmPJPlqmOYOC/Kq0RKscLxyrygIGvcCdPWNw2aebrHnnNvExtol1r+8iOFL3uO/
         Ju2yQs1Qd2lnbnj//GJYwZ7xU/q+AsoHsY6mqSFKp/3Ps5BdECGf3SW4ANgrJyRzxX/N
         CvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836066; x=1748440866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ONFUsLHSa7vkUiHilg2/DdNQnH53B+UdBapmF3QMSKQ=;
        b=hQf2Qjo2V8KIvx7KPUgeSqki/Q41zt2y21lK7bEj1r4o7rX7uJGWcwDrSf/sogXs1G
         olmhyjOfdb2z34odtKoyF7AmJlyalFnCCSK7AWqe834sYHnnT/2F8tzox0hEFc/bVPD6
         4sJU6l4qcja5Qq3YG4qGwO1UZkclR+eo+wdBVHTLx4pNoUYzfm6I82Xo/hXb/utqgLoP
         d/qZmdBgb0jyVbPBLYJl8Zyu2LJ3YoQzcz2oYpb/MwrQ4qEMUzEBMKYPaabxgBwLFrB0
         d8hr3AsFogsQj8WJbEVqnqpADnsuDhWFb0H4w8d+Pn6+TZ09u8UAoE7xODOOH7Dyk5wc
         +I3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVFZFxXHB2HFp2lbSV0VH4UWNoorms3Dw4KLpusWuymUD7XWduNEYbjNvTTVV8GAQpKdEeqp3lwidI/v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Kx7hu7MUpwSDxS4LZW5PZDkKe94pI4kQ3/wBi7xw8cKisEaK
	GLt3P6ePLApVbo712ryf786lKZTLHVSYctHjUgs7HkHwVzxGnElWcN5PN77nUGl9CyeBKyduplb
	7S+Z+/SVO6izVIvuF/SOXGHO+9SD8xA==
X-Gm-Gg: ASbGncsZNGeIg2MQcYpPYEwMVM0Q3t/V3+/Z3etW+fDxFqa2o9Xm/uPMaY/GaBWXq+w
	ER1Itj+0w16FO5MQzMajXGT8Yk+52KlOOamsnaUo48UAIT/zJJDXbk3R0lL+VN82xC5+MHsxELg
	/o/vbAPPUzzr8JhnZqpiZRjwJlVKHsPUuNERPVydfXlHaxzyTDg2M+CA==
X-Google-Smtp-Source: AGHT+IEErQUumcNlrERVRbwPeQbo8ThcwdLSPgoMWXN/7EPZuI0HoopGUnJGS+ztTTTB0ldhhXIhU/86Feukltp2+jI=
X-Received: by 2002:a2e:be0f:0:b0:329:14df:5c3b with SMTP id
 38308e7fff4ca-32914df5d0amr55710461fa.33.1747836065607; Wed, 21 May 2025
 07:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: John <john.cs.hey@gmail.com>
Date: Wed, 21 May 2025 22:00:51 +0800
X-Gm-Features: AX0GCFvrUSYfmVFmYHPWPUqbKUBjeps2254KYsjRGu5U2TziEdJnEhvhO2IgNAA
Message-ID: <CAP=Rh=P0vsd4FVn+FUWpAM6v72CuD8tX27X9zzr6BhkKNDDjLg@mail.gmail.com>
Subject: [Bug] "kernel BUG in corrupted" in Linux kernel v6.14
To: Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

I hope this message finds you well.

I am writing to report a potential vulnerability I encountered during
testing of the Linux Kernel version v6.14.

Git Commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557 (tag: v6.14)

Bug Location: 0010:ext4_do_writepages+0x273d/0x32b0 fs/ext4/inode.c:2619

Bug report: https://pastebin.com/WwMypbdm

Complete log:https://pastebin.com/WvhAuSgQ

Entire kernel config: https://pastebin.com/MRWGr3nv

Root Cause Analysis:
The crash was caused by a fatal metadata inconsistency in an ext4
filesystem mounted from loop3.
The function ext4_mb_generate_buddy() detected a mismatch between the
block bitmap and group descriptor free cluster count (25 vs.
150994969), which indicates filesystem corruption.
This led to a forced kernel BUG() in ext4_do_writepages(), which was
invoked by the background writeback kernel worker.
The subsequent attempt to exit via do_exit() triggered another warning
due to an invalid instruction pointer, suggesting that the kernel
entered a corrupt execution state.
This bug is indicative of either a malformed or fuzzed ext4 image, or
a logic flaw in metadata accounting in ext4=E2=80=99s delayed allocation an=
d
writeback path.

At present, I have not yet obtained a minimal reproducer for this
issue. However, I am actively working on reproducing it, and I will
promptly share any additional findings or a working reproducer as soon
as it becomes available.

Thank you very much for your time and attention to this matter. I
truly appreciate the efforts of the Linux kernel community.

Best regards,
John

