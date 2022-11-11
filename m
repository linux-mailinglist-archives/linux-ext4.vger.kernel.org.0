Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB52624FF6
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 02:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiKKB7x (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 20:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKKB7r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 20:59:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF859FCF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 17:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668131927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jH0zYB+OYxD0qBtEUYBydLU4oAU/0AAB3kkvdo5CIQI=;
        b=UbUbDn5/V/7FwL4Xperw5LrB8wVfakfO6TyQ7eObpZ1dzMz19qHpr5B3/JY6g4TdbUL7hP
        ox6HXC82tKOOEerhGOpqmV8b6k0KR1aS/RmxSIgz7FPJvyGbYR+qviyDJBtQntisxShiLo
        /RKS/IF3wtxE8oSCXRkS+LRrtNm5l3c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-56-9Wdvc_FCPgeop9FxERgmsA-1; Thu, 10 Nov 2022 20:58:46 -0500
X-MC-Unique: 9Wdvc_FCPgeop9FxERgmsA-1
Received: by mail-pj1-f70.google.com with SMTP id w2-20020a17090a8a0200b002119ea856edso4478320pjn.5
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 17:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH0zYB+OYxD0qBtEUYBydLU4oAU/0AAB3kkvdo5CIQI=;
        b=RVcC92k7OAlPzx0UmvPV7t36mb35NH2C8Sy642z9P7b9vZG2ExLsLp0VCx5tkZbnX6
         S/KCi7Fu5byJmMyxpl0ul3xDlk1ePyKbU0yp1homxclOANJhavrZ4YJauLrrAzG/5ivW
         Hp9v5eec03yhYb0bv6J8o1fZDv5wZe3w4sRToCy9W/t3O6B56C1Tc7YNwZlJOp8EWJDK
         k14k9PLzz2+DLM6vGRohF5oQu9n1bd3EF/e1k+HHRha2wF87rUkaw9me67hGVax3zsDR
         C8O2g4gviSyuPDyrWVDVdPB6V/5G8MHxgIppLYHbDLTArR8kyzW2DHYM/FM8E5V6Sl7b
         fVqw==
X-Gm-Message-State: ACrzQf2rTAWbwWVKQGcC08m9cH29BtahEerjU9H4aCPfptVqmnf898hG
        ujca4eEtm4++Nm2Y9P8D2eFPxl2LydkUjvrSNsYxMoi3IKgQGsknnnasIqPPXJbdxJyBcejGWnX
        Kslz2LnAO4KePk835Cyy8Dg==
X-Received: by 2002:a17:90a:46ce:b0:200:a7b4:6511 with SMTP id x14-20020a17090a46ce00b00200a7b46511mr2952109pjg.101.1668131922654;
        Thu, 10 Nov 2022 17:58:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6hW+bLusNREnQgfVADkvaDvp63rdhFqCpZo4QBZBCQ5ismlb9ntfxnSnzeXJmwnQ+JgpERLw==
X-Received: by 2002:a17:90a:46ce:b0:200:a7b4:6511 with SMTP id x14-20020a17090a46ce00b00200a7b46511mr2952043pjg.101.1668131920896;
        Thu, 10 Nov 2022 17:58:40 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a24-20020aa794b8000000b00561b02e3118sm326158pfl.106.2022.11.10.17.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 17:58:40 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:58:35 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, djwong@kernel.org, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fstests: update group name according to xfs_io command
 requirement
Message-ID: <20221111015835.j4pf2gqsd3qipjmj@zlang-mailbox>
References: <20221108183242.3362013-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108183242.3362013-1-zlang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 09, 2022 at 02:32:42AM +0800, Zorro Lang wrote:
> When a test case requires someone xfs_io command, that nearly means
> that case belong that kind of test group. Likes fpunch for punch
> group, fcollapse for collapse group, falloc for prealloc group, fzero
> for zero group and so on.
> 
> Many fstests cases miss some test groups they should belong to, so
> this patch trys to supplement this lack,  according to the "xxxx"
> which required by _require_xfs_io_command "xxxx".
> 
> Reported-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> Ted complains the insert and collapse groups missing [1], cause he
> have to skip some cases by command of _require_xfs_io_command.
> 
> I think the group missing is the real problem and the first problem,
> so I'm trying to add missed groups to fstests cases, simply according
> to _require_xfs_io_command lines.
> 
> By a simple grep, I found there're too many cases contain _require_xfs_io_command,
> so I wrote a ugly temporary script to help to do this job automatically as [2].
> This script is not good enough, so I took a little time to do manual checking
> after running the script. Hope this patch helps, feel free to review or test,
> and please tell me if I miss something.

Any comments about this change? I'm not asking for reviewing that script,
just the group names change :)

Thanks,
Zorro

