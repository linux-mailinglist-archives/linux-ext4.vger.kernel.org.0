Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB71A5FA250
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 19:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJJRBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJRBk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 13:01:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65066128
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 10:01:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso13614245pjf.2
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfr6H5O7vFRZ+/xImrbGMQVEpqVo4OWqQRkRP1dlzuw=;
        b=IDbzdUyE4Ipqn5WiyGLuKV1+0vVWDDPkDjDSqN/PDsMfXYHPPZ0ljKfjiGzojyNSrl
         F/B1erIfB9sGEKTrGSc+fGFo4ZnWxuA4Z+bn29zaaUY6BWBIFrqsz038ySGBeZ/u3H1n
         gSt+2A7pubYGmyQELYKpeErsOYj8032bqXGxsIPDND5SBAQEALPV7mBj9izCpApOD/jd
         NMha/kV4Ogpm/EvbgA/JyB76SSpLCsa3hk+VKktKuebA60WjJ7tFTVHbJz7EsTpGIh59
         Pq/p9jKKKIFtTZJ9K2pg7gFSb5Vhe4boV94cY7XylFa0B2dP0xcUYESwC1OJ8RTQFLok
         DW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfr6H5O7vFRZ+/xImrbGMQVEpqVo4OWqQRkRP1dlzuw=;
        b=1sQpPldDTafeN/Ro36F7wQ3gI7ndcMMM2En7uDB2WsTg8h0YAxbQwYzYbkPJbS4npA
         SJbeg2luPuhPHxZONThkXG8ZQ9f2L9UAyJkNo/eDzDuiW+orNciahiQrWS7lc6hWIMCI
         Xjo/7StIW1WY9YuX4ZBDzlg5pULDvcGsct4YBWJPeBiMjgQkz//yttaiWirCod2DTxIk
         Xsi7Z4hAT2cINpkD+7Ug0cnhYs3qFZjKL2lhZb+awncQZ6FjfauvqECNDzaslJFqjthc
         AihTikuy14r97urtryx36qoFHJiKf8QRsakjW0sMIBFN8HqGKciHXH3DABBGntH6WX1J
         9fNg==
X-Gm-Message-State: ACrzQf0Ir/p9U3OvXPqf14C4v+qxxGqeraBU/7tdsQH22sG9dHtLDWlK
        DoYE8G84AuzED0KG0F22jsd9Fncj0HY=
X-Google-Smtp-Source: AMsMyM71/Ad/ukN/dL4AEAJ7Ry8YhFQxAS1hfQ97XDWhXr35P1P4vWEBPk2B7indfaKPSAi4Be+ULw==
X-Received: by 2002:a17:902:efc9:b0:183:88ed:d15e with SMTP id ja9-20020a170902efc900b0018388edd15emr29330plb.139.1665421299029;
        Mon, 10 Oct 2022 10:01:39 -0700 (PDT)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id s23-20020a17090a1c1700b001fabcd994c1sm9386959pjs.9.2022.10.10.10.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 10:01:38 -0700 (PDT)
Date:   Mon, 10 Oct 2022 22:31:33 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     bugzilla-daemon@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [Bug 216529] New: [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Message-ID: <20221010170133.ti2t26nu72tvcbxc@riteshh-domain>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
 <YzEySPNMuIcfsda9@mit.edu>
 <20220927181049.jpk3b52ssmq326b5@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927181049.jpk3b52ssmq326b5@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/27 11:40PM, Ritesh Harjani (IBM) wrote:
> On 22/09/26 01:02AM, Theodore Ts'o wrote:
> > On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=216529
> > >
> > >
> > > Hit a panic on ppc64le, by running generic/048 with 1k block size:
> >
> > Hmm, does this reproduce reliably for you?  I test with a 1k block
> > size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
> > < pagesize... and this isn't reproducing for me on x86, and I don't
> > have access to a PPC64LE system.
> >
> > Ritesh, is this something you can take a look at it?  Thanks!
>
> I was away for some personal work for last few days, but I am back to work from
> today. Sure, I will take a look at this and will get back.
>
> I did give this test a couple of runs though, but wasn't able to reproduce it.
> But let me try few more things along with more iterations. Will update
> accordingly.

I thought I had updated this. But I guess I forgot to update on this mail
thread...

I tested this for quite some time in a loop and also gave it a overnight run,
but I couldn't hit this issue. I had kept low memory size guest, so that we
could see more reclaim activity (which I also ensured by doing perf trace to see
if we are going over that path or not while test was running).

I am not sure whether this could be a timing issue or what. Maybe if you could
share your defconfig, I could give a try with that on my setup once.

-ritesh
