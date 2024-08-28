Return-Path: <linux-ext4+bounces-3937-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BB09623A6
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 11:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F541281EDD
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD1167D95;
	Wed, 28 Aug 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afqhHMk3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76854165F14;
	Wed, 28 Aug 2024 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837865; cv=none; b=ICiGZacL5Lvvd9oJra+xRnEbd3pw2egho97OEgapCY0+zZ1u2LKCZwwXfiUhTUleVn8iGuYszm8yo8h4bzuDpBWVjxzV8gEG7H12L/p7ttYbEadqUyGXRn8pVDw7ZZvZL/gIxnyUjX82EQan0PSy3pdf/jcVLNj821b+I6pmd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837865; c=relaxed/simple;
	bh=F2X5KuZYLbBhGu5uDfZz+kDC7m3l7XMuLL+vVDblwZc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=nns1dXtw2nmdYiX3tubbeQmPDjttm1lnM8n1KoFMC1tRapzlXdrOQYXwUVCe21/VLoiITVPM0F5AUmqeIC6/MA2LpUZFKAyvg5+9OjUUJAz3P4yWm/3HAmRdNuB8tXikY27isbPHPwKN51EHAj9Qqf/0KjUc2em6p6YXgzddy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afqhHMk3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso319597b3a.0;
        Wed, 28 Aug 2024 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724837863; x=1725442663; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k1veELgeAvAn9WVHUaUf89+0IrISdVNLie35DWYESu8=;
        b=afqhHMk3MrIQWfg/fX86AOSQ6orOZlz47E+Jebp3ad1cC4520/gOhMwX0cNjTvgcJ7
         6DaqfRtFw4DvzdhsI5muXCQfCab0h4ww6y9dbvrGkqtSAJf39WSjE1vK7BBNQIhboKCD
         6tUtsHYo5amRqcKwVxxpmxaHo9lLnK00yE3goytqzSmQYUh/WjsyBHpO5X0t900QS48a
         42EB2fSnDqSkGbetqRPcIMCVQlGFbULUE8vTTJzF8DntUhkT6SXntFqDh87k8+wOvR0V
         MCRgFl8KJV15YEBjzTxRiHvNWAm/rsx2c293p6gJ5mMVyZtVXs8EnUR8Jna/NOQBlrj2
         EFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724837863; x=1725442663;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1veELgeAvAn9WVHUaUf89+0IrISdVNLie35DWYESu8=;
        b=Bx3xYoCU6onrVnSRBhbcFJDN8YBWiLGEodFdpOW/4/u6UpEeOlMrDFp9kC7uRFm2xz
         exHJ8vxwe0ATfhsu9q0UfFiRRDoU+YQnZJMUidIItfN7Bs97R1NkDO/GBZmk+0Q4wlRT
         kU1Irsf2NwxzjJKcQTus+Obc91D+Qsix+Nv0Ye8DUnyrMBE7IVRpHns3XS7e84RBxH45
         yNuVGVjhLIH1wQ6yztEr/cmcx+1vHyZX9ZQniZX4LqBYEU3Xp/LuU7f0XL4s+897u/fr
         SND2ctBCgB7CD5EIS1bYrdv7FkI64vcDdzBj1YTLThSXZMZ2wpLF0Pj8fzTOGalIp2KU
         b2UA==
X-Forwarded-Encrypted: i=1; AJvYcCWqE2Yv8VMUAKRE/Kokt4nCJUZHHoLvcxZ57fKerzNswDHZPO3ppUgwxCAQhbHz0S848pCS5GPZ0UES@vger.kernel.org
X-Gm-Message-State: AOJu0YwKpSk4RIox2qFyH++vzQl7WFcDGYAZAZMgbow+AraZ/wEOwHFw
	pl9+IG0bDoZ2fVm4Q8lcylW8SHE7+bF0unQoQG7C9XMPohzZKn2KoXHi6w==
X-Google-Smtp-Source: AGHT+IHCtiXlFwdSXB2FP2vizuSLGSIjecIK8rSdI8gxkYHRYnVIcWKQzVLl3LsSe1puutEtxBmw0A==
X-Received: by 2002:a17:903:234b:b0:1fd:6033:f94e with SMTP id d9443c01a7336-204f9c4bed6mr25824735ad.27.1724837862573;
        Wed, 28 Aug 2024 02:37:42 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557ea28sm95321595ad.96.2024.08.28.02.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:37:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>, syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] ext4: Check stripe size compatibility on remount as well
In-Reply-To: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
Date: Wed, 28 Aug 2024 15:03:39 +0530
Message-ID: <87v7zlq9e4.fsf@gmail.com>
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:

> We disable stripe size in __ext4_fill_super if it is not a multiple of
> the cluster ratio however this check is missed when trying to remount.
> This can leave us with cases where stripe < cluster_ratio after
> remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
> unforeseen bugs like divide by 0.
>
> Fix that by adding the check in remount path as well.
>
> Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/super.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)

Minor nits below, but otherwise looks good to me.

Please feel free to add - 
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..9d495d78d262 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5165,6 +5165,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
>  	return 0;
>  }
>  
> +/*
> + * It's hard to get stripe aligned blocks if stripe is not aligned with
> + * cluster, just disable stripe and alert user to simpfy code and avoid

s/simpfy/simplify

> + * stripe aligned allocation which will rarely successes.

s/successes/succeed

-ritesh

