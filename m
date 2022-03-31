Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E194EDC3B
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Mar 2022 16:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbiCaPBL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Mar 2022 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiCaPBK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Mar 2022 11:01:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 530BF1168E4
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648738755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3UPSXsBXbBxR9jHAQjImYmyrxFJbYvzkW4HvUR0RY0c=;
        b=TNjW3tlQZtbnRvwxJw9LOPpD9csGhs3BfgmIxcjxRmSbEor8DHn60ZF0fxPJ6zng0Q5yS2
        6ejsDELryrpSiwIz0TwkyhmGajNMjxhzttJuHkT8bffiDHdfVMA+Px5GEJGpXgDPjdgsdp
        pou33ogjwsMUCndvS1pDGRFABFesiww=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-FIGt0kFTMvyrocgqJlLdcA-1; Thu, 31 Mar 2022 10:59:13 -0400
X-MC-Unique: FIGt0kFTMvyrocgqJlLdcA-1
Received: by mail-pj1-f71.google.com with SMTP id lr15-20020a17090b4b8f00b001c646e432baso2003975pjb.3
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 07:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3UPSXsBXbBxR9jHAQjImYmyrxFJbYvzkW4HvUR0RY0c=;
        b=RHNQ1STSYiN8a/1P+O0VE+FYV9rWp3QATOSBNqDLGNhlo1xcYkBx3A5jPDMfpg1CR1
         iURSkDpH7JNuxxMX30/eBJ4AAFrEWX0ApqmSKQH7f0VJz3XnIjgMPO3A9WvV+hiRra8x
         c0J+VWBfJgIvjdEMGBec3rM3kA5ffKt8wOREIV+rz7Nop/Yc1IR411jlNyuAjHpyWPG4
         m6XLwZM3qNkmDHCEMuztym3ymGU4nl34lOSVRevJe8IA0/vM9CgsaovUZ5hafLKMgmm2
         GOLjCDaIqnHkmSEQzSqrHH/NkhCFDtqR+mkMqW7chBLHR15zwQdK6038sjILDWWR0rN5
         kIHg==
X-Gm-Message-State: AOAM5300ngXDmr8pGIdGqLCqltNGU6dl8LdeQ+pGByudmv003wmN/TC9
        Q4xmjPi+8mmtpVukumQLnVcCA1RN3CsnBDrt5Y4axANKYnVh7gfc4YIgsTJ8TYBxlZchfxkXC9X
        qfIvY2GZUKXRVnjMbg9xQYg==
X-Received: by 2002:a63:6e49:0:b0:385:fb1c:f432 with SMTP id j70-20020a636e49000000b00385fb1cf432mr10797241pgc.207.1648738751759;
        Thu, 31 Mar 2022 07:59:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoZT5wDF0poe6aQsfaCzO2CaFeO81E9wI6C1m3GKnpl4KY3oJD0fPCgsFrjKsx8qQ3ar62iw==
X-Received: by 2002:a63:6e49:0:b0:385:fb1c:f432 with SMTP id j70-20020a636e49000000b00385fb1cf432mr10797226pgc.207.1648738751410;
        Thu, 31 Mar 2022 07:59:11 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d21-20020a056a0010d500b004fd9ee64134sm7189852pfu.74.2022.03.31.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:59:10 -0700 (PDT)
Date:   Thu, 31 Mar 2022 22:59:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
References: <cover.1648730443.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648730443.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> Hello,

Hi,

Your below patches looks like not pure text format, they might contain
binary character or some special characers, looks like the "^M" [1].

So please check how you generate/edit/send these patches, make sure
they're pure text for Linux then send again.

Thanks,
Zorro


[1]
# cat -A /path/to/your_patch
index 95752d3b..5e73cff9 100755^M$
--- a/tests/generic/468^M$
+++ b/tests/generic/468^M$
@@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1^M$
 _require_metadata_journaling $SCRATCH_DEV^M$
 _scratch_mount^M$
 ^M$
+# blocksize and fact are used in the last case of the fsync/fdatasync test.^M$
+# This is mainly trying to test recovery operation in case where the data^M$
+# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.^M$
+blocks=32768^M$
+blocksize=4096^M$
+fact=18^M$
+^M$
...
...

> 
> The ext4 fast_commit kernel fix has landed into mainline tree [1].
> In this v3, I have addressed review comments from Darrick.
> Does this looks good to be picked up?
> 
> I have tested ext4 1k, 4k (w & w/o fast_commit). Also tested other FS with
> default configs (like xfs, btrfs, f2fs). No surprises were seen.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> 
> -ritesh
> 
> Changelogs:
> ===========
> 
> v2 => v3
> =========
> 1. Addressed review comments from Darrick.
> 2. Rebased to latest master.
> 
> v1 => v2
> =========
> Sending v2 with tests/ext4/ converted to tests/generic/
> (although I had not received any review comments on v1).
> It seems all of the tests which I had sent in v1 are not ext4 specific anyways.
> So in v2, I have made those into tests/generic/.
> 
> Summary
> =========
> These are some of the tests which when tested with ext4 fast_commit feature
> w/o kernel fixes, could cause tests failures and/or KASAN bug (generic/486).
> 
> I gave these tests a run with default xfs, btrfs and f2fs configs (along with
> ext4). No surprises observed.
> 
> [v2]: https://lore.kernel.org/all/cover.1647342932.git.riteshh@linux.ibm.com/
> [v1]: https://lore.kernel.org/all/cover.1644070604.git.riteshh@linux.ibm.com/
> 
> 
> Ritesh Harjani (4):
>   generic/468: Add another falloc test entry
>   common/punch: Add block_size argument to _filter_fiemap_**
>   generic/678: Add a new shutdown recovery test
>   generic/679: Add a test to check unwritten extents tracking
> 
>  common/punch          |  9 +++---
>  tests/generic/468     |  8 +++++
>  tests/generic/468.out |  2 ++
>  tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/678.out |  7 +++++
>  tests/generic/679     | 65 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/679.out |  6 ++++
>  7 files changed, 165 insertions(+), 4 deletions(-)
>  create mode 100755 tests/generic/678
>  create mode 100644 tests/generic/678.out
>  create mode 100755 tests/generic/679
>  create mode 100644 tests/generic/679.out
> 
> --
> 2.31.1
> 

