Return-Path: <linux-ext4+bounces-8188-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE9BAC260E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 17:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE0AD3B4F72
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C420296711;
	Fri, 23 May 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbbENeCf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858C5D8F0
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013080; cv=none; b=ZHkTBZcWuj9xEqRKwWzi+ddbv01Ufkf1tLXLKLWbY7m4RqQoWN0xEtMS9mxgn6y0sX0TJv0PbYnYRgFzSuM1bG0ZQkQv9mf6g6WOe5YY+5JWNFJyJ1DP3AuY+HM3IjOoCHFTepk6UjHW3ykoMHYwRB519i1Y056rvZiU1GhfTLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013080; c=relaxed/simple;
	bh=+tReRAgv0vI30RDuIgS++Ebwbd8kzKFBgqf3nLvaLf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXSxgLMGMgiyIQVeTHNH77OqFPFr7sGaXuLbhBBfuJQvr/Q/Ag+fzUAdsJcaFi1ETLycBiPIwplszeD20GbXob0B4K3VepRVegUj1oHz3hTaXmCZAS0axvn40rsiL7PmZ9HW3gRC7Ocm6VTAN0qsfNVOP9yMsMORQrEbmJG2jg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbbENeCf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748013077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voaSsyYj2YOmvOIrQ6J0fboFnlH7C77mXI0eP3uhd0k=;
	b=UbbENeCfYuvv0Cg16xOnFKOWLtxRxdXupwVjhnnfEoOdtss070yUlDUj8X6jIZ8EO8W0Uh
	7kxG1SXbfHuJBELpQ8WJNAqDso3+/PnhJpFYV3xhVekqxQWvVq8Zp3ACHCgr6b/I3cr/+L
	EU2ycpX6xLO1st33M4bWguBKNqCm9mg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-KJiZesFNNw2OFEgRfkqr5Q-1; Fri, 23 May 2025 11:11:15 -0400
X-MC-Unique: KJiZesFNNw2OFEgRfkqr5Q-1
X-Mimecast-MFC-AGG-ID: KJiZesFNNw2OFEgRfkqr5Q_1748013075
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742cf6f6a10so85080b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 08:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013074; x=1748617874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voaSsyYj2YOmvOIrQ6J0fboFnlH7C77mXI0eP3uhd0k=;
        b=bUpNS7Zve00k4r9ysa3CGawcNU0k4h5c4pIL8lr4jlPUCtfLnxvahTLIBR9NCvAvAg
         DUvUR3+lrUdvGy74ttljUEj+rB1VSjBWnfr3ko4pRTWpx17i5tD5Q4EGsUHaROur+phC
         Sdox8FXRhFCTgwR5PhEN7GyaHy34HDMizR4eaSkevUW5PS/hvcK/i4y1/X/RftR/tVvH
         A/VpeJPuVCpDg20Ox7NCOc8l1jPBGLoVfcvUjM7Z1Xiavs6YjmkGCvKc8LjS6zTN0PRV
         q6RipV+oGuI5VY59NUXvHDzctTBF/O30uKh37t+k+98gvNKJZriO0hszSQ1m805qjxlj
         a9cw==
X-Forwarded-Encrypted: i=1; AJvYcCVVTRnGXWyCRL7985/d8xG85wp3Z7KAfHKsw/AIoMP/pxFtgvl9I1WdsQoAr24xFwUzZSqcHn4fI8vm@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvlApKBp2C9kUx9NHG4Ib+hn9KrrTa7g5p0HND/qwlWku9pxE
	Z8CALmabUtbkMrhtB9afXrzhPIVLoCTzgIrWe3mYr9+Yfxyt3H8qkX7N+/XHs3sHYrj0UUBFupN
	OTFc5IIhrvzSd6OgySdivFxBNCNjMtKilqcaO+eDbGT2KTxBgtMN2eAmJiEtYLKg=
X-Gm-Gg: ASbGncu3q7rdxbb2FHLFebeIX14b+fCL3o24BVBuSuNwjmVJx7iwyKRffV2ilCVpTrB
	XTaSRyO+jkGYVMK7l/ERFKBhNysghgLW5ky8/iJDsbWPiOC/SyeXhlf9jR/LVJzUB1F/UiRI8E4
	Q9Rv5ZTfeFrS47WoBIlXSZIVBsx+pIhcR4FGEcL6SzTRRtCCk3F4GKHfIr2UuK2fESq8y5Oh0JK
	vzBa5ZAzTMdFsTh5wrsdsPrZYTpGHeDl0ZjspzNBeYfPyW2sL1cSBXecYsoMCaboMGOMBHwiOWz
	7TlkBHYAciH9/paRj22XVSbZyebC4644Ahwtx6UaV/h3IDQoS0Ty
X-Received: by 2002:a05:6a00:1705:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-745ed8f5cffmr5029425b3a.19.1748013074606;
        Fri, 23 May 2025 08:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbaSPNwoZLNrAuqi+CqpvcPBlF151WSA0skLZzhPzzTFD58zs05MmaKUwsU1qXxvi/84EA2Q==
X-Received: by 2002:a05:6a00:1705:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-745ed8f5cffmr5029380b3a.19.1748013074227;
        Fri, 23 May 2025 08:11:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970e1a3sm12784504b3a.71.2025.05.23.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:11:13 -0700 (PDT)
Date: Fri, 23 May 2025 23:11:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v4 1/2] new: Add a new parameter (copyright-owner) in the
 "new" script
Message-ID: <20250523151108.axky3xfznd5yackb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
 <72c4879ec3f037db0478bdf0c64c1fbc6585cea7.1747892223.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c4879ec3f037db0478bdf0c64c1fbc6585cea7.1747892223.git.nirjhar.roy.lists@gmail.com>

On Thu, May 22, 2025 at 05:41:34AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> copyright-owner for each new test file that is created using
> the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <copyright owner>: IBM Corporation
> Creating skeletal script for you to edit ...
>  done.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..a7ad7135 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <copyright owner>: " -r
> +copyright_owner="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $copyright_owner.  All Rights Reserved.
>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 


