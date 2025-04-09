Return-Path: <linux-ext4+bounces-7155-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A2A81C03
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2556C4A77BB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 05:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D141D89F0;
	Wed,  9 Apr 2025 05:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUf5AQm/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F1A14F117
	for <linux-ext4@vger.kernel.org>; Wed,  9 Apr 2025 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744175101; cv=none; b=uGmWc1lpLcx+o/W3cpCxZJSIb3HEpC1vp6myjGZd46MMhyK4TJeftJpIig2MCSNxOyBzCmWfooGYgYtd9HZ3swI8CP8cbT5PHQuQYcX4E+4QeIJrlfDo2YEJ/GEY4g41eYAGBCZ6c49mlVaTMnmFvytohf2Ui21b+NULLpT5JAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744175101; c=relaxed/simple;
	bh=UqMD5apIFlDteCOIyX/lwa0HCAXVdzeqy/bejU0wBtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM0DWXGJ7auvj5p6T7v44OBLqIXyPx/FWsRoSfm5rTzoytDhHRCTiVTOIHH3G+3rjxy69N/vcssLXdNMeXSiqKrcbfJWp+CWMPcwYNgICmZ+lYV7zTRloKxOtwDbhxVQHuSd5LMS31Vd99Od7fpeUZj4Ne9jK/YjvTgHiK8TLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUf5AQm/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744175098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1y3iAg9Agds/Ogx11q6UpGaQVkkfD7b35TZnTxtdUOA=;
	b=OUf5AQm/rud5i4xRWtwXfQjG7+q1nmBulEHErVzSnSnSPCMfNNGN1/YZvKOJYXzu1bjrnR
	bxoOpr/QZIdxZFjCLIhdCM2Qysip76ySu3vGItsuxl2qVo30tZbRo8Ma1VAm6Rr//0j+CX
	DObQFH65iZOrzjrZiRCs3MCvF7qqVCo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-uuUnv-ioPtOB0EnHFcNV5Q-1; Wed, 09 Apr 2025 01:04:57 -0400
X-MC-Unique: uuUnv-ioPtOB0EnHFcNV5Q-1
X-Mimecast-MFC-AGG-ID: uuUnv-ioPtOB0EnHFcNV5Q_1744175096
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so6188804a91.2
        for <linux-ext4@vger.kernel.org>; Tue, 08 Apr 2025 22:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744175096; x=1744779896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y3iAg9Agds/Ogx11q6UpGaQVkkfD7b35TZnTxtdUOA=;
        b=rRcd9x63BqVM/6nuMkw+zeoeichIgW+pvnY+6LW3gjIv4iu1QqbcDDfB9wRkgmK+ZD
         ewT2TjkVXW1FD+Xpbl3u7IWJqSBOBimXsWmcPS6v3aYIn8/yPx8tQ89NntyLNQt/9x/c
         rRPMRxjOjHG06rtWwjV3LYUFzKNFHJcZLKyq27VDTmSvi0TSzgAY5SSqgNWeLXufZk2s
         SM5JoL8UWf4FrGPUWqNjORKsqEWJoR2MjOWlXs0q+KCau5guAPipvOyNCxX7V8FDjwkw
         5nBI5OlBHoRmwi8IbWI0FsSat+kWjG2ku8bCgiXQ+RJEWAw9eo0JHvf6oVXSdiesppLE
         SA4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+1LCcYKEVocicC6BD4dwcxSxWL2JKiA0u8G9owmIFdYbmKprJJzElHXJb3cx1qmx2AXImZyZ3xh0a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GCaD6pdxTZB4J3jTA3LA7hfi9CnfZb8/n2wKM1y/5D1h9crT
	UpBa4otHFjA69eVX9Qkf0q6dH+YGxPKp2LKJKxrsUoFwEpe6DbtY+Zob8DScinfaRcQaC7wW7M/
	KxUKcbjJQ2TXBluL/EZLEMSvu1mxPRyKlaBTnP37edPfqwpqA3A0UgoFtSNbTXVPbaJseQg==
X-Gm-Gg: ASbGncvH+wN0Kp/c3BQmYjiU4iW5oMyqzykQ2gJulE9hdrRsSFJwS4RyhaxuD2tiwUT
	X6eflEWOoqxIdrJemihBlPgs513N6ZgdoXeDU4HgeI2fgYUSpPwFX7+hIVQBnrRjAcdwJpzzj4z
	zRiwpuZczpCEmZOAaxmvOPPtiU+0y4rWNJZiEDxISEO4/UVhmJ5vvUQ76MkKlQ/i3FuMiBIbOW0
	+zF2cqknW1MFJg/46jqEaUCHYqn7SS5R+TdTEtihwvlp/4UDjOhP3Pqk8GEHbKcxGXHe/KLwnnA
	a5GyNYue/B3EI1QxnhaOsaHs+uLRasDMSLwegNHG/KbuZ5PFJPm8Jms6
X-Received: by 2002:a17:90b:5488:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-306dbc390e9mr2115573a91.29.1744175096037;
        Tue, 08 Apr 2025 22:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDcrE2k0N742zHbBe7oI20IFqxVkjJZoXi1LOt1Rkg6ayMeaOnkhcBhB907+V8zBE2CUb15g==
X-Received: by 2002:a17:90b:5488:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-306dbc390e9mr2115544a91.29.1744175095663;
        Tue, 08 Apr 2025 22:04:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb544csm2383045ad.167.2025.04.08.22.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:04:55 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:04:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 2/6] generic/367: Remove redundant sourcing if
 common/config
Message-ID: <20250409050451.tzw5e2g5fpk3ktne@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>

On Tue, Apr 08, 2025 at 05:37:18AM +0000, Nirjhar Roy (IBM) wrote:
> common/config will be source by _begin_fstest
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/367 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/367 b/tests/generic/367
> index ed371a02..567db557 100755
> --- a/tests/generic/367
> +++ b/tests/generic/367
> @@ -11,7 +11,6 @@
>  # check if the extsize value and the xflag bit actually got reflected after
>  # setting/re-setting the extsize value.
>  
> -. ./common/config
>  . ./common/filter
>  . ./common/preamble
>  
> -- 
> 2.34.1
> 
> 


