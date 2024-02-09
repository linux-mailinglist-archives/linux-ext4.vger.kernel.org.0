Return-Path: <linux-ext4+bounces-1179-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFDF84EE98
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 02:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3249C1C24627
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Feb 2024 01:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5F117F0;
	Fri,  9 Feb 2024 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcip8T3N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B035139B;
	Fri,  9 Feb 2024 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707442268; cv=none; b=rB0Yzq0UHlEhSAZxRnrXRtBv8UYc11+/Q32luqbd1oSljrxG2/kNjL3MhSd04CdijN0FR4/7ykaMDxiBGHIFag8piuTPmZ/VdIZYdudD2IcAtQqJjqeMEoLq/SQ02JZWwaAxL0IYjp7RLopKpGviFaSi5g5aKvCIwU/7Kfk0njA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707442268; c=relaxed/simple;
	bh=p3zlu/E3W/WKsj+cCOGICxFG2/HCzUWAOADyG7V5D2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFc6xfGYheiemV/bwi1ld0swcIBSsvdXpHtz4apLy4mWPRaaJwNK6+EoidJSbanmI5HQFOVI2iSZPzbUL/K3qFOAmbk5DL+eXROpsRgLdIYQbxLlTafmGbHqujN/UYVw+WKTCa13R6ONmPwZvY0wBMnCATpG3ImPLLaeh7tqnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcip8T3N; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d932f6ccfaso3671125ad.1;
        Thu, 08 Feb 2024 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707442266; x=1708047066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bprQbHP0KmzrBT7fI1rF6/ldh7TrnDFkNXc+2P8VLCw=;
        b=kcip8T3NKDVgag9+Qh0WaSg3ndJ6c1/rsN3Xl3uFwUYH26dZVjKJgJp7uToDXc7BiI
         oybwc/yvKnKcEV3pDy5wdogP1U0EkF1l7PEs4HoXBsarpk9/Padfhbt+8YNizJh19mTL
         7V/2MXlHlQyJFPAXNjYvEegoXHGVcGyGBxntUJSKKDEPOQOLBPISgMapirG/6OoNVPG7
         Lvbt/bpNgs1d7Sc9UxPiG1h3SXaU8kqH708w9Ve0SIiyAAV1K1dVjs2O1fMX2P7CGe5e
         G1+3JSVdRNF7L1eoxAyV0LrgaSH/jK93vu/DVZB1FQTzD3zBOLNI6xWAj1CmTBjdsLuB
         DTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707442266; x=1708047066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bprQbHP0KmzrBT7fI1rF6/ldh7TrnDFkNXc+2P8VLCw=;
        b=M/aWTunqaghN7CXKY44vWY4aEn7BbeU97ZKXUPKtYLSWJg6Yj8s5dWgGR4WzbP7pO/
         FNXgRvL/q/1poXEKcC50j+/zFiPXkXDhIlIKJGOb1ZmmXBKWKRdUZnohDvWkHadS21sE
         M4P/ATP8rzVw2acjkPdy2e/zM/9OM4ZgxTNhnu1acHiQhvL/kG9Y+2cEcxcPEO77foCb
         OfYkMf4ggTLMhEIRJVSMUZty1edALpZKBacuY0MjDAeyBTl5pjCSJMoctyk9Lr7l2xdE
         9Y0/J593fXb9hc7mtM7UCkpf4s8mRbfEhQ627Qt+3LxqEbZsDgNAqDPVRVe4XRZRN8BW
         Sc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX77EA2rhzDD57ZYqDi7cL5S4AE8Ho5Jjxzd9jPItmgJ8a13CjfZA67Rkl+yYlqMybK/pohe2vgRPFJ10+/l6zaeL1G/amD374JIPOb
X-Gm-Message-State: AOJu0Yz+9c8T+l32cIThe5wCVxsWJeb7lQmIryFw0aMHjB6o+J808eYz
	CzOBuKyGw2PcIODfdN15Z1kdy5/kHFDtY7YK8pFlBzebbUWP8JfQ
X-Google-Smtp-Source: AGHT+IFuzvdzoSHrzHhl7Qy6zKUrcUUdORSu08QLgYELiPV+a3fAs/ieWAKEGsTt5B/rgQResYphgw==
X-Received: by 2002:a17:903:25d2:b0:1d9:486e:ae47 with SMTP id jc18-20020a17090325d200b001d9486eae47mr107500plb.33.1707442266599;
        Thu, 08 Feb 2024 17:31:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQgGK5lqpAgT7zjqlCqUYUcHDuRix4ZjSqaiaKrW/jyZ4OQhMRLjyWQQVUCrTkjaJA9LPwD1mBywNmq/m3MwfIBAt5/8jaNLq6hXzUdoN7H4suB+umEMPiXuYGpPtmsTsVTVUHz5d0kw+Srs78MowAjNfuHLY=
Received: from ddawson.local ([2602:ae:1f73:8d00:aaa1:59ff:fe2b:a859])
        by smtp.gmail.com with ESMTPSA id d19-20020a170903209300b001d92a58330csm405611plc.145.2024.02.08.17.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:31:06 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id 3E48230C87DF;
	Thu,  8 Feb 2024 17:31:05 -0800 (PST)
Message-ID: <58418b66-8dd1-41ca-90d6-f1dc3176c9be@gmail.com>
Date: Thu, 8 Feb 2024 17:31:00 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ext4: destroy inline data immediately when converting
 to extent
Content-Language: en-US
To: Luis Henriques <lhenriques@suse.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208165808.5494-1-lhenriques@suse.de>
From: Daniel Dawson <danielcdawson@gmail.com>
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
In-Reply-To: <20240208165808.5494-1-lhenriques@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 8:58 AM, Luis Henriques wrote:
> The 'lsattr' command shows that the file has data stored inline.  However,
> that is not correct because writing 192 bytes (3 * 64) has forced the data
> to be un-inlined.  Doing a 'sync' before running the 'lsattr' fixes it.
I know I'm the one who initially reported this, but I suppose there is 
an argument to be made that this in itself is not a bug, as Ted seemed 
to say before. What is a problem, however, is lseek() giving ENOENT when 
the kernel finds file data where it expects to find a block/extent map, 
and I can confirm this patch solves that (tested against 6.8.0-rc3). Not 
sure if it's the best thing to do so by forcing immediate allocation, 
but I feel it's still an improvement.


-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


