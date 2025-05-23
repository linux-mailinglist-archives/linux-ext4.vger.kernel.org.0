Return-Path: <linux-ext4+bounces-8183-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0277AC249F
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 16:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453BC189ED91
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E12951AB;
	Fri, 23 May 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP+nvUDy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84929345B
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009034; cv=none; b=Pb8GCbDBmXZtOlWlHVjzscJc2gmGRDj2JOm3CfYL5Q6OxA5Voj7fB7tlFTA2SjTuKL21WpawVXKj287olWyUG+jDDkvrJapxpF2AEMPXKhdgLxgrg6alfyAJCCzLILsJFbvSTXiRZsnPm/YBvzNIySwThUzYYd1HpyIb1QRjhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009034; c=relaxed/simple;
	bh=DGkXuHEeaKTLfrGvSNgzGoTOQMi11yZ1xm0b38NCK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=darzLPjpPDKS3jNnqwfGF7geWCqhiy0nVZ5D8AoE2UFLQVAOVEpuMOKenUXi8Q8CEV4l4QpV2CrrI1wda08vXSZuVv9JnWiHtJ8kjaDLkYaizSG91Hy6rK6S7QkbyKSx1MsX/JtGnEn3YjstD2P7zL+z38KUSshQ6edk9X0nUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP+nvUDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748009032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YGRKcfNyyUn6jZ4ThCK6xz4VOL69I1YIik12BFOPpw=;
	b=VP+nvUDyAgcvwjfq6QnBqnN2teNZMkQg4aysQwmkOL8s5wOQKNvDKfoDL9T5XL9tz7uXGI
	cx47mq0Jd/C+McqWF/8Hl8jHEnioOoa44rjtLSA1soQAlf3BBS13aIpTMWeUrsCZwmCsjZ
	KGqCg4LA2vnFVgKdWOxXCE+1XGtxHF4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-gkk77k3fMGqQnXvkgey5Mw-1; Fri, 23 May 2025 10:03:50 -0400
X-MC-Unique: gkk77k3fMGqQnXvkgey5Mw-1
X-Mimecast-MFC-AGG-ID: gkk77k3fMGqQnXvkgey5Mw_1748009029
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-73bfc657aefso6915785b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 07:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748009029; x=1748613829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGRKcfNyyUn6jZ4ThCK6xz4VOL69I1YIik12BFOPpw=;
        b=EgKPwxhhfsB3uBKTAfWelESpWbr1lMPSXVKTKZz4B+ZuXCW8pVA/xxy/HQRAGeA86k
         +VreDLwcZqL8nolvEl7nHj/m3NhaGyb3SCg1KNj3w1ikD7uvYYtkLSf1JlHzebKlKjEK
         79YdVeo5whepELZFVm/YfJGv6aWiUkMJScjde0tiImTL873GM8IPT7hFy0PTycB6NH/G
         K2oBvAdF5iB8BRJmQbRO4t/ODLxy5o6FcNYm8QUkSo9wXMqW36YVMq84dX1iU97NiXPg
         drpYdZF72GLpwbXGR8xdQqlAHEDAUobqWQJXiBivpgkw/DETqRApVDSpYPRo8PG5ijum
         Bg8w==
X-Forwarded-Encrypted: i=1; AJvYcCW1jnZXwg1klVYzZCC7icmlUrR3VFC+SQa07KZPFP/DO+y7y78wCtqXhJkVysDi96Jy4V+NOzs2mDH8@vger.kernel.org
X-Gm-Message-State: AOJu0YxpizzsBB7B9fWm98J4Mqgrcv3A+z+ICFw0wHA7pZ13UW1Qt8pt
	ux0Bqgpkunlwp5P5dW82Bf0jZXgCoOHJUYRD2kaKU0riECqSvNpeI3E2XGWQPAdcqg90Hp9v6kk
	cPxmp/iInOGEaPrGxo12LGojENxwMCFXfHUu2agZWc6g3YVTxB40tbspu0HFcyo0=
X-Gm-Gg: ASbGncuoDgZTcoIgiwD3RlBqFu61NYrYtcwljG7EJAuJKunJT8t8/+kCupxRU/mN8Ps
	PmThJ96+qNRhHVeLGczfO9Wgv9gsUIZkqGe+Pho6wMtT9ycW+HoCTVtEtsvXE9njV/ELoPWZPtg
	dAU4UsEJovq2GhZLfsGHS+7WaN0gWpJICCKXyxmSFdSRRhSg534Ot2l43vxd8MjVs+Tz3huMURS
	0nYv2MIlkwwQcyCA/pjI7Lxw213pltb8j5SdX318SMYK5Z8f5mo52pioanLMD7S8QZRGhuzUkIl
	AQdCCjfY9PRU9QQa+Jj6KByGEd+335/h+jiVBSxyg7Smt/oCymZ6
X-Received: by 2002:a05:6a00:3cc7:b0:732:2923:b70f with SMTP id d2e1a72fcca58-745ed87c9b5mr4232730b3a.11.1748009029366;
        Fri, 23 May 2025 07:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj17p1KKn+GDztyBFqeRvJRnpGGbjfNutmIwYVNXD38chctaNMiPd24PVPyBf3pQmeyrOY5g==
X-Received: by 2002:a05:6a00:3cc7:b0:732:2923:b70f with SMTP id d2e1a72fcca58-745ed87c9b5mr4232686b3a.11.1748009028952;
        Fri, 23 May 2025 07:03:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a3403sm13273668b3a.177.2025.05.23.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:03:48 -0700 (PDT)
Date: Fri, 23 May 2025 22:03:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 1/2] new: Add a new parameter (name) in the "new"
 script
Message-ID: <20250523140343.nabmzlbss346faue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
 <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>

On Mon, May 19, 2025 at 06:16:41AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> author name for each new test file that is created using
> the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <author_name>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> Creating skeletal script for you to edit ...
>  done.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..636648e2 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <author_name>: " -r
> +author_name="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $author_name.  All Rights Reserved.

Dave thought we shouldn't use "author_name" at here:
https://lore.kernel.org/fstests/aC509xXxgZJKKZVE@dread.disaster.area/

If you don't mind, I'll merge PATCH 2/2 this week. If you still hope to
have the 1/2, please consider the review point from Dave.

Thanks,
Zorro

>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 


