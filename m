Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE056A6C7
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiGGPSr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 11:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbiGGPSq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 11:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EABA27179
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657207122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azRhSeFKQirbnO8LbM232D+yP5m2H5ec79dl4Py0T+A=;
        b=ZF+f0zdQGAmw9r1SZPu0/WI2R/801IxlU1vlJN3O0SMKhg1oganVKlvCmxneaoP++QI0Dh
        XIMkX9Fy+JQur7tZvU9KnZlFSUrhB+NiQjkT/61JwMRUKthM7oYLL8oXwTADdEEIbG7BOl
        8QTLYyVH4QPz+owiyJQFoo6sbMLLhII=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-lwdWzZJhOQ6qZkzTGFW-9A-1; Thu, 07 Jul 2022 11:18:40 -0400
X-MC-Unique: lwdWzZJhOQ6qZkzTGFW-9A-1
Received: by mail-qk1-f200.google.com with SMTP id bs42-20020a05620a472a00b006b550b57229so2086800qkb.15
        for <linux-ext4@vger.kernel.org>; Thu, 07 Jul 2022 08:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azRhSeFKQirbnO8LbM232D+yP5m2H5ec79dl4Py0T+A=;
        b=F931hs6B0+l4CGkHAUApcWtDP8TAuzsYN7EDVaO7CMveUJIxEumMrAPLMxIpJkjygi
         JN0kmoeIXIvHigvwjRUoQJXC5YkeOOTcYI7KDCAka8pgerH8GMUH4umzMe2waKoJvOhG
         CzKvnLVVviBoaNoeLIeKJ5G89n5cbFcuVdfSul0BEN8IjpnJci5wsB31XkaeDai+rZXV
         Mb3mobY0IGlnHG4fI1yjhQVEWR7gjQtWsfwn5a+qIpM8bVlikqwtZlVWekSEzkWk16vw
         EbLa+ddCQh7nhv9rbcmcSheJP4Vgd3EPfBFclOK170EzQXyCiGa/VqMh3o/Fgstdx06z
         rncw==
X-Gm-Message-State: AJIora9xIT8bld3AsxOLb0Q4i0pk1x2S2LLGPSP6UkRfRLN3DTCpV+04
        eJ2CZ5lbShwvtWPW2wSn7a9IZnlemYk1c3x5MeoYk51UMCaAQsgt8MFOsGSt0ZX7Ok2mmAXtgos
        qfls3PnB0VNKeKzm2U69g1Q==
X-Received: by 2002:ac8:7e8e:0:b0:31d:3d75:b623 with SMTP id w14-20020ac87e8e000000b0031d3d75b623mr23771358qtj.204.1657207120033;
        Thu, 07 Jul 2022 08:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t4sJ1Raa/1fKRKVduoz+hEKSEi9UR9gvkFS2khR7f/kzvAhotBnNWmzMv2BOMQCEY0UTamZA==
X-Received: by 2002:ac8:7e8e:0:b0:31d:3d75:b623 with SMTP id w14-20020ac87e8e000000b0031d3d75b623mr23771313qtj.204.1657207119510;
        Thu, 07 Jul 2022 08:18:39 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t6-20020a37ea06000000b006b53fe19c41sm3375443qkj.14.2022.07.07.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 08:18:39 -0700 (PDT)
Date:   Thu, 7 Jul 2022 23:18:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4/058: set 256 blocks in a block group Set 256
 blocks in a block group
Message-ID: <20220707151833.72ggvyxjzz2e42kh@zlang-mailbox>
References: <20220707135917.373342-1-sunke32@huawei.com>
 <20220707135917.373342-3-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707135917.373342-3-sunke32@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 07, 2022 at 09:59:17PM +0800, Sun Ke wrote:
> Set 256 blocks in a block group, then inject I/O pressure, it will
> trigger off kernel BUG in ext4_mb_mark_diskspace_used.
> 
> Regression test for commit a08f789d2ab5 ext4: fix bug_on
> ext4_mb_use_inode_pa.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

About the subject:
"ext4/058: set 256 blocks in a block group Set 256 blocks in a block group"

Don't use a fixed number for new case, you can use "ext4: ...". And I can't
understand the meaning of this subject, except you say it's a duplicate :)


>  tests/ext4/058     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/ext4/058.out |  2 ++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/ext4/058
>  create mode 100644 tests/ext4/058.out
> 
> diff --git a/tests/ext4/058 b/tests/ext4/058
> new file mode 100755
> index 00000000..dc7903b7
> --- /dev/null
> +++ b/tests/ext4/058
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test 058
> +#
> +# Set 256 blocks in a block group, then inject I/O pressure,
> +# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
> +#
> +# Regression test for commit
> +# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa 
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
     ^^^

This's comment can be removed.

> +_supported_fs generic

If it's a ext4 specific test case, don't use "generic" at here.

And _fixed_by_kernel_commit() is recommend.

> +_require_scratch
> +_require_command "$KILLALL_PROG" killall
> +
> +# set 256 blocks in a block group
> +MKFS_OPTIONS="-g 256"
> +_scratch_mkfs >>$seqres.full 2>&1

I think
  _scratch_mkfs_ext4 -g 256 >>$seqres.full 2>&1
is enough. Does other mkfs options will affect this testing?

Or make sure mkfs passed:
_scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"

> +_scratch_mount
> +
> +$FSSTRESS_PROG -d $SCRATCH_MNT -n 1000 -p 1 >> $seqres.full 2>&1 &

Is "-p 1" necessary?

> +sleep 3
> +$KILLALL_PROG -q $FSSTRESS_PROG
> +wait

Hmm.... one more background fsstress test case again ... if so, you need to make
sure the fsstress processes be killed in _cleanup(). Please refer to other cases.

Besides that, I'm wondering if you really need to run fsstress in background?
Due to from the code logic, you run and kill it directly, then do nothing.
What special reason cause you have to run fsstress as that?

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/058.out b/tests/ext4/058.out
> new file mode 100644
> index 00000000..fb5ca60b
> --- /dev/null
> +++ b/tests/ext4/058.out
> @@ -0,0 +1,2 @@
> +QA output created by 058
> +Silence is golden
> -- 
> 2.13.6
> 

