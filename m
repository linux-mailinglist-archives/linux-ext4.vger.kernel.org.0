Return-Path: <linux-ext4+bounces-13739-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hp8Bce+lWkfUgIAu9opvQ
	(envelope-from <linux-ext4+bounces-13739-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 14:29:43 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827B6156A6F
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 14:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BA85300E5CD
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Feb 2026 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BBC2FD68B;
	Wed, 18 Feb 2026 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZcyhhGT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08932D8DD9
	for <linux-ext4@vger.kernel.org>; Wed, 18 Feb 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771421376; cv=none; b=cmRjvMRP3WIZhg4zshEIcy3JdwvZplx+Xq+7FQzw07aUN+PCmMEe8asp+tbmTWBkK5G5cMaia9D1p/6Wzfb0KA3kA7X8yhRbmXM5mezQ7epoHFgvkmZZrnj4adqTRPvvLKA/rupo3T3+maRrXHYAbx0zBL1OMrvcNVPr7aUMktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771421376; c=relaxed/simple;
	bh=0PkuZoUk+Tc3pZq5oW4s6ngtVAHdr+f9SP6oIha8QwY=;
	h=Message-ID:Date:MIME-Version:From:Cc:Subject:To:Content-Type; b=N0i9aR33Fwnkv0lyyB5mvDWC+N4GRLGpqQhyWe+UftaT0UVojY/FPBjFu4QqMHdUZM6EoqS63tr2KeDaexDEviBAPJGYPqxHqF4xVCb/gVWAK10Itr3FsLPK324CTsGfKRG2Tly8pwMqm4vn/TTPDMdKHChcs571hNSFntjWNs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZcyhhGT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48372efa020so39384615e9.2
        for <linux-ext4@vger.kernel.org>; Wed, 18 Feb 2026 05:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771421373; x=1772026173; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:cc:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBIoPuTMi/6ruSqVzRLcP1R/zZrBDdqVk2s3C2l9HiI=;
        b=aZcyhhGTObSeaUtCg1TFn9VgsnmJvgaBannKgaoVl5NTCuwYg07UeSwcFO9yBnpRai
         ynoLV1g5Mtv9TLcZ92FMLP5VRS6mvM/x5Ln5zQDft7TvXCILcqC7t9lPmk56Rl2l1eFy
         fOkRpqpod37WgoH/evdEtRu/hb1bIeRmc6f6W9ZyRheIUfX8AeEwsEGFSKy7RUy2bgyM
         Mg28sC4IpKhXYAQtPg5kZpCV+5GJZRn556di4VuPk9IRQ7oj1xTecRJSTF361qlOCjMz
         /5Zcw0kJ3etLH+u2GY5QUAR7/mCe72KbqBoWH6ei2H2f0FAHwyv+UQEdaaQ72LzVPImQ
         i/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771421373; x=1772026173;
        h=content-transfer-encoding:to:subject:cc:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBIoPuTMi/6ruSqVzRLcP1R/zZrBDdqVk2s3C2l9HiI=;
        b=Xzub1ogX6gSbhuBYLHn4GNLffFSnEnnAKhcdQTTOwwy/KoHVzNmAA+4Ks/rJ1leiGs
         Ae+/bJISM89M2RJIdD3InXRGtoTFhai8CjUEVXb6rmblE1HYtSRXjw1L8+5J99XTFcrQ
         EfzM59lgYCVevque+RP3ZPU0WMePkBMQUnU7EzasrkMuqScRzGbkHiNkha9ET0uyzNdr
         7++Ya/Ricb8spc2I/Zj5gjHv6QVxT9TZhR07rOifRFGc0nEuXsqbagF0nWPD3/XcXn76
         qa2SQJavR67Wk+xI/aGkkdEZVdkC5SLezf/cO/D7x2nGKJAuTeQWgO/Ly0J5iTFG09Gk
         VOfg==
X-Gm-Message-State: AOJu0YwsqSt7pL/JBcoS5968teq/5KEYLpo1MaPwjL59fUozYJ5lC6p/
	XDPZSSxGZYO4O9K+fCFaxiMBQR9TDhYtD4kdydwfyBOIrpZjnV9udSmC
X-Gm-Gg: AZuq6aK/mqx9EP3JpRQHl4rRYCT70KMn9o7LXmYIWjvU5cVEvq9NsJEHrCA+5IkTzcx
	1Gk/lFWF9xRZV0LMIMAKPSP0WSKwEpGa43mwEp6QGQp6zDJn/0g1wlt/O+SQfcjGn6ATlef6Cp7
	TF8gmqtZ/pKe2CzaHoJ7VVNi6fRh3Bb1fj8DBZrV6/5cbJ4poJPikJPctSmLJW8mpWBpMWMIdX8
	zSQss8Xfw28rXc2vrzE1GwRELSUoKSZwkTFB3LEBn4i7E/RdwpO38Ler6BVlYlDSNFyhwbsZwpy
	xc1SAtJnN47uGl4874+6915UmfQQtj5hf2ClNUgQoDAwEU4GSDzdon9WTTzE4eHh/qb2aVey2HH
	iE05yL1x9PES2j6HGJZN86ESl72kPYBWykZXRoDoMQa3s3o9S7MPhVUjOUu3bkAZZcfTsj0m3aF
	Hk53sOE6KteYhKpex3mMfns6WoNA00XzREQxpo9/ZUzomy
X-Received: by 2002:a05:600c:609a:b0:483:7020:864 with SMTP id 5b1f17b1804b1-48379c178eamr258480935e9.25.1771421372830;
        Wed, 18 Feb 2026 05:29:32 -0800 (PST)
Received: from [10.128.170.182] ([77.234.210.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837e565f5esm419668495e9.10.2026.02.18.05.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 05:29:32 -0800 (PST)
Message-ID: <3d8f73f4-3a64-4a86-8fc9-d910d4fa3be1@gmail.com>
Date: Wed, 18 Feb 2026 16:29:30 +0300
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Writing more than 4096 bytes with O_SYNC flag does not persist all
 previously written data if system crashes
To: tytso@mit.edu, adilger.kernel@dilger.ca
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13739-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slavakovalevskiy2014@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,man7.org:url]
X-Rspamd-Queue-Id: 827B6156A6F
X-Rspamd-Action: no action

Detailed description
====================

Hello, there seems to be an issue with ext4 crash behavior:

1. Create and sync a new file.
2. Open the file and write some data (must be more than 4096 bytes).
3. Close the file.
4. Open the file with O_SYNC flag and write some data.

After system crash the file will have the wrong size and some previously 
written data will be lost.

According to Linux manual 
<https://man7.org/linux/man-pages/man2/open.2.html> O_SYNC can replaced 
with fsync() call after each write operation:

```
By the time write(2) (or similar) returns, the output data
and associated file metadata have been transferred to the
underlying hardware (i.e., as though each write(2) was
followed by a call to fsync(2)).
```

In this case it is not true, using O_SYNC does not persist the data like 
fsync() does (see test below).


System info
===========

Linux version 6.19.2


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

#define BUFFER_LEN 5000 // should be at least ~ 4096+1

int main() {
   int status;
   int file_fd0;
   int file_fd1;
   int file_fd2;

   char buffer[BUFFER_LEN + 1] = {};
   for (int i = 0; i <= BUFFER_LEN; ++i) {
     buffer[i] = (char)i;
   }

   status = creat("file", S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH);
   printf("CREAT: %d\n", status);
   file_fd0 = status;

   status = close(file_fd0);
   printf("CLOSE: %d\n", status);

   sync();

   status = open("file", O_WRONLY);
   printf("OPEN: %d\n", status);
   file_fd1 = status;

   status = write(file_fd1, buffer, BUFFER_LEN);
   printf("WRITE: %d\n", status);

   status = close(file_fd1);
   printf("CLOSE: %d\n", status);

   status = open("file", O_WRONLY | O_SYNC);
   printf("OPEN: %d\n", status);
   file_fd2 = status;

   status = write(file_fd2, "Test data!", 10);
   printf("WRITE: %d\n", status);

   status = close(file_fd2);
   printf("CLOSE: %d\n", status);
}
// after crash file size is 4096 instead of 5000
```

Output:

```
CREAT: 3
CLOSE: 0
OPEN: 3
WRITE: 5000
CLOSE: 0
OPEN: 3
WRITE: 10
CLOSE: 0
```

File content after crash:

```
$ xxd file
00000000: 5465 7374 2064 6174 6121 0a0b 0c0d 0e0f  Test data!......
00000010: 1011 1213 1415 1617 1819 1a1b 1c1d 1e1f ................
00000020: 2021 2223 2425 2627 2829 2a2b 2c2d 2e2f  !"#$%&'()*+,-./

.........

00000ff0: f0f1 f2f3 f4f5 f6f7 f8f9 fafb fcfd feff ................
```

Steps:

1. Create and mount new ext4 file system in default configuration.
2. Change directory to root of the file system and run the compiled test.
3. Cause hard system crash (e.g. QEMU `system_reset` command).
4. Remount file system after crash.
5. Observe that file size is 4096 instead of 5000.

Notes:

- This also seems to affect XFS in the same way.


