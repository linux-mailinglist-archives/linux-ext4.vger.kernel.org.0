Return-Path: <linux-ext4+bounces-224-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BE17FE0BF
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 21:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D976C1C20FCB
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 20:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B221A0C;
	Wed, 29 Nov 2023 20:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfaWVrHb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEABF;
	Wed, 29 Nov 2023 12:05:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2858ae35246so162375a91.0;
        Wed, 29 Nov 2023 12:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701288353; x=1701893153; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T4KOkUHQByFZ8OKeOPSq83EmagT7oQ/Utwruetc6jzg=;
        b=JfaWVrHbWVQBqztlsgJKHpm2r7EK68HXfuWnRAh0F3K60QvCZLhyzm3ydtKgXMK3M5
         /NvEHJNzvy1M/BuvFj0D+mXmYsSYGU9RtZsYPlZlgbrh+Tn5u0B8RSRGXe7lPgn9lcNt
         wMdJbMCr0KCz8Yp4SIS6h5ZwVnBBZ6ty13mxQ4ZsuCnjFq4D8mnoRzDUjhPefjnQE4/S
         Lqk8QmJslEcdMzZ2WZ/KryBLPiVCo6AZVL3QcQBdDfpBNpoB7bJkKnyE/Imi7roCjW+a
         UjZ9ayiCvUgarcS+jTTaMa+bMtPlhJ8hV94BrN2YL+qIrzW/9y5MHsHYxY1UjCrpX7iM
         ZagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288353; x=1701893153;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4KOkUHQByFZ8OKeOPSq83EmagT7oQ/Utwruetc6jzg=;
        b=Yeecp3VelQl6d4UHignuYSC4st+aqxXeA5uMEe6sCq71KEUIFf6Pb8EsClVIkqfOF8
         mB2LGVpSdFQSWOW9QO4QopGsBC4Uk3y4YkhT+q+v0Dq6sOOXWHtTDwXaObgBSkjABCFJ
         ljWgeyTf3drCi8VpYormu2Y8Quxe3SPNiy+N28SnTj4kNrdtcNwxOcqlSYnp1wLOCNB7
         2VhGmd3uW4kRdzllcOoGXUWp5F6wlgmf5S6YSsjDnpg+OdljvtWwLz6kpgSkm6VrC1Hd
         JuqqpJYrrc0FslrZCQH1VKNwcuxtVsfo6tA3EJqMVeTP52QR8MKxJGfK8tVYdCl5HBgq
         R06w==
X-Gm-Message-State: AOJu0YxBO6Nu05BJyZ3h4riKnZ7+ptrpdsWWwOBhaqIx1U0ysRKHG91b
	d7XnTUytq677kJ4mKOo+QSU=
X-Google-Smtp-Source: AGHT+IE8G+xDGisS3XDTwV1lyxzMjdQnx3CMal/tNg8XEa1KwZ1+fHfQaTVN4lH80ax4CM00oHOs3A==
X-Received: by 2002:a17:90a:1cf:b0:285:9b85:45ee with SMTP id 15-20020a17090a01cf00b002859b8545eemr14531882pjd.3.1701288353648;
        Wed, 29 Nov 2023 12:05:53 -0800 (PST)
Received: from ddawson.local ([174.31.57.58])
        by smtp.gmail.com with ESMTPSA id pg15-20020a17090b1e0f00b002807c61ca2bsm1772905pjb.26.2023.11.29.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:05:53 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id 79B5E2DEAEBE;
	Wed, 29 Nov 2023 12:05:52 -0800 (PST)
