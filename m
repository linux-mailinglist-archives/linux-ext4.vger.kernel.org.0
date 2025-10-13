Return-Path: <linux-ext4+bounces-10853-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101EBD398A
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8E4189FDCE
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Oct 2025 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C00268C42;
	Mon, 13 Oct 2025 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyjqRqSN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B810942
	for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366100; cv=none; b=hgzNjlHWAPiJcJBvrmePJtdcjoc476xLm+WUv3AygYPMYU0d0pA+7zhnyFoLy1hqb6gp6ZmG1fEGZ1B2vpgWcKy446J/3Heo3TWyk1R6cVCIlw+aydoAHaorruGfNQkiK7SqEafzUpk7BpqtP2Lv/dNRo9BHMsZcLeMTNMwsDF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366100; c=relaxed/simple;
	bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJFGMos1gN73DtYCM+/j+TElo8UPmmnpPBjRnH+Btw85mki7zztquebKA8QKOwrXqcFLdmi/UEbWEm8AOU8VGqfcCXKUH2G3ek9uQqS77qj/u16J+qbsdQq3wsn/vvyF9Ylx9zQt02m/5Fr6r/7ehWKl+lI9nQ0lWRG9GKAqQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyjqRqSN; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6354af028c6so4223456d50.3
        for <linux-ext4@vger.kernel.org>; Mon, 13 Oct 2025 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760366098; x=1760970898; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
        b=JyjqRqSNf0aHm1e0wI7D8IMTkbZFdzBXxlkaV5ImUpnd1oi8nzMJt2UmWXUbBsKyf9
         2ohdTWeouQeK8ATmOJw/45XynzeNQmvlD2iGCyZcNH0Dr3RAMMDlucCW52gBTL9Qp4kx
         ehg0239ym6QWWTJLVZIybj9q3M/+vbW7uT0xVbEllXjGZ8dNGOrabtuTiXpvGQqVMRSk
         fUUuEax2OEhtWgwbgEbU/HWaW/ueKKVFd8EhCsbmEDb+whcX/DhebM3cjNRYNnXv3xsc
         sR9X7DADJ02kIJ/ln5Soj8G3T/kTInCaVnD/6UMqZX23qdAWuzoqKwhlHBHqVZFfc7+Y
         afHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760366098; x=1760970898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OUBzFA0EWu6+C2ZUWePVBWalhb+/XSYRn8tZPem7vlY=;
        b=aDZUZU0k94hVBN++5tUKaf+BXsshRbqxEi/qxH8x9kivxqwDvHc0yBK4FfyFv55AQD
         c+sZ0lQ4f4v7NkuzSC1+T18oNu1A8njDVU3F7FHb8qT203+lM3KyoTVqgCXT9yE6m7mj
         Q4l6juNL8aTSlP0ZfPvW4H3gU2uarnp5tzqgJVmGDzgacBibU/YoPP7HLWLFTx/eirkJ
         XB+nzoyUCAPIExp77T0h7x8/zpnoQu0HAzk7iusiV0NPnvYer5qluaP3ehivQKvvC1/8
         zX9T43S1NcOxcc/x7DKrBm1EOICEXef3BNkA37SOK6UJdpny+khTMk52sKoQO72MA4Q8
         siIg==
X-Forwarded-Encrypted: i=1; AJvYcCXsh/dYyrVRZK2mC4G0gQ5G6FOKENhGzqHVRBD9XqlTApuQarZAgWzwjxQhuCWwCPYfbvNaoKwRKjF6@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT2Z6HpRR9J3X9FsdFKQ1aQZZSWaz4l0b8vfi4aY1q0nLOdxE
	dfxXNmJVMarwISUrzB2cCWer/JE4NyfqiWvLVPdQVerfXVEkmpsK1svD8vZlTOPf/aLAHCaPYuJ
	j6uk2ITY5gD6/sc8G8LAuHIqCHPjjOV0=
X-Gm-Gg: ASbGncvIMQ8k7ZG7Zg/YRpFEN+vEYe7+002bI0StiMiQ6EAo2u3zKJWA/BEbM0ffnuR
	HlQGsX2hVNFJGZO0TJa7pE/t6zGDPXx7gTUkzYVro3FOsUj9LjtM5gEcn/j803y+uhJhWsghAcH
	faPxKyOiSRCaKA6aFeaclEJRg0AwHdmyGRrSI+C2YBq9WqlpEHJIyVdOpR3/hwNHr2PWJYM8IjZ
	aV2NfI4isGTWn2vMZEb6kcFptpZQR6jiaP0TdFjMio8QcxLVeE2OD7a7BQFJWHLACoock5UOH7E
	sKXr1x4up/SE9es=
X-Google-Smtp-Source: AGHT+IHLCK4ACBaTIUEA/LGVtl3MWQLwbAyoauPQDGgrE+Yd88kcEKxoUMbTBKKt6QPyVCxc2yUDu07Tlaopdnhokyw=
X-Received: by 2002:a05:690e:246:b0:63c:da95:21a4 with SMTP id
 956f58d0204a3-63cda9524a8mr11633399d50.25.1760366098354; Mon, 13 Oct 2025
 07:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930112810.315095-1-kartikey406@gmail.com> <4962e5a0-a03e-4e9a-8f8e-5db04504c30e@huaweicloud.com>
In-Reply-To: <4962e5a0-a03e-4e9a-8f8e-5db04504c30e@huaweicloud.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Mon, 13 Oct 2025 20:04:46 +0530
X-Gm-Features: AS18NWA6PkfGAzcoJajFKMNWANM0EYZlmu0IVwjM_yZHVDaXZ0OiTvbHLF7CG7g
Message-ID: <CADhLXY7Q87ZAMV_j0a003pNqJ0GNqEpC9gBLAeTaW1pz=589UQ@mail.gmail.com>
Subject: Re: [PATCH v4] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
To: tytso@mit.edu
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+038b7bf43423e132b308@syzkaller.appspotmail.com, 
	Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Theodore,

Just following up on this patch to check if there are any further
comments or if anything else is needed from my side

Thanks

