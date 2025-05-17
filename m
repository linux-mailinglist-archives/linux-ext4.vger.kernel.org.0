Return-Path: <linux-ext4+bounces-7949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045CABA7F1
	for <lists+linux-ext4@lfdr.de>; Sat, 17 May 2025 05:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D51A067F7
	for <lists+linux-ext4@lfdr.de>; Sat, 17 May 2025 03:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0F155C83;
	Sat, 17 May 2025 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzkF0Wkg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7132C7E792;
	Sat, 17 May 2025 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747451084; cv=none; b=M7PUvYLxJJpXMof76jT+3VI+deFNK1gJPbHvwxxgYcJSpEX8Fl4zYp+IIIcGmyCKAdAUtIdJen5HMafTwoWM3E7J6s7p0lYlYoGoe7oeZQKev4U6xCLBEotb7xECi59GgSfX5wLSWHYNMMDPqCwYOHGk41wSR61/DnKEt8IkJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747451084; c=relaxed/simple;
	bh=AiB1G5fTDiC92KHGQaXhJuHBsdKHaLXkpjf4Wj/zw+4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GfNubZ9kLt3oOUg1Clu9qGr76pw0vxKPb/VTmnr9P4RK2QHQRyTbn6IJoTB1ftOHFu/ZLwZ1W3oNJjs8eAh51mKR++QMnqQi2Bs5vGGjGwW4M4BrNczh2niNEnE+f/WwvLRFgIbkwkeg3bxU/uDj/Epz0eHFkIiciYNhBXqYT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzkF0Wkg; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26f67f10ddso782531a12.3;
        Fri, 16 May 2025 20:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747451082; x=1748055882; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5uGPldJKKMAwnPZRWE4Ky1XmrauLBy4Q/KR+6W7TF8=;
        b=ZzkF0WkgpBI92RsyBw/dzkT9IUUlN0FqgrQ5Vk/xg3os48JtT9CenEMvPZOmhvQ8as
         ONNiq8OsekgSN6Q8Io96BJuRHxBHtCCGclNUh4LjtIknBuWvw324uy9P7iM6ZACuPobX
         ok2RKpp/cvm1g7HWbgM3CHXyUkmBLUg9koT+eQ5xdIhLUse/u2qkGZBj/QpssP0S03wG
         y+3xS7OAh6KNMysMstE8E4VFLQmhQ6+OxZQ2rY5VkuMngBPTAxkJo3kV33qafU+xLgW4
         aQl5+xwjW8UTT4I8JiQ8pK/ENdDwzYg9/6tp0HSVwKy5L4ak15gee5tsOchPIp3rY13Z
         XTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747451082; x=1748055882;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5uGPldJKKMAwnPZRWE4Ky1XmrauLBy4Q/KR+6W7TF8=;
        b=QUlIT8q+OTdeHEJuVHD0b2SYoPyr/klXip0fqE8voTnKEbDledq9nMZP57VzFLzMIy
         ASGtHECoL6bVOsxsrgz9hv/J6WhZq/osV9Fx6BojEhKbj8Zws/xFn4kntao3X3HqbpGV
         3JQbexmA96hujFF3ehWHTQJhEKFgrgPy6NLffZVQhZ4/U+/ePRnMZ+0MJ93cyjx/eDU/
         hA/G3dVTsKsZNoAG+MW9tP5kaYfgf5TDJoSsJTdnNryXIPgftX5DZlmWwVOvMWGmNJeF
         G+tkWz1paqhJhJ/K5SKEYX8YOxI8z6HQWmBv37Ab/bE7cF0bX5Tg0t6L0x0/+gGvt+hz
         Biww==
X-Forwarded-Encrypted: i=1; AJvYcCVmiDkmhe2ZWE8S64Uxaj/q2RnrVd/xNWisDEGW6czfmoc/jYgS8+UjRg8lRQacpp6A0KG1Tle7@vger.kernel.org, AJvYcCWLTJ3MNahMg4O9Ymh24JAVrVkYvtpBFqsjTcVNnJJYZ/VX/jY4Ljb0BukHSVDc/87AMjF1IjGpPoKZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpRAMVpnrsiZqch+ByenAUNbGM6G6np9aOjVrQyuepa7Twd+n
	Z7/M4osdZSgSdq5MhETVYoeNRH60mtFwgTxMD1nm6ZbA347YFHdw64Ui
X-Gm-Gg: ASbGncvqv0CIwDaBpYFBwGG/v2dHIB6tp+2tqH3z5L3gHnt9wCY/bu7rK5+pbVuSh5T
	tS7MMNqWUxw9WUw/aaSZDzRR8EUgnNkbv9f3MVQRbRyzg8a4KQKpdSUbyUqubPeyxsmdQP64fiP
	HhGNI5sfpXSpZbPUc47tbaKuc15WwR7b7tx1vDDIMJKUCgrEu5ZyOQXmsK0eNn5j26FxmEv6pwp
	ngUd/a86YdePuIpPlkeFzY0G+2V6OzYdiOE+Kbm8Ys2AIAlymlrCw8DmaBKiJ43pEWRG6Vx2S0M
	h9rIQwG/7QH7Rk51fXy4pODHeRae4K2JAypp1eZq8F4=
X-Google-Smtp-Source: AGHT+IFMBW7vy0zF8OQTN+mqbHH/5Mo5Ze/IldPJQvPBPMtjZZ29zvsh/Hqz9ZMeWKcpQEkltzLB4A==
X-Received: by 2002:a05:6a21:318c:b0:1f5:7c6f:6c8b with SMTP id adf61e73a8af0-2170cc61570mr6521169637.10.1747451082516;
        Fri, 16 May 2025 20:04:42 -0700 (PDT)
Received: from dw-tp ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33451984sm5979535a91.23.2025.05.16.20.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:04:41 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org, david@fromorbit.com, nirjhar.roy.lists@gmail.com
Subject: Re: [PATCH v2 1/2] new: Add a new parameter (name/emailid) in the "new" script
In-Reply-To: <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
Date: Sat, 17 May 2025 08:18:46 +0530
Message-ID: <87jz6gvto1.fsf@gmail.com>
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com> <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com> writes:

> This patch another optional interactive prompt to enter the
> author name and email id for each new test file that is
> created using the "new" file.
>
> The sample output looks like something like the following:
>
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>

I don't see much of a value add in this change here, as folks or
atleast I prefer to quickly get into writing my test first and later
worry about these details :). But I guess I understand where you are
coming from, a lot of times people miss to update this and end up
sending a test with "YOUR NAME HERE" placeholder.

So, sure if we are doing this - then please fix the commit message too,
as it still shows <email-id> above.

-ritesh

> Creating skeletal script for you to edit ...
>  done.
>
> ...
> ...
>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/new b/new
> index 6b50ffed..636648e2 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <author_name>: " -r
> +author_name="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $author_name.  All Rights Reserved.
>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1

