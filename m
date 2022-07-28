Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E427B583975
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Jul 2022 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiG1HZV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Jul 2022 03:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiG1HZU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Jul 2022 03:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 022E4BC92
        for <linux-ext4@vger.kernel.org>; Thu, 28 Jul 2022 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658993117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+tMkjEMziXVWQL0Hc0sIbnW0UNTbgF4ku145LrrHidY=;
        b=OsuIoib4y6iDAU2T4JcHju9h9s/tk+nvSZOZRh4/F9YKmQ0sBrGfMdu88baT6urEpfekVC
        XKlwGwJM8vV4L6uGW9IaJV114RqL1HQdbPvT7M6tU2FXH2DuKz8I3ptB9WCmeRSwoEtm8m
        pXC8GdKE7p/Xz5f1DWVP4mZHeG3loas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-73_cM-pEO8y-2M9qmTaPfw-1; Thu, 28 Jul 2022 03:25:13 -0400
X-MC-Unique: 73_cM-pEO8y-2M9qmTaPfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 597CE85A585;
        Thu, 28 Jul 2022 07:25:13 +0000 (UTC)
Received: from fedora (unknown [10.40.193.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B5AF1121314;
        Thu, 28 Jul 2022 07:25:12 +0000 (UTC)
Date:   Thu, 28 Jul 2022 09:25:10 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220728072510.yunkzplfqx2vt4wb@fedora>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727232224.GW3600936@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 28, 2022 at 09:22:24AM +1000, Dave Chinner wrote:
> On Wed, Jul 27, 2022 at 01:53:07PM +0200, Lukas Czerner wrote:
> > On Tue, Jul 26, 2022 at 01:10:24PM -0700, Darrick J. Wong wrote:
> > > If you are going to run some scripted tool to randomly
> > > corrupt the filesystem to find failures, then you have an
> > > ethical and moral responsibility to do some of the work to
> > > narrow down and identify the cause of the failure, not just
> > > throw them at someone to do all the work.
> > > 
> > > --D
> > 
> > While I understand the frustration with the fuzzer bug reports like this
> > I very much disagree with your statement about ethical and moral
> > responsibility.
> > 
> > The bug is in the code, it would have been there even if Wenqing Liu
> > didn't run the tool.
> 
> Yes, but it's not just a bug. It's a format parser exploit.

And what do you think this is exploiting? A bug in a "format parser"
perhaps?

Are you trying both downplay it to not-a-bug and elevate it to 'security
vulnerability' at the same time ? ;)

> 
> > We know there are bugs in the code we just don't
> > know where all of them are. Now, thanks to this report, we know a little
> > bit more about at least one of them. That's at least a little useful.
> > But you seem to argue that the reporter should put more work in, or not
> > bother at all.
> > 
> > That's wrong. Really, Wenqing Liu has no more ethical and moral
> > responsibility than you finding and fixing the problem regardless of the
> > bug report.
> 
> By this reasoning, the researchers that discovered RetBleed
> should have just published their findings without notify any of the
> affected parties.
> 
> i.e. your argument implies they have no responsibility and hence are
> entitled to say "We aren't responsible for helping anyone understand
> the problem or mitigating the impact of the flaw - we've got our
> publicity and secured tenure with discovery and publication!"
> 
> That's not _responsible disclosure_.

Look, your entire argument hinges on the assumption that this is a
security vulnerability that could be exploited and the report makes the
situation worse. And that's very much debatable. I don't think it is and
Ted described it very well in his comment.

Asking for more information, or even asking reported to try to narrow
down the problem is of course fine. But making sweeping claims about
moral and ethical responsibilities is always a little suspicious and
completely bogus in this case IMO.

-Lukas

