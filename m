Return-Path: <linux-ext4+bounces-575-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A281F647
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Dec 2023 10:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B564E283890
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Dec 2023 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1E863CD;
	Thu, 28 Dec 2023 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE3WZoif"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1B63A8;
	Thu, 28 Dec 2023 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c7c422ad3so1089239a91.3;
        Thu, 28 Dec 2023 01:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703755751; x=1704360551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A3Ig0aHapiIQwgj1PxxKUjtSncjMhZol6viXCrEfEek=;
        b=XE3WZoifSPRSa08i6PXZxXCZW2jbxRD24ZAdgxD70Mh2WJtbmia8tFvc5JukXd7zMw
         XmSo0OqGM9YlLEJHTJo4Ihm8u31Ikv3HyR33U5PGDy1XiGBxOJgTZZYEqf8FifASu3lz
         nbl3nnY3Zu5clxqn3h1IfkXVn75OpDCfVqy160iZsFQUN7rdKCDGGpbXDgHYMW51/OpW
         lNg8fGFysgoGYf8wuRg2s+CcvK542aJgSxR31nTncTAq1Lx61+OIF3dtG01aHvQtNnTj
         RoiIfTs5NmjKvHaGyJP1tk2VDGr8+ZjUzD9fTV3sdiyVUxSpJsNphMrCTG2H+Xskb6GK
         Uoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703755751; x=1704360551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3Ig0aHapiIQwgj1PxxKUjtSncjMhZol6viXCrEfEek=;
        b=jtuRfvX7Qg78uUpgRU2tXwY6jXW1rBNKXRM+kal3FkpMPgM+6ZRsh3yk6kf8Z1bAy6
         v2CKl3Ydeip7J9ABiWIk8ywitz07NpsWd7L9tmePgG0lh1hqKYU0Z6TfqCaOpbZiXWff
         iKfBnGUf5XHrDRm0Q/4XnF/l7G7DcRTA+kaEnPYRGKqIx1SnEAGWGZBM/GnBOOMe0YX6
         vxHLMfTZHJOkxMAD9Zxcv+oHO7juSfazLL5BYw6HZzkbQ/kJpGKJmq1XZMvwYuktDDM6
         kgItj47lK4rbNlaT85ZSW+XoCdPpoawaZWuL1iEZ/ULjd9rPjFTwxBw7pC99trv9jegw
         +aXQ==
X-Gm-Message-State: AOJu0YyW3fuuSC+q5TSa4/8YnKlJ9ioC5r9RB4miXETQzx+ZpozMP0QT
	dFg9vnh0WRbASmtjZOn4APykUBN0evAvnQ==
X-Google-Smtp-Source: AGHT+IF/bKRPI+W2d1VRvmjycdc+I4rdVZDuWOFW2kkcZ7NdY5Mse25vgnUI1S11jVtB7wCzFxO2ig==
X-Received: by 2002:a17:90b:3785:b0:28c:3db:44c8 with SMTP id mz5-20020a17090b378500b0028c03db44c8mr2997270pjb.95.1703755751257;
        Thu, 28 Dec 2023 01:29:11 -0800 (PST)
Received: from ddawson.local ([174.31.117.194])
        by smtp.gmail.com with ESMTPSA id k62-20020a17090a4cc400b0028c72951de9sm6307047pjh.20.2023.12.28.01.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 01:29:10 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id A1AE52F36DA8;
	Thu, 28 Dec 2023 01:29:09 -0800 (PST)
Message-ID: <3341f8e6-5aab-4454-a1c6-805abf868b44@gmail.com>
Date: Thu, 28 Dec 2023 01:29:04 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
 <20231130040651.GC510020@mit.edu>
Content-Language: en-US
From: Daniel Dawson <danielcdawson@gmail.com>
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
In-Reply-To: <20231130040651.GC510020@mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/29/23 8:06 PM, Theodore Ts'o wrote:
> I'll need to turn this into an actual patch and then create a test to
> validate the patch but I'm pretty sure this should deal with the
> problem you've come across.
Is there anything new on this (apologies if I managed to miss it)? Let 
me know if there's anything I might do to help, like maybe testing.

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


