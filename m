Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E656C0A5
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbiGHQhH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiGHQhG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 12:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED3F513D23
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jul 2022 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657298223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Zr0jbSDEiPewoOYQiS8jt5xohMJS4RyFoMUqblRWb4=;
        b=JcBQPDIiLbT8qfklKwE7WjmkNx4gV/7m/VOwwCCUj25h6pVHXuOj2YeHBYf/+i906xEp+K
        C4/o8cwkt/WAfLaRF1J9NOnYo7y26nX7SFvtsMEWDdt+/xw/+Qn5nls22fbkYc0tui1kFg
        y3fAiZ5lJKchJ8ruE5RpvjGiwDsU+Y4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-iIMvRKSuPUSaoYIr1FJCkg-1; Fri, 08 Jul 2022 12:37:02 -0400
X-MC-Unique: iIMvRKSuPUSaoYIr1FJCkg-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac87c56000000b0031d4ab81b21so15126042qtv.1
        for <linux-ext4@vger.kernel.org>; Fri, 08 Jul 2022 09:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Zr0jbSDEiPewoOYQiS8jt5xohMJS4RyFoMUqblRWb4=;
        b=jq2SaBKZSU5nIv2qKCAjtMotF5SUf/Mfi+KA86Yg8MZ+RKCyIUabzmX3ypDScyBfM8
         F0wE6SZ9GhFEQTmV8IvODuOlEk3rNzk3qJrhDJkdjLmMBCYt2zeyqc4EttYFP28DzltH
         VWcgnMgPkajQcTpoYg+P4zriiq+eWw32wLzxrEcDtHTVRmSDznUtdMZJNkI/+5gpjzLF
         UGRhpgDbShmq4Qb6gSCYJEl3hONyxTm11ah3L7LJB7WGSBLxj24LBb+rObKq0OCa121G
         sq57vGJIsETpPKhgy2pMbL54Zdr8TFFWV/isF70u9/+pUdzX4IlAsKMWXkvPwB/HvSxC
         Kj9A==
X-Gm-Message-State: AJIora92oBPWgBm/tK4eE7R9CGFUfVjQwz+qO8SaRc37xt4nFq4iWkir
        5yU8hsXNX7ikVkU5bFcmg4bOEiahf3yG3lpIO+lzz9eDYXR915nRZlkWtdKYMMHD4iIFpqNFPT8
        4PPI8pGCGZeu/jDQ4re4DXw==
X-Received: by 2002:a05:6214:20e4:b0:472:f202:e5c9 with SMTP id 4-20020a05621420e400b00472f202e5c9mr3435934qvk.117.1657298221778;
        Fri, 08 Jul 2022 09:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tLodHqnMICc3jBUKWfFxKS8MZ0KSELXWib57FdwdsymYtEgFHgG/9uQS0BGeTCQ1NH1J9DcQ==
X-Received: by 2002:a05:6214:20e4:b0:472:f202:e5c9 with SMTP id 4-20020a05621420e400b00472f202e5c9mr3435909qvk.117.1657298221487;
        Fri, 08 Jul 2022 09:37:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19-20020ae9eb13000000b006aee672937esm33860039qkg.37.2022.07.08.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:37:00 -0700 (PDT)
Date:   Sat, 9 Jul 2022 00:36:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu, djwong@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 0/5] check: add option to rerun failed tests
Message-ID: <20220708163654.7luwvjfdn4ep5jgw@zlang-mailbox>
References: <20220708085142.20991-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708085142.20991-1-ddiss@suse.de>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 08, 2022 at 10:51:37AM +0200, David Disseldorp wrote:
> This patchset adds support to loop on failed tests, as proposed by
> Ted Ts'o in https://lwn.net/Articles/897061/:
>   add a mode that will immediately rerun a failed test 25 or 100 times
>   to establish a failure percentage.

This patchset is good to me. if no more objections, I think it's time
to merge this feature. I'll give it a testing, then try to push it
this weekend.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> Changes since (v3), following Darrick's review:
> - extended full/out.bad/etc. retention to cover more paths and remove
>   stale .rerun# files
> 
> Changes since (v2), following Darrick's review:
> - dropped RFC flag
> - rebased atop v2022.07.03
> - simplified test iterator
>   + results stashed at the end of each iteration, rather than start of
>     next / loop-exit
> - dropped aggregate loop stats message from xunit report
> - squashed full/dmesg/out.bad file retention patch with rerun patch
> 
> Changes since (v1):
> - rebased atop upstream v2022.06.26
> - added a few extra cleanup commits
> - append details for every rerun to xunit output
>   + provide aggregate stats via <testcase status=X>
> - extend _stash_test_status to call report hook, as well as save failure
>   artifacts with a .rerun# suffix
> 
> Diffstat:
>  check         | 137 +++++++++++++++++++++++++++++++++++++-------------
>  common/report |  90 ++++++++++++++++-----------------
>  2 files changed, 144 insertions(+), 83 deletions(-)
> 
> 

