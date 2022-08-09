Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C158D6DA
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbiHIJyA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiHIJx6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 05:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FC3723179
        for <linux-ext4@vger.kernel.org>; Tue,  9 Aug 2022 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660038836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8/HBkjbt+K6SQvBDy2kU7f/Iydj8sIpgQn064wD42V0=;
        b=bVUodCND+NGitdJD8WGXEvbOvx42DXuDxREslWNf6ODO5gJ6SllweQ0Bnt4I5rBv8QPZmW
        SIeB0xSbtqV+k5dH+JggG/cRCD5POmLTst7eqZaI12g4fmr1hYQDuxyWb0UiOqQaRF/3wG
        ygQo2d7WgcHpJDedvkPJ/PwXTa5IRnY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-GDyFqVbeNzuTHs5V6cfcbA-1; Tue, 09 Aug 2022 05:53:52 -0400
X-MC-Unique: GDyFqVbeNzuTHs5V6cfcbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 02FEB3C025C2;
        Tue,  9 Aug 2022 09:53:52 +0000 (UTC)
Received: from fedora (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6420EC15BA1;
        Tue,  9 Aug 2022 09:53:50 +0000 (UTC)
Date:   Tue, 9 Aug 2022 11:53:48 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        minchan@kernel.org, ngupta@vflare.org, Jan Kara <jack@suse.com>,
        Ted Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext2/zram issue [was: Linux 5.19]
Message-ID: <20220809095348.lojwndf7uwolpfvo@fedora>
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <702b3187-14bf-b733-263b-20272f53105d@kernel.org>
 <20220809091212.mgreambnhgso5hzw@fedora>
 <YvIluTU6oFDpwQwK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvIluTU6oFDpwQwK@google.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 09, 2022 at 06:15:37PM +0900, Sergey Senozhatsky wrote:
> On (22/08/09 11:12), Lukas Czerner wrote:
> > Hi Jiri,
> > 
> > I've tried a quick xfstests run on ext2 on zram and I can't see any
> > issues like this so far. I will run a full test and report back in case
> > there is anything obvious.
> 
> AFAICT this should be visible only when we are under memory pressure,
> so that direct reclaim from zs_malloc handle allocation call makes a
> difference.
> 

True, I haven't seen the other email from Jiri, sorry about that. I can
confirm that under memory pressure it is in fact reproducible with
xfstests and also I can confirm that reverting
e7be8d1dd983156bbdd22c0319b71119a8fbb697 makes it go away.
But Jiri has a better repro already anyway.

Thanks!
-Lukas

