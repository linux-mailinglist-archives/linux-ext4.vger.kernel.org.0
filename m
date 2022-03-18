Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692F14DE16A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Mar 2022 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiCRS5p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Mar 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiCRS5p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Mar 2022 14:57:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07221590E
        for <linux-ext4@vger.kernel.org>; Fri, 18 Mar 2022 11:56:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c15so12421342ljr.9
        for <linux-ext4@vger.kernel.org>; Fri, 18 Mar 2022 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0WpCPeJF/glvoQcLTwJKAKI6FncEVSy4Y2K6xPy2Y8=;
        b=f7MfvhR/cTZArrnZxlIv8GZbrzzOnswona1V4BXmQPljdWKur1uZmgcfw5Gov3BZTV
         +8oIobQjsXBFlocU280eAc/KMDRwR0QsHriW+A424ELUu54U5AF1TX4DGsG3wfztxp2c
         uc7bAxqjmBZAmgiEe/ZSRGk4oCxcgeO2gFlNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0WpCPeJF/glvoQcLTwJKAKI6FncEVSy4Y2K6xPy2Y8=;
        b=Za9abtTxTowyRFkJ1IAPP6RjGCnHJpRceV9kcelr6Jy7lI3B18nENCL/jGAeAV4pdo
         k01Fj4YN8ZKUHYey3XtHKMOQ99hcChnkLo8xqTyuLBFdH1FbVYHxH1pDbH/WdfBhn70G
         NSbSph2vkZHlp9VhU9d4Y3Tdsti4fEjCPepM80cIKGWlKdsb50GKf3PPYcFPmfeDgmGl
         35PUB9vxrx6orrQcfKEBMhIKMlVCsczxHH9ypUVbDQuc0dXUEkZcx0Dg4bHBvCAJuGrh
         E9x54p+ZOu9RLFcP3KwwU/XhC244ssV/4TN7BBARetqu3pZtEbC5OU4C7iO48jNi147V
         +sFw==
X-Gm-Message-State: AOAM533AhfNcOmRxlokUye2d9RRsp6aOZVZZB+Y74f2JNPkj3cux0ivL
        BBBjzi4eV+srhUJPC2vQzpgjXxQY50XMsx85S1c=
X-Google-Smtp-Source: ABdhPJyxK2o7u06KVUr0Zcbhx/lO+As0BhxbVbaBGROBJhL+3kO9qLT76mIP1sZFmRyzSRq4GHxp+g==
X-Received: by 2002:a2e:808b:0:b0:238:ea7c:faf8 with SMTP id i11-20020a2e808b000000b00238ea7cfaf8mr6904637ljg.513.1647629784386;
        Fri, 18 Mar 2022 11:56:24 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y14-20020a2e544e000000b0024800f8286bsm1110957ljd.78.2022.03.18.11.56.21
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:56:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id t25so15486670lfg.7
        for <linux-ext4@vger.kernel.org>; Fri, 18 Mar 2022 11:56:21 -0700 (PDT)
X-Received: by 2002:a05:6512:2037:b0:448:92de:21de with SMTP id
 s23-20020a056512203700b0044892de21demr6661516lfs.52.1647629780934; Fri, 18
 Mar 2022 11:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org> <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
 <YjOlJL7xwktKoLFN@casper.infradead.org> <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
In-Reply-To: <20220318131600.iv7ct2m4o52plkhl@quack3.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
Message-ID: <CAHk-=wiky+cT7xF_2S94ToEjm=XNX73CsFHaQJH3tzYQ+Vb1mw@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 18, 2022 at 6:16 AM Jan Kara <jack@suse.cz> wrote:
>
> I agree with Dave that 'keep_towrite' thing is kind of self-inflicted
> damage on the ext4 side (we need to write out some blocks underlying the
> page but cannot write all from the transaction commit code, so we need to
> keep xarray tags intact so that data integrity sync cannot miss the page).
> Also it is no longer needed in the current default ext4 setup. But if you
> have blocksize < pagesize and mount the fs with 'dioreadlock,data=ordered'
> mount options, the hack is still needed AFAIK and we don't have a
> reasonable way around it.

I assume you meant 'dioread_lock'.

Which seems to be the default (even if 'data=ordered' is not).

Anyway - if it's not a problem for any current default setting, maybe
the solution is to warn about this case and turn it off?

IOW, we could simply warn about "data=ordered is no longer supported"
and turn it into data=journal.

Obviously *only* do this for the case of "blocksize < PAGE_SIZE".

If this ext4 thing is (a) obsolete and (b) causes VFS-level problems
that nobody else has, I really think we'd be much better off disabling
it than trying to work with it.

                 Linus
