Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0794EFE3F
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Apr 2022 05:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiDBDmn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Apr 2022 23:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDBDml (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Apr 2022 23:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE9871066F9
        for <linux-ext4@vger.kernel.org>; Fri,  1 Apr 2022 20:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648870845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gu7qS08tngVh1IJLv0SxMOra4HDD0LqwyzU+ZdcmWCM=;
        b=MNEk4Km/SDNBfXIALX/sToZWZ5eNFpWB0xtPwPEMSCNeTZbgnVifrJ0fKtdTc+GaFIsr05
        HlE6Zrt9PAmf5WyxNQJGUQRP18cxchMhNRnY40BCbSxgsPdUlpYzAu151nX+7KO23KgSK/
        9Q4u17UFVJCmIx66zEoz5onTPLUuHu0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-8v8Gnx1rO72RBaFJ4RHb0Q-1; Fri, 01 Apr 2022 23:40:44 -0400
X-MC-Unique: 8v8Gnx1rO72RBaFJ4RHb0Q-1
Received: by mail-pg1-f198.google.com with SMTP id r11-20020a63440b000000b0038068f34b0cso2485330pga.0
        for <linux-ext4@vger.kernel.org>; Fri, 01 Apr 2022 20:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Gu7qS08tngVh1IJLv0SxMOra4HDD0LqwyzU+ZdcmWCM=;
        b=cm1sEhY8TXKeEXiaL259OHeuctY8zZCJz3pUS/rKwcpjmyBxsUfGv1gEu8l7id2CST
         olu8ZCGY7gPGPPjeXV2PhRNbgx9FFTKEx/BfXi9z5/mPPrhW158Kq6BcPqjpXHhBx08s
         GjOTKVWx+ZFxzwDLZSBhyyGB3e3G92QwrfzcSVmPE/YgwaKmTXU9GIL4W3Ovz0HVwa2y
         3OZ912mJZIKwBmcQyAVsaeIGeuspmCTpvrzin5QEc/lXISGvVoev6rXRBhO/5pTnv8ne
         JBl5hOmmD/LB6W7WaDdZ5MTSeU4HrRjbfGzMVAEptJBfBky879qAa+LJUbsU5V/6sbe4
         H6tA==
X-Gm-Message-State: AOAM530mnc8Y9HEaOvnYxKEYJ9X2UsLN7eCT9BeLrEa6I1i8kCDq3AMz
        Cag4/7G3XKk1rs5LiaAc5LDugR7RQ30zP4jK5dOiCcfFgyHdb65xQIwvOISXDUm1NrB1uJSS/Z8
        R2HrdeoCiSSQCCYrLUcaUKg==
X-Received: by 2002:a63:b24b:0:b0:398:9894:b8be with SMTP id t11-20020a63b24b000000b003989894b8bemr16579712pgo.108.1648870843391;
        Fri, 01 Apr 2022 20:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQwSGKJLPaTExWl3PP1Fr9ox7Pr4m6DphuAOi7YCJetMf0Hx1BViK5U8xSQADFa/RA0oXLCA==
X-Received: by 2002:a63:b24b:0:b0:398:9894:b8be with SMTP id t11-20020a63b24b000000b003989894b8bemr16579702pgo.108.1648870843047;
        Fri, 01 Apr 2022 20:40:43 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j3-20020a056a00234300b004faabba358fsm4476346pfj.14.2022.04.01.20.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 20:40:42 -0700 (PDT)
Date:   Sat, 2 Apr 2022 11:40:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ojaswin@linux.ibm.com
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220402034037.rkrgxbjfqcs4sjvd@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ojaswin@linux.ibm.com
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
 <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
 <20220401170451.GB27665@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401170451.GB27665@magnolia>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 01, 2022 at 10:04:51AM -0700, Darrick J. Wong wrote:
> On Fri, Apr 01, 2022 at 01:30:47PM +0800, Zorro Lang wrote:
> > On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> > > On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > > > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > > > Hello,
> > > > >
> > > > > Hi,
> > > > >
> > > > > Your below patches looks like not pure text format, they might contain
> > > > > binary character or some special characers, looks like the "^M" [1].
> > > 
> > > Sorry to bother you. But here is what I tried.
> > > 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
> > >    the patches.
> > > 2. Saved the patch using mutt. Again didn't see such character while doing
> > > 	cat -A /patch/to/patch
> > > 3. Downloaded the mail using eml format from webmail. Here I do see this
> > >    character appended. But that happens not just for my patch, but for all
> > >    other patches too.
> > > 
> > > So could this be related to the way you are downloading these patches.
> > > Please let me know, if I need to resend these patches again? Because, I don't
> > > see this behavior at my end. But I would happy to correct it, if that's not the
> > > case.
> > 
> > Hmm... weird, When I tried to open your patch emails, my mutt show me:
> > 
> >   [-- application/octet-stream is unsupported (use 'v' to view this part) --]
> > 
> > Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
> > this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.
> > 
> > Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
> > only my personal issue, I'll check my side.
> 
> There's no application/octet anywhere in the email that I received.
> Has your IT department gone rogue^W^Wincreased value-add again?

Thanks Darrick and Ojaswin! I'll check with our IT department. But it's weird, only
this patchset and 2 of another patch[1](it's sent 3 times) has this problem, I see
all other patches normally. And Ritesh, sorry for taking your time to check it :-D

Thanks,
Zorro

[1]
[PATCH v2] generic/674: replace _require_scratch_reflink with _require_scratch_dedupe

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > -ritesh
> > > 
> > 
> 

