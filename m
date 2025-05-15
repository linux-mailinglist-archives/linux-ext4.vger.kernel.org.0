Return-Path: <linux-ext4+bounces-7911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D791AB84AC
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540DB1B634A0
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A05297A57;
	Thu, 15 May 2025 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBRMje7I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6925C2C9;
	Thu, 15 May 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308165; cv=none; b=kLmiTBmuO+oP97/zgMj7Rvu2IlrhBMS6lRre4EsMljWrlNJpZ34OSjLoKVnq0a6mpJO0kCg2ERkHMH0XeJgeCyltQaCd5PDtWz0mOGGNvq/bgWcgsogqmqnUKvEFNipPGJ54SJPiGtUXZ6aC7ztjJsgx8YtTMdxTxa8lXHA1UB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308165; c=relaxed/simple;
	bh=aD3ahMdolvWSBfNxRmKfoKUY31bsCsh0KD6krUWX7Ag=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=l8LmJF6841skbBhMDkgWauihtrUNR3Te6tn46/B9dkz7VX+kLb7N2nNXvHPjvVvrM5/6+3BgvCLUX5qzRAyC6PEyBXc9tDVgjvEP07cXO12zDFGn4pJuAUm+7zX0Op26KYJbfHK6obEeBERMGaz0IazReiqnFN/OUneny82Riac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBRMje7I; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e7b3410e122so817150276.2;
        Thu, 15 May 2025 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308161; x=1747912961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aD3ahMdolvWSBfNxRmKfoKUY31bsCsh0KD6krUWX7Ag=;
        b=XBRMje7IGmikZ8aXlMrFFmwWMgWl9REBc//YyP+w64LtS/QlJOhmhVNHOVV2QrKfF3
         nkYvZ6IcYLqGy9zxknISubYEGPnUI0yZMQujNH2peXkRK/7sHAx0W9e5r5sQyw6KtTm0
         1DgBU/vgni3mHFhNZ21OSnEn64uRfxKK0W3qnhf7c7duAul3sktFwqxqozWH5GwInEu7
         ywn+ZAJFji+tQ/j064heWtMeGyAFJWFINJXkdupSyYzx57odBYfec/tXz1dEK286MXl0
         RmXzB/YLtz9hGhWiqe3NaE31DnKs0LfKqkEC2L8v0xHd+2Ohq69LgSX7JcJJOaUDS4sw
         QYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308161; x=1747912961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aD3ahMdolvWSBfNxRmKfoKUY31bsCsh0KD6krUWX7Ag=;
        b=moEsi4+8qk2GGPxM2U55SdbRM/ucX2dR6/C37tUJLy7e1hpEdnzVkBtGHToArepuED
         jSVrW4HE8nuE5g9T0g4zyQb1bDTNMtftk7CFO4IzeVv1kdGF8sY+C8MMLfOkmd01nKIe
         afnLPzMtJcxvODgGTohRo4L0eleJehsepn3OLtGX8N2gzdvrqw2g3BHNpLH1jjxwhlzE
         ShGvDZIEP83O3vtx8Q0EX0pw1MXPiAQEfwDMIniQqo1wOmUY1V2HfZZWudDG95vsCS8F
         LKFEJWWxEs4pZLlA4+qwiEMyIqqcSVnEAAAdZQGd/HCKApLq7m6HTzZwGiUrdLyWw1kP
         B7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxciqwLvDSQcpUAB6KCKTNjCTJTVGQ90A+vraThz4gSLQWhXJ4g/KNcs21UGpYFS2WzxeWMwNNYBfR@vger.kernel.org, AJvYcCVMoOwHuuX2DrYjEJev+QuuyKZavoEZvAqtuI9Sg1yW1iWSeD+Lmd4wMi3IuyXsj/W/XkPUPbeuCAnk5zJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIwjK+IHH7RbLfLegD24eO89/sFqtAYawLaF31wV3cHepFaeV
	zNqIhtxe51i+kA7bQGvEho/C/JmHZkfPxmYbjPqeao1jyswFcp1yWE7Ze1bLirUuf2PYUCS+4rN
	g+eDOO0oqvHOAKKNmmqXW++4UlHU=
X-Gm-Gg: ASbGnct0H5oDh8l5wZzjvLgCH36Uy1V8utm9GDpVDr09nYVCz44jLrbtD6Rn1i/10qa
	RaeROSxr5rt2b6xWniMp35aCgjl7My7qNK/wHjkNqhy5Qef09dU5LP26wBWZpbggtAuO4g877g0
	ZLm8J5WRaruv9BzLGhTASFfcCrbrWHbP9dIqE=
X-Google-Smtp-Source: AGHT+IGP/+LBlcc23jMwqW/NJ4FYcUvDfJY2pcx8vBqn5G6aFGwZBIfWCXs72GRRPNMS+RTfDkjJLxPVM0I1e4u18G8=
X-Received: by 2002:a05:6902:2209:b0:e60:7d3b:1e18 with SMTP id
 3f1490d57ef6-e7b3d5ea594mr9048063276.40.1747308161553; Thu, 15 May 2025
 04:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Thu, 15 May 2025 19:22:31 +0800
X-Gm-Features: AX0GCFul1A7P1pX1Lgbzfc0_kbfLhE42bIm4x3Nnaj9FBUBaQ0CHRUfbX72ehyw
Message-ID: <CAJNGr6tvycbeVx+C_ER-BDPsRK3M76B2ufQLDSvC79mUKwMGSA@mail.gmail.com>
Subject: [BUG] WARNING in gup_vma_lookup
To: akpm@linux-foundation.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This crash occurs due to a mismatched symlink length validation in
ext4 when handling corrupted inode data, combined with improper stack
expansion handling in GUP. The crash can be reproduced through
syzkaller's filesystem stress tests involving symlink operations and
direct I/O writes.

The key issues are:

1. In __ext4_iget() at fs/ext4/inode.c:5012:

inode_set_cached_link() triggers a warning when detecting a symlink
with actual length 39 bytes while expecting 29 bytes. This indicates
either disk corruption or a kernel bug in symlink length handling. The
problem likely stems from improper validation of i_extra_isize and
fast symlink storage in ext4_inode.

2. In gup_vma_lookup() at mm/gup.c:1362:

The warning "GUP no longer grows the stack" appears when handling VMA
lookups for addresses below the stack region. This occurs during
direct I/O writes (ext4_dio_write_iter) when pin_user_pages_fast()
attempts to access user memory near stack boundaries, but the kernel
refuses to expand the stack automatically.

Suggested fixes:

1. For ext4: Add stronger validation of i_extra_isize and inline data
size before calling inode_set_cached_link() in __ext4_iget

2. For GUP: Re-examine the stack growth policy when handling direct
I/O operations near stack boundaries to avoid filesystem corruption
cascades

This can be reproduced on:

HEAD commit:

38fec10eb60d687e30c8c6b5420d86e8149f7557

report: https://pastebin.com/raw/wDUgDsV0

console output : https://pastebin.com/raw/HndaBU1E

kernel config : https://pastebin.com/raw/u0Efyj5P

C reproducer :

part1: https://pastebin.com/raw/3AA1ZHUd

part2: https://pastebin.com/raw/0LaFkaAd

