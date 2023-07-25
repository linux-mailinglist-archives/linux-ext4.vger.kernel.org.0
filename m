Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7340F762027
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 19:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGYR37 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 13:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGYR37 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 13:29:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FEBE3;
        Tue, 25 Jul 2023 10:29:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ba97e4feso288774b3a.0;
        Tue, 25 Jul 2023 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690306197; x=1690910997;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xgZS10gxwLiB4J4DuZ0O8385gaDRgzFGpZ0jU0vnu6A=;
        b=Blr/ldogi5fItWvDGThv4RhC6uJBy1WkAzHJ+0zGdHqSlXXarsDZLt8ZkOhCPJuAX1
         X6se5FGi92AjhmuyjcWekeu/hsCpfwJNAfcVcihisflZ1ZbS6ksyafIMs/uyUfm3aRT3
         BEsdDNEv57ef9YfHr+5L7X/QXqSf8SKFwehAfrWnQm1d86zYnlwgAWYYpuva7xJbryf6
         L5OjKwIClg04HWzz/AjtdYeAiIVIeYhNWjr8sd+vO49t+2PtSIfY4+SHwyMrWotSWusP
         lVxnN0+7OpquBFH2RP/61bJFsrX/AkAFDD4VmN1GGdXdc3DX5gvGT2zl4GJMJhvJYJJh
         w1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690306197; x=1690910997;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgZS10gxwLiB4J4DuZ0O8385gaDRgzFGpZ0jU0vnu6A=;
        b=GCgyqWe2z/LczfaQb6VVTX2wwyish7WUUEJaWbB7OutIYmRtAjjkPAY2dbvjYwVs6b
         TJDUwYRLqlUNGAELECcDQm+N3MkrJZ4QlE9nDdxHV9QxDmKzMW0NgLrwt3zEy+MqTe8N
         5YHlAPTH5byoEE5s4OEgE11lBnn9ZggHe7YRAvzjm48VTH0yOm8Oy8LcgNq+R8Uk0pOg
         iBM/tkRjwc+CX5R6NQJITouhhGjC2z2IxDjlPlmbPZoBKx7dP9acSKLw+1X6HihQwH99
         SFL8htGpX/j3c0eHNdbKatxGKp1AhJZjACZeha9abgys3e80dOWOvjz7qpSvBO/kWLAc
         5H3Q==
X-Gm-Message-State: ABy/qLZKgCVmBUqNTM9fJa9BE0JIAItNKwcWFLyr8i9WF/cKJBThE3G4
        0XUEOi09FQJoP7OV/rY8W3E=
X-Google-Smtp-Source: APBJJlG0C8nmeUolLEjrSOZPGkr1qL8IvOcIo3/WnlQeeHskWsMO1l1xYjSCwmkj2YM5t8H+/xHYqg==
X-Received: by 2002:a05:6a00:c8d:b0:673:aca1:a0b0 with SMTP id a13-20020a056a000c8d00b00673aca1a0b0mr15823583pfv.3.1690306197636;
        Tue, 25 Jul 2023 10:29:57 -0700 (PDT)
Received: from dw-tp ([49.207.232.207])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b0064d74808738sm9853226pfh.214.2023.07.25.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 10:29:57 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:59:52 +0530
Message-Id: <87y1j3c31r.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        libaokun1@huawei.com, stable@kernel.org
Subject: Re: [PATCH v2 2/3] ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow
In-Reply-To: <20230724121059.11834-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Baokun Li <libaokun1@huawei.com> writes:

> When we calculate the end position of ext4_free_extent, this position may
> be exactly where ext4_lblk_t (i.e. uint) overflows. For example, if
> ac_g_ex.fe_logical is 4294965248 and ac_orig_goal_len is 2048, then the
> computed end is 0x100000000, which is 0. If ac->ac_o_ex.fe_logical is not
> the first case of adjusting the best extent, that is, new_bex_end > 0, the
> following BUG_ON will be triggered:
>
> =========================================================
> kernel BUG at fs/ext4/mballoc.c:5116!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 673 Comm: xfs_io Tainted: G E 6.5.0-rc1+ #279
> RIP: 0010:ext4_mb_new_inode_pa+0xc5/0x430
> Call Trace:
>  <TASK>
>  ext4_mb_use_best_found+0x203/0x2f0
>  ext4_mb_try_best_found+0x163/0x240
>  ext4_mb_regular_allocator+0x158/0x1550
>  ext4_mb_new_blocks+0x86a/0xe10
>  ext4_ext_map_blocks+0xb0c/0x13a0
>  ext4_map_blocks+0x2cd/0x8f0
>  ext4_iomap_begin+0x27b/0x400
>  iomap_iter+0x222/0x3d0
>  __iomap_dio_rw+0x243/0xcb0
>  iomap_dio_rw+0x16/0x80
> =========================================================
>
> A simple reproducer demonstrating the problem:
>
> 	mkfs.ext4 -F /dev/sda -b 4096 100M
> 	mount /dev/sda /tmp/test
> 	fallocate -l1M /tmp/test/tmp
> 	fallocate -l10M /tmp/test/file
> 	fallocate -i -o 1M -l16777203M /tmp/test/file
> 	fsstress -d /tmp/test -l 0 -n 100000 -p 8 &
> 	sleep 10 && killall -9 fsstress
> 	rm -f /tmp/test/tmp
> 	xfs_io -c "open -ad /tmp/test/file" -c "pwrite -S 0xff 0 8192"
>
> We simply refactor the logic for adjusting the best extent by adding
> a temporary ext4_free_extent ex and use extent_logical_end() to avoid
> overflow, which also simplifies the code.
>
> Cc: stable@kernel.org # 6.4
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)

Looks good to me. Feel free to add: 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
