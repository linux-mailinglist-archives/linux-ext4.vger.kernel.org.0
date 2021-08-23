Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201643F4993
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhHWLUV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbhHWLUU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 07:20:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8DC061575
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 04:19:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so9914661plr.12
        for <linux-ext4@vger.kernel.org>; Mon, 23 Aug 2021 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=77kLq4KKo93CAw42c+JCsKr4aBqORkcnO9iq/Z+eQRo=;
        b=O15CIu2095ox08Bm6oiWHovsfdK3GF7CqbVpaKWuxq5GDQu1471nYwRdoOjRIVV70r
         lBfFs4sU4ply7LsCXMK1AlqPRrSwVKPb159/0L6WPF02bPTna8vYxP1eVPlj1Fx3x5vR
         bS68+wMUpR8Y0pDz1jXeh/jM6R2WfS2quTqKS+rpa7Fp3P07IhZ2grwSXGP5NwEA/roq
         lfuApguf7dLjdG2CZw5yk2dzzYut+Sw1Omwqp3vU+CSXfnzfkzZvMiOvKGVjju2xwHur
         MZ7vw/zlyOPJhGei/XtJjlUoLQYjQTSChSrRvTnHP+qVHs/PXPmaj1aKtuaGNyHFi9aF
         mS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77kLq4KKo93CAw42c+JCsKr4aBqORkcnO9iq/Z+eQRo=;
        b=TUWYNJB8xQz9rtafaO0dvhOvFux2VWKMEa1kCUD6NLEAK+p+buZksHEkjTa62jX7HL
         hfDqPW3aR9IAoPeV1bcyx5eBplE+9PgGlqsNxI4QB+3kLkOf2fItbP4Q7fLwlP/hZrd/
         QGkT+aPgo0oP3L0Rx4NQqamB71ei9MAYuV7SG3VCDDaL2oukbpSeSS8cNw/af0lR74Or
         w2+hIHD/Xj79iU13TYoVXD15YLOabBBz9z6diPJZ3Wx+XFEc8zYNshCmr1vMh5qjs8os
         /C/OnLCMI8K1uc/3kbtyZVRWlRAbSe5PctWLnc5+LY3CAZxqoV2ULrdKhsj7Cpl9UiFG
         5Abg==
X-Gm-Message-State: AOAM531mYD3tsUJ72k+CDR3Yu5DgI4z/Y+fdhIEltgrko5ntq+4rLV4b
        6A5xjmaOAyKPH0FfTtqmxO8oVg==
X-Google-Smtp-Source: ABdhPJybGSkkPY6cs5QDr1fbq+tQqKICUtJkXsCXTcJjvr4jMDcP6UixCa/2S7bNrXvAEslMsCrKrg==
X-Received: by 2002:a17:90b:88e:: with SMTP id bj14mr6850588pjb.115.1629717577643;
        Mon, 23 Aug 2021 04:19:37 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:473e:ebbc:26b4:6d4d])
        by smtp.gmail.com with ESMTPSA id c133sm15517935pfb.39.2021.08.23.04.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:19:37 -0700 (PDT)
Date:   Mon, 23 Aug 2021 21:19:22 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     krisman@collabora.com, pvorel@suse.cz,
        Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Message-ID: <YSOEOj7xUpADB73f@google.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
 <YR+CH2+GYzwU2/SG@pevik>
 <YSAlb7XGUNoc73ZJ@google.com>
 <20210823093524.GB21467@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823093524.GB21467@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 23, 2021 at 11:35:24AM +0200, Jan Kara wrote:
> On Sat 21-08-21 07:58:07, Matthew Bobrowski wrote:
> > On Fri, Aug 20, 2021 at 12:21:19PM +0200, Petr Vorel wrote:
> > > Hi all,
> > > 
> > > > No problem. That's what review is for ;-)
> > > 
> > > > BTW, unless anyone is specifically interested I don't think there
> > > > is a reason to re post the test patches before the submission request.
> > > > Certainly not for the small fixes that I requested.
> > > 
> > > > I do request that you post a link to a branch with the fixed test
> > > > so that we can experiment with the kernel patches.
> > > 
> > > > I've also CC'ed Matthew who may want to help with review of the test
> > > > and man page that you posted in the cover letter [1].
> > > 
> > > @Amir Thanks a lot for your review, agree with all you mentioned.
> > > 
> > > @Gabriel Thanks for your contribution. I'd also consider squashing some of the
> > > commits.
> > 
> > Is the FAN_FS_ERROR feature to be included within the 5.15 release? If so,
> > I may need to do some shuffling around as these LTP tests collide with the
> > ones I author for the FAN_REPORT_PIDFD series.
> 
> No, I don't think FAN_FS_ERROR is quite ready for the coming merge window.
> So you should be fine.

Alrighty, thanks for letting me know Jan.

/M
