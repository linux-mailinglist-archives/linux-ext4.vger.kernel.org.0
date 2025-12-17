Return-Path: <linux-ext4+bounces-12388-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE1CCC8FF1
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F0373140DC9
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 17:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CF33A6E5;
	Wed, 17 Dec 2025 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNXm6df"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E262C3277
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990895; cv=none; b=CXdVEquZlPAv8oGDUPtYCSOQn/jBb+ZCYxqMZm8AOFNBgOmzlQoLSgqAQTEBqxg16DUuxJ5b6FiUjzx3q08CYMPnzZe18ydq0usOfVLt+Ts5jPI+g1MbSR+0ueZJwWBOMN2Fw4e5FlRspKdW9igtXoL0xDeOj2kC+xLT1TONAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990895; c=relaxed/simple;
	bh=fpFnDzhZoXXWC4Kp8cec3dL+gf7xE0QtOfAURsHF3rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3Du6MVh7bwZ8sIg0+jkecJjdHER+4H7oEL/uAfnNnGg/q35udHatoQPvsoQW6bLVi3oqM6znmjjg/xjjblvCL4DJojCegLccvy80p4KWgi+6djipRwJMkI3HzCXzJqA++a50HnHee5Vou7V0KkaRnhwD/2r2AEjUymOMmlmorg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRNXm6df; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso4869635b3a.3
        for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990893; x=1766595693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+FQObq4BlmA1znanAjBgJXenx2Op3zd07yw7QPGN50=;
        b=JRNXm6dfFTxJU7MeiG6VfAxetUn2Yymb8CujQpCWkCS5so955BfghZ5PbbwGBsvvxN
         6Bl7BjhAXs5zuEHUEm3AJYCpUKHdOIDVvLeY+G+yB0lsui8K/R9d4F5vzYYc3q2R9JJF
         sF0wdZvx46yWUQR1LKZX4GxT4h8+Plr3qElmcP/ai1ph/AnWVWz68ay67R8mSxBqv6tu
         GbVebgvwy0NXhLmHqz2WQ1cIVuSTWicbJZC2BCo7YIB6QpI+cMCBEHSPAMQdaSCgNPqI
         ym2dT9H6I8RitVl7RqleKcr7NdEC4XhT+6KMy6kQBwtyuPlP512n/Q5QWHydjYXCIuz0
         1JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990893; x=1766595693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+FQObq4BlmA1znanAjBgJXenx2Op3zd07yw7QPGN50=;
        b=Q/VwPHulKH4ygzOCAM0R94fDDNf3lS+yo4Wec7AM6KtaC9B8GMUSac4Icztt1Sq+aO
         IYQUDDUfY2yBQTXIyt5fTXZFOTTMMDYfT5QSnXZ8puZ0wuSBmkSPk3Sp/IYSN3RDdhDH
         ZLSYwqtatRjLGzM/MhA/Fcb15j1++37IeR2h6H0Qjyd51BIWc6m1T1NBTJ5r4grRlNcr
         6kFUa586dAUMX8bmqNQx3tZvsF4nwYKAq4mKgouUM6+FVpUJvbZLVLyFtQl6QPIsUOgj
         lZ3cgBpGZQcOCVCeKtxBErEe8rc2sF28M2RBf6x/8AzAfTnD1Ppi8obbykV3f3ufqmg6
         H7ng==
X-Forwarded-Encrypted: i=1; AJvYcCWidYYng4cRm6XVMrw8iawqXevJAnoAG0nIPDa2cBu1TruI6SWthUb2ou7WAe5XjJkjTmxXJ538rfu3@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtyAHf/ixCMfw/F96AXE4E3X+0B2sly42+H11EmpcohjmPv9L
	VKqL8wNRkR2yCanQ1aJdEH4ahBfa2xb41LZUl8tkdp1IR2VXEgQTTExI
X-Gm-Gg: AY/fxX6CIzrjZXPtfkz1OgB6Ww2lsHyG3D0crowNwgvSNZJq/qLUbgcRGpZjKzJSYJO
	u41aVbfaLJZS/tX16k6oZdMnwYVvB1oq2I37Q3XAFcnQp5gM0LxwS8lY1GhLVC0bXhXe49Qnh+Z
	UvXYRStSlraVgsuHRkueeu8GkuSqKZRg8qUxD+peotHcqlW4sfVYaoITmg794MSo2QwKRKYzQEU
	p14Vz4lR2w5YAxCmLR7qqvQPWrIZ2rL+CO7lBmmhAXrLK7Vw1m/w6f0/vIHUt9tMZqXbJy6tOvT
	KvaYLBabV9qq62hMA1jw/qCFi47AF51NdNuAvO8E4MMNqlO1IQiHZPW0EicLpBauE98yRure7fW
	FCGur6PeeNDxws/s1fXWUpLlgfK4XlV314x3MeqQafo27LJhTi4pEljWKNP3V8czwwVBSCFtuuX
	wupZYV5uaYPft4/mQ=
X-Google-Smtp-Source: AGHT+IGDtgBQ4KQcHdb1LBCvEWJkZILPcU9I11r/0S4sbvgYuq/WsKBoqpiccDIsNUdDum5ypziV5Q==
X-Received: by 2002:a05:6a00:2993:b0:781:4f0b:9c58 with SMTP id d2e1a72fcca58-7f667935e19mr19497642b3a.15.1765990892447;
        Wed, 17 Dec 2025 09:01:32 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12316e60sm12290b3a.30.2025.12.17.09.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:01:32 -0800 (PST)
Message-ID: <f9913843-07c1-4750-9545-a5af47f5fbd3@gmail.com>
Date: Thu, 18 Dec 2025 01:01:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] ext4/006: call e2fsck directly
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-3-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Looks good

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks

On 12/12/25 16:21, Christoph Hellwig wrote:
> _check_scratch_fs takes an optional device name, but no optional
> arguments.  Call e2fsck directly for this extN-specific test instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   tests/ext4/006 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/006 b/tests/ext4/006
> index 2ece22a4bd1e..ab78e79d272d 100755
> --- a/tests/ext4/006
> +++ b/tests/ext4/006
> @@ -44,7 +44,7 @@ repair_scratch() {
>   	res=$?
>   	if [ "${res}" -eq 0 ]; then
>   		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
> -		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
> +		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
>   		res=$?
>   	fi
>   	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"


