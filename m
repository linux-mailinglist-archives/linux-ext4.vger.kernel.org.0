Return-Path: <linux-ext4+bounces-867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B806D838713
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jan 2024 07:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC17A1C22F6C
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jan 2024 06:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238954E1C3;
	Tue, 23 Jan 2024 06:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbuM46BZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F794E1D1;
	Tue, 23 Jan 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705989986; cv=none; b=os/c2JKZRuwPlhWTvN0dNUJ9PUh4RupSvHpSFrNsJtd6Oz8gi+h8I91QNoR7nnrvubZQexSm+xjbABzAMMIa9j7Nb00X1t+9AD4N93xc1uILRl+i8OJZPdgHwQTHnWb5qdwhxCmhbAPSkcjAVZeOi26t6918iULRCqCEJypcsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705989986; c=relaxed/simple;
	bh=T6sQjSVZoDPqa9QnD1KIBSNd8H86TmcVZKXVVSAGVs4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ogAX21q/xplCxBAeAF9CC870rTz9e0XSjAVybt1reM87MFD3UT4vA6JN3ET/02nw1Pnq5RMY941wmwRXBBdCUAu0zNopQrBnl74Kj2eN8ArIpvcwnVlpUN0/8i+1m21nvffWObGULAJfS7zJ/Qnw89wXSPl4T7/9liHMvOJstjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbuM46BZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-206689895bfso2017844fac.1;
        Mon, 22 Jan 2024 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705989983; x=1706594783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FyasXNOru482cNRTIapaiSgeT6NkIVhvCSkzZTrAFxM=;
        b=jbuM46BZ7qiRDI1Cd5I0Mou4/F0xtY1R2cYwSWuFb3jZP2H6tS4Q5t3/CJHL5qyoSv
         Uf59M9l+nGGi1Xty8FzIqR3tHl/szUIqEVwprL+kkANufKLuGv7WTdEeqA03LhSrnYi1
         70M1Og+4/S+ltijpkUAEwjSG1WYaQxoRk8D+411RuDF2HbkpwpmU7KMgdwnf/ylBxocV
         chCE8GuPKuv2eSVhX0juI2/EXY/jBCxLMxL4fqOwgp9ZequZ7amwK3kBDZBrNVTH9clJ
         GfVfRlPEek5QB07kbp8Olg8cQKOgGNt2CmBKPE5W76/xSmWfpCvO+l5XyziSM9wQvCvS
         tPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705989983; x=1706594783;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyasXNOru482cNRTIapaiSgeT6NkIVhvCSkzZTrAFxM=;
        b=Nsu/An/jkA7Tb4pB6YpflxFyHXFZ++tjtL5MXh782idqhlh27h5KL4CaFe2baO30VN
         9ahCgx4IwchaxOk7VskhPZhyp2bGFwfayXLIeBqfB6iy++Oo3Q8YPsKfhhdHV96xtr2l
         5V07vNKHIIswdjnjVoNBjxc8CKL+7WBIO7FlIK0gG6CmHpyypq6iP5/n1av+fjbksJFA
         dLKixU79NfsBULkDkOKSXOhMfHeuwwjDLjupDiOVzjvCMmg0heEzls9/HmpGRPVMob0U
         Rk64jfDCbYpBmbiATkAZ1ceNEL0UeXmBubhBtr1Oo9jIW3+QSg3qPJ1VYxFVvX8lGQDO
         A7iw==
X-Gm-Message-State: AOJu0YxRhwDz69G6LLRXjkJke5Sk65ARLk67+09sKKIYd6lfngs5dovU
	GrIWwXQ9sS/KpGml6CVDLFPVztaPqzScO4bceq14hlJwcgiOvE+5CKtQo3f7AsQ=
X-Google-Smtp-Source: AGHT+IE4D1JuAkCSQ7Fb326LiGuRPqMBr/ykQ7H891Gii8X/IMt/rqHAe3qD7m1pSz+B2DzUP5bcVw==
X-Received: by 2002:a05:6870:4154:b0:210:e532:af4a with SMTP id r20-20020a056870415400b00210e532af4amr943465oad.119.1705989983048;
        Mon, 22 Jan 2024 22:06:23 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f29:8500:aaa1:59ff:fe2b:a859])
        by smtp.gmail.com with ESMTPSA id j8-20020a63e748000000b005c6e8fa9f24sm9115992pgk.49.2024.01.22.22.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:06:22 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id 5A7E1301E2DA;
	Mon, 22 Jan 2024 21:56:33 -0800 (PST)
Message-ID: <358aaf68-0618-41e6-9adf-04e211eb690e@gmail.com>
Date: Mon, 22 Jan 2024 21:56:28 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
From: Daniel Dawson <danielcdawson@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
Content-Language: en-US
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
In-Reply-To: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 10:15 PM, Daniel Dawson wrote:
> When a file is converted from inline to non-inline, it has stale flags 
> until sync.

> Why is this a problem? Because some code will fail under such a 
> condition, for example, lseek(..., SEEK_HOLE) will result in ENOENT.


Just tested. Still happening on 6.8-rc1.

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


