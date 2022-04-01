Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750594EE7C4
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Apr 2022 07:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiDAFcp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 01:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiDAFco (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 01:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09D6D3A5C5
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 22:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648791055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=PMryfqAM2olVNymcCN2h8Mtm9rJ+/33VFY1ANyOK9gL07qjap+keV93vbNnbPU4EwwqMWI
        zvxa7JEhRBMS1NSheBxiN7inzgfJ2RlRFHjknnieORZoaN02Hisgzen7tL0cqRO36MVBYh
        hruXVFS3XyMHHDtqiW80PTv1Q8JnN7M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-HszMFyZlPdiSpSvMIdRLdQ-1; Fri, 01 Apr 2022 01:30:54 -0400
X-MC-Unique: HszMFyZlPdiSpSvMIdRLdQ-1
Received: by mail-pf1-f199.google.com with SMTP id k69-20020a628448000000b004fd8affa86aso997226pfd.12
        for <linux-ext4@vger.kernel.org>; Thu, 31 Mar 2022 22:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7QMXqtrbsC5xFcoJnlfW2A3rDBF4OPWrvizGei7+JWY=;
        b=qosLvBH6cqFYef8fwuuN1zzaFJkS5aUGDVlC6NtxXs0rXDv8Xlm4rgvRtpqO7wOTuX
         MX9u91qTxkKs3h0799nQJJlss58hPrH5rKyrJmzBfQVjGVrlODp8IHgfG4PSa23I5WKK
         PAdKstTrgw+rFIJhxdulJlZu98rX1AC9P5x3k7k4m9DUe8D2Lh7/jgcFlXrd9vBv0Bjh
         FMY/kSjhCTlS0wkfJwckocNhK3C2k+rwdlt978buvsHNM4rLty/Y9M+uC1Xjf3x5EPig
         en9w84idpxJTpLQBjW7C10FU8BDwEW8YIE5WsZqnqIrlDPSiNeJB/xcd5M3CycathLB2
         Gi9Q==
X-Gm-Message-State: AOAM532wueSgFvTlY4Kz6EpfgzcSWkQyhXGTuffSnsebq68S86cZGggJ
        AOwDksUQ05dNJ2TnrWFq/nuqL92CV/noCkCoMNI+VRaxFO+biYB005/RiEum1wlFR+QnYoTW2Us
        GpwsW0+2IvpMg9B+6ib02sw==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829436pln.89.1648791052560;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY7OvK2M1A5AqbXUDoQ2crpDG+2Q85cwgkdCc0FQgN2u2i+IfXl3sL6nrto7SfNk04ngqIng==
X-Received: by 2002:a17:902:684e:b0:154:3b94:e30c with SMTP id f14-20020a170902684e00b001543b94e30cmr8829414pln.89.1648791052218;
        Thu, 31 Mar 2022 22:30:52 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a637204000000b00398522203a2sm1056282pgc.80.2022.03.31.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 22:30:51 -0700 (PDT)
Date:   Fri, 1 Apr 2022 13:30:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > Hello,
> > >
> > > Hi,
> > >
> > > Your below patches looks like not pure text format, they might contain
> > > binary character or some special characers, looks like the "^M" [1].
> 
> Sorry to bother you. But here is what I tried.
> 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
>    the patches.
> 2. Saved the patch using mutt. Again didn't see such character while doing
> 	cat -A /patch/to/patch
> 3. Downloaded the mail using eml format from webmail. Here I do see this
>    character appended. But that happens not just for my patch, but for all
>    other patches too.
> 
> So could this be related to the way you are downloading these patches.
> Please let me know, if I need to resend these patches again? Because, I don't
> see this behavior at my end. But I would happy to correct it, if that's not the
> case.

Hmm... weird, When I tried to open your patch emails, my mutt show me:

  [-- application/octet-stream is unsupported (use 'v' to view this part) --]

Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.

Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
only my personal issue, I'll check my side.

Thanks,
Zorro

> 
> -ritesh
> 

