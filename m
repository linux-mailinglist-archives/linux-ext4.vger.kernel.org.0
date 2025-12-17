Return-Path: <linux-ext4+bounces-12387-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FE9CC8FB2
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 18:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A7783016350
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D68833ADB1;
	Wed, 17 Dec 2025 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ91WYlr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D675338595
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990795; cv=none; b=L53s/apmxFer6HRtzuIYMTA1J1E5BcHvjoniHZ8ZlBHU7YatiFqI549xZQXjmQE5ONqfm1i2UUHGtFauwkICb6M11e1ExoVgJxHYtfhds8egwXbxadQtKhrIqJl8+huhoRNq1wmu/cdZEbxcrbV3GpG+9/uyDOJyQgjCeij4NcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990795; c=relaxed/simple;
	bh=4nT3eL+nqqlKXmzFJdFVnTOdEBe7d+tIOLCTKsUwt94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npF6bpHapjhDmwq5EJTJpbqvWqxDvqBvBxOSMzC6fa0kZsXoUHjTACgxt9H9vaXBJ5JwMNVtsxUjKV/JW63fkP5R4sC6B6Y5Y9whIAMFwBJO2V4Ia8canSr+0a8UhOBuQ3iykAMHzr4p21ebngjwSmiBJI+SG7GvjRGyJpPILK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ91WYlr; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29f2676bb21so67712495ad.0
        for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765990793; x=1766595593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0JZV4ZTKPnvVOohyqVtnOMKthFN4WCJ75pI/pYQsXF0=;
        b=FQ91WYlrlb3ZNT2Y346nixu0QlqkDboGLvyhaNMUZ8dYVjcO+eA9CSsnPouB3awBFI
         ih/Emu3ORhfKb4Cz9185hKIKT37ySgTcqzLRxCZae46WcNukaR3PiuBY1mBY7HUSTMpz
         wJ669cQUKh5aNIyMPniNwaGCfGkX0hrb2tfRbAlP6w/YlfzWSX0vJtkxntBSTQq2btbL
         XNcLtBIvRujfs81wv2VRkZAIlaNHy5rV6yO5Kw/057FRH1rojLIoVgHNYvnmn1V7gRxh
         fZQppAAVFmtHGmhm563AhC7Wuj/cgutgNiYvdSg3B4T6j4o2pH8rJ3jSs0RJszSjcb45
         DryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765990793; x=1766595593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JZV4ZTKPnvVOohyqVtnOMKthFN4WCJ75pI/pYQsXF0=;
        b=QaVHDgV38z+PC31g5ln8N3R3fca7hK2948+h6bvJEFl878bkRByZwFP2CNoe4VONea
         I6O1D1CtYjUC01VJMngq6siLIHcuV47Jonfl6marWvSHrOwie0tUDyxts3WGBTtRYK+H
         hhsYe7m6bzr+UDg4S0ilddmnvFGklnTV2I3H75oAzygVs0aEaDuMFSmeR1Gf/VtKybSb
         2/sgE2iitYhm408d+yrXwV1Egqc1PnP7+RMk+AO77eKIlGYcH83KBa0GK9WOOh14/od9
         0B/MaZ6+MK9xAJT+/Gn68HJIQxfzNFMoDDBIuh4kYZ84EVdFWE/BkagRbsAtb8DBwrE6
         LI2g==
X-Forwarded-Encrypted: i=1; AJvYcCVDhpbzzXtWbuqLzzCrmDEl8weAOf5R7ZTZCWTl8QmNSAIDa6HefN9yQQJ2M0DhbK46+5MfzwPgXrUS@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+qRlJimy8m1WT0Q+RkIF5VbVdQLygDQahhmuwGhWAWPoRvX6
	iwjO5Uy7Tdio9sbhH8a0l8RF+MhdTuHBsqk9GiNFRltc2vLP9vxMq7ru
X-Gm-Gg: AY/fxX5lo6Wf+ZMH8tA7vlV822wkZE947yWBt46F/RztJ7G697MagoiNPDp1+eL1bxs
	nS3+M2PN/yLJPyA4Ws0Em8VbB6TDNiaXD4751qIO7jOWUN3jdXydtHFKvZwDcvz/X6WNnyAWw5p
	JJ4VSB0OvbyBzoUxF8A3Ayr8MAj7AmYKNWqqcBgu7bkKtnTHCtUyvEsj4u8H9K59xS5n3KBVdcx
	NUtvmsir/fEaj78qTAHRrSf2NB8RGZR/pPj/oviLIXUvclV+pDKDROJenOsyA8JZm+tT+8TYPTM
	tphauKbfFyZqpYn3WMDmaIbx2RhIA0fsJYP+KvvgKgObITvhbY1/rM/0hGRmO8Kvj3xfzr2WB78
	oTjnlmCVbYjdGpxK0jj/MlqFdhJsrm9R3tVWNbomh1ua+ViFrSyQ1bd0i6kHQrHg8fUStuHBm20
	Otev5LAhb+gWPpHzc=
X-Google-Smtp-Source: AGHT+IFoKMbJ9xsJocF+/SOztzH9OTtMgNQkpOw51+pBJHLXYHTp4rBAb77rmGPybXMBIEZgWFijkA==
X-Received: by 2002:a17:903:458d:b0:29f:135c:5f25 with SMTP id d9443c01a7336-29f23de670cmr175716925ad.4.1765990793498;
        Wed, 17 Dec 2025 08:59:53 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2ccdc62f6sm107615ad.29.2025.12.17.08.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 08:59:53 -0800 (PST)
Message-ID: <62945fac-eab8-4e42-8f3b-dfdee66a1b15@gmail.com>
Date: Thu, 18 Dec 2025 00:59:50 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] dmflakey: override SCRATCH_DEV in _init_flakey
To: Christoph Hellwig <hch@lst.de>, Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>, Filipe Manana <fdmanana@suse.com>,
 "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20251212082210.23401-1-hch@lst.de>
 <20251212082210.23401-2-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251212082210.23401-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


 > where to create the custome dm table.

typo
s/custome/custom/


>   _cleanup_flakey()
>   {
>   	# If dmsetup load fails then we need to make sure to do resume here
>   	# otherwise the umount will hang
>   	test -n "$NON_FLAKEY_LOGDEV" && $DMSETUP_PROG resume $FLAKEY_LOGNAME &> /dev/null
>   	test -n "$NON_FLAKEY_RTDEV" && $DMSETUP_PROG resume $FLAKEY_RTNAME &> /dev/null


> -	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
> +	test -n "$NON_FLAKEY_DEV" && $DMSETUP_PROG resume flakey-test > /dev/null 2>&1

flakey-test target? Appears to be a typo for $FLAKEY_NAME;
I'll send a separate patch fixing the existing bug.

The rest looks good.

Reviewed-by: Anand Jain <asj@kernel.org>

Thanks.

