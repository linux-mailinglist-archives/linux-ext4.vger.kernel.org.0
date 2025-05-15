Return-Path: <linux-ext4+bounces-7906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80DAB7E5A
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 08:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387597B0C40
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF86297B6B;
	Thu, 15 May 2025 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YykKjdvd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33404297A75;
	Thu, 15 May 2025 06:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747292095; cv=none; b=MoAfyCPmkY/RXCtF7swr9bJHVW0ISYJe18BKvKLuBJTieZxk4SHNcoIlhkJaHBbcWmSimSFlGiwO7DtVjnRghiIQdFA6CvrDQeBymVaShRa4tnhjlH2jgI2lwKv+aS7DTkI4eId8TeVi0A/9Q7Sq56e/JHegqc+vUiqk5jVp2o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747292095; c=relaxed/simple;
	bh=t1cmxPP2lIC19qYJZZVCtSyQ5R5NNKHU/xitTTP2MSI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cNGM1661KZMz6OYRp6QRHD39ZCacYVd9XnlbrW2F70b0Fo7IhOFecJpHrF4kX7gX4gtDE3YTXOhTdnFwdAVv6y9ho9vQ3o0U+KqI+NmffRLM77sECT4wd6KAUlN2zaOcRdR/yYH1byHu/QQuVesEfInJY4OPph6H+Djgy/r3pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YykKjdvd; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e72a786b1b8so578411276.1;
        Wed, 14 May 2025 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747292093; x=1747896893; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t1cmxPP2lIC19qYJZZVCtSyQ5R5NNKHU/xitTTP2MSI=;
        b=YykKjdvdVIdsPwaaAia73dhZ0e4ZidC2MnbeFnfnFvyOoJw9phM/XBVOAgQ6kBDTrG
         nkFy8nkM/wCh6zn7C3BhevTDPh9YSU9d3TC6hjD9BVhJ1EIehVx3oPPa6uL06M8x2+WY
         MVL/Jc+CkiaQ9I+WsMCjO1SLiOdkX3VmYU8GjWABO4id0eD7Mrtf8Qe4aQppKOqD3n9E
         0JVqKH+94uAn0fNcuWWyq6N9sZlxJMDPu0IiITu5mfQjpqQt7B/Rf9XHZO1NpwK5QIOU
         VZIp1c9kErmtiT0Jr5cxu8JCSsQJJuC6nqeg5nD0hUq01U+rg7ZA3WkghvJDvDAiD+4l
         MxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747292093; x=1747896893;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1cmxPP2lIC19qYJZZVCtSyQ5R5NNKHU/xitTTP2MSI=;
        b=VUOMC3NwjfxpsdPUlFjzI1bZoESU6B9+oljOI7i7HFA3oIIdoxvKrs/2yCy5blwShX
         8RwqrCZfqBBUjDYq7i2uDLRzUPcEr6OutRvjOwaQeKIoeBefbCYzeBf9HVkFh///xKei
         M+hHMwFPB3vD/YDXIso3zGJ10nEBh0bxGSM0DMRsz6cJBlCBh9sOD6d8C2POVYTmpVUo
         n6HtcEVqX32TZ2+lIYjhxNO282+b5+P1Dst8P9w/GQ1RthbM1jjUngQZ9So1WvOTlJIQ
         ox6TpuLzUw8LqWcrSP4zlXYWPAVcwz4PQ+U4ZTNdmYqlhz+m1xWxoqXgFRr0/aUGocAK
         aHTA==
X-Forwarded-Encrypted: i=1; AJvYcCW/vbM5WeT3FQ1sMYRyO4h8VUkcDpBY+6xyaG0gT3x7v3X98mDISJirgeOyk/fxC9HGbeFHRdAO4qgs@vger.kernel.org, AJvYcCXaJCpmlA+6YqQKzy38LVcxZq0gmqApPJj49/lgI8Dfk48dKOs2X1Uu9UvlyKCpJ1S91Tgguaejl7Q26C2u@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UF1RatGGF8bFxevfS8jowRO1/0wCsoruDmXsst/zzmXFtpPX
	kmGEXXGoXXVFnFUu38EW05h3CnWDKEAv88bA1kGgdpjqZarO797YoBWexmDrdhMODCNd5YW1tKp
	91qptvZqaR6v/V4JhvPCoeAb9X16lO1GD+/ssV/Z3nGGi
X-Gm-Gg: ASbGncuJzecJ/wckCn85NoNQhICRF54SzIOdFGVKqB9ghperOz4XGTB9Ax7SZ98aTC9
	Q786lEWmlkbI9GbcNZ4ExYZtdTtSGTJSnsef15tJPjcMupIb7HNUpuSyH4P3e0FquvgxLG1Dqn2
	TuE2EZQ1qhr7PuegO3+BRntJJ+rOyQsmq5
X-Google-Smtp-Source: AGHT+IFzNiJ+zUyWkZFPg4RNuORDWffWYwQyIa09PVZx9ngM+x8SyPMp78/380FkRNmPOgMgyItWbe+VIAUEsW4BcAc=
X-Received: by 2002:a05:6902:c02:b0:e7a:3d4f:6355 with SMTP id
 3f1490d57ef6-e7b4f87732emr3222858276.19.1747292093056; Wed, 14 May 2025
 23:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Thu, 15 May 2025 14:54:43 +0800
X-Gm-Features: AX0GCFvmW-oCLyE_tglm61LLo5PTqhIE_ahHf0u84RbTzumcEHtp48MSObXmNfI
Message-ID: <CAJNGr6uGfUpvHkPdE-OrWL4_cqd+_AG9Z4ZS9DB1KfYm3CzQAA@mail.gmail.com>
Subject: [BUG] INFO: rcu_tasks_trace detected stalls on tasks:
To: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This crash can be triggered by repeatedly executing a syzkaller test
case that stresses the signal handling path and EXT4 filesystem
operations. The reproducer causes the kernel to process signals (e.g.,
via do_group_exit) while performing delayed block allocation on a
corrupted EXT4 filesystem.

The call trace shows the task is stuck in get_signal
(kernel/signal.c:3036) and exit_to_user_mode_prepare
(include/linux/entry-common.h:329) while handling signals.I think the
key failure occurs in ext4_validate_block_bitmap due to inconsistent
block bitmap padding, combined with an ENOSPC error during delayed
allocation. This leads to RCU stalls when the task (syz-executor.4)
fails to exit the RCU read-side critical section during resource
cleanup.

Maybe we can add sanity checks for block bitmap padding in
ext4_validate_block_bitmap?

This can be reproduced on:
HEAD commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557

report: https://pastebin.com/raw/A7yVpRQJ

console output : https://pastebin.com/raw/Me02WbSY

kernel config : https://pastebin.com/raw/u0Efyj5P

C reproducer : https://pastebin.com/raw/TLx7rz0Q

