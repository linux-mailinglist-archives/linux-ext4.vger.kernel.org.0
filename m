Return-Path: <linux-ext4+bounces-350-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D14980B21E
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 06:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93E01F21373
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5C17EA;
	Sat,  9 Dec 2023 05:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UY7pNteo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD410EF
	for <linux-ext4@vger.kernel.org>; Fri,  8 Dec 2023 21:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702098560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1dglHsXHch+sNbPf4lh7SiEjxLw7RXEQLZMwESVvc8=;
	b=UY7pNteotAbPOmqnlwBYYhgNFZbEcDy8sassgRqh8Wu+lZMzn5GilMLLFKoKzknkHNoagj
	tHejcDYnIt6JKdhrQ2kqRbc+DGeqwYWbu1Y/VUuRxbrD3YR/+XyqVcKJ/yBmuPKO/CMlG7
	+YxG+HBkkuC+JX1ScCwHQPcvCjOp2DE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-sGR0hKOcOHqvMuZUElSFPg-1; Sat, 09 Dec 2023 00:09:18 -0500
X-MC-Unique: sGR0hKOcOHqvMuZUElSFPg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5b8d4a559ddso2523290a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 08 Dec 2023 21:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702098557; x=1702703357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1dglHsXHch+sNbPf4lh7SiEjxLw7RXEQLZMwESVvc8=;
        b=S8K5P3Fwy2BQwM+1Kkj8bB9faCMSLRCbTqWQmBrQ8wetdlZjmgpb5iD3J1bQV0VjIj
         XGRGcsKLIrAhjmOLAwwxXI7+YqesZNk8m94aBR525mN4A7ac20drFJj5HXY0aB6ccrmN
         2HTs5OiarUtR+6qCuStcngWe7fNud0XuGrRA93gtcrKUChxdheu8hCU2DKuf05EAuRwi
         Xp056imbGxC1dSs9mLX+16P5GOzyOUrhrqRL62liT9uPWf560mTCF3m9DeCredY1jWvB
         eql5zrvMF4arDzI1qmo/VzLDiSRg5pKHrde9rYBWaUQtRQjWwV3kmQXUqI+MrmUMuOXK
         nL2w==
X-Gm-Message-State: AOJu0Yz1inbDmy303e595VU0D4DL1+dbMe0xDXRPJYlxzH8CWey8/bfb
	284w6Hz7bu9N5ETvgkhyP43DFqsFfXFP/RLqpJZ1WsrO45hR/MJwi2iCKs6Y3PCnIB4qkhGZu5Q
	3lx9Cl5JxlVFUU/y2+HS/8g==
X-Received: by 2002:a05:6a20:7d97:b0:18b:e5f7:25c5 with SMTP id v23-20020a056a207d9700b0018be5f725c5mr1651070pzj.11.1702098557273;
        Fri, 08 Dec 2023 21:09:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmkWzDhUGE41VSpPpvt2T79s4Knv+0nrQ+KK18g8CZEhvRjUfgjLsws69EBA5nKA/u+aCvkw==
X-Received: by 2002:a05:6a20:7d97:b0:18b:e5f7:25c5 with SMTP id v23-20020a056a207d9700b0018be5f725c5mr1651059pzj.11.1702098556910;
        Fri, 08 Dec 2023 21:09:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gw17-20020a17090b0a5100b00285be64e529sm4259574pjb.39.2023.12.08.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:09:16 -0800 (PST)
Date: Sat, 9 Dec 2023 13:09:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCHv3 2/2] generic: Add integrity tests with synchronous
 directio
Message-ID: <20231209050913.2l42zctsh44bfhit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
 <e255d8494511a705bacc5103e15dd532d2f433d0.1700478575.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e255d8494511a705bacc5103e15dd532d2f433d0.1700478575.git.ritesh.list@gmail.com>

On Mon, Nov 20, 2023 at 04:49:34PM +0530, Ritesh Harjani (IBM) wrote:
> This test covers data & metadata integrity check with directio with
> o_sync flag and checks the file contents & size after sudden fileystem
> shutdown once the directio write is completed. ext4 directio after iomap
> conversion was broken in the sense that if the FS crashes after
> synchronous directio write, it's file size is not properly updated.
> This test adds a testcase to cover such scenario.
> 
> Man page of open says that -
> O_SYNC provides synchronized I/O file integrity completion, meaning write
> operations will flush data and all associated metadata to the underlying
> hardware
> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/generic/733     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/733.out | 22 ++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/733
>  create mode 100644 tests/generic/733.out
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> new file mode 100755
> index 00000000..18021e8a
> --- /dev/null
> +++ b/tests/generic/733
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
> +# Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick shutdown aio
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_shutdown
> +_require_aiodio aio-dio-write-verify
> +
> +_fixed_by_kernel_commit 91562895f803 \
> +	"ext4: properly sync file size update after O_SYNC direct IO"

As this a generic test case, so:

[[ "$FSTYP" =~ ext* ]] && ...

Anyway, I'll change that when I merge it. Other looks good to me

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "T-1: Create a 1M file using buff-io & O_SYNC"
> +$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-1: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-1: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-1: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
> +echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
> +$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
> +echo "T-2: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-2: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-2: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t2
> +
> +echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
> +$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1
> +echo "T-3: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-3: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-3: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t3
> +
> +status=0
> +exit
> diff --git a/tests/generic/733.out b/tests/generic/733.out
> new file mode 100644
> index 00000000..e0536a4e
> --- /dev/null
> +++ b/tests/generic/733.out
> @@ -0,0 +1,22 @@
> +QA output created by 733
> +T-1: Create a 1M file using buff-io & O_SYNC
> +T-1: Shutdown the fs suddenly
> +T-1: Cycle mount
> +T-1: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-2: Create a 1M file using O_DIRECT & O_SYNC
> +T-2: Shutdown the fs suddenly
> +T-2: Cycle mount
> +T-2: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-3: Create a 1M file using AIO-DIO & O_SYNC
> +T-3: Shutdown the fs suddenly
> +T-3: Cycle mount
> +T-3: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> -- 
> 2.41.0
> 
> 


