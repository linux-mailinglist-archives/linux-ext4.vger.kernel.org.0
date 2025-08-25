Return-Path: <linux-ext4+bounces-9594-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B3B334EA
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 06:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB2B167A61
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F0B23FC49;
	Mon, 25 Aug 2025 04:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKzR4zX0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D19066B;
	Mon, 25 Aug 2025 04:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756095025; cv=none; b=dHbSy6UIehOiikEh5B967VCMgdqJLvem6g9AxL8RCco+zJD+b8eHt5kAxf0zLmeqZgfT7l7vHvHa2orY8uat/iXky+3lx7K6Z/Gd2wdkyfX2KFbmOhVCRexJRNYGdeuFpHMyG44HLgI/FhCKUGiR9k5yF+An5jWtVuGfm3t554o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756095025; c=relaxed/simple;
	bh=ABqMjKXkt5wzIMPDef6z89C5KQnrniB/DFMU5oitdfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=k8Gpsrxu/MP8sBJh2haEaD/6Juk04Kx2a70uTSzeJoFcsT6X5k6KSD9l6ZVZRi5h6KbRf+XawJkyGq7Nln/n0Mn8Si9b26WbA9ZkQ0yStBAURD7nA3vp8hIpIB4GXCP08ro56mZsdvOmul+RxQ/DH9JhrF8O96p2Qk/8ADfW518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKzR4zX0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so2569073b3a.2;
        Sun, 24 Aug 2025 21:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756095022; x=1756699822; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XM9WXdUNpNrO+N+iHztfV0bM2xVDNwP7kFz/CY3E4ks=;
        b=XKzR4zX0arL8mYGAwnwCo2FMVJJiNxezPBjmr0kWEMnR7hyWBYKLIJlbb5YhTC5j+c
         qfZk9S4Q5+frYEHZIt6poABhirmAZqKTwS3dCt56xWTScNCd90MMpEcE1uYoncofc2eK
         Vd9e/yqbiOg/0F/WrhbkWQPDoCUdzc0k/yhpqFiDavesZ9vm8V83P1tRJDuf9zuboqEP
         pJOQLft5eEN8KBC8vVdnzwg8mmGhi/4Xg8Ds0rbrrQM1zQhDb7YLxHPPi611/VBNW0NM
         2SkJ2WV37D8ukcoNk6ZFqK7D5xVhzuZQO4tBCwoJmEvYiMIFPRf6L4/gG42E1x6+g2GO
         7PAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756095022; x=1756699822;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM9WXdUNpNrO+N+iHztfV0bM2xVDNwP7kFz/CY3E4ks=;
        b=PiYvuifdIAzIPXPRGi+Dac88+0T6M95vFEPoRC7TvUO0LjY3buqFzQTYQxkA/IJVRg
         ZEWh7YxDpvalT04pKT0cjzsYHBQUz/qQkUCh9vJebwOMuxkUKl9FgGfEyWT1gAIVrBdk
         BQh/NwVa4hzzGjPHht8q1yujdphZD9SJvswMxOqVQsnY1lcnInQpdV1xmpJhLV3JM9tb
         Ih9Py2bRKIZeoBX2s73gDwTMJNxR1xs/6SqUuy/uF19+Wucyaa5Vz4b0OehDLcthOzYp
         D0XUPpkcJ4GAvThdDqpGCjeJLj4A94DXkiscpQVzcnGFNErMAev56NnKWsL9UjZYi4gz
         WtZw==
X-Forwarded-Encrypted: i=1; AJvYcCUYVg93QGTaxN0yXZxV0v789H0lmDFRAN9mpl5DdAMXIkboMoGXFVHmB+h4T2xL5b/oZiMxFBpPWQ+F@vger.kernel.org, AJvYcCVwPUQleDaDwglm++1itdT2x3fQ/fi53y0UyI/OJrEM6tVsZS7GIY8Gg9fM9Pk+dJUA71VT8dvrrAF+C6IO@vger.kernel.org
X-Gm-Message-State: AOJu0YwovBMAStKgMwqRpIrc6Wle8qWEpjvIJyYogu3CWbw3Rjw+rmbd
	S4qjjKsr09uoU0IDhA8/uSWFT8vy0vGzE13Adnn/H6Q23Xaz8zhiwGme
