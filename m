Return-Path: <linux-ext4+bounces-4362-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC279886C7
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A01C22845
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Sep 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5F41487F1;
	Fri, 27 Sep 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiWZqNl/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7E13D53E
	for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 14:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446500; cv=none; b=mK70Tz55JatMkvbKREM7pvD18+BOOfgE/iVLbRklbXnNXsIV0OZYTVJscFdyFhEAFPqr8WPk0aQS09P1CyAaz9Ev8ZFY3TcbfNINdK0dve8XHv5fcFMtyukrC0SdUc5y4F5SI+kQS8VU6D5jFzRGY3IaYDPq00V2DHPKirB0dQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446500; c=relaxed/simple;
	bh=z6l6UqJVlIxyrSLPMV0t2YGZ65osw5mRdjxCX5dDdgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1xBz351w7TKmH0ym8dCN1NcpVsBsmYxssh4oHKtY7pVjJPv9/59csBmEMAAzMoJbErWtw1DMDNfyxYXRRCLFxwRod0P146pWy8z4hzHMDKVk0A5kKQxOdcOGg9XtnbDY2XcLtUbhz69FNt+Ib9Xa0QcAk9mgL66AXK7CQAUyE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiWZqNl/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727446498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuxftadAjWerGEbrKESG5hKgBBRqoRGlsTRV5Tuc8Mw=;
	b=UiWZqNl/6sNXK2Lkl98GBeHnLBO6N8YAjKrxhGZ37cUMDX7h5m/kzHUyldMDwIiesQWU8t
	/GaUPINoirWPaK9Uf+y/7KJNubUiOYrHtz9NmbfWX8smZQdVqABIOd2LjLdCNT50dJtqU8
	yMOrtmA8J1OdLPijc/i8bN//pUENCDw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-iSwm9UlyMKqwwXT-ys5Y7g-1; Fri, 27 Sep 2024 10:14:56 -0400
X-MC-Unique: iSwm9UlyMKqwwXT-ys5Y7g-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so224489439f.3
        for <linux-ext4@vger.kernel.org>; Fri, 27 Sep 2024 07:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446495; x=1728051295;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuxftadAjWerGEbrKESG5hKgBBRqoRGlsTRV5Tuc8Mw=;
        b=Rninlnw41g5EWE7ArrCS9NBUWmdAC0QMAcnITYtOKy40LRb0MkvFOp+lXvJE+qJvYA
         JNZpF+J0DSQuWEtmEgN89jHsBdXJIuSEO3bOv4njL6tBzBYaa+aDFeXU0/bSNnnwhPjP
         sp1mz806kY/q655Y4/fCtz0WU54g+OJRYcHM4csZFoqTdpKgbwlZrQWL7e9jlQEJ1BoA
         Mdl8vizcG30dYpCvfKOYYGFaNv9EjPl/SeRmDpK1AmGAdCBYRTNMVqB6a+u9Sw+oeBNc
         XevI0apbiJ7ZNXvOIW4k6dFwYSN650i6kCI6UeKbWwH7CwynnCbbXaPSTqV+nbPCn80n
         TixQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXeGyRGalJ7gD3V1tL1mn/JUaLN2A9szqpmyDGBF1qx0IbtgPbt0eB4ie+6hs2G3tpvay1Eb4nlMRl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzg83qvyAuz0dWa9wS262JgZLn195TaHQp953Aw+KDy25aaE5G
	Kn34dUOjM59YbtqmSBs0rdv28zv0ZOqgd3qlIQMIPdWMY54zUn9cjeA/PwMKXBxzmsUmOizSwhn
	9N+hGc46FDKVCOB7Srm4W0IMXZhOYeL99Lvbs3S/8baoVaGEaYZ5Vr5P/ZSKIBIPHyeQrQ6lq
X-Received: by 2002:a05:6e02:12c8:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a345169b59mr26012395ab.9.1727446494841;
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9L1s5XILx2Fi8g1dF/McVkrc/4jfVxHJ46gx4GxhnzEkRstMhOJ+Xc6ay0/qaRv9g/z1i8g==
X-Received: by 2002:a05:6e02:12c8:b0:3a0:979d:843 with SMTP id e9e14a558f8ab-3a345169b59mr26012205ab.9.1727446494513;
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
Received: from [10.0.0.71] (67-4-202-127.mpls.qwest.net. [67.4.202.127])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d60530sm6043725ab.18.2024.09.27.07.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 07:14:54 -0700 (PDT)
Message-ID: <fbe9ed47-b3cc-4c51-8d25-f44838327f89@redhat.com>
Date: Fri, 27 Sep 2024 09:14:52 -0500
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ext4: fix off by one issue in alloc_flex_gd()
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 Baokun Li <libaokun1@huawei.com>,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
 stable@vger.kernel.org
References: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240927133329.1015041-1-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/27/24 8:33 AM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 

...

> Delete the problematic plus 1 to fix the issue, and add a WARN_ON_ONCE()
> to prevent the issue from happening again.
> 
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Closes: https://lore.kernel.org/all/20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com/
> Tested-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> Tested-by: Eric Sandeen <sandeen@redhat.com>

The patch has changed a little since I tested, but it still passes my testcase
(as expected, no WARN ON etc) so looks good from that POV, thanks!
-Eric