Message-ID: <a5877875-5e4c-4098-b9a2-1394691c1b01@gmail.com>
Date: Wed, 29 Nov 2023 12:05:47 -0800
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
 xsDiBEgh6rARBADb6EAQHrgO9HyRizchiOWTqeicOwO8RWNmpc9ZLIhBdO8DIh93Acuc4zAm
 FKeXUNoKR5qBD4hqfDUr6HZgQ4h4TPxzePXQmfkH6YLk/DczvNhTNX7nZbkrRxTq8dYyxnZA
 qxQhTOus4u3C3uZefx/cYgROZ74FlA2ZlvNDc23tWwCgxaMnx0ld+f3L3zfvbBrXtCI9J30E
 AMW75WRBHeHcZM13uxQFRzVHIWiZTiG17bozNgs1Ncqf1/U4P3+GzRJK28WmKI0zJmvzLQhB
 NcHTn1zycDRHzZgu6PvIuho9N6+eAt1xW8qQSEqleQQG5MUpCn5ZnGEFCe60WrrSSrQ/RZEH
 z5Wc4lX13LqyJIspOfeboz02lxpVA/4jtuj1F0oaKoNN5umNGQRzUDQN2js4yyFALVWNMJrv
 7ma/6MthSr5u7RZjVQ/cb+cejKK3VE/tcDoihgp5W16g/UvJXNb8sm5RE+JPdKr64i+1vg8s
 yWibsPfOaidpZnqdB7sQPEHtv6MZa/ALpox87He8uzIgvjGwH75eUC+5gM0nRGFuaWVsIERh
 d3NvbiA8ZGFuaWVsY2Rhd3NvbkBnbWFpbC5jb20+wn4EExECAD4CGwMCHgECF4AFCwkIBwIG
 FQoJCAsCBBYCAwEWIQRbvVCA/rDvfxQvgXPVcreR97RCKgUCYxseswUJOQxsAwAKCRDVcreR
 97RCKuaqAJ9OlZDeENw5aGqL0TAaDHuJ9ASiaACgtlJ7dgpFydG2Sk8Fa1faYkMkJerOw00E
 SCHsJRAQAKCakjg+S4QQ9ZKzKf8y6uPFQ6fsqgO1x6gMfRkMALWQxrh+ox7u2BmcqImTWR3X
 cxh+Dx+Ot4rXXkiVGUEgMxyaDkM9x/c506enKGs2hZpdalsR4t4xknRIa0JC1dK2/U7SJPGk
 75LGPZ63xY0/Gi1WkExgSF/Z+gzuHOaAGQhMSrAYBnQbylajARcLw9G7wwNL/oK1xd3nVM0+
 oHfnRvXqPTw7qnC8T1rSOjYZprCbmcXLLrdzqTb3bSZzb3bxeYIBmN5WlI3+DXfAc+xYDUSs
 tm5aEnR/mPk3I3Loqe+YqPhOBjE4PShFfh2HIXYbk4HOVVW6q4F7eb9pk5VsccwX6e5Wja9S
 nLgJJLimuEWAF4awoljc6hy7ZRDfIyEnPCNHMy4eEyFHP/OQJ01FJSAJXkhNEHA+Kh5pLlrI
 LgvOZEMfZnNrVZfyxzmPcTFEUZVvUMaCtE2M0Myzalzzxi6qrUfdMT9y76IfJkM1W4pJmd3j
 HBGVYBUfRx1XEOFKUc8sEXE91v+xDgDb9TPJ4cFnrKOLUIuj7eTqVMq7A1KNkC1JScdacQ2K
 65sruv32vI83Y2/uWOy4TvLcyRSnUSPmWDUURdc6EezitUwJ7qKrsALp0oxUnas7HOEshfVp
 oD6sMEL7wzVtJZTv4/WC/Ibfb+zgI5TED7Rv2AjESXJ3AAMFD/9RuWJVRHIqpBTnAIOTTyfq
 HZirIXjvsAgVT8NHr1kRmGVmXaZJ0ipeceIVjOcLG1tO/F0b2XrKyb0KhvMvIiQS7rtoqfdz
 dF4T58tHLgE2sYztaWGYvDbxQJU7ozavropanHNbKlNRKH4EByDLR+cqUAcZyNWuYLbypMNS
 4PzfIjDrLF5akuTLu2RivD88jsruq0MTL9JaLseVqDi/f49WlpT2YzTpNN6QaKHt7mizKxGs
 OhDYSPc103aSZ1OOnfTGL8Q3FT9/4wf3tS3tQbqK0Coz0iiSt+5w0UbhVLL184AtAquBkNj0
 5XvSsahydDF+/FYj4249pT+gpMXXolfs/8dOCy9pPMP+gT6YLm3MuXnmi6Uoq+k7aimlAM3k
 9s3Biyr80tVX+B0U1p4fostWdGsNx3P05cXHXTTUTXqFdfI0JvzECWQnMxMmfxAHU3DFMMew
 SbjxZC5az9bL3TbwIZ9+meKMR3Odg/civpU6IWnvjz7CCHUtcpaLe89egOu2zu4ZMJLwJIlm
 FOA3GXDFV0YlEWn201pk5WgTnSMDif8N2N+dCXPYu0DVF6oYDkQaUBAYBQ/RbR9/lYIKxINm
 L5V6q/WVfpkzcQQNWaSWpH/rbUQn+xU5ZW6nU91tlXf++FW3x4JGKzSIC7NXgEee8PJRMZtg
 fQE5qrScpLolxMJmBBgRAgAmAhsMFiEEW71QgP6w738UL4Fz1XK3kfe0QioFAmMbHpEFCTkM
 amwACgkQ1XK3kfe0QirF8QCgnca6Roqero59ZRaMAOtFE1C5u0kAoKhJX6kiMfdLhuEpjadG
 bi1gCpm8
In-Reply-To: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 10:15 PM, Daniel Dawson wrote:
> $ rm -r test-file; dd if=/dev/zero of=test-file bs=64 count=3 
> status=none; lsattr test-file

My apologies. That should be "rm -f" at the start.

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