X-Gm-Gg: ASbGnctMnl1DcYzivYPztM3iTT/RE0Y3wwSI4cYoNi7IQdfsCB5nEyVVKE2uQspgTJv
	gGZgnVdITr9iCoV7df/JtJRtReChhSA5kgNkP/l9D5xx65+sZhr5uCJoJIJBSPEWGqpKCFb80eV
	Mla4OWOFVY0OW2ZS0sRXWd9+YxKKeQ5CsxfRiQvIpBflP+kw8KvGBY33IjNxlNMI64jJjeCnyys
	kFMRWWqnSh2uGzY2XmCBbQUykQBU9/9lCGpALe0qg9fWJidzXusLqBYy0g3kLeP5Tje//zOk+ud
	N7sXs8tYowCPV/1wE1MlZRNUbF+EzXGmdhPNg2x4Ksc7Enq+98zkeTNdMYmldyTAF9zhUSLZSU6
	LMKlBZoZMdoTmhg==
X-Google-Smtp-Source: AGHT+IGykXNTUX0Nbqh3Pun0VaW3f49LT/h+6mO+D2br3lvru/lltLqAFDX0Ccx5X8WQRAQYjoohVA==
X-Received: by 2002:a05:6a00:bd92:b0:76b:42e5:fa84 with SMTP id d2e1a72fcca58-7702f9d8207mr12900871b3a.7.1756095021988;
        Sun, 24 Aug 2025 21:10:21 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771ebabeee1sm133533b3a.103.2025.08.24.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:10:21 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, libaokun1@huawei.com, libaokun@huaweicloud.com, syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix potential null deref in ext4_mb_init()
In-Reply-To: <20250825033830.2230202-1-libaokun@huaweicloud.com>
Date: Mon, 25 Aug 2025 09:32:11 +0530
Message-ID: <87349g9hh8.fsf@gmail.com>
References: <20250825033830.2230202-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

libaokun@huaweicloud.com writes:

> From: Baokun Li <libaokun1@huawei.com>
>
> In ext4_mb_init(), ext4_mb_avg_fragment_size_destroy() may be called
> when sbi->s_mb_avg_fragment_size remains uninitialized (e.g., if groupinfo
> slab cache allocation fails). Since ext4_mb_avg_fragment_size_destroy()
> lacks null pointer checking, this leads to a null pointer dereference.
>
> ==================================================================
> EXT4-fs: no memory for groupinfo slab cache
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU:2 UID: 0 PID: 87 Comm:mount Not tainted 6.17.0-rc2 #1134 PREEMPT(none)
> RIP: 0010:_raw_spin_lock_irqsave+0x1b/0x40
> Call Trace:
>  <TASK>
>  xa_destroy+0x61/0x130
>  ext4_mb_init+0x483/0x540
>  __ext4_fill_super+0x116d/0x17b0
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  do_new_mount+0x197/0x300
>  __x64_sys_mount+0x116/0x150
>  do_syscall_64+0x50/0x1c0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
>
> Therefore, add necessary null check to ext4_mb_avg_fragment_size_destroy()
> to prevent this issue. The same fix is also applied to
> ext4_mb_largest_free_orders_destroy().
>
> Reported-by: syzbot+1713b1aa266195b916c2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1713b1aa266195b916c2
> Fixes: f7eaacbb4e54 ("ext4: convert free groups order lists to xarrays")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

I was just looking at the syzbot report. You submitted the fix pretty
fast ;)

Since these two functions can get called in error handling routine, we
should check for null before iterating over the uninitalized array.

The fix looks good to me. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

-ritesh


>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5898d92ba19f..6070d3c86678 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3655,16 +3655,26 @@ static void ext4_discard_work(struct work_struct *work)
>  
>  static inline void ext4_mb_avg_fragment_size_destroy(struct ext4_sb_info *sbi)
>  {
> +	if (!sbi->s_mb_avg_fragment_size)
> +		return;
> +
>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>  		xa_destroy(&sbi->s_mb_avg_fragment_size[i]);
> +
>  	kfree(sbi->s_mb_avg_fragment_size);
> +	sbi->s_mb_avg_fragment_size = NULL;
>  }
>  
>  static inline void ext4_mb_largest_free_orders_destroy(struct ext4_sb_info *sbi)
>  {
> +	if (!sbi->s_mb_largest_free_orders)
> +		return;
> +
>  	for (int i = 0; i < MB_NUM_ORDERS(sbi->s_sb); i++)
>  		xa_destroy(&sbi->s_mb_largest_free_orders[i]);
> +
>  	kfree(sbi->s_mb_largest_free_orders);
> +	sbi->s_mb_largest_free_orders = NULL;
>  }
>  
>  int ext4_mb_init(struct super_block *sb)
> -- 
> 2.46.1

