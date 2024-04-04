Return-Path: <linux-ext4+bounces-1871-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0BA899141
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79ED1F2307B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 22:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D213C3D8;
	Thu,  4 Apr 2024 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1VdbGSV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E08E13473D
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269463; cv=none; b=MMStwMdampXMAG3IxB7jNSK555clnYHRGAlKHOKgO2DD0d1eVdpbPhh1A6T7El0vutlhCRah+VDHHaYqcx5snM5zfTKQEcojG0RYt+Dj3AH5C4lAG6N3+DiUOc0uu3R2R1qZKOiVURjsz472pm+Voy+YTuaYn65zuZE35F2+LeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269463; c=relaxed/simple;
	bh=k1TXt+CdYZOaX0qdAy2cb+IiqakRxh6JueoWsKsfE7A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=R9syVh3WnST+aCY1ZJ8S4QoIJQFLS5EeXCTWHG5MFKvHveyW1EeJZdgkjdy89KlgCW14mGeLp3SkjqwBNLg4Th6Gtp+Ing/UABMw1GuBabotgWcLie6dBJ4qT43Y/Wvryme0QscCvClJNUydUVWsYuypLwqi2qFkO4neDQOCb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1VdbGSV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a2ec65332fso679371a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712269461; x=1712874261; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P6ihik6rGPARI0TewqlgGNLWtE3Rk9/DaD0Q3aQRpMY=;
        b=X1VdbGSVjWZmJtwa4f1FbQwroDMxa6YyYm1Mi54uz03rKDVtwwuNT2diFcDqwglVUU
         MJRhziNooVZd7EMN88I+AOzrZD2SCh7lqvTKo0duRchWgLmS5bQA0HQG9ZGIhc4jjQXM
         NykVsErG9DcnBuF/CYOREOWpYfso4bLmxNrf/CrVmzhcWKq3Gyc1xwmZv6+ElHKedKHe
         CemmygRgs0gyNbbO+K0FApJlQE8OggGwp2GL27wVp2PhovdLKuP6V/cFVHlLMpBWvVbE
         TH0qJtFaVjTR8tr2BmOvRJVUeJgAieTbpZ7RO73If8kSUZnb1WBk1CemdkXp/gc/Dvwe
         M1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269461; x=1712874261;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P6ihik6rGPARI0TewqlgGNLWtE3Rk9/DaD0Q3aQRpMY=;
        b=YpalE5j42EeuPuqGaCh8tARpG6VyjSHYBGE7Dmr9mDou+vJMueQ0bIM0fBllyNjdnU
         qL1C4hLB6Qgzw5c6HVNrs3tmgZf/EqhhZKMshFiMwdM25ND/X0sqjjJ9GtvNCz5WybMw
         O5el3bPh79vIvxX79hkr3xo86CRU6lxRrwhpGAnUvEiNM3neLQT/LO4RUXRgCiPQZ2Tw
         FryeDPk35SrE+N9ohnxRoT/9LGu7jn5TWnadwgP1LGCvPQeV5wwJlKqbUAmJ6gJoorn9
         99o3yIg//OmouRMMbZaViyUnscsnbEPVhHV5CEyG6IoHWty5hFpQWHCR5ywZMVJf8sxb
         MREQ==
X-Gm-Message-State: AOJu0YwXN0TNzKUNHvnOI2YjJR5rhD0Zj/cFmeRjb7lsU2QVhyay4WwN
	Mdmlzhy6M0IwXeQyN3GdkrAUZEjiEQQ4sMHjzS/dFrhTqYNpghUVntR98XME60pCBItd9zguzU/
	urUSAqpaDFbn+1n1QkIt9f5HqEQ1k3Q4rjaM=
X-Google-Smtp-Source: AGHT+IEwH8nrD6AAONkqZ7lUoBI8Z1nceU4zqFD26ttBYDzqRX2H9pH1tezzofFPy+gDOf9DZdkHdNGNZl45sr3zqp4=
X-Received: by 2002:a17:90b:205:b0:2a2:f281:66ed with SMTP id
 fy5-20020a17090b020500b002a2f28166edmr1045989pjb.21.1712269460830; Thu, 04
 Apr 2024 15:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hanasaki Jiji <hanasaki@gmail.com>
Date: Thu, 4 Apr 2024 18:23:44 -0400
Message-ID: <CAMr-kF3yY6zYi2ZBXG7g77zaG2qzA9B294cqL=B7HOtkXYhOeA@mail.gmail.com>
Subject: ext4 e2fsck error interpretation and howto fix? expecting 249045418
 actual extent phys 249045427 log 1 len 2
To: linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

I have an ext4 filesystem with e2fsck reporting many of the below
lines.  Neither e2fsck nor fsck fix the issue.
Repeated runs result in the same errors.

kernel version = linux-image-6.1.0-18-amd64 / Debian Bookworm

Your help understanding the output and help fixing are very much appreciated.

Thank you,

==== e2fsck output ====
62264184(d): expecting 249045418 actual extent phys 249045427 log 1 len 2
62264185(d): expecting 249045419 actual extent phys 249045429 log 1 len 2
62266954(d): expecting 249045453 actual extent phys 249045486 log 1 len 3
...
/dev/...: ***** FILE SYSTEM WAS MODIFIED *****

     5123698 inodes used (8.01%, out of 64004096)
        3791 non-contiguous files (0.1%)
        3725 non-contiguous directories (0.1%)
             # of inodes with ind/dind/tind blocks: 0/0/0
             Extent depth histogram: 5112072/403
...

