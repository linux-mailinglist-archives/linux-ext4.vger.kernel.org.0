Return-Path: <linux-ext4+bounces-573-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CF881DED8
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Dec 2023 08:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B485FB20386
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Dec 2023 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5111846;
	Mon, 25 Dec 2023 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7KG5XDF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E715A8;
	Mon, 25 Dec 2023 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so181548639f.3;
        Sun, 24 Dec 2023 23:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703489952; x=1704094752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12sjrmI3H61gkwYKi3JuoV0MUNI9GNrztsWPVByfSok=;
        b=U7KG5XDFcEIa3vEgLPBiPqCz+7GSRTH1SZPLT+GfPZO6penls8ZSdcfDqRmAXbKk3N
         cocR3/bxnK2LX95jTd6UkzmOBHbKLjBSzb3M8cpULbwTzMW2Str3hoI9B7dyGq1kK5xU
         /babYjzL4FOkTq5P3uvfk/zNA4Hkg1HQIcplAxkZYfYAgNZgLsae8ZEoF0BfZGCI1UHZ
         93V7MlJhgtMzQQgeSaTGPav6fq4R7AAZgJ5JqBd1Z3PoGcOI4f1uCpPHQ/iCNWNw0L/v
         en9wLUyFHDzzoq0YHrUrL4NXtlyA4xn7cCKZTPxKL6KacaLWGj+9IY8rIsdeFMKPQKvi
         ESGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703489952; x=1704094752;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12sjrmI3H61gkwYKi3JuoV0MUNI9GNrztsWPVByfSok=;
        b=sq/awKbQgw23tvMQLRBeyp0eVpFO3px6cBeyyxzmAjvKK3E2oixTnvEpOkEQrI6Qia
         twhS9mdGqCKBM2AZBkACbTBCzTE+04FL3mxxXOigHjNYokUvjGesnq+kqwUbl8pJ8gZ9
         en9Ebc0MHyxBpFoYWccTk7ZEAXXOIBnZ7ITgetBSR71zugYHJ5UW/RbeVTl54R7PQ7+d
         a/fc46xhwCTQkZIP71TezowqmDFSB0OIotKHYT6I1Hk6vTGm3BswunkNZc/fq5tum4+m
         riFFts0HYixzMRyzEbdg94VbD3TbsoH9oeCy6ZF84ZcZ/JQUn4bXB6tCGE0qOO4An537
         HpAw==
X-Gm-Message-State: AOJu0YyrA8dwuL0dAI7e9qnS9Zwcp1yK+ihd5vP5zKnVwrwr28JezvR5
	md+45Rr2E2e23Ad+x7ago15XeMxgGPk=
X-Google-Smtp-Source: AGHT+IHNQZAD/sevTIqC9oaj37jYWC4yYufZddKBl6uKeQ7M+xlDWGO7WyVSpjhA7WKyX/VF9OORHA==
X-Received: by 2002:a05:6e02:1d0c:b0:35f:bd88:cf54 with SMTP id i12-20020a056e021d0c00b0035fbd88cf54mr8625771ila.50.1703489951779;
        Sun, 24 Dec 2023 23:39:11 -0800 (PST)
Received: from ddawson.local ([174.31.117.194])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001bbb8d5166bsm7694743plw.123.2023.12.24.23.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 23:39:11 -0800 (PST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
	by ddawson.local (Postfix) with ESMTP id 55B952F04D8A;
	Sun, 24 Dec 2023 23:39:10 -0800 (PST)
Message-ID: <ed52f171-646f-47ff-ad3b-be8bef48d813@gmail.com>
Date: Sun, 24 Dec 2023 23:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parity raid and ext4 get stuck in writes
To: Carlos Carvalho <carlos@fisica.ufpr.br>, linux-ext4@vger.kernel.org,
 linux-raid@vger.kernel.org
References: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Content-Language: en-US
From: Daniel Dawson <danielcdawson@gmail.com>
Autocrypt: addr=danielcdawson@gmail.com; keydata=
 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
 bi1gCpm8
In-Reply-To: <ZYX2AS8isUHtbMXe@fisica.ufpr.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/23 12:48 PM, Carlos Carvalho wrote:
> This is finally a summary of a long standing problem. When lots of writes to
> many files are sent in a short time the kernel gets stuck and stops sending
> write requests to the disks. Sometimes it recovers and finally sends the
> modified pages to permanent storage, sometimes not and eventually other
> functions degrade and the machine crashes.
>
> A simple way to reproduce: expand a kernel source tree, like
> xzcat linux-6.5.tar.xz | tar x -f -
This sounds almost exactly like a problem I was having, right down to 
triggering it by writing the files of a kernel tree, though the details 
in my case are slightly different. I wanted to report it, but wanted to 
get a better handle on it and never managed it, and now I've changed my 
setup such that it doesn't happen anymore.
> - it happens only with ext4 on a parity raid array

This is where it differs for me. I experienced it only with btrfs. But I 
had two arrays with it, one on SSDs and one on HDDs. The HDD array 
exhibited the problem almost exclusively (the SSDs, I think, exhibited 
it once in several months, while the HDDs did pretty much every time I 
tried to compile a new kernel (until I started working around it), and 
even from some other things, which was a couple of times a week). I 
imagine because HDDs much slower and therefore allow more data to get 
cached.

Now that I've switched the HDD array to ext4, I haven't experienced the 
issue even once. But the setup has better performance, so maybe it's 
just because it flushes its writes faster.

-- 
PGP fingerprint: 5BBD5080FEB0EF7F142F8173D572B791F7B4422A


