Return-Path: <linux-ext4+bounces-7031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7709FA78300
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 21:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7721697BA
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 19:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B21E102D;
	Tue,  1 Apr 2025 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLjDjnKJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3AD1C8630
	for <linux-ext4@vger.kernel.org>; Tue,  1 Apr 2025 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537542; cv=none; b=TZ/5Da4tut7UDEIhZCK4zTbx6zk/uuY32594a3WNAn0/rFb7Bi3/DwM6rLAmOB00w0ULPe0efMK2q5TLu7BUibbNJ4b1Ml9VUNUUS400Fs0h+l+xqvbCijEdzZdIqZ0qRhveBuG4dIdGxx5oo+hT7ceop2D1Xs4vxIBQnFJTMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537542; c=relaxed/simple;
	bh=OkMdkj6JirOXrdK94X0oCRFOiRNPIGs/j/G8MIG3a7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rj+9kiZcblFiliow1TJxmvuoqSCAtBwYWkGbZogSAVRDcCwPLO2/FExAOfInEJ6TvCct9rX5eKZMgAqx6kkOAdNoM9ORHRCZbW1Jcz7n1rE1kxjvf7eA2Fljo3cvY7joSDlm/Dq7WeCc/VCTnpcpgYLAWzQIQ5UaGh85NBsAh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLjDjnKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743537539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nd0F6xrysyZRvdcOwsCXTIAlwtOfRO1g6Ab4Fb92gFo=;
	b=FLjDjnKJlxQZFSWSyPbxt8NiyCn2WdyB21niO988A7/R0+snXl9BTVbEcPsUSVlsO9G9b2
	5/vh3s2O7UiiOYjPfIKLfQ9aXVWhivrk2uvOmGb2FxIS0GczDTT9LBPF9WgVCRAC6a0SR6
	scDBtC0UYHKGN/LiKTCs5r9+Jfh80B0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-MghZcaWxMSKYiQqyFQ3kpQ-1; Tue, 01 Apr 2025 15:58:57 -0400
X-MC-Unique: MghZcaWxMSKYiQqyFQ3kpQ-1
X-Mimecast-MFC-AGG-ID: MghZcaWxMSKYiQqyFQ3kpQ_1743537536
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d9848a7so80721f8f.0
        for <linux-ext4@vger.kernel.org>; Tue, 01 Apr 2025 12:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743537536; x=1744142336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nd0F6xrysyZRvdcOwsCXTIAlwtOfRO1g6Ab4Fb92gFo=;
        b=aj2gd8QTWYFUR/s3v2bjDKdHYChHqsA2yhiKy8/0BK0RP2yWvL9OlvXdpNv9LhJafG
         CCBl9Cb8MOLw4Bu+ej2J3VJxtlSk+1d3t34NbU3/RNlv+ZELyMzw9hAXHBA0LaSnKbPW
         Apjgk01CWHxoheTxhfDQ4N/+mjzluBSiWlWTvZscqUSTr4xYwEFjXGNinaHWvbucW+Lb
         AW7b/IJJ5mJj/lfVIo8hBw5ugjwrinDlYdHyekjqXzJTHnHuGqtx7Py84hqy4hM+17xi
         iIcwdeyXHKwqFxH4unlLJ1VdDyoIK3Xuv6pBmbWZkerWDDD43JSGeK0BLQ/w2xsSMRsR
         4Dcg==
X-Gm-Message-State: AOJu0Yw+n7BfNRr8wFH3Dm5NMpit7U3qEzDYynjHles1YH6dtzYuYs0I
	kNVLLmn4z9q/ThJe4TpyrCB/W4ymz4ljXF8tuRwUMwbvABt4FsRhb8amSHgxamp8WbsNz4fois4
	6uHwOf9vLxSz6hdl5DvCy3feG0BXGHP05Q8/C5IN78fthUir6Kgo5reOcfU4=
X-Gm-Gg: ASbGncsnGO4GDES0ZD7Tn35OGJA8KD9lyU2a58zEEsjZNosCrNmX9FsLg9R+IaSPyQL
	c56ypaw97XAvbCr8+dD15ZG4dQFkZSei3vRtoZh2T0BA0M9mssih3r1pODTJuSk8BpnUbGTQE/7
	/Fm5p8ZobbGV2I4zi6nHgb3l/zmDc8JvFqMtkZ/JkE3lP5VEHGo5eKPr70CDyTUO8blhJx/ANCd
	cGu3R1bwy54VUpg6VSzgqUyWgB+7/ASCGPxghTWjmCrXBkpVExQWp7JSrxfUd2F11dXFg2NrQ9z
	6v71bgyaSv9FKWGCW+y2fb+pMJYAsBAfAx9m/zdetiCM4Wo4+YFx
X-Received: by 2002:a05:6000:2284:b0:39a:c9c0:a37d with SMTP id ffacd0b85a97d-39c27f04ca9mr1323647f8f.21.1743537536531;
        Tue, 01 Apr 2025 12:58:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgK0wBZX98uYt+wwbKEBeEq2goKKgmKsFhZQj3Wo3bDjsqN1EAiut29I7KBSfdN/p0bRHo0w==
X-Received: by 2002:a05:6000:2284:b0:39a:c9c0:a37d with SMTP id ffacd0b85a97d-39c27f04ca9mr1323629f8f.21.1743537536140;
        Tue, 01 Apr 2025 12:58:56 -0700 (PDT)
Received: from [192.168.100.149] (gw20-pha-stl-mmo-2.avonet.cz. [131.117.213.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm14831244f8f.3.2025.04.01.12.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 12:58:55 -0700 (PDT)
Message-ID: <25ada3f9-0647-48ee-a506-92caa5129b2d@redhat.com>
Date: Tue, 1 Apr 2025 21:58:54 +0200
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] xfs/539: Ignore remount failures on v5 xfs
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org, david@fromorbit.com
References: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
 <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-US
From: Pavel Reichl <preichl@redhat.com>
In-Reply-To: <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 04/03/2025 14:48, Nirjhar Roy (IBM) wrote:
> Remount with noattr2 fails on a v5 filesystem, however the deprecation
> warnings still get printed and that is exactly what the test
> is checking. So ignore the mount failures in this case.
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>   tests/xfs/539 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/xfs/539 b/tests/xfs/539
> index b9bb7cc1..5098be4a 100755
> --- a/tests/xfs/539
> +++ b/tests/xfs/539
> @@ -61,7 +61,7 @@ for VAR in {attr2,noikeep}; do
>   done
>   for VAR in {noattr2,ikeep}; do
>   	log_tag
> -	_scratch_remount $VAR
> +	_scratch_remount $VAR >> $seqres.full 2>&1
>   	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
>   		echo "Could not find deprecation warning for $VAR"
>   done


Reviewed-by: Pavel Reichl <preichl@redhat.com>


