Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFB75F059B
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 09:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiI3HU5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Sep 2022 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiI3HU4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Sep 2022 03:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF7123848
        for <linux-ext4@vger.kernel.org>; Fri, 30 Sep 2022 00:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664522452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiQbNrtfmXMC5cy1TkFU4ki7ghnl5s6b1zmYauHjwMw=;
        b=fy04RRvINjyh0RnJrhsHOhU4ftEfZBceAvZFzIey8tWRNiGEmgTemlfhABiUbdKU3RNlUc
        TrxM159NlHtRWgplP+1Ft69IjulNgZZPc1tJtmrk+7y3R42q+leN0ZpJJ05v4/AX779WTQ
        qOGaEOdKHAPnZwzRBnIDZnBk15/vCfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-eqb_9zyvMoGQ9MSNRYePrA-1; Fri, 30 Sep 2022 03:20:46 -0400
X-MC-Unique: eqb_9zyvMoGQ9MSNRYePrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4451B811E67;
        Fri, 30 Sep 2022 07:20:46 +0000 (UTC)
Received: from fedora (unknown [10.40.193.165])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 54E021121315;
        Fri, 30 Sep 2022 07:20:45 +0000 (UTC)
Date:   Fri, 30 Sep 2022 09:20:42 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong <linfeilong@huawei.com>
Subject: Re: [bug report] misc/fsck.c: Processes may kill other processes.
Message-ID: <20220930072042.dwakvbnefctk2jyd@fedora>
References: <4ffe3143-fc53-7178-cf44-f3481eb96ae4@huawei.com>
 <20220929112813.6aqtktwaff2m7fh2@fedora>
 <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470ea2ee-54fd-3dd5-2500-36fb82665c11@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 30, 2022 at 09:42:52AM +0800, zhanchengbin wrote:
> 
> 
> On 2022/9/29 19:28, Lukas Czerner wrote:
> > Hi,
> > 
> > indeed we'd like to avoid killing the instance that was not ran because
> > of noexecute. Can you try the following patch?
> > 
> > Thanks!
> > -Lukas
> 
> Yes, you're right, I think we can fix it in this way.
> 
> diff --git a/misc/fsck.c b/misc/fsck.c
> index 1f6ec7d9..91edbf17 100644
> --- a/misc/fsck.c
> +++ b/misc/fsck.c
> @@ -547,6 +547,8 @@ static int kill_all(int signum)
>         for (inst = instance_list; inst; inst = inst->next) {
>                 if (inst->flags & FLAG_DONE)
>                         continue;
> +               if (inst->pid == -1)
> +                       continue;

Yeah, that works as well although I find the "if (noexecute)" condition
more obvious. We can do both. Also rather than checking for -1 we can
check for <= 0 since anything other than real pid at this point is a bug.

Feel free to send a proper patch.

Thanks!
-Lukas

>                 kill(inst->pid, signum);
>                 n++;
>         }
> > 
> > 
> > diff --git a/misc/fsck.c b/misc/fsck.c
> > index 1f6ec7d9..8fae7730 100644
> > --- a/misc/fsck.c
> > +++ b/misc/fsck.c
> > @@ -497,9 +497,10 @@ static int execute(const char *type, const char *device, const char *mntpt,
> >   	}
> >   	/* Fork and execute the correct program. */
> > -	if (noexecute)
> > +	if (noexecute) {
> >   		pid = -1;
> > -	else if ((pid = fork()) < 0) {
> > +		inst->flags |= FLAG_DONE;
> > +	} else if ((pid = fork()) < 0) {
> >   		perror("fork");
> >   		free(inst);
> >   		return errno;
> > @@ -544,6 +545,9 @@ static int kill_all(int signum)
> >   	struct fsck_instance *inst;
> >   	int	n = 0;
> > +	if (noexecute)
> > +		return 0;
> > +
> >   	for (inst = instance_list; inst; inst = inst->next) {
> >   		if (inst->flags & FLAG_DONE)
> >   			continue;
> regards,
> Zhan Chengbin
> 