> 
> 
> Thanks,
> Zorro
> 
> [1]
> https://lore.kernel.org/fstests/Y2qHkFxVvYlANCZc@magnolia/T/#ma74a7108f263a6583e8742846470fea5f007ef0a
> 
> [2]
> #! /bin/bash
> 
> grep -r _require_xfs_io_command tests | grep -v .out | tr \" \ | tr \' \  > /tmp/file
> 
> check_and_fix_group()
> {
>         local gname=$1
>         local fname=$2
> 
>         if ! grep -E -q "_begin_fstest.*$gname" $fname;then
>                 sed -i "/_begin_fstest/s/$/ $gname/g" $fname
>         fi
> }
> 
> while read line;do
>         echo "Working on $line ..."
>         fname=`echo $line | cut -d: -f1`
>         cmd=`echo $line | awk '{print $2}'`
>         echo "dealing with $cmd on $fname"
>         if [ "$cmd" = "falloc" ];then
>                 check_and_fix_group prealloc $fname
>         elif [ "$cmd" = "fpunch" ];then
>                 check_and_fix_group punch $fname
>         elif [ "$cmd" = "fcollapse" ];then
>                 check_and_fix_group collapse $fname
>         elif [ "$cmd" = "fzero" ];then
>                 check_and_fix_group zero $fname
>         elif [ "$cmd" = "finsert" ];then
>                 check_and_fix_group insert $fname
>         elif [ "$cmd" = "funshare" ];then
>                 check_and_fix_group unshare $fname
>         elif [ "$cmd" = "copy_range" ];then
>                 check_and_fix_group copy_range $fname
>         elif [ "$cmd" = "reflink" ];then
>                 check_and_fix_group clone $fname
>         elif [ "$cmd" = "dedupe" ];then
>                 check_and_fix_group dedupe $fname
>         elif [ "$cmd" = "fsmap" ];then
>                 check_and_fix_group fsmap $fname
>         elif [ "$cmd" = "fiemap" ];then
>                 check_and_fix_group fiemap $fname
>         else
>                 echo "Don't know how to deal with this line"
>         fi
>         echo "-- Done --"
> done < /tmp/file
> 
> 
>  tests/btrfs/013   | 2 +-
>  tests/btrfs/016   | 2 +-
>  tests/btrfs/025   | 2 +-
>  tests/btrfs/034   | 2 +-
>  tests/btrfs/037   | 2 +-
>  tests/btrfs/046   | 2 +-
>  tests/btrfs/079   | 2 +-
>  tests/btrfs/095   | 2 +-
>  tests/btrfs/112   | 2 +-
>  tests/btrfs/153   | 2 +-
>  tests/btrfs/169   | 2 +-
>  tests/btrfs/170   | 2 +-
>  tests/btrfs/180   | 2 +-
>  tests/btrfs/193   | 2 +-
>  tests/btrfs/205   | 2 +-
>  tests/btrfs/206   | 2 +-
>  tests/btrfs/290   | 2 +-
>  tests/ext4/009    | 2 +-
>  tests/ext4/015    | 2 +-
>  tests/ext4/034    | 2 +-
>  tests/ext4/054    | 2 +-
>  tests/ext4/307    | 2 +-
>  tests/f2fs/001    | 2 +-
>  tests/generic/032 | 2 +-
>  tests/generic/038 | 2 +-
>  tests/generic/042 | 2 +-
>  tests/generic/103 | 2 +-
>  tests/generic/137 | 2 +-
>  tests/generic/144 | 2 +-
>  tests/generic/145 | 2 +-
>  tests/generic/156 | 2 +-
>  tests/generic/186 | 2 +-
>  tests/generic/187 | 2 +-
>  tests/generic/188 | 2 +-
>  tests/generic/189 | 2 +-
>  tests/generic/190 | 2 +-
>  tests/generic/191 | 2 +-
>  tests/generic/194 | 2 +-
>  tests/generic/195 | 2 +-
>  tests/generic/196 | 2 +-
>  tests/generic/197 | 2 +-
>  tests/generic/199 | 2 +-
>  tests/generic/200 | 2 +-
>  tests/generic/201 | 2 +-
>  tests/generic/216 | 2 +-
>  tests/generic/217 | 2 +-
>  tests/generic/218 | 2 +-
>  tests/generic/220 | 2 +-
>  tests/generic/222 | 2 +-
>  tests/generic/223 | 2 +-
>  tests/generic/227 | 2 +-
>  tests/generic/229 | 2 +-
>  tests/generic/238 | 2 +-
>  tests/generic/264 | 2 +-
>  tests/generic/284 | 2 +-
>  tests/generic/286 | 2 +-
>  tests/generic/287 | 2 +-
>  tests/generic/289 | 2 +-
>  tests/generic/290 | 2 +-
>  tests/generic/291 | 2 +-
>  tests/generic/292 | 2 +-
>  tests/generic/293 | 2 +-
>  tests/generic/295 | 2 +-
>  tests/generic/299 | 2 +-
>  tests/generic/311 | 2 +-
>  tests/generic/324 | 2 +-
>  tests/generic/351 | 2 +-
>  tests/generic/372 | 2 +-
>  tests/generic/391 | 2 +-
>  tests/generic/404 | 2 +-
>  tests/generic/413 | 2 +-
>  tests/generic/414 | 2 +-
>  tests/generic/422 | 2 +-
>  tests/generic/468 | 2 +-
>  tests/generic/469 | 2 +-
>  tests/generic/483 | 2 +-
>  tests/generic/485 | 2 +-
>  tests/generic/499 | 2 +-
>  tests/generic/503 | 2 +-
>  tests/generic/511 | 2 +-
>  tests/generic/515 | 2 +-
>  tests/generic/540 | 2 +-
>  tests/generic/541 | 2 +-
>  tests/generic/542 | 2 +-
>  tests/generic/543 | 2 +-
>  tests/generic/546 | 2 +-
>  tests/generic/605 | 2 +-
>  tests/generic/610 | 2 +-
>  tests/generic/619 | 2 +-
>  tests/generic/627 | 2 +-
>  tests/generic/641 | 2 +-
>  tests/generic/649 | 2 +-
>  tests/generic/652 | 2 +-
>  tests/generic/653 | 2 +-
>  tests/generic/654 | 2 +-
>  tests/generic/655 | 2 +-
>  tests/generic/658 | 2 +-
>  tests/generic/659 | 2 +-
>  tests/generic/660 | 2 +-
>  tests/generic/661 | 2 +-
>  tests/generic/662 | 2 +-
>  tests/generic/663 | 2 +-
>  tests/generic/664 | 2 +-
>  tests/generic/665 | 2 +-
>  tests/generic/666 | 2 +-
>  tests/generic/667 | 2 +-
>  tests/generic/668 | 2 +-
>  tests/generic/669 | 2 +-
>  tests/generic/674 | 2 +-
>  tests/generic/683 | 2 +-
>  tests/generic/684 | 2 +-
>  tests/generic/685 | 2 +-
>  tests/generic/686 | 2 +-
>  tests/generic/687 | 2 +-
>  tests/overlay/060 | 2 +-
>  tests/xfs/014     | 2 +-
>  tests/xfs/042     | 2 +-
>  tests/xfs/076     | 2 +-
>  tests/xfs/084     | 2 +-
>  tests/xfs/114     | 2 +-
>  tests/xfs/118     | 2 +-
>  tests/xfs/128     | 2 +-
>  tests/xfs/166     | 2 +-
>  tests/xfs/167     | 2 +-
>  tests/xfs/176     | 2 +-
>  tests/xfs/184     | 2 +-
>  tests/xfs/185     | 2 +-
>  tests/xfs/187     | 2 +-
>  tests/xfs/192     | 2 +-
>  tests/xfs/200     | 2 +-
>  tests/xfs/204     | 2 +-
>  tests/xfs/215     | 2 +-
>  tests/xfs/218     | 2 +-
>  tests/xfs/219     | 2 +-
>  tests/xfs/221     | 2 +-
>  tests/xfs/223     | 2 +-
>  tests/xfs/224     | 2 +-
>  tests/xfs/225     | 2 +-
>  tests/xfs/226     | 2 +-
>  tests/xfs/228     | 2 +-
>  tests/xfs/230     | 2 +-
>  tests/xfs/231     | 2 +-
>  tests/xfs/232     | 2 +-
>  tests/xfs/243     | 2 +-
>  tests/xfs/245     | 2 +-
>  tests/xfs/248     | 2 +-
>  tests/xfs/249     | 2 +-
>  tests/xfs/251     | 2 +-
>  tests/xfs/254     | 2 +-
>  tests/xfs/255     | 2 +-
>  tests/xfs/256     | 2 +-
>  tests/xfs/257     | 2 +-
>  tests/xfs/258     | 2 +-
>  tests/xfs/280     | 2 +-
>  tests/xfs/294     | 2 +-
>  tests/xfs/310     | 2 +-
>  tests/xfs/312     | 2 +-
>  tests/xfs/313     | 2 +-
>  tests/xfs/316     | 2 +-
>  tests/xfs/324     | 2 +-
>  tests/xfs/326     | 2 +-
>  tests/xfs/328     | 2 +-
>  tests/xfs/330     | 2 +-
>  tests/xfs/331     | 2 +-
>  tests/xfs/332     | 2 +-
>  tests/xfs/335     | 2 +-
>  tests/xfs/336     | 2 +-
>  tests/xfs/337     | 2 +-
>  tests/xfs/341     | 2 +-
>  tests/xfs/342     | 2 +-
>  tests/xfs/343     | 2 +-
>  tests/xfs/344     | 2 +-
>  tests/xfs/345     | 2 +-
>  tests/xfs/346     | 2 +-
>  tests/xfs/347     | 2 +-
>  tests/xfs/423     | 2 +-
>  tests/xfs/443     | 2 +-
>  tests/xfs/444     | 2 +-
>  tests/xfs/445     | 2 +-
>  tests/xfs/450     | 2 +-
>  tests/xfs/513     | 2 +-
>  tests/xfs/528     | 2 +-
>  tests/xfs/529     | 2 +-
>  tests/xfs/534     | 2 +-
>  tests/xfs/535     | 2 +-
>  tests/xfs/537     | 2 +-
>  tests/xfs/545     | 2 +-
>  tests/xfs/554     | 2 +-
>  188 files changed, 188 insertions(+), 188 deletions(-)
> 
> diff --git a/tests/btrfs/013 b/tests/btrfs/013
> index 1335b8cb..459b6e80 100755
> --- a/tests/btrfs/013
> +++ b/tests/btrfs/013
> @@ -11,7 +11,7 @@
>  # dmesg to see if there was a csum error.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick balance
> +_begin_fstest auto quick balance prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/016 b/tests/btrfs/016
> index 6d05da54..35609329 100755
> --- a/tests/btrfs/016
> +++ b/tests/btrfs/016
> @@ -7,7 +7,7 @@
>  # btrfs send hole punch test
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send prealloc
>  
>  tmp=`mktemp -d`
>  tmp_dir=send_temp_$seq
> diff --git a/tests/btrfs/025 b/tests/btrfs/025
> index b9ffd8cc..26f95c7d 100755
> --- a/tests/btrfs/025
> +++ b/tests/btrfs/025
> @@ -11,7 +11,7 @@
>  # causing the receive command to abort immediately.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send clone
> +_begin_fstest auto quick send clone prealloc
>  
>  tmp=`mktemp -d`
>  
> diff --git a/tests/btrfs/034 b/tests/btrfs/034
> index 92ad5c38..abda75db 100755
> --- a/tests/btrfs/034
> +++ b/tests/btrfs/034
> @@ -8,7 +8,7 @@
>  # bad detection of file holes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send prealloc
>  
>  tmp=`mktemp -d`
>  
> diff --git a/tests/btrfs/037 b/tests/btrfs/037
> index 9ea43358..61193fdd 100755
> --- a/tests/btrfs/037
> +++ b/tests/btrfs/037
> @@ -15,7 +15,7 @@
>  #   Btrfs: fix data corruption when reading/updating compressed extents
>  #
>  . ./common/preamble
> -_begin_fstest auto quick compress
> +_begin_fstest auto quick compress prealloc
>  
>  tmp=`mktemp -d`
>  
> diff --git a/tests/btrfs/046 b/tests/btrfs/046
> index f654adae..8b65fb1f 100755
> --- a/tests/btrfs/046
> +++ b/tests/btrfs/046
> @@ -14,7 +14,7 @@
>  #   Btrfs: send, fix data corruption due to incorrect hole detection
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send preallocrw
>  
>  tmp=`mktemp -d`
>  
> diff --git a/tests/btrfs/079 b/tests/btrfs/079
> index 92d59479..22f57396 100755
> --- a/tests/btrfs/079
> +++ b/tests/btrfs/079
> @@ -18,7 +18,7 @@
>  # btrfs: Fix the wrong condition judgment about subset extent map
>  #
>  . ./common/preamble
> -_begin_fstest auto rw metadata fiemap
> +_begin_fstest auto rw metadata fiemap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/095 b/tests/btrfs/095
> index b3a5fc14..3bd34c72 100755
> --- a/tests/btrfs/095
> +++ b/tests/btrfs/095
> @@ -13,7 +13,7 @@
>  # The regression was introduced in the 4.2-rc1 Linux kernel.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick metadata log
> +_begin_fstest auto quick metadata log preallocrw
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/112 b/tests/btrfs/112
> index dac6b5b0..c3f7fe5c 100755
> --- a/tests/btrfs/112
> +++ b/tests/btrfs/112
> @@ -8,7 +8,7 @@
>  # corruption or data loss.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/153 b/tests/btrfs/153
> index 4c28a2b8..99fab101 100755
> --- a/tests/btrfs/153
> +++ b/tests/btrfs/153
> @@ -7,7 +7,7 @@
>  # Test for leaking quota reservations on preallocated files.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick qgroup limit
> +_begin_fstest auto quick qgroup limit preallocrw
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/169 b/tests/btrfs/169
> index a3f823fe..009fdaee 100755
> --- a/tests/btrfs/169
> +++ b/tests/btrfs/169
> @@ -9,7 +9,7 @@
>  # in a section of that prealloc extent.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick send
> +_begin_fstest auto quick send prealloc punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/btrfs/170 b/tests/btrfs/170
> index 8700be07..ab105d36 100755
> --- a/tests/btrfs/170
> +++ b/tests/btrfs/170
> @@ -9,7 +9,7 @@
>  # subvolume, after a clean shutdown the data was not lost.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick snapshot
> +_begin_fstest auto quick snapshot prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/180 b/tests/btrfs/180
> index 68e382f6..b7c8dac9 100755
> --- a/tests/btrfs/180
> +++ b/tests/btrfs/180
> @@ -11,7 +11,7 @@
>  # "btrfs: qgroup: Make qgroup async transaction commit more aggressive"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick qgroup limit
> +_begin_fstest auto quick qgroup limit prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/193 b/tests/btrfs/193
> index ae293f2e..b4632ab0 100755
> --- a/tests/btrfs/193
> +++ b/tests/btrfs/193
> @@ -10,7 +10,7 @@
>  # "btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick qgroup enospc limit
> +_begin_fstest auto quick qgroup enospc limit prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/205 b/tests/btrfs/205
> index dae8c68f..728f9a7c 100755
> --- a/tests/btrfs/205
> +++ b/tests/btrfs/205
> @@ -14,7 +14,7 @@
>  #   "Btrfs: implement full reflink support for inline extents"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone compress
> +_begin_fstest auto quick clone compress prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index efb07b4b..f6571649 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -12,7 +12,7 @@
>  #	btrfs: replace all uses of btrfs_ordered_update_i_size
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log replay recoveryloop
> +_begin_fstest auto quick log replay recoveryloop punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/btrfs/290 b/tests/btrfs/290
> index 06a58f47..61e741fa 100755
> --- a/tests/btrfs/290
> +++ b/tests/btrfs/290
> @@ -9,7 +9,7 @@
>  # preallocated extents, holes, and the Merkle descriptor in a btrfs-aware way.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick verity
> +_begin_fstest auto quick verity prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/ext4/009 b/tests/ext4/009
> index 096eb036..4258c486 100755
> --- a/tests/ext4/009
> +++ b/tests/ext4/009
> @@ -8,7 +8,7 @@
>  # see how the kernel and e2fsck deal with it.
>  #
>  . ./common/preamble
> -_begin_fstest fuzzers
> +_begin_fstest fuzzers prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/ext4/015 b/tests/ext4/015
> index ec7f4159..3c07b5e5 100755
> --- a/tests/ext4/015
> +++ b/tests/ext4/015
> @@ -8,7 +8,7 @@
>  # see how the kernel and e2fsck deal with it.
>  #
>  . ./common/preamble
> -_begin_fstest fuzzers punch
> +_begin_fstest fuzzers punch prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/ext4/034 b/tests/ext4/034
> index bf7466d4..b656e54d 100755
> --- a/tests/ext4/034
> +++ b/tests/ext4/034
> @@ -11,7 +11,7 @@
>  # "ext4: make sure enough credits are reserved for dioread_nolock writes"
>  #
>  . ./common/preamble
> -_begin_fstest auto quick quota fiemap
> +_begin_fstest auto quick quota fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/ext4/054 b/tests/ext4/054
> index e23acbb1..215f564a 100755
> --- a/tests/ext4/054
> +++ b/tests/ext4/054
> @@ -12,7 +12,7 @@
>  #    ext4_valid_extent_entries())
>  
>  . ./common/preamble
> -_begin_fstest auto quick dangerous_fuzzers
> +_begin_fstest auto quick dangerous_fuzzers prealloc punch
>  
>  # Import common functions
>  . ./common/filter
> diff --git a/tests/ext4/307 b/tests/ext4/307
> index a249213e..db83a083 100755
> --- a/tests/ext4/307
> +++ b/tests/ext4/307
> @@ -7,7 +7,7 @@
>  # Check data integrity during defrag compacting
>  #
>  . ./common/preamble
> -_begin_fstest auto ioctl rw defrag
> +_begin_fstest auto ioctl rw defrag prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/f2fs/001 b/tests/f2fs/001
> index 1141a63e..2bf39d8c 100755
> --- a/tests/f2fs/001
> +++ b/tests/f2fs/001
> @@ -16,7 +16,7 @@
>  # In f2fs, up to 3.4KB of data can be embedded into 4KB-sized inode block.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/032 b/tests/generic/032
> index 90ff0773..c006a591 100755
> --- a/tests/generic/032
> +++ b/tests/generic/032
> @@ -11,7 +11,7 @@
>  # are always read back as zeroes.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw fiemap
> +_begin_fstest auto quick rw fiemap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/038 b/tests/generic/038
> index e9b49967..5c014ae3 100755
> --- a/tests/generic/038
> +++ b/tests/generic/038
> @@ -31,7 +31,7 @@
>  # disk's image file is performed by the host).
>  #
>  . ./common/preamble
> -_begin_fstest auto stress trim
> +_begin_fstest auto stress trim prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/042 b/tests/generic/042
> index dbc65e33..38e0a488 100755
> --- a/tests/generic/042
> +++ b/tests/generic/042
> @@ -13,7 +13,7 @@
>  # stale data exposure can occur.
>  #
>  . ./common/preamble
> -_begin_fstest shutdown rw punch zero
> +_begin_fstest shutdown rw punch zero prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/103 b/tests/generic/103
> index 4efa1dc3..fd650ec9 100755
> --- a/tests/generic/103
> +++ b/tests/generic/103
> @@ -11,7 +11,7 @@
>  # ENOSPC.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick attr enospc
> +_begin_fstest auto quick attr enospc prealloc
>  
>  _register_cleanup "_cleanup" 25
>  
> diff --git a/tests/generic/137 b/tests/generic/137
> index 8ee705fd..18644d9d 100755
> --- a/tests/generic/137
> +++ b/tests/generic/137
> @@ -13,7 +13,7 @@
>  #     extents, and non-matches; but actually dedupe real matches.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone dedupe
> +_begin_fstest auto clone dedupe prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/144 b/tests/generic/144
> index 21c49577..4daaeae0 100755
> --- a/tests/generic/144
> +++ b/tests/generic/144
> @@ -10,7 +10,7 @@
>  #   - Check that the reflinked areas are still there.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/145 b/tests/generic/145
> index 0d545438..f213f53b 100755
> --- a/tests/generic/145
> +++ b/tests/generic/145
> @@ -11,7 +11,7 @@
>  #   - Check that the reflinked areas are still there.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone collapse
> +_begin_fstest auto quick clone collapse prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/156 b/tests/generic/156
> index 18f5208c..df0d0a74 100755
> --- a/tests/generic/156
> +++ b/tests/generic/156
> @@ -20,7 +20,7 @@
>  # "funshare" refers to fallocate copy-on-writing the shared blocks
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone unshare
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/186 b/tests/generic/186
> index c5a1e13a..5f6959a7 100755
> --- a/tests/generic/186
> +++ b/tests/generic/186
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone punch
> +_begin_fstest auto clone punch prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/187 b/tests/generic/187
> index be7a635a..0653b92f 100755
> --- a/tests/generic/187
> +++ b/tests/generic/187
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone punch
> +_begin_fstest auto clone punch prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/188 b/tests/generic/188
> index 52a7f2d2..4a6346a7 100755
> --- a/tests/generic/188
> +++ b/tests/generic/188
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/189 b/tests/generic/189
> index 63faac6e..262ae671 100755
> --- a/tests/generic/189
> +++ b/tests/generic/189
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/190 b/tests/generic/190
> index b336f12b..d95f071a 100755
> --- a/tests/generic/190
> +++ b/tests/generic/190
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/191 b/tests/generic/191
> index 1b12d9ac..49d31dbc 100755
> --- a/tests/generic/191
> +++ b/tests/generic/191
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/194 b/tests/generic/194
> index aa80560b..93dc4778 100755
> --- a/tests/generic/194
> +++ b/tests/generic/194
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/195 b/tests/generic/195
> index 4f21201e..1262b185 100755
> --- a/tests/generic/195
> +++ b/tests/generic/195
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/196 b/tests/generic/196
> index 366d0cad..e02ee24a 100755
> --- a/tests/generic/196
> +++ b/tests/generic/196
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/197 b/tests/generic/197
> index ac314186..a057cac4 100755
> --- a/tests/generic/197
> +++ b/tests/generic/197
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/199 b/tests/generic/199
> index 2246fdd1..e20a2e28 100755
> --- a/tests/generic/199
> +++ b/tests/generic/199
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/200 b/tests/generic/200
> index eeefeb50..3cd90aa4 100755
> --- a/tests/generic/200
> +++ b/tests/generic/200
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/201 b/tests/generic/201
> index 0a5a1d4a..faf168b2 100755
> --- a/tests/generic/201
> +++ b/tests/generic/201
> @@ -8,7 +8,7 @@
>  # unlink the file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/216 b/tests/generic/216
> index aa2939b3..2e40173d 100755
> --- a/tests/generic/216
> +++ b/tests/generic/216
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/217 b/tests/generic/217
> index 3c49662b..a5a8b35f 100755
> --- a/tests/generic/217
> +++ b/tests/generic/217
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/218 b/tests/generic/218
> index 00d6af05..3e6bd18a 100755
> --- a/tests/generic/218
> +++ b/tests/generic/218
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/220 b/tests/generic/220
> index ae979b7c..f3a53565 100755
> --- a/tests/generic/220
> +++ b/tests/generic/220
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/222 b/tests/generic/222
> index 409cfe0d..bdb5bb1e 100755
> --- a/tests/generic/222
> +++ b/tests/generic/222
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/223 b/tests/generic/223
> index 2a581124..0fb07e12 100755
> --- a/tests/generic/223
> +++ b/tests/generic/223
> @@ -7,7 +7,7 @@
>  # File alignment tests
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/227 b/tests/generic/227
> index ce81e58c..e7708db9 100755
> --- a/tests/generic/227
> +++ b/tests/generic/227
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/229 b/tests/generic/229
> index 82abf25f..c5c94184 100755
> --- a/tests/generic/229
> +++ b/tests/generic/229
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/238 b/tests/generic/238
> index 410dbc0e..c8d12c19 100755
> --- a/tests/generic/238
> +++ b/tests/generic/238
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/264 b/tests/generic/264
> index 83538319..1a7ccc84 100755
> --- a/tests/generic/264
> +++ b/tests/generic/264
> @@ -10,7 +10,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/284 b/tests/generic/284
> index f9eefff3..dc9b8a9d 100755
> --- a/tests/generic/284
> +++ b/tests/generic/284
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/286 b/tests/generic/286
> index 73581245..629cb55b 100755
> --- a/tests/generic/286
> +++ b/tests/generic/286
> @@ -7,7 +7,7 @@
>  # SEEK_DATA/SEEK_HOLE copy tests.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick other seek
> +_begin_fstest auto quick other seek prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/287 b/tests/generic/287
> index 61301368..14aea37c 100755
> --- a/tests/generic/287
> +++ b/tests/generic/287
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/289 b/tests/generic/289
> index 52d03c35..3ce234c3 100755
> --- a/tests/generic/289
> +++ b/tests/generic/289
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/290 b/tests/generic/290
> index 5352b9ba..13e09878 100755
> --- a/tests/generic/290
> +++ b/tests/generic/290
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/291 b/tests/generic/291
> index 1c589cf6..f61ae5a3 100755
> --- a/tests/generic/291
> +++ b/tests/generic/291
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/292 b/tests/generic/292
> index 725fe057..40566cec 100755
> --- a/tests/generic/292
> +++ b/tests/generic/292
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/293 b/tests/generic/293
> index 05997501..99500b41 100755
> --- a/tests/generic/293
> +++ b/tests/generic/293
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/295 b/tests/generic/295
> index 9ccf823f..7ab95803 100755
> --- a/tests/generic/295
> +++ b/tests/generic/295
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/299 b/tests/generic/299
> index 1bb371a3..d8ecff53 100755
> --- a/tests/generic/299
> +++ b/tests/generic/299
> @@ -9,7 +9,7 @@
>  # Test will operate on huge sparsed files so ENOSPC is expected.
>  #
>  . ./common/preamble
> -_begin_fstest auto aio enospc rw stress
> +_begin_fstest auto aio enospc rw stress prealloc
>  
>  fio_config=$tmp.fio
>  fio_out=$tmp.fio.out
> diff --git a/tests/generic/311 b/tests/generic/311
> index 23f37a0d..d83da5a4 100755
> --- a/tests/generic/311
> +++ b/tests/generic/311
> @@ -18,7 +18,7 @@
>  # regression test of sorts.
>  #
>  . ./common/preamble
> -_begin_fstest auto metadata log
> +_begin_fstest auto metadata log prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/324 b/tests/generic/324
> index 2d185021..523d1f04 100755
> --- a/tests/generic/324
> +++ b/tests/generic/324
> @@ -7,7 +7,7 @@
>  # Sanity check for defrag utility.
>  #
>  . ./common/preamble
> -_begin_fstest auto fsr quick defrag
> +_begin_fstest auto fsr quick defrag prealloc
>  
>  PIDS=""
>  
> diff --git a/tests/generic/351 b/tests/generic/351
> index fb16da16..c4e87675 100755
> --- a/tests/generic/351
> +++ b/tests/generic/351
> @@ -11,7 +11,7 @@
>  # devices that don't support write_same or discard.
>  #
>  . ./common/preamble
> -_begin_fstest blockdev rw punch collapse insert zero
> +_begin_fstest blockdev rw punch collapse insert zero prealloc
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/372 b/tests/generic/372
> index ca50ae39..dac51dec 100755
> --- a/tests/generic/372
> +++ b/tests/generic/372
> @@ -7,7 +7,7 @@
>  # Check that bmap/fiemap accurately report shared extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/391 b/tests/generic/391
> index 748af9d8..cd99ee2e 100755
> --- a/tests/generic/391
> +++ b/tests/generic/391
> @@ -9,7 +9,7 @@
>  # to spurious -EEXIST failures from direct I/O reads.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw
> +_begin_fstest auto quick rw prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/404 b/tests/generic/404
> index 30fce85d..ddbc04d5 100755
> --- a/tests/generic/404
> +++ b/tests/generic/404
> @@ -45,7 +45,7 @@
>  # each block insert.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick insert
> +_begin_fstest auto quick insert prealloc
>  
>  testfile=$TEST_DIR/$seq.file
>  pattern=$tmp.pattern
> diff --git a/tests/generic/413 b/tests/generic/413
> index 4f9e1fe0..155f397d 100755
> --- a/tests/generic/413
> +++ b/tests/generic/413
> @@ -7,7 +7,7 @@
>  # mmap direct/buffered io between DAX and non-DAX mountpoints.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dax
> +_begin_fstest auto quick dax prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/414 b/tests/generic/414
> index f2d63c17..684b2bf2 100755
> --- a/tests/generic/414
> +++ b/tests/generic/414
> @@ -8,7 +8,7 @@
>  # block mapping extent.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/generic/422 b/tests/generic/422
> index 96dbe11b..455d7aeb 100755
> --- a/tests/generic/422
> +++ b/tests/generic/422
> @@ -9,7 +9,7 @@
>  # delayed allocations.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/468 b/tests/generic/468
> index 95752d3b..f8d537f9 100755
> --- a/tests/generic/468
> +++ b/tests/generic/468
> @@ -18,7 +18,7 @@
>  # that inode metadata will be unchanged after recovery.
>  #
>  . ./common/preamble
> -_begin_fstest shutdown auto quick metadata
> +_begin_fstest shutdown auto quick metadata prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/469 b/tests/generic/469
> index 42f6a4af..81573972 100755
> --- a/tests/generic/469
> +++ b/tests/generic/469
> @@ -14,7 +14,7 @@
>  # the bug on XFS.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick punch zero
> +_begin_fstest auto quick punch zero prealloc
>  
>  file=$TEST_DIR/$seq.fsx
>  
> diff --git a/tests/generic/483 b/tests/generic/483
> index 8a8a6f24..2b35f285 100755
> --- a/tests/generic/483
> +++ b/tests/generic/483
> @@ -8,7 +8,7 @@
>  # are placed beyond a file's size.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick log metadata fiemap
> +_begin_fstest auto quick log metadata fiemap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/485 b/tests/generic/485
> index 2e0bc612..3f7749ff 100755
> --- a/tests/generic/485
> +++ b/tests/generic/485
> @@ -9,7 +9,7 @@
>  #    7d83fb14258b ("xfs: prevent creating negative-sized file via INSERT_RANGE")
>  #
>  . ./common/preamble
> -_begin_fstest auto quick insert
> +_begin_fstest auto quick insert prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/499 b/tests/generic/499
> index 7159871f..4b39c48b 100755
> --- a/tests/generic/499
> +++ b/tests/generic/499
> @@ -8,7 +8,7 @@
>  # eof to return nonzero contents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw collapse zero
> +_begin_fstest auto quick rw collapse zero prealloc
>  
>  # Import common functions.
>  . ./common/punch
> diff --git a/tests/generic/503 b/tests/generic/503
> index ff3390bf..a01d3327 100755
> --- a/tests/generic/503
> +++ b/tests/generic/503
> @@ -14,7 +14,7 @@
>  # don't require the DAX mount option or a specific filesystem for the test.
>  
>  . ./common/preamble
> -_begin_fstest auto quick dax punch collapse zero
> +_begin_fstest auto quick dax punch collapse zero prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/511 b/tests/generic/511
> index 058d8401..61c21e42 100755
> --- a/tests/generic/511
> +++ b/tests/generic/511
> @@ -8,7 +8,7 @@
>  # eof to return nonzero contents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw zero
> +_begin_fstest auto quick rw zero prealloc
>  
>  # Import common functions.
>  . ./common/punch
> diff --git a/tests/generic/515 b/tests/generic/515
> index 758bd639..1d537dec 100755
> --- a/tests/generic/515
> +++ b/tests/generic/515
> @@ -10,7 +10,7 @@
>  # exposure bug uncovered by shared/010.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/540 b/tests/generic/540
> index 8c66b572..290e05d0 100755
> --- a/tests/generic/540
> +++ b/tests/generic/540
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/541 b/tests/generic/541
> index 227c45e1..e6f0fa3c 100755
> --- a/tests/generic/541
> +++ b/tests/generic/541
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/542 b/tests/generic/542
> index 7b413d6d..4d907d8a 100755
> --- a/tests/generic/542
> +++ b/tests/generic/542
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/543 b/tests/generic/543
> index 66f46e92..928b761f 100755
> --- a/tests/generic/543
> +++ b/tests/generic/543
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/546 b/tests/generic/546
> index 9dc507be..2eb99543 100755
> --- a/tests/generic/546
> +++ b/tests/generic/546
> @@ -12,7 +12,7 @@
>  # All operations above should not fail.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone enospc log
> +_begin_fstest auto quick clone enospc log prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/605 b/tests/generic/605
> index 1db58491..77671f39 100755
> --- a/tests/generic/605
> +++ b/tests/generic/605
> @@ -7,7 +7,7 @@
>  # Test per-inode DAX flag by mmap direct/buffered IO.
>  #
>  . ./common/preamble
> -_begin_fstest auto attr quick dax
> +_begin_fstest auto attr quick dax prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/610 b/tests/generic/610
> index f75cf979..18cfcfff 100755
> --- a/tests/generic/610
> +++ b/tests/generic/610
> @@ -9,7 +9,7 @@
>  # and the respective range return zeroes on subsequent reads.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick prealloc zero
> +_begin_fstest auto quick prealloc zero punch
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/619 b/tests/generic/619
> index 6e42d677..c4bdfbce 100755
> --- a/tests/generic/619
> +++ b/tests/generic/619
> @@ -24,7 +24,7 @@
>  #               retrying")
>  #
>  . ./common/preamble
> -_begin_fstest auto rw enospc
> +_begin_fstest auto rw enospc prealloc
>  
>  FS_SIZE=$((240*1024*1024)) # 240MB
>  DEBUG=1 # set to 0 to disable debug statements in shell and c-prog
> diff --git a/tests/generic/627 b/tests/generic/627
> index e82a42db..9a7359e6 100755
> --- a/tests/generic/627
> +++ b/tests/generic/627
> @@ -17,7 +17,7 @@
>  # size < page size.
>  #
>  . ./common/preamble
> -_begin_fstest auto aio rw stress
> +_begin_fstest auto aio rw stress prealloc
>  
>  fio_config=$tmp.fio
>  fio_out=$tmp.fio.out
> diff --git a/tests/generic/641 b/tests/generic/641
> index 41b3504b..1fd3db2a 100755
> --- a/tests/generic/641
> +++ b/tests/generic/641
> @@ -9,7 +9,7 @@
>  # assignment to unsigned sis->pages in iomap_swapfile_activate").
>  #
>  . ./common/preamble
> -_begin_fstest auto quick swap
> +_begin_fstest auto quick swap collapse
>  
>  # Import common functions
>  . ./common/filter
> diff --git a/tests/generic/649 b/tests/generic/649
> index d6727765..2e156dfe 100755
> --- a/tests/generic/649
> +++ b/tests/generic/649
> @@ -16,7 +16,7 @@
>  # unshare a hole.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone unshare
> +_begin_fstest auto clone unshare punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/652 b/tests/generic/652
> index 42af175f..d7b74e0e 100755
> --- a/tests/generic/652
> +++ b/tests/generic/652
> @@ -10,7 +10,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/653 b/tests/generic/653
> index 8c18c136..a63c7138 100755
> --- a/tests/generic/653
> +++ b/tests/generic/653
> @@ -10,7 +10,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/654 b/tests/generic/654
> index 45ed19de..f73ae81b 100755
> --- a/tests/generic/654
> +++ b/tests/generic/654
> @@ -10,7 +10,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/655 b/tests/generic/655
> index 8106d15c..a131b1d1 100755
> --- a/tests/generic/655
> +++ b/tests/generic/655
> @@ -11,7 +11,7 @@
>  # the golden output; we can only compare to a check file.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/658 b/tests/generic/658
> index a296f88b..a5cbadaa 100755
> --- a/tests/generic/658
> +++ b/tests/generic/658
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/659 b/tests/generic/659
> index e42077e2..ccc2d795 100755
> --- a/tests/generic/659
> +++ b/tests/generic/659
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/660 b/tests/generic/660
> index 7d339aad..bc17dc5e 100755
> --- a/tests/generic/660
> +++ b/tests/generic/660
> @@ -12,7 +12,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/661 b/tests/generic/661
> index 295a6a8d..788dae7e 100755
> --- a/tests/generic/661
> +++ b/tests/generic/661
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/662 b/tests/generic/662
> index a09a467f..3fdfb4e0 100755
> --- a/tests/generic/662
> +++ b/tests/generic/662
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/663 b/tests/generic/663
> index dcd8c861..658a5b70 100755
> --- a/tests/generic/663
> +++ b/tests/generic/663
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/664 b/tests/generic/664
> index 4dc313fc..3009101f 100755
> --- a/tests/generic/664
> +++ b/tests/generic/664
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/665 b/tests/generic/665
> index 6f21aaff..86ba5787 100755
> --- a/tests/generic/665
> +++ b/tests/generic/665
> @@ -15,7 +15,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/666 b/tests/generic/666
> index 47dd4ce4..5e4f3062 100755
> --- a/tests/generic/666
> +++ b/tests/generic/666
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/667 b/tests/generic/667
> index e9f07feb..9f1cb1be 100755
> --- a/tests/generic/667
> +++ b/tests/generic/667
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/668 b/tests/generic/668
> index b703713b..41e03ae8 100755
> --- a/tests/generic/668
> +++ b/tests/generic/668
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/669 b/tests/generic/669
> index 8e744e89..c8816042 100755
> --- a/tests/generic/669
> +++ b/tests/generic/669
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/674 b/tests/generic/674
> index c3ff1b7b..2ed022df 100755
> --- a/tests/generic/674
> +++ b/tests/generic/674
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a deduplication.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone quick perms dedupe
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/generic/683 b/tests/generic/683
> index 302f8bb2..eea8d21b 100755
> --- a/tests/generic/683
> +++ b/tests/generic/683
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fallocate.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone quick perms prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/684 b/tests/generic/684
> index 19ccb228..541dbeb4 100755
> --- a/tests/generic/684
> +++ b/tests/generic/684
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fpunch.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone quick perms punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/685 b/tests/generic/685
> index a58eccda..29eca1a8 100755
> --- a/tests/generic/685
> +++ b/tests/generic/685
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fzero.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone quick perms zero
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/686 b/tests/generic/686
> index ef9ea47a..a8ec23d5 100755
> --- a/tests/generic/686
> +++ b/tests/generic/686
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a finsert.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone insert quick perms
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/generic/687 b/tests/generic/687
> index f4a1c1bb..ff3e2fe1 100755
> --- a/tests/generic/687
> +++ b/tests/generic/687
> @@ -7,7 +7,7 @@
>  # Functional test for dropping suid and sgid bits as part of a fcollapse.
>  #
>  . ./common/preamble
> -_begin_fstest auto clone quick perms
> +_begin_fstest auto clone quick perms collapse
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/overlay/060 b/tests/overlay/060
> index 733245db..363207ba 100755
> --- a/tests/overlay/060
> +++ b/tests/overlay/060
> @@ -7,7 +7,7 @@
>  # Test metadata only copy up functionality.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick metacopy
> +_begin_fstest auto quick metacopy prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/014 b/tests/xfs/014
> index 1f0ebac3..be25c176 100755
> --- a/tests/xfs/014
> +++ b/tests/xfs/014
> @@ -12,7 +12,7 @@
>  # ENOSPC/EDQUOT.
>  #
>  . ./common/preamble
> -_begin_fstest auto enospc quick quota
> +_begin_fstest auto enospc quick quota prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/042 b/tests/xfs/042
> index 657abd21..4433d577 100755
> --- a/tests/xfs/042
> +++ b/tests/xfs/042
> @@ -11,7 +11,7 @@
>  set +x
>  
>  . ./common/preamble
> -_begin_fstest fsr ioctl auto
> +_begin_fstest fsr ioctl auto prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/076 b/tests/xfs/076
> index db88b43d..a6ec0568 100755
> --- a/tests/xfs/076
> +++ b/tests/xfs/076
> @@ -18,7 +18,7 @@
>  # inodes (.i.e., free space) have been consumed.
>  #
>  . ./common/preamble
> -_begin_fstest auto enospc punch
> +_begin_fstest auto enospc punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/084 b/tests/xfs/084
> index e796fec4..ab734355 100755
> --- a/tests/xfs/084
> +++ b/tests/xfs/084
> @@ -8,7 +8,7 @@
>  # for data corruption (zeroes read) near the end of file.
>  #
>  . ./common/preamble
> -_begin_fstest ioctl rw auto
> +_begin_fstest ioctl rw auto prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/114 b/tests/xfs/114
> index 858dc399..0e8a0529 100755
> --- a/tests/xfs/114
> +++ b/tests/xfs/114
> @@ -9,7 +9,7 @@
>  # extents on either side of the collapse area are mergeable.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone rmap collapse insert
> +_begin_fstest auto quick clone rmap collapse insert prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/118 b/tests/xfs/118
> index 03755b28..6bb81a3a 100755
> --- a/tests/xfs/118
> +++ b/tests/xfs/118
> @@ -16,7 +16,7 @@
>  # ip->i_df.if_bytes not ip->i_d.di_nextents in xfs_swap_extent_forks
>  #
>  . ./common/preamble
> -_begin_fstest auto quick fsr
> +_begin_fstest auto quick fsr prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/128 b/tests/xfs/128
> index 658c0b1f..5591342d 100755
> --- a/tests/xfs/128
> +++ b/tests/xfs/128
> @@ -7,7 +7,7 @@
>  # Ensure that xfs_fsr un-reflinks files while defragmenting
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fsr
> +_begin_fstest auto quick clone fsr prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/166 b/tests/xfs/166
> index 9e082152..45f28e77 100755
> --- a/tests/xfs/166
> +++ b/tests/xfs/166
> @@ -7,7 +7,7 @@
>  # ->page-mkwrite test - unwritten extents and mmap
>  #
>  . ./common/preamble
> -_begin_fstest rw metadata auto quick
> +_begin_fstest rw metadata auto quick prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/167 b/tests/xfs/167
> index 15bb1854..734c107f 100755
> --- a/tests/xfs/167
> +++ b/tests/xfs/167
> @@ -7,7 +7,7 @@
>  # unwritten extent conversion test
>  #
>  . ./common/preamble
> -_begin_fstest rw metadata auto stress
> +_begin_fstest rw metadata auto stress prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/176 b/tests/xfs/176
> index ba4aae59..5231b888 100755
> --- a/tests/xfs/176
> +++ b/tests/xfs/176
> @@ -8,7 +8,7 @@
>  # of the filesystem is now in the middle of a sparse inode cluster.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick shrinkfs
> +_begin_fstest auto quick shrinkfs prealloc punch
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/184 b/tests/xfs/184
> index e6f083f0..c251040e 100755
> --- a/tests/xfs/184
> +++ b/tests/xfs/184
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/185 b/tests/xfs/185
> index 73b21092..abeb0525 100755
> --- a/tests/xfs/185
> +++ b/tests/xfs/185
> @@ -16,7 +16,7 @@
>  # smaller than the rt device.
>  #
>  . ./common/preamble
> -_begin_fstest auto fsmap
> +_begin_fstest auto fsmap prealloc punch
>  
>  _cleanup()
>  {
> diff --git a/tests/xfs/187 b/tests/xfs/187
> index a9dfb30a..7c34d8e6 100755
> --- a/tests/xfs/187
> +++ b/tests/xfs/187
> @@ -28,7 +28,7 @@
>  # the fix patches themselves.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw realtime
> +_begin_fstest auto quick rw realtime prealloc punch
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/192 b/tests/xfs/192
> index a4a33bc7..85ed7a48 100755
> --- a/tests/xfs/192
> +++ b/tests/xfs/192
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/200 b/tests/xfs/200
> index eb0121e3..f91bfbf4 100755
> --- a/tests/xfs/200
> +++ b/tests/xfs/200
> @@ -13,7 +13,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/204 b/tests/xfs/204
> index c62ad980..d034446b 100755
> --- a/tests/xfs/204
> +++ b/tests/xfs/204
> @@ -13,7 +13,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/215 b/tests/xfs/215
> index c07cdd1a..d2c0d6fc 100755
> --- a/tests/xfs/215
> +++ b/tests/xfs/215
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/218 b/tests/xfs/218
> index cc3e1552..1a994d79 100755
> --- a/tests/xfs/218
> +++ b/tests/xfs/218
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/219 b/tests/xfs/219
> index bd2c47bf..507b033b 100755
> --- a/tests/xfs/219
> +++ b/tests/xfs/219
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/221 b/tests/xfs/221
> index cda99b5c..598df3f1 100755
> --- a/tests/xfs/221
> +++ b/tests/xfs/221
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/223 b/tests/xfs/223
> index e22c1ba9..849667d4 100755
> --- a/tests/xfs/223
> +++ b/tests/xfs/223
> @@ -14,7 +14,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/224 b/tests/xfs/224
> index 7e984a8a..6f6dcd04 100755
> --- a/tests/xfs/224
> +++ b/tests/xfs/224
> @@ -14,7 +14,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/225 b/tests/xfs/225
> index a07ef3f0..8722d506 100755
> --- a/tests/xfs/225
> +++ b/tests/xfs/225
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/226 b/tests/xfs/226
> index 1e566e2e..a5f46a14 100755
> --- a/tests/xfs/226
> +++ b/tests/xfs/226
> @@ -13,7 +13,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/228 b/tests/xfs/228
> index 85a4abc5..504f9288 100755
> --- a/tests/xfs/228
> +++ b/tests/xfs/228
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/230 b/tests/xfs/230
> index 2347a307..fd1209be 100755
> --- a/tests/xfs/230
> +++ b/tests/xfs/230
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/231 b/tests/xfs/231
> index de8a7ca9..31f267ee 100755
> --- a/tests/xfs/231
> +++ b/tests/xfs/231
> @@ -12,7 +12,7 @@
>  # - Write more and see how bad fragmentation is.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/232 b/tests/xfs/232
> index 5ca1a9f1..f402ad6c 100755
> --- a/tests/xfs/232
> +++ b/tests/xfs/232
> @@ -13,7 +13,7 @@
>  # - Write more and see how bad fragmentation is.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/243 b/tests/xfs/243
> index 8f0c5939..4595415a 100755
> --- a/tests/xfs/243
> +++ b/tests/xfs/243
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone punch
> +_begin_fstest auto quick clone punch prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/245 b/tests/xfs/245
> index 417dd18c..0cd0935c 100755
> --- a/tests/xfs/245
> +++ b/tests/xfs/245
> @@ -11,7 +11,7 @@
>  # - compare file[12]
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/248 b/tests/xfs/248
> index cdb1da02..9b95af1d 100755
> --- a/tests/xfs/248
> +++ b/tests/xfs/248
> @@ -14,7 +14,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/249 b/tests/xfs/249
> index 0c4b0335..4febb79c 100755
> --- a/tests/xfs/249
> +++ b/tests/xfs/249
> @@ -14,7 +14,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/251 b/tests/xfs/251
> index 1efa331d..7e21b502 100755
> --- a/tests/xfs/251
> +++ b/tests/xfs/251
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/254 b/tests/xfs/254
> index d08ccc52..f31b6651 100755
> --- a/tests/xfs/254
> +++ b/tests/xfs/254
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/255 b/tests/xfs/255
> index 8ec6f0be..c2eade3e 100755
> --- a/tests/xfs/255
> +++ b/tests/xfs/255
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/256 b/tests/xfs/256
> index 7157d532..5162e450 100755
> --- a/tests/xfs/256
> +++ b/tests/xfs/256
> @@ -16,7 +16,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/257 b/tests/xfs/257
> index c3100d60..ae1dc98d 100755
> --- a/tests/xfs/257
> +++ b/tests/xfs/257
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/258 b/tests/xfs/258
> index a3a130ea..7ce7bd2e 100755
> --- a/tests/xfs/258
> +++ b/tests/xfs/258
> @@ -17,7 +17,7 @@
>  #   - Check that the files are now different where we say they're different.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/280 b/tests/xfs/280
> index 0d9a7958..35598b2f 100755
> --- a/tests/xfs/280
> +++ b/tests/xfs/280
> @@ -7,7 +7,7 @@
>  # Check that GETBMAPX accurately report shared extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone prealloc
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/xfs/294 b/tests/xfs/294
> index e00f0127..d381e2c8 100755
> --- a/tests/xfs/294
> +++ b/tests/xfs/294
> @@ -14,7 +14,7 @@
>  # Failure is a hang; KASAN should also catch this.
>  #
>  . ./common/preamble
> -_begin_fstest auto dir metadata
> +_begin_fstest auto dir metadata prealloc punch
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/310 b/tests/xfs/310
> index 3214e04b..edd7d0d7 100755
> --- a/tests/xfs/310
> +++ b/tests/xfs/310
> @@ -7,7 +7,7 @@
>  # Create a file with more than 2^21 blocks (the max length of a bmbt record).
>  #
>  . ./common/preamble
> -_begin_fstest auto clone rmap
> +_begin_fstest auto clone rmap prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/312 b/tests/xfs/312
> index e4884787..cb232bdf 100755
> --- a/tests/xfs/312
> +++ b/tests/xfs/312
> @@ -8,7 +8,7 @@
>  # Inject an error during block remap to test log recovery.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/313 b/tests/xfs/313
> index 9c7cf5b9..21e36982 100755
> --- a/tests/xfs/313
> +++ b/tests/xfs/313
> @@ -8,7 +8,7 @@
>  # Inject an error during refcount updates to test log recovery.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/316 b/tests/xfs/316
> index f0af19d2..7f7bdd64 100755
> --- a/tests/xfs/316
> +++ b/tests/xfs/316
> @@ -8,7 +8,7 @@
>  # Force XFS into "two refcount updates per transaction" mode.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/324 b/tests/xfs/324
> index 9909db62..57cab86a 100755
> --- a/tests/xfs/324
> +++ b/tests/xfs/324
> @@ -8,7 +8,7 @@
>  # Force XFS into "two refcount updates per transaction" mode.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/326 b/tests/xfs/326
> index d8a9ac25..8ab60684 100755
> --- a/tests/xfs/326
> +++ b/tests/xfs/326
> @@ -10,7 +10,7 @@
>  # instead of when we're stashing the CoW orphan record.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone punch
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/328 b/tests/xfs/328
> index c45fa5f8..30e364eb 100755
> --- a/tests/xfs/328
> +++ b/tests/xfs/328
> @@ -7,7 +7,7 @@
>  # See how well xfs_fsr handles "defragging" a file with a hojillion extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fsr
> +_begin_fstest auto quick clone fsr prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/330 b/tests/xfs/330
> index 5a82a1fd..c6e74e67 100755
> --- a/tests/xfs/330
> +++ b/tests/xfs/330
> @@ -7,7 +7,7 @@
>  # Ensure that xfs_fsr handles quota correctly while defragging files.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fsr quota
> +_begin_fstest auto quick clone fsr quota prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/331 b/tests/xfs/331
> index 733ff58f..2332533f 100755
> --- a/tests/xfs/331
> +++ b/tests/xfs/331
> @@ -7,7 +7,7 @@
>  # Create a big enough rmapbt that we tickle a fdblocks accounting bug.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap clone
> +_begin_fstest auto quick rmap clone prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/332 b/tests/xfs/332
> index 4cc01e97..a2d37ee9 100755
> --- a/tests/xfs/332
> +++ b/tests/xfs/332
> @@ -7,7 +7,7 @@
>  # Make sure query_range returns -EINVAL if lowkey > highkey.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap clone collapse punch insert zero
> +_begin_fstest auto quick rmap clone collapse punch insert zero prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/335 b/tests/xfs/335
> index ccc508e7..d07485b2 100755
> --- a/tests/xfs/335
> +++ b/tests/xfs/335
> @@ -7,7 +7,7 @@
>  # Exercise expanding and shrinking the realtime rmap btree.
>  #
>  . ./common/preamble
> -_begin_fstest auto rmap realtime
> +_begin_fstest auto rmap realtime prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/336 b/tests/xfs/336
> index b1de8e5f..ee8ec649 100755
> --- a/tests/xfs/336
> +++ b/tests/xfs/336
> @@ -7,7 +7,7 @@
>  # Exercise metadump on realtime rmapbt preservation.
>  #
>  . ./common/preamble
> -_begin_fstest auto rmap realtime metadump
> +_begin_fstest auto rmap realtime metadump prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/337 b/tests/xfs/337
> index a2515e36..8502a5ff 100755
> --- a/tests/xfs/337
> +++ b/tests/xfs/337
> @@ -7,7 +7,7 @@
>  # Corrupt the realtime rmapbt and see how the kernel and xfs_repair deal.
>  #
>  . ./common/preamble
> -_begin_fstest fuzzers rmap realtime
> +_begin_fstest fuzzers rmap realtime prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/341 b/tests/xfs/341
> index f026aa37..122def0f 100755
> --- a/tests/xfs/341
> +++ b/tests/xfs/341
> @@ -7,7 +7,7 @@
>  # Cross-link file block into rtrmapbt and see if repair fixes it.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap realtime
> +_begin_fstest auto quick rmap realtime prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/342 b/tests/xfs/342
> index 1ae414eb..73f7fc04 100755
> --- a/tests/xfs/342
> +++ b/tests/xfs/342
> @@ -7,7 +7,7 @@
>  # Cross-link rtrmapbt block into a file and see if repair fixes it.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap realtime
> +_begin_fstest auto quick rmap realtime prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/343 b/tests/xfs/343
> index 816ff241..bffcc7d9 100755
> --- a/tests/xfs/343
> +++ b/tests/xfs/343
> @@ -7,7 +7,7 @@
>  # Basic rmap manipulation tests for realtime files.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap collapse punch insert zero realtime
> +_begin_fstest auto quick rmap collapse punch insert zero realtime prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/344 b/tests/xfs/344
> index 230757e4..adb6627e 100755
> --- a/tests/xfs/344
> +++ b/tests/xfs/344
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/345 b/tests/xfs/345
> index 8511e568..36625e83 100755
> --- a/tests/xfs/345
> +++ b/tests/xfs/345
> @@ -10,7 +10,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/346 b/tests/xfs/346
> index 0cbe8ab3..9ce58ab8 100755
> --- a/tests/xfs/346
> +++ b/tests/xfs/346
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/347 b/tests/xfs/347
> index e5a2dcd4..1867c08c 100755
> --- a/tests/xfs/347
> +++ b/tests/xfs/347
> @@ -11,7 +11,7 @@
>  # - Check the number of extents.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick clone fiemap
> +_begin_fstest auto quick clone fiemap unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/423 b/tests/xfs/423
> index c9dfaece..a94118cc 100755
> --- a/tests/xfs/423
> +++ b/tests/xfs/423
> @@ -10,7 +10,7 @@
>  # count them if the fork is in btree format.
>  #
>  . ./common/preamble
> -_begin_fstest dangerous_scrub
> +_begin_fstest dangerous_scrub prealloc
>  
>  _register_cleanup "_cleanup" BUS
>  
> diff --git a/tests/xfs/443 b/tests/xfs/443
> index 764c63eb..56828dec 100755
> --- a/tests/xfs/443
> +++ b/tests/xfs/443
> @@ -15,7 +15,7 @@
>  # accounting inconsistency.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick ioctl fsr punch fiemap
> +_begin_fstest auto quick ioctl fsr punch fiemap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/444 b/tests/xfs/444
> index 69158f03..8f06d732 100755
> --- a/tests/xfs/444
> +++ b/tests/xfs/444
> @@ -11,7 +11,7 @@
>  # about the fix.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick prealloc
>  
>  _register_cleanup "_cleanup; rm -f $tmp.*"
>  
> diff --git a/tests/xfs/445 b/tests/xfs/445
> index 9c55cac7..ca956efc 100755
> --- a/tests/xfs/445
> +++ b/tests/xfs/445
> @@ -18,7 +18,7 @@
>  # freed inodes in a partially initialized state.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick filestreams
> +_begin_fstest auto quick filestreams prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/450 b/tests/xfs/450
> index d35e55cb..a2ba49dc 100755
> --- a/tests/xfs/450
> +++ b/tests/xfs/450
> @@ -8,7 +8,7 @@
>  # after the rmapbt has grown in size.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rmap
> +_begin_fstest auto quick rmap prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/513 b/tests/xfs/513
> index 85500af0..eb5ad8ee 100755
> --- a/tests/xfs/513
> +++ b/tests/xfs/513
> @@ -7,7 +7,7 @@
>  # XFS mount options sanity check, refer to 'man 5 xfs'.
>  #
>  . ./common/preamble
> -_begin_fstest auto mount
> +_begin_fstest auto mount prealloc
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/528 b/tests/xfs/528
> index 29e81228..2bd8c289 100755
> --- a/tests/xfs/528
> +++ b/tests/xfs/528
> @@ -8,7 +8,7 @@
>  # size is and isn't a power of 2.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick rw realtime
> +_begin_fstest auto quick insert zero collapse punch rw realtime
>  
>  # Override the default cleanup function.
>  _cleanup()
> diff --git a/tests/xfs/529 b/tests/xfs/529
> index 1cd0454d..83d24da0 100755
> --- a/tests/xfs/529
> +++ b/tests/xfs/529
> @@ -9,7 +9,7 @@
>  # mapping.
>  
>  . ./common/preamble
> -_begin_fstest auto quick quota
> +_begin_fstest auto quick quota prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/534 b/tests/xfs/534
> index 47c0dac9..f17c45b8 100755
> --- a/tests/xfs/534
> +++ b/tests/xfs/534
> @@ -7,7 +7,7 @@
>  # Verify that XFS does not cause inode fork's extent count to overflow when
>  # writing to an unwritten extent.
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick prealloc
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/535 b/tests/xfs/535
> index 1a5da61b..f76c1725 100755
> --- a/tests/xfs/535
> +++ b/tests/xfs/535
> @@ -7,7 +7,7 @@
>  # Verify that XFS does not cause inode fork's extent count to overflow when
>  # writing to a shared extent.
>  . ./common/preamble
> -_begin_fstest auto quick clone
> +_begin_fstest auto quick clone unshare
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/537 b/tests/xfs/537
> index a31652cd..7e114887 100755
> --- a/tests/xfs/537
> +++ b/tests/xfs/537
> @@ -7,7 +7,7 @@
>  # Verify that XFS does not cause inode fork's extent count to overflow when
>  # swapping forks between files
>  . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick collapse
>  
>  # Import common functions.
>  . ./common/filter
> diff --git a/tests/xfs/545 b/tests/xfs/545
> index dfe2f2dc..ccb0dd6c 100755
> --- a/tests/xfs/545
> +++ b/tests/xfs/545
> @@ -8,7 +8,7 @@
>  # than the root inode. Ensure that xfsdump/xfsrestore handles this.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dump
> +_begin_fstest auto quick dump prealloc
>  
>  # Import common functions.
>  . ./common/dump
> diff --git a/tests/xfs/554 b/tests/xfs/554
> index 7f180a71..65084cb3 100755
> --- a/tests/xfs/554
> +++ b/tests/xfs/554
> @@ -9,7 +9,7 @@
>  # and ensure that 'xfsrestore -x' handles this wrong inode.
>  #
>  . ./common/preamble
> -_begin_fstest auto quick dump
> +_begin_fstest auto quick dump prealloc
>  
>  # Import common functions.
>  . ./common/dump
> -- 
> 2.31.1
> 

