Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7157E375
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiGVPL0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiGVPLY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 11:11:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95306951DD
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658502682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xi8dTMRGNSd0HqoORa/8kAp5M9DPhO5fCb8gODNwrS8=;
        b=MnFVpx0VJ6kxOx/a+a/i1bUR7wl48ZN6Ipbuf7B6tNAke8QRJmOiXCnHfuBLJO9MPCCm2Y
        7rZXbcR/by06jKJkwBQuI4xPKrkv8M4GVn3oniRGZ9VSUzJDx92RQ3FrsZBwc94ZVafwTZ
        A5PqWWIbaPwHQ3yKmgg6VW7edTRiHXk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-si0x10VPMpqew8MZpJwMgg-1; Fri, 22 Jul 2022 11:11:21 -0400
X-MC-Unique: si0x10VPMpqew8MZpJwMgg-1
Received: by mail-qk1-f198.google.com with SMTP id k190-20020a37bac7000000b006af6d953751so3929527qkf.13
        for <linux-ext4@vger.kernel.org>; Fri, 22 Jul 2022 08:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xi8dTMRGNSd0HqoORa/8kAp5M9DPhO5fCb8gODNwrS8=;
        b=IUntI1sD5PSSY3JHibPDJ4lcgN0sxFyDWWoblgYbn0EkYB7Ni27zzyT5BNGQc7gKjV
         QoEI5E/f7geQIgD4CXrGgA6qpv8xldFkEZPfGO5J1jieq4acchyD7XlA6ZpQwlNpC/o8
         wyb/FJNxEmy4bpsuv3EakpUY/ORzarzekaH7r6q32M8u9TVByNPkoIwljpKWNqSndx5r
         esMNLjwq2U5+H9RTcdDm+Hg8Em0wa2ktEViOTfWQmDdsMsSJm1RQ629hTf+Wb8BieQxF
         QdgrULGrLCCCDCNEpP3sN4LduDfRiawT69zwtPrEVNwkueNAD39JAKLX6kihuLV4uKfV
         42Rw==
X-Gm-Message-State: AJIora9JThsjGT5k2E/Twu94LRLLeXH7otVRQfnJ4mXPOQlocrBQ1sQz
        w4q1yMP/NLZfF4ugO0FcYcLzais5nguYS3dccEUwEjG9Lqt8m9N9HOwbjNa+aNdgkv96ycc4fiJ
        hMTRcJk3Hh1BQKI1d5GcMiA==
X-Received: by 2002:a37:b03:0:b0:6b5:e533:e984 with SMTP id 3-20020a370b03000000b006b5e533e984mr281230qkl.364.1658502680842;
        Fri, 22 Jul 2022 08:11:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uq3flzgxrqK1gQXJEHFwK4uxREs0DKbcZ8RAp9PLHwPr7/n5KyiFPkrP0IlE4UhjA3p2EX5A==
X-Received: by 2002:a37:b03:0:b0:6b5:e533:e984 with SMTP id 3-20020a370b03000000b006b5e533e984mr281210qkl.364.1658502680564;
        Fri, 22 Jul 2022 08:11:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d17-20020ac81191000000b0031ee3449f34sm2933907qtj.86.2022.07.22.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 08:11:20 -0700 (PDT)
Date:   Fri, 22 Jul 2022 23:11:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Sun Ke <sunke32@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Message-ID: <20220722151114.c4w7s6v6fu5hphf5@zlang-mailbox>
References: <20220713092859.3881376-1-sunke32@huawei.com>
 <20220713092859.3881376-2-sunke32@huawei.com>
 <20220714154607.qq6cqgvncxhsn66w@zlang-mailbox>
 <YtCSAjiMc9RElnHu@mit.edu>
 <20220715180815.gegmapvruor6vin3@zlang-mailbox>
 <b424fd69-aeb4-f749-d09b-5d824454dd94@huawei.com>
 <YtqPXcFbbrFBr1om@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YtqPXcFbbrFBr1om@mit.edu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 22, 2022 at 07:51:57AM -0400, Theodore Ts'o wrote:
> On Fri, Jul 22, 2022 at 04:16:26PM +0800, Sun Ke wrote:
> > 
> > 1. The test run fsck automatically, and complain inconsistent，I think it
> > need not run fsck.
> 
> The check script always run fscks after the test.  In order to
> suppress the fsck complaint, we'll need to add this after the
> resize2fs invocation:
> 
> _scratch_unmount
> $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 0" $SCRATCH_DEV \
>         >>$seqres.full 2>&1
> 
> This resets the s_reserved_gdt_blocks field back to zero, so the fsck
> doesn't fail.  Which is fine, because the point of the test is to see
> whether the kernel dereferences a NULL pointer or not.

Or maybe just replace _reuqire_scratch with _require_scratch_nocheck, if we
corrupt the fs on SCRATCH_DEV intentionally?

Thanks,
Zorro

> 
> > 2. It warn missing kernel fix, but the commit had merged.
> 
> The way _fixed_by_kernel_commit works is if the test fails (for any
> reason), it prints that you MAY be missing the bugfix commit:
> 
> > HINT: You _MAY_ be missing kernel fix:
> >       b55c3cd102a6 ext4: add reserved GDT blocks check
> 
> 		     	       		- Ted
> 

