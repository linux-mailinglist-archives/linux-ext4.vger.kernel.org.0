Return-Path: <linux-ext4+bounces-1849-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF83897CF7
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4AD1F2A6B3
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E73FC2;
	Thu,  4 Apr 2024 00:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QC8LjDVH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE7634
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712189944; cv=none; b=XCH4mwVisZ9pziOG7yX/Pt7iK6qiLrlOq5j7ibZXfFBcXav27GmRSczV/uWa0Erflk25D77a6rYdVOqi2zzkMVUJlaxcCAcwHzp5ulCOx/rAjKX36hlsFWvN9oHz4gXpadO3aXhRchAuCJF8jAs4mOZmO4bjdIgsA4iehhu7C4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712189944; c=relaxed/simple;
	bh=5LdGWGkBVQLDfDXo+88TMXwyj/Bf1G3/Mw8MFW3rdR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqMKMDkiEwDzcuDBN+htpRQopJfSxa4GaskxgY/MqGDmbiQNMU20fwX2zG+IKxKY08M9dYuBhBpm6aEl6AwagcgZyLMn3z4lihHj8oVBELMLrWE5DsBYm5wku04ozVYdW2Wjd9ClkGKeSPnFG/7UkobVX/T4A27L0vPw6NwhhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QC8LjDVH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so382073b3a.1
        for <linux-ext4@vger.kernel.org>; Wed, 03 Apr 2024 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1712189942; x=1712794742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/Ew6UmSHF3bhF5sgzlv0Nsw7b3+N8hTZIhaCBiHnNA=;
        b=QC8LjDVHvjZl/8qIXe/DYQPHNI8d7bHKZXoN/L+4SqtlUiZw4x8MgWDMFw4FkOoJ30
         Zy5mZYNo8txp40gHgfvpYBqXbnYhUHx7JdpZbRGoYF9yPqqd+T98/kYQHAZk+yMMV1Ox
         DGPv72zfWo8CYZr1xM3LLdLTgbsA31ebRSTa2muzwzP4ewG2SL0Jdv6OxBFSAwYXV//q
         GXu5HJ4VySZAd54UY7le6D3ZllDZPz7YSFsi2NsXsY2sh2ge12GcA+njNipLQEqgrpwr
         jyexGLZ4hoGyodSSEkL4wbUVBT6XOOJOIiWWrIa/QIZysveM2p3cip4rxD+FAZHFZeZR
         4/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712189942; x=1712794742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Ew6UmSHF3bhF5sgzlv0Nsw7b3+N8hTZIhaCBiHnNA=;
        b=XnLDPqQ1HfDuLLrY3NEDrZgRRyLg/MW8RPTEyhrcROlmw7btEga2cLy3thhksB4fyW
         SBayYTezOTL6nWGejZV3vCXV4JXZkl5t6nKFEtV9GlENLtgluNca4h9+L4Ca1BehxfS9
         RIZchyKjEj8/ILeqJgg2aoZGuXtwUhhk5jnmjeZ4jHJsW2dAgZTQEterKPIqKah4Nmkd
         gKnMmG4zE6nNE2EvoV/SM8Fea3VWS7BF6nZjuPSfUp9GyfJ6fa90+9oqgs29e7QOZwvx
         XGCUNreXghRFHAwM7+5+fjEKM5DRTxyQxrw8xNX/B7d+Jbg+s3UH9PaBvlD+Y+UZv0LN
         8PwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfuD2CHODoVn7CWudErCNIlJ+vmIbm2x2jNeGN7cYrisLydODZqVYoK36Da/M1KbwML6VNIQgCIZNQbGdLWHNz418fjMesEI2Y8A==
X-Gm-Message-State: AOJu0Yx4fETieET3+unttRV7rB9egSp991K/ZdF21QAHHG+Ha3zbG27I
	C8U+bLiHzVwWmSsTlrRgm/99btJXd4JeLIzdweqgosMNGDs37KUbg94FmNY2zpo=
X-Google-Smtp-Source: AGHT+IFKT2w4O4ruHJDML5BtSRsEHhnp0R38EYWMUlfGE3tp+i8irA6jmLpi5aCVV37KdBohbDNcZQ==
X-Received: by 2002:a05:6a20:158d:b0:1a3:c390:6a6b with SMTP id h13-20020a056a20158d00b001a3c3906a6bmr1418055pzj.6.1712189941674;
        Wed, 03 Apr 2024 17:19:01 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id gd22-20020a17090b0fd600b002a0187d84f0sm298668pjb.20.2024.04.03.17.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 17:19:01 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rsAok-00369Z-39;
	Thu, 04 Apr 2024 11:18:58 +1100
Date: Thu, 4 Apr 2024 11:18:58 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] jbd2: use shrink_type type instead of bool type for
 __jbd2_journal_clean_checkpoint_list()
Message-ID: <Zg3x8qJXrseiiYgU@dread.disaster.area>
References: <20240401011614.3650958-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401011614.3650958-1-yebin10@huawei.com>

On Mon, Apr 01, 2024 at 09:16:14AM +0800, Ye Bin wrote:
> "enum shrink_type" can clearly express the meaning of the parameter of
> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
> bool type.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/checkpoint.c | 9 +++------
>  fs/jbd2/commit.c     | 2 +-
>  include/linux/jbd2.h | 4 +++-
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 1c97e64c4784..d6e8b80a4078 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>  
>  /* Checkpoint list management */
>  
> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};

So this is a local, internal definition, but ....

> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 971f3e826e15..58a961999d70 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1434,7 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>  extern void jbd2_journal_commit_transaction(journal_t *);
>  
>  /* Checkpoint list management */
> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
> +enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};

... this exports it to the world. That's a problem, because the
"SHRINK_*" namespace is owned by the memory management subsystem for
controlling memory shrinkers. e.g. SHRINK_STOP and SHRINK_EMPTY are
already defined and in wide use across the kernel in the cache
shrinker infrastructure.

IOWS, these new types needs to be prefixed to indicate they are JBD2
objects. i.e

enum jbd2_shrink_type {JBD2_SHRINK_DESTROY, JBD2_.... };

So that people who are looking at memory shrinker stuff don't get
horribly confused by jbd2 using shrinker namespaces for things that
are completely unrelated to memory reclaim...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

