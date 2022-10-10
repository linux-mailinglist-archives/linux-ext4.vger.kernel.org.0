Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B15F9AB0
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 10:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiJJIKB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 04:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiJJIJ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 04:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4C4AE7F
        for <linux-ext4@vger.kernel.org>; Mon, 10 Oct 2022 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665389393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QXM4F3eZALWq7+DWrWfi8eA7nzSxYJCpBdpBXH6ZUYw=;
        b=Cv39onD2/9wfg8BTsbNN2vckhLHsSY6tAyAg4bZYBVXgp/AbeQ84Pbt2HCmoLq57W2T+hw
        HTqIO8ZAqgSQgX3MRlC8Qq1YwaCmzITXk3liIzFqj01MZ1UJkbFR67ZSgcnLU3/aXGqPCT
        opvQd7WQSop9F4X6Q82uMieiBgBR0TE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-z0yR_T0eNsaOPpDwSaxGlg-1; Mon, 10 Oct 2022 04:09:48 -0400
X-MC-Unique: z0yR_T0eNsaOPpDwSaxGlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E0411C0514F;
        Mon, 10 Oct 2022 08:09:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB14440E992D;
        Mon, 10 Oct 2022 08:09:46 +0000 (UTC)
Date:   Mon, 10 Oct 2022 10:09:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     zhanchengbin <zhanchengbin1@huawei.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
Message-ID: <20221010080944.u447ovrfpmpjwj6q@ws.net.home>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
 <20220929112813.6aqtktwaff2m7fh2@fedora>
 <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
 <20220930072042.dwakvbnefctk2jyd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930072042.dwakvbnefctk2jyd@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 30, 2022 at 09:20:42AM +0200, Lukas Czerner wrote:
> On Fri, Sep 30, 2022 at 09:42:52AM +0800, zhanchengbin wrote:
> > 
> > 
> > On 2022/9/29 19:28, Lukas Czerner wrote:
> > > Hi,
> > > 
> > > indeed we'd like to avoid killing the instance that was not ran because
> > > of noexecute. Can you try the following patch?
> > > 
> > > Thanks!
> > > -Lukas
> > 
> > Yes, you're right, I think we can fix it in this way.
> > 
> > diff --git a/misc/fsck.c b/misc/fsck.c
> > index 1f6ec7d9..91edbf17 100644
> > --- a/misc/fsck.c
> > +++ b/misc/fsck.c
> > @@ -547,6 +547,8 @@ static int kill_all(int signum)
> >         for (inst = instance_list; inst; inst = inst->next) {
> >                 if (inst->flags & FLAG_DONE)
> >                         continue;
> > +               if (inst->pid == -1)
> > +                       continue;
> 
> Yeah, that works as well although I find the "if (noexecute)" condition
> more obvious. We can do both. Also rather than checking for -1 we can
> check for <= 0 since anything other than real pid at this point is a bug.
> 
> Feel free to send a proper patch.

Yes, please. It would be nice to have the same solution in the both
(e2fsprogs and util-linux) trees.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

