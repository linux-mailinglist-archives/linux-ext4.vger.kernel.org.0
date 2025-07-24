Return-Path: <linux-ext4+bounces-9176-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3628B109B1
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 13:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 680277B4F1B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jul 2025 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103F2BE630;
	Thu, 24 Jul 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7cjZE5r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDE1F4C83
	for <linux-ext4@vger.kernel.org>; Thu, 24 Jul 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358216; cv=none; b=RGTATUKqFnmk01x+TaCiM4QI88WcFBzvxljMtl+NAR4+dBohVXxOf699/939H1bq/Gm1HK6jlKd0wiKg51A1XNJLLvLP78986fbqusx7oKvABrI3QclmDFIl5KYuOIH7zKLErsLQM+18unjvIvcYGrEv0qG6JShcrlNxd30oBWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358216; c=relaxed/simple;
	bh=7CJZx8+oUmDwS89yEkLE6AqM2TtV8g2SMBNzrHRE+NE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=IWiRbLatO27Vl+JWlmZYl+HQ83fIx/rg2vOlqatEeIvcj2CQuiK5tZYzvlmggKrjBJWn9S8O03ODXxI3Efjlk+Zwp/y6FADl2F6T0v2mTS3qQ/andgQfb70K1ckNv0dgNGGnrxQYC1Au7Lozp9GixlKmDbaW+aHQv3EUZvJZPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7cjZE5r; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso567874b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 24 Jul 2025 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753358214; x=1753963014; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PGBv3N7Ou0fnuAgKeJRKPprtNmSm9Y+4O/ioVAVUik=;
        b=F7cjZE5riW9hnTD5VwJlANAdTBSJC+qScuAX74z04X1OXMV/QLfiFdXIOzhGeehURQ
         yPNQaEEO7e8Y9kGN6agDlhoXk4Lsr2MsGjzk4/zx2vwdfwTW7ylOopkTNi934TuBVrwO
         KujVUldU0vCjlQ9PfZdbtnUanXlcFIBJkch106eiQecm0tPPahV2gz0Go1fB87BwXmXa
         Az5YaTfq5jMQpl+LlzLBJMxkFnlqhSyffAZPWILly9gp381TcCYl27wkZ6Q2sPD/YAg5
         iGfcvzJGQrNeNQwQuoJ85K0FNz3j2KujDBqWaWnzkDpkyYVT0toHtlO1MPTQc9uvyNPC
         4FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358214; x=1753963014;
        h=content-transfer-encoding:subject:from:content-language:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7PGBv3N7Ou0fnuAgKeJRKPprtNmSm9Y+4O/ioVAVUik=;
        b=JfHeeUmcP5V/mEbgPrcQ3nqsbWS3PvmCXlN+18vzBYGQXM/i5ox1+p2TqPkYjAWQKc
         UhjyuDJ9W+gyeDRaLFg5qEWReidmcbynhPa6Hdyk2Ic/1f3JV8mNVCSYGXScSX77Mlws
         34YTeyLNyyNNUKYUAOAq8EtNknBbnDZsMH6XeOqs0hi4bmC593e81cQMWqXqDgUgUrkw
         ty57VMM2PMjbyjkUH/lwFkjHx8WVhQliJDWDYeXMTaNlRk4vD3fT1C8mJ9RTHLVG1qLd
         7Au0iFg79I8GA91TQ7dyqY1UJ82C9usP29RLuDUOIKNonbSzXnpgRIlBpQav2ZCCtIo3
         /Piw==
X-Gm-Message-State: AOJu0YzCXQY4+t35fB6qU49hQRe/tG0pJhmD23pWw6OFbBPsIKaN738x
	F6XJ+CN5NNEGxLVJQUHpCsnfi/WFMzcgHlWfCCsUo1gQLbARpajWh7yBblxGtQ==
X-Gm-Gg: ASbGncvnoQS4FQjBve8wm4qSyN+//5m0h9kguvZ6wQPT4gH7EXYdEiVBVASEL49bZ2+
	z+PA/52f76RYAWMoQc8YilQNqwwEflX7kYNG+jX34N37tORXe7eA7LpExHOs1EnbQ+E4ZbG2De2
	ecyCz8F/mZ3yu4AKGPYtmgzawO4P3unHVFjFqtIjaS+PRfo2Pd8TDUJbbsInbnfcIzEVbKyJl0t
	5QICGYKs4jGseGPQvbzhcAi2uY7OGXLJUlWh8mVfhL2q9+oySr/nRhdPX9rUgkidnd/WxaQtzok
	1Qb0jgFc9q4WFanoHy0Kr5wlfXJkeA6P6sXIKNZEAzjP63FD6Mqvog68pWrnz5bU0rvCG1vkzwD
	xPgN0dvU8E1LOQmLZBlqeuV13
X-Google-Smtp-Source: AGHT+IH6vMEQqC/x0Cl0/8Ma56yKDorHYDb3SjvCuaiBgPZzIRRF5YCapy/lgCKMB2TBzbvayeMabw==
X-Received: by 2002:a05:6a21:7a8b:b0:22f:bba6:5dee with SMTP id adf61e73a8af0-23d49137958mr10571125637.34.1753358214412;
        Thu, 24 Jul 2025 04:56:54 -0700 (PDT)
Received: from [192.168.43.48] ([189.40.75.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c1165basm1246796a12.56.2025.07.24.04.56.52
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:56:53 -0700 (PDT)
Message-ID: <de1f4f53-49b5-4d0e-a20d-f797b72b29be@gmail.com>
Date: Thu, 24 Jul 2025 08:56:49 -0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ext4@vger.kernel.org
Content-Language: en-US
From: Sergio Abreu <dosergio@gmail.com>
Subject: I have one idea to improve ext4 filesystem efficientcy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I am just in love with ext family file system!

I have studied it deeply and now I want to contribute with an idea that 
could be used for next versions from ext4 and ahead

It's a simple thing that is fully compatible with current Ext4 version 
and will improve space efficiency.

I don't really want to write code, just transfer my vision to an already 
envolved and competent programmer that is working on ext4 development.

PS: I have contributed to other free open source projects. My name is 
present in the Greasemonkey Mozilla extension (js expert) and as 
TuxGuitar as translator.

Now I just wanted to share a tech insight that would improve ext4 
efficiency even more.

Best Regards

Sergio Abreu - Brazilian developer since the year 2001



