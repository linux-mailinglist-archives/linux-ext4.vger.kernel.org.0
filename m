Return-Path: <linux-ext4+bounces-216-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F400C7FCEE9
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 07:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0D1C21061
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Nov 2023 06:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425DDF40;
	Wed, 29 Nov 2023 06:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVCa89LV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707D91;
	Tue, 28 Nov 2023 22:15:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cfb30ce241so35466265ad.0;
        Tue, 28 Nov 2023 22:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701238516; x=1701843316; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Lq3C9nO6f+qHHUUwVu7uF7KiTmCoSI/+iHTACKV7B8=;
        b=QVCa89LVtZPDaeDxdA6BEcV1WIkPQBN3cTtbb6VXD/oQ9TL0jJ3Anc4bxjMc9ZHMTo
         NvD841Nxuwqb92A6yA2VjAeFgjwCigRbOpxXQC4mgNzGavhwMfLzXqXKGlB4UbYhr0LW
         uLmIK2fOZZw9bawPKBvtqeyK0V6JBOqyi8evC2WJdbPSwnxErr+9/xA18CrXf2okcU56
         LXWP10jojz4t8BFUI5wJ3C+mDQgEqyh3r4shV0c7PeZki3meG3wSYnLNS+fy/GZJ51Sv
         zkfecUDz0+ifJbqDCprCmz5QeMatU8G9yMVkRcn5B/IJQwNpBWg5YXo9aLGhenGg9xXq
         kKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701238516; x=1701843316;
        h=content-transfer-encoding:subject:cc:autocrypt:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Lq3C9nO6f+qHHUUwVu7uF7KiTmCoSI/+iHTACKV7B8=;
        b=PG+qEo77BVcTHfYpMAj+cfI4C5gNUXoD4owlSlwTyY6TBWLVAMDGJpjss29Yw/hLPr
         +ilgKtHaXkXxF6g4i/SJfaht1yanx7fz6XcKwr2aUVUv3m/9m38Y95v5JUHsxI01EqUk
         WgErFFeI/pBz6kluSEpDfnjMfbgAFTMIws+Uk9SggPUP3oBwvg0iDBRcTXQsokaBVVKC
         QcnJcW3oesBLL5BpsdatyBVBk1cDS8/y+UMiVuAGVkhef1PiEUKv1baNVvIAuELnLx6r
         G3ItoUW0wWkYWQYzErL0ttM3Wh2wR8Si62ymJrX+kkWa9YU1woaeFh63+0P/YkX017nn
         LkKg==
X-Gm-Message-State: AOJu0YzKTG2lNra3MxV6/L7JyhZtYm9lUVB4T9/c+7LpAApyK3MfnrER
	lfdvH9ean11LvvTdNkjr1Uo=
X-Google-Smtp-Source: AGHT+IHFC0P6rO5vt6pfO33KskR0/fz+/sj25EV6y3XMdURzuiUbP3gvsspRFN0koZY+hVTD+aPLpA==
X-Received: by 2002:a17:902:c405:b0:1cf:a70f:3a2d with SMTP id k5-20020a170902c40500b001cfa70f3a2dmr21668110plk.63.1701238515990;
        Tue, 28 Nov 2023 22:15:15 -0800 (PST)
Received: from ddawson.local ([2602:ae:1f39:3a00:aaa1:59ff:fe2b:a859])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ea9100b001c5fd2a28d3sm11345526plb.28.2023.11.28.22.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 22:15:15 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id D5F272DEA0B8;
	Tue, 28 Nov 2023 22:15:14 -0800 (PST)
Message-ID: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
Date: Tue, 28 Nov 2023 22:15:09 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
From: Daniel Dawson <danielcdawson@gmail.com>
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

When a file is converted from inline to non-inline, it has stale flags 
until sync.

If a file with inline data is written to such that it must become 
non-inline, it temporarily appears to have the inline data flag and not 
(if applicable) the extent flag. This is corrected on sync, but can 
cause problems in certain situations.

Details:

All that is needed to show this behavior is the following command:

$ rm -r test-file; dd if=/dev/zero of=test-file bs=64 count=3 
status=none; lsattr test-file

Assuming extents are in use, this should show

--------------e------- test-file

but instead shows

------------------N--- test-file

until test-file is synced. Despite this, the file is already non-inline 
and is treated as such for most purposes.

Why is this a problem? Because some code will fail under such a 
condition, for example, lseek(..., SEEK_HOLE) will result in ENOENT. I 
ran into this with Gentoo's Portage, which uses the call to handle 
sparse files when copying. Sometimes, an ebuild creates a temporary file 
that is quickly copied, and apparently the temporary is written in small 
increments, triggering this.

Here is a small program that reproduces the SEEK_HOLE problem (pass it 
the pathname of a file to create):
https://gist.github.com/ddawson/22cfd4cac32916f6f1dcc86f90eed21a

Tested with kernel: 6.7.0-rc3 (also 6.6 series)
/proc/version: Linux version 6.7.0-rc3 (ddawson@ddawson.local) (gcc 
(Gentoo 13.2.1_p20231014 p8) 13.2.1 20231014, GNU ld (Gentoo 2.41 p2) 
2.41.0) #4 SMP PREEMPT_DYNAMIC Tue Nov 28 20:09:05 PST 2023
Operating System: Gentoo Linux
uname -mi: x86_64 GenuineIntel
.config: https://gist.github.com/ddawson/2f2e60c6e44a62047d7b7d99c7ce5632
dmesg output: 
https://gist.github.com/ddawson/026ea63f099ee3e0c301f522dff00764

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


