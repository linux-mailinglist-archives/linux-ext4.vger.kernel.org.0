Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976852113C
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiEJJrL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEJJrK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 05:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC46E6A42B
        for <linux-ext4@vger.kernel.org>; Tue, 10 May 2022 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652175793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7oZv0qDe8PoR2IcozjQ8ABMi0/YE7k7caegZ0ltZM3c=;
        b=fqxve5YUuVxOwA/MF3tRMyiK4ijYLcaqHxLljzGPI8CcYHmYpWGWcKwLoQ3+abDzdR7Su9
        TU051qIgNusf3p+fIdGFi3SJ8SQDCtOm3CxI1jJaydQlK244HMj531rvEEMX8U4HGpB3Pv
        nuUqWPRUq1wjcThLLlFgIADsmRT2kpE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-Jh8by8wSN_ORnc3JoBFF4w-1; Tue, 10 May 2022 05:43:11 -0400
X-MC-Unique: Jh8by8wSN_ORnc3JoBFF4w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E7AB811E75;
        Tue, 10 May 2022 09:43:11 +0000 (UTC)
Received: from fedora (unknown [10.40.193.237])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE2BB417E3F;
        Tue, 10 May 2022 09:43:10 +0000 (UTC)
Date:   Tue, 10 May 2022 11:43:08 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [xfstests PATCH] ext4/053: fix the rejected mount option testing
Message-ID: <20220510094308.mhzvcgq5wrat5qao@fedora>
References: <20220430192130.131842-1-ebiggers@kernel.org>
 <Ynmmy+bWp0Q1/747@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynmmy+bWp0Q1/747@sol.localdomain>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 09, 2022 at 04:42:03PM -0700, Eric Biggers wrote:
> On Sat, Apr 30, 2022 at 12:21:30PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > 'not_mnt OPTIONS' seems to have been intended to test that the
> > filesystem cannot be mounted at all with the given OPTIONS, meaning that
> > the mount fails as opposed to the options being ignored.  However, this
> > doesn't actually work, as shown by the fact that the test case 'not_mnt
> > test_dummy_encryption=v3' is passing in the !CONFIG_FS_ENCRYPTION case.
> > Actually ext4 ignores this mount option when !CONFIG_FS_ENCRYPTION.
> > (The ext4 behavior might be changed, but that is besides the point.)
> > 
> > The problem is that the do_mnt() helper function is being misused in a
> > context where a mount failure is expected, and it does some additional
> > remount tests that don't make sense in that context.  So if the mount
> > unexpectedly succeeds, then one of these later tests can still "fail",
> > causing the unexpected success to be shadowed by a later failure, which
> > causes the overall test case to pass since it expects a failure.
> > 
> > Fix this by reworking not_mnt() and not_remount_noumount() to use
> > simple_mount() in cases where they are expecting a failure.  Also fix
> > up some of the naming and calling conventions to be less confusing.
> > Finally, make sure to test that remounting fails too, not just mounting.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  tests/ext4/053 | 148 ++++++++++++++++++++++++++-----------------------
> >  1 file changed, 78 insertions(+), 70 deletions(-)
> 
> Lukas, any thoughts on this patch?  You're the author of this test.
> 
> - Eric

Haven't tested it myself but the change looks fine, thanks.

You can add
Reviewed-by: Lukas Czerner <lczerner@redhat.com>

