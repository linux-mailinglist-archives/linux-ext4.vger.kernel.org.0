Return-Path: <linux-ext4+bounces-12390-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB38CC8FFD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61605316B66F
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1742DC34B;
	Wed, 17 Dec 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrCbc00H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8742221DAE
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990969; cv=none; b=N3Uo0BxRC72QZS8GcmVEtf8su4hZWGs3TEMAIJ6/pqJTHxxAJ5B9ivx03kDAlUUw6tzAAOkd/+oZgTeLFzgf3s3Lm/YOgDOq6nkuL4oxVjO0bSZekz+c+PVGb4T0N2uA2M0O3dH0PCtqo8MwOhbBI5TdWk7QO2Nqs+QskYmnbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990969; c=relaxed/simple;
	bh=ToRJHcpjvXVga4X877HC3kIL7IrMUEU1J2VVkV8cndc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZvZJ1opzwgn8PQ46LtJWM0MhIKEBr/+PyHQ09EPKqf9iEdeuXNd6OPsNPf2f2QvkgfdnuDSRLby3QtXkoWiGFcCdjAVFad94zcSgpR1nEyKrmU2HVjHyffQVthtTmCFOeBH0Yx1lF84lxvqEbgmnIq9ANR6HWAtQLYoU9H6yV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrCbc00H; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c3259da34so4613506a91.2
        for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 09:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990967; x=1766595767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BlAKzA21ErBWFpH53H6S+ldLrYlUKuDSpGtu3kSDeU=;
        b=lrCbc00HEbRr6b+RJNwKbSt0O2VWfxdq7QcAC+gbQU5Rc3TYV/D8+in0hJPHFZweJ9
         E+fyKhwtVK8INnPGiZhmGif8Iq4c5gna92K6HXby0Tu34fB/hkNI6UMnSlclGNj6zxNW
         z6ac6mP2Gf3Rx1yMHGokppfnzHML1TqkNBoNHTkfirXPx0VZZtWxhBjkYaF41T8l29Zr
         xFjESe5ciixJLKAq1nzPAz0Gl4dmRbzy9euDwYx/rVQ15BfaIb7RmOnWS5cQANXyKeOe
         7A25LFMPxAjn+4F96XRdW7v0yv6KjhFD3yxnjY1vd+9x8YTtwfXbRAZ7t5L0OrMX8TnS
         X0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990967; x=1766595767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BlAKzA21ErBWFpH53H6S+ldLrYlUKuDSpGtu3kSDeU=;
        b=QNf6jSl+zPT45lJD1L4AkctMooD6v+Gq3ZrXuDRRk3C+86OnaAGCrIqsDVeCWxjhDp
         Pu+drCWACwuOjoaVNsjgflsZDWeQQl0F6f3RZYDiSEX3hOOFq7SUT1WM0gSfdDfVinba
         Oi99MqIL9FlagmZrUWwFZ56HhI7/sESxFkJUPPmJXj7hN6TuDkySJErT30MtyF9//San
         EatcgK0D8mnRuRe6izcTo/abzleKtaxqi3uOIK6cvFnEiN82mYpkwi68i0kE/4NNU+L3
         txHK++/F4zgCkno0uwuL0dtni6jz3aAo0v68b0kCR1fMln+Wcbz9/fHT2Q++n4upUbqQ
         6b7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7xjG1//QoML88uguWyzFdPWOCFtcQRGA/6XgkI02Q1zRSlKIkadOck4styz5S2SlVt6DcdififD8k@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsod5n3Ukk+y5zN8RppzUvhoQusFASV++Qz9kp8yHU2ahh3AD
	8stTbOyb1kc+KaSoJdI3AFVi4QdWpNsSiem4UdxO14HOrdIQsNPwyOtn
X-Gm-Gg: AY/fxX45UY2qgtKu73UK+j3ZlS6I8t2n8uwWv5APnnr+LY7OTRxqaqIomxVBuejTBnP
	LSwmMidT0JCeGFXoWJMaZFH2VFsmcHpVQsuYoz7rTJzOO2h+9RUTKzcPvkjzdsR8UDl9WKhu7Gq
	X72VfJgoiwx/+TPfDySw5qYbuXQsti4//rodwArVQfJGPh1/wddAwPCkMvV3kbxLK65cXlfANRn
	7doqVa4ULQzhUVe+9i+nuV5B6a35oqyzKGo6a1yTCptTbyZoFUGRwYSdKnuJNq7a7nZ/eMvRZvB
	eMXxp+G1sENvcd7OiJRgWHNeDb1hgUftSreixFL/YLNxNfePkx3LKtD+Wk1vudYGKI+Qp1l9jjd
	pA6tNAXLMQkxIrYBQgshEMuAU6CmJOUhzRtLLe9PK+wwVxQnnLrEvzsEnCa0r6c2jmlNDMT7pt1
	iZG2KjnCyaycXrsb24s9miLKxHOw==
X-Google-Smtp-Source: AGHT+IEjJA54aEA6lI7AscWvPNd06zlq1bSw1wMcFH8bsgGXOTWLSkjWYzIWJqEuLnR0WZ1MVIJLCQ==
X-Received: by 2002:a17:90b:3912:b0:34a:4a8d:2e2e with SMTP id 98e67ed59e1d1-34abe47924fmr19838591a91.17.1765990964073;
        Wed, 17 Dec 2025 09:02:44 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd9aaaf2csm1933817a91.5.2025.12.17.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 09:02:43 -0800 (PST)
Message-ID: <7f13d1fb-92c0-4175-806a-0f7dbb2bfc63@gmail.com>
Date: Thu, 18 Dec 2025 01:02:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ext4/032: use _check_dev_fs
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-5-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Looks good
Reviewed-by: Anand Jain <asj@kernel.org>

Thanks

On 12/12/25 16:21, Christoph Hellwig wrote:
> _check_dev_fs is the new designated helper to check file systems on
> arbitrary devices, use that instead of _check_generic_filesystem, which
> is just an implementation detail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>   tests/ext4/032 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 690fcf066c11..043ae4f53505 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -66,7 +66,7 @@ ext4_online_resize()
>   	$UMOUNT_PROG ${IMG_MNT}
>   
>   	echo "+++ check fs" | tee -a $seqres.full
> -	_check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
> +	_check_dev_fs $LOOP_DEVICE >> $seqres.full 2>&1 || \
>   		_fail "fsck should not fail"
>   	_destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
>   }


