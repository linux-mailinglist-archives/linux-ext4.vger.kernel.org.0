Return-Path: <linux-ext4+bounces-12441-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B289CCDAEA
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 22:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32213014602
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD94030F816;
	Thu, 18 Dec 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpjYr05S"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658D2D4B66
	for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093265; cv=none; b=SBA2AoclRlIb++dcyw1ASxfdM2J1Fc/GU2scnPG8UYmFOi+RvjxrGuLIG4C7qWrlNZPmzcY0lMYFItlz1DdgIHUFy4KQQA4uhizVEfYYHkB5QvQF29nkV1U7wXedpKg4qNplgvjzN2QJtyAx4L8/GP0hCf+sseZvEcqIIaoh3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093265; c=relaxed/simple;
	bh=ssp6MgaMGnnKdoqFisDTFr9/zz2YnKqd/trrmdIJETQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dt2F9xKTH+Gy/iu/yQ2gweJtEucOIJQMyrFKANqqmKV+9d+zTSSUy0wprPPxOWda+wxp1xrSlKvz6jWAaTNuidBjC7qvBkU8qtvCMkWqylshCNrhXM4wGinasgXlKEW43gIv+PZluWSI1JcGl9WT4iVNtBS9ZEhr0UWzJ/qCOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpjYr05S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0a33d0585so10797755ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Dec 2025 13:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766093263; x=1766698063; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtKlcFT+8oac25TBdlE/6dhf/oQjmi8HEpnZr0zN7f8=;
        b=IpjYr05Sawiov8nyEBLLYIFxseaYcVcYw+kEAWNIRNBYXQnNs2xxUCG1Zr77hbk3uo
         mjbufBIrqT+dofy0t21RZAZJQSgXAxZbc7pgBx0kujOEHJKWkUARgbiPgFAcbtsYgmHR
         zfVGJaOcfMspIN9CY3ZayoO355IXWKcEQKzpY1I4R6CRwijqXR5WlY1CiJ2LGTYE6Q8G
         8HM0AMK6fygecu/1nw3jcCC9qWz5mJNJPlFhxNcGwi9sj2E3YMiFFCFCA8D8RhUXuaH8
         +FdtY3Xa1BkY/slmg/dtUKYydgIvtfJD3CEm86PjtTNWVR6O/wX/sgchkBdTMCluEIQx
         Xm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766093263; x=1766698063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtKlcFT+8oac25TBdlE/6dhf/oQjmi8HEpnZr0zN7f8=;
        b=paLUI+dOUaWjjSovyGDUzcNRTEjVPUYiUM5K3D+6V02m5F8R5vrGUIBX+/6jNNCzxR
         hn5R79GguvApn6GVwMLCvzpgLXyy0e3bm7ZOjEWKj+GR7cxQW9fbq46Q7WQ7XV6yP22U
         uBTdLyoZgZTMtYRPTWAYk3BLWublpjFUnz24jTBfJutVumRZ+cv5d3afxJpYfTfgAnpD
         BeBwcpf9i6aL5Q6ZIWhSi+sut1XnMYQ5uGqYLpwAK51u0yTJLSx9TerXQ2zzGPdL6jfC
         KgUaKzi/rpcZhum77+GRSw8Clmlja6HZCpkL4v3wSSCxgvgd6PXLQ+3c26knGCv1m8ga
         yaow==
X-Forwarded-Encrypted: i=1; AJvYcCWPIYXUBnIY8gZDq8zMquhddnR2yMtCkaYzQMsdPWqo/aqKgKXzQEa3XvKGPzq4GOgFHsI5Ht4DPuS5@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2Db+iCt7U9ebOLeFbxI4RXSOSs3/usmjSjoNNDw2w1qv2zmb
	u9x44N1lD3ZK7rScswoh7GJwSEE8fiHwA7WJTjRdah4uIPdCiBQ+Dw+D
X-Gm-Gg: AY/fxX611PJak4W/oGKSmSdO6QAJ2dQFQjp6LaYS3/hy3GtaFKBF671DDCXnIMForKz
	oqSj3FjXRQf26UCebi3E9loeQqwLhci9ucPGItsPAbSm7n0XYP8Sc+eHRlgwc1x6lrCR0tu+ZXW
	zhWMfsRV9fPWux5Axc1Mz0eIHBGMUD37YMe6d6S6jgUMijSpJ4kzQMWAkGEXNbFRcNnWQbv9vH3
	TVq1lXFEAs226OJvKHjOTlm5qFJJXnf/PMpqFC7popMXDQWu9KbCEdDouvUKEMKtHrL5PZ42fcP
	FCVt7a9RFIcain0DSENW1uHX1qIuRQLRivD6XnP3F29RtcC8T93Ufoi37CIkyJnfGaA/Y9Hkcg9
	34P//89ij8Dufu1FRE2hkPg/vC9tD4x2jwyKM19eJEwqPIHdvaVSn7j7zxHa89GZt9eJTrRP7uh
	HXuhcf/FUwtkSKM5Y=
X-Google-Smtp-Source: AGHT+IFy7ceREQxfkIyUxi+oyD4JXaH5EBPvU1D27q3jSDSQbKE1yT3afkwTKTiOeRnMobUoeH8j8g==
X-Received: by 2002:a17:903:2ac5:b0:2a1:3ee7:cc7a with SMTP id d9443c01a7336-2a2f2223616mr6333525ad.17.1766093263501;
        Thu, 18 Dec 2025 13:27:43 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d76ce3sm2079125ad.90.2025.12.18.13.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 13:27:43 -0800 (PST)
Message-ID: <3286164e-71b5-4111-8c63-c6f9856a9dd7@gmail.com>
Date: Fri, 19 Dec 2025 05:27:40 +0800
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
References: <20251218073023.1547648-1-hch@lst.de>
 <20251218073023.1547648-2-hch@lst.de>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251218073023.1547648-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/12/25 15:29, Christoph Hellwig wrote:
> _init_flakey already overrides SCRATCH_LOGDEV and SCRATCH_RTDEV so that
> the XFS-specific helpers work fine with external devices.  Do the same
> for SCRATCH_DEV itself, so that _scratch_mount and _scratch_unmount just
> work, and so that _check_scratch_fs does not need to override the main
> device.
> 
> This requires some small adjustments in how generic/741 checks that
> mounting the underlying device fails, but the new version actually is
> simpler than the old one, and in xfs/438 where we need to be careful
> where to create the custom dm table.
> 

Reviewed-by: Anand Jain <asj@kernel.org>

> Signed-off-by: Christoph Hellwig <hch@lst.de>

