Return-Path: <linux-ext4+bounces-1501-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCB8709EF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 19:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6561C21620
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 18:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4578B4C;
	Mon,  4 Mar 2024 18:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxyIwQi0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BE4D599;
	Mon,  4 Mar 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578533; cv=none; b=N357JqNchj+H5tWcJLAZ/I/5M2BjVFKtT6zpYaISAvWTuqpBIrZ5PC2zs3tgGXyfpKlIFkJYBbPukXo9hH5m12bV7aodq8Wz2EINyTRsyG9bKcLkmkfYIw4pu4ocEz7Rkydz5Ukh+Ic81Gl1BF4Fs3WBQw+dZbQ2RMRkQltZ8OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578533; c=relaxed/simple;
	bh=5yBHoiNu9VfZV0hM6h9eesyVOJ26EoSf7Q0OFY+WqCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAR+CNTOn6kpY1coGwueLLNtF12zD7rfyu5GSQrNWo/CVneBsefsJ0FSLK+mLlhTKuiSQn2z4IL74/EfvTyHTW8eCu3wE01vGv81uL/lfR0R25yMthTY/U7RZQ5D887/Ku559ImBQIIKOLewj4m9jq51nCLYMMRyhUgsOMK+GSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxyIwQi0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29b2c48fa3dso1289564a91.1;
        Mon, 04 Mar 2024 10:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578531; x=1710183331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gR9my6EaMtG7U6QVaXDmcb/8/H1dbFGvOn9fySmbC+Y=;
        b=BxyIwQi0++Lni/aH9x3Lbew8m/WwaA4wdnO3pfe0Y5VWo+vyf6aw8ZPhI5ZWuetn2h
         eWdIAgRZd3F4wscIEg2Xkk5xZYxKv2rv17++DSqhQbWIxoQdHR48N6FpAhDj9mAJXXLf
         Vy1MrMpf8eslEwSeY79DU7JrMyhEXjftXgpLMSakMGI+GvlxHOmlghC0jOt9hmCfKS0C
         pH/o8diZPvUTCH7Bzdh9X3P5ZITNawlAB1KR5Q6+NqVgXgYIKDieIBPPNV0O4HuVJIlh
         iZIcF47wNBqpqOixBj9K8EJvL4HIx0lLH9BHe0/W+6VMnPiB9XKfocypCiR8KL21Pr+8
         PPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578531; x=1710183331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR9my6EaMtG7U6QVaXDmcb/8/H1dbFGvOn9fySmbC+Y=;
        b=rILAQEqR9iUGj7+SA7rXFEEZE71FZVhYdclv/Aie16rCmXd/mO15L3QY46+8o/FKEw
         GC7VwYTFladiy44elwMwgLOm+n6YKq79iBkGCpIqxtGi7TARnZgKXYozInD+ZRy00BDy
         00e8D0SF2hS2pzUf+BvMTQ8a8IpGaWgWCVffBz8onmEF5e7R6y9ZW4ghuYREVS+V1HkE
         fp1fiJqiFiloKoamwzcXxHGFrn7b5aGCsEgeT0qq9rh+6KCaMoStnvGjHW0rSFJk1cAX
         mRc26eWvj1Yqq2JRzZxBRS6PQDZ0xy5IbY+MTIWN4wg8oRr68t/iKxuiM9S00lUxmFxC
         4d4g==
X-Forwarded-Encrypted: i=1; AJvYcCUaOjIiB8+EN2rWRfjH0WENbJyOWQ/Pxyx678kUBUMXVvTnMwI2+FYEBWYbqj7JrR/L+sFWD9XhLZTdyV5GBnba+H/B+a8UiIfncvFeOR06lLjCrFBXxy09QtREZ5Z6gXPygLcWNwDelQ==
X-Gm-Message-State: AOJu0YyTa3qPdpWBzDf02g4lYSjCZficn2qPZ2H7eG5WSWzOd2uK8yG/
	qoUNdQiL43qynGbdBVjw/VObe6RykOeYEW725D+pnSMfsSrx1F+7
X-Google-Smtp-Source: AGHT+IEUKC0aSErDIE6jhb7NmrIXbIyIir/FEmedrm91wyIBSngot/MMeStKpdS95a9cHlBGdh0Kwg==
X-Received: by 2002:a17:90a:c3:b0:29a:ae40:9e10 with SMTP id v3-20020a17090a00c300b0029aae409e10mr7028152pjd.17.1709578530775;
        Mon, 04 Mar 2024 10:55:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id kn11-20020a17090b480b00b00299101c1341sm8290581pjb.18.2024.03.04.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:55:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 4 Mar 2024 10:55:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org, brauner@kernel.org
Subject: Re: [PATCH v4 1/3] ext4: alloc test super block from sget
Message-ID: <8268a3ec-51c5-4447-93b5-bc96fadb8feb@roeck-us.net>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
 <20240304163543.6700-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304163543.6700-2-shikemeng@huaweicloud.com>

On Tue, Mar 05, 2024 at 12:35:41AM +0800, Kemeng Shi wrote:
> This fix the oops in ext4 unit test which is cuased by NULL sb.s_user_ns
> as following:
> <4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
> <4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
> <4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174)
> <4>[ 14.346696] alloc_inode (fs/inode.c:268)
> <4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
> <4>[ 14.348016] new_inode (fs/inode.c:1033)
> <4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:3719)
> <4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
> fs/ext4/mballoc-test.c:314)
> <4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c:443)
> <4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30)
> <4>[ 14.351530] kthread (kernel/kthread.c:388)
> <4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
> <0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)
> 
> Alloc test super block from sget to properly initialize test super block
> to fix the issue.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

