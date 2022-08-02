Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B485879D4
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Aug 2022 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiHBJ2u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Aug 2022 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiHBJ2s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Aug 2022 05:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 598641BE8E
        for <linux-ext4@vger.kernel.org>; Tue,  2 Aug 2022 02:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659432526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxPWtHy/Rc7WpmYKejrALDu7klNSMC4Sh6u+LbIhZcE=;
        b=EKqTyIpukCRSn7SSfJT6z3PGuphncK2LZfDQIlOkYk5jk+CXUv6hkv1FXH8iRcjJ5p+FUZ
        VQrEOPjfWGCAa4ZN9JFi2fqjVyr2dlyxxsXIjslLqtGw7YVM9eGsma9MDQ8DUYZ3Pm8JQI
        9NCGFNTyvpp+WdTZ0JaENmif9nRo7xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-lA9qFvPzMw6kcD-jkF7Zhg-1; Tue, 02 Aug 2022 05:28:41 -0400
X-MC-Unique: lA9qFvPzMw6kcD-jkF7Zhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A230E8037B5;
        Tue,  2 Aug 2022 09:28:40 +0000 (UTC)
Received: from fedora (unknown [10.40.194.249])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D71901410F38;
        Tue,  2 Aug 2022 09:28:39 +0000 (UTC)
Date:   Tue, 2 Aug 2022 11:28:37 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, bugzilla-daemon@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [Bug 216283] New: FUZZ: BUG() triggered in
 fs/ext4/extent.c:ext4_ext_insert_extent() when mount and operate on crafted
 image
Message-ID: <20220802092837.wqgut2i6kkbehcof@fedora>
References: <bug-216283-13602@https.bugzilla.kernel.org/>
 <YuBKMLw6dpERM95F@magnolia>
 <20220727115307.qco6dn2tqqw52pl7@fedora>
 <20220727232224.GW3600936@dread.disaster.area>
 <20220728072510.yunkzplfqx2vt4wb@fedora>
 <20220801224551.GA3861211@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801224551.GA3861211@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 02, 2022 at 08:45:51AM +1000, Dave Chinner wrote:

--- snip ---

> > 
> > Look, your entire argument hinges on the assumption that this is a
> > security vulnerability that could be exploited and the report makes the
> > situation worse. And that's very much debatable. I don't think it is and
> > Ted described it very well in his comment.
> 
> On systems that automount filesytsems when you plug in a USB drive
> (which most distros do out of the box) then a crash bug during mount
> is, at minimum, an annoying DOS vector. And if it can result in a
> buffer overflow, then....
> 
> > Asking for more information, or even asking reported to try to narrow
> > down the problem is of course fine.
> 
> Sure, nobody is questioning how we triage these issues - the
> question is over how they are reported and the forum under which the
> initial triage takes place
> 
> > But making sweeping claims about
> > moral and ethical responsibilities is always a little suspicious and
> > completely bogus in this case IMO.
> 
> Hand waving away the fact that fuzzer crash bugs won't be a security
> issue without having done any investigation is pretty much the whole
> problem here. This is not responsible behaviour.

Since it's obvious that the security status of this is disputed, then
please feel free to create guidelines stating that fuzzer bugs for xfs
are considered a security issues and reporters should follow guidelines
of responsible disclosure and bugs are not to be reported publicly.

Problem solved and no moralizing needed.

-Lukas

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

