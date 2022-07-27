Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D245825E8
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 13:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiG0LxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiG0LxQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 07:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1363025285
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658922794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMfHKlFrYjnxovEaG8YemezedsneUgj3glxjTg4e+70=;
        b=J7n+/k7EmMoIXMj4eOOMh8Q2loTLcXBgFa4197U3EoC8N+woKhG/cLaAc+RmS7dLLatM7T
        VhNA3HovW7Ji6KotgD5DgrvZUMceWSqLAMV8s1HpHioymd8W7xUbH9gBqylChGyAflBTPQ
        V1t5bi5Dya7wNfxUWNv1lxYBBKg3ZKU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-RjB390kPNJG_b5QCft_A1w-1; Wed, 27 Jul 2022 07:53:10 -0400
X-MC-Unique: RjB390kPNJG_b5QCft_A1w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B770802E5D;
        Wed, 27 Jul 2022 11:53:10 +0000 (UTC)
Received: from fedora (unknown [10.40.192.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E04A418EB7;
        Wed, 27 Jul 2022 11:53:09 +0000 (UTC)
Date:   Wed, 27 Jul 2022 13:53:07 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     bugzilla-daemon@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220727115307.qco6dn2tqqw52pl7@fedora>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuBKMLw6dpERM95F@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> If you are going to run some scripted tool to randomly
> corrupt the filesystem to find failures, then you have an
> ethical and moral responsibility to do some of the work to
> narrow down and identify the cause of the failure, not just
> throw them at someone to do all the work.
> 
> --D

While I understand the frustration with the fuzzer bug reports like this
I very much disagree with your statement about ethical and moral
responsibility.

The bug is in the code, it would have been there even if Wenqing Liu
didn't run the tool. We know there are bugs in the code we just don't
know where all of them are. Now, thanks to this report, we know a little
bit more about at least one of them. That's at least a little useful.
But you seem to argue that the reporter should put more work in, or not
bother at all.

That's wrong. Really, Wenqing Liu has no more ethical and moral
responsibility than you finding and fixing the problem regardless of the
bug report.

I think the frustration comes from the fact that it's potentially a lot
of work to untangle and fix the real problem and now when it is out
there we feel obligated to fix it. And while bug reports and tools
generating these can always be better and reporters can always be a bit
more active in narrowing the problem down, you're of course free to
ignore this until you, or anyone else, has a bit of spare time and
energy to investigate.

-Lukas

