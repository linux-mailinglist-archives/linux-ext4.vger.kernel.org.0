Return-Path: <linux-ext4+bounces-13684-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBAWBeO+jWkZ6gAAu9opvQ
	(envelope-from <linux-ext4+bounces-13684-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 12:52:03 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E96E12D2F0
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 12:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 877AA303D895
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Feb 2026 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157235028D;
	Thu, 12 Feb 2026 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhQMjqt9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949F2EFD8F
	for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897113; cv=none; b=WC5Mtsv+sv+0ieTB+xv89/TiEaTmfrWNgNJkozfEeW3vBxq8mwnur0EBRbp+avNp7XIkoCJWEgfTWmgMkZgbWmvWZoysaqp0YXr0DIMAnWo9t3HgX9Hj8nRpFZc7za1W/uu/RyL/V0AJZL4gOLefIgc9Cc2iU9dwMoiSdnyF8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897113; c=relaxed/simple;
	bh=XjSWJvCqXNs6KFHlJCEjDBXFilEFAsp8RQ/y0dAQPl8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fuPAF4BwAbPU531X/BDoHCxe2h7BLvypbSmkkavFipDeVdnwgPndx86DXm1TQLI+UEQhmPS2/8FdWB7neKKi0TLy5AkovyPhcaS1AXzgqR1S2tZf4agprnO/9EN1AZjBHZuSAESzT3SYWn4RDe1PmfB72B8P5jGiyp8EYEuobeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhQMjqt9; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38709888abbso10970841fa.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Feb 2026 03:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770897110; x=1771501910; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icNB5xuvo+j+qezx7gqf5Y6Yw5qJ0+ofGzzhpNwJwdA=;
        b=FhQMjqt90S68QJBXL9jHocY7B1/g5ZRIw4R14Jz+q8ubrflb3FFjMjVVlBxz2Hi0VC
         0dnIBz/gzOseJszrl/f6To9dnq3zIQmBrE2uq6bq0Ovnr3t6Ia26bEm/EL3ZVhgKGiZZ
         wQ//I9DlDaDkl9wDQF/XYTMzSS6V1ph0rqylYdQcs3t19ho+cjMCq+OqV9gLICvEpsZr
         Y06Sm3TKWgqdUHJhAHoRcyfWmegywK32x990iLePGZFvgtE1Fpv0CJZ08tt3/hZBJNDx
         yMjYZXUOv1u0ya1pDSipjc908Q1650HRawkTSMMf6GcDdJb2iLZfYEMQYvDiMb9kVIex
         /d8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770897110; x=1771501910;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icNB5xuvo+j+qezx7gqf5Y6Yw5qJ0+ofGzzhpNwJwdA=;
        b=WmMakjgDPS0RjJGfQ65mnX+XDZxuWGbR5Qo8SpD4bHBLShP8yyIBwWyUqvnGR0YRw9
         SR36r0Jg4D8+qpz/1tLoY2CKI1ISBwA80DEpxMBo3JYM1KUtM8T5Ir2uoqw6x98Ikfp5
         806XzTTZfPOqxSqEwF/AkAF2GdZzJYA3UmZpaeFggHiPd1wnP4zGls/puZf8JaZ5btVO
         fdHw3q85XZZe/XFipjMjfEJXYTGqJusBSoDA9amoNz7sSgS63WYm3sy5cbEMqWMueDBt
         OsDGD6LIzeVwaHC1edtzg6n9vDe/t5drDUEFItQ1iRbBB8Ik2s7nMag+ffGRSoZjBymA
         jqRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoJo6ePU+7iz77UTNibqMin3pMyC60oHKj2Ni8ImJX8yri8e/hf0DS0IZrkaBTlTwoglDC3K4vCac8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzija//2SRtBm6ho9cl6hyyK4O4eY1ApXW/jlekQs0in4A+nRHk
	mG7nYn/1Q5LQjTOSRDXWTJqll0k+aiu3gXO5GidrvIqFI7QGkpckpWPJ
X-Gm-Gg: AZuq6aLWKXxm3t7C9kw59hE1XcyxwciWpF052ivPog/31xA0UfBvH72EVeHmSvP+FxM
	se8eO/D9Chu0JPTLAIm0pBRCG6a5v9kNOpRa5YYZ9k9YBPGQLWbLlXpBIY/pWqfWnButxDHZl3Q
	AAYCAhZaGDwT1az3eP7SiAvO1aDfsmHsBmmJpWSLcr3ydAMIuLLoYZnTASjIrHISeg5I7SvenDF
	3NS0CJ6Y5cfjv2qz2WiXk9bfrvjTzth5zUq7DbLL3tE+KZPenfvJTxjSHZx2Whb7B/1Bw86RGAg
	IdWWiGUHdHZQ4yqAPt4BqQqqcGO1WapLEfoygO2q5gMd8dlKLv6+/XNwDfnBYaZtREDxUB6lJfm
	4Zo5JSO52zGbcXLvaerEsauXiJOq/jAbAiL4X4TrY6iXERmRlSYV/Nh8SQZYSdrZEAWdG8OEwDH
	M1LLIGQWmk/xATl5GQYynOAGqftBFmbOthVmG3cl8pc/RJ
X-Received: by 2002:a05:651c:4193:b0:382:624d:a703 with SMTP id 38308e7fff4ca-38712c1064amr7134971fa.45.1770897109932;
        Thu, 12 Feb 2026 03:51:49 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3870689e107sm7206681fa.14.2026.02.12.03.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 03:51:48 -0800 (PST)
Message-ID: <4b207a36-5789-41d2-ac17-df86d4cde6da@gmail.com>
Date: Thu, 12 Feb 2026 14:51:47 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: viro@zeniv.linux.org.uk, brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Subject: File name is not persisted if opened with O_SYNC and O_TRUNC flags
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-13684-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E96E12D2F0
X-Rspamd-Action: no action

Detailed description
====================

Hello, there seems to be an issue with O_SYNC flag when used together 
with O_TRUNC on various file systems.
Opening a file with O_SYNC (or using fsync(fd)) should persist directory 
entry.
However, if O_SYNC is used together with O_TRUNC the file will be 
missing if system crashes.
According to POSIX this is OK, but most file systems provide stronger 
guarantees (would be actually nice to have a more recent documentation 
on this behavior).
This happens on Btrfs, ext4, XFS, F2FS and likely other file systems.


System info
===========

Linux version 6.19-rc7, also tested on 6.17


How to reproduce
================

```
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
   int status;

   status = creat("file", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("CREAT: %d\n", status);
   close(status);

   status = open("file", O_RDWR | O_TRUNC | O_SYNC);
   printf("OPEN: %d\n", status);
}
// after the crash `file` is missing
```

Steps:
1. Create and mount new file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that file is missing.


