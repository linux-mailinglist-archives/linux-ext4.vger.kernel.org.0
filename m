Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB53F3635
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhHTV7C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTV7B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 17:59:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0A7C061575
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 14:58:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id n18so10528355pgm.12
        for <linux-ext4@vger.kernel.org>; Fri, 20 Aug 2021 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EaFIGGechC7EpN4PWrehUsrca1/pEJnlpXV0nESFhHg=;
        b=og+QZ4BX4cGXa9W4I+mgLzdrSKnVvb398bpPfoYO+kB4IlfiEKkJY6H+OiI/v4oTTE
         dI53/7Ig51GipRSIGV6iChu18skmnmTuufg8hF+PzA6rT/HKmK34UUFh/0gsxj87kQaP
         4S13DrtSgFeUPINUDg0PUSIny+243/RTuHBbTRQpKWNxUeLKdB9MApVsjlJWrr+/cLAQ
         zvi5P2pTRIig7C07PJYvlbgBLA66pRiYhY+C1Yu8vMgiyrMplWJNBX1rPsT4tqzkV4T8
         wxPjvrOxh0FOTafZz7aoJ1O8LbjYAHhQQaJ9cnxwrx93UHP1yZvEwrK5JuzssDmGvdFG
         3Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EaFIGGechC7EpN4PWrehUsrca1/pEJnlpXV0nESFhHg=;
        b=Y/XwrrqkZm/NBfTI/N7XqQuJZq55uDOP36YkXHbppTef/l78aVfz/BHKZUc1kNyuTi
         XWXb1tIz6LKsKNGu1AfpEJFCVMdxZ8Mcz37829W9ILfNkfzHWg3F++1+GnVbopMuIfHy
         cSyq5xBFS3s7FJOdKT+E0PN6eCMHhVCv8lK3TjcWGPYVS5GYLP6d4RbzDWxAYlQ1qhoY
         DqfHjInmspKCU2vMHNW2ACAt99QGZUosuRQXMgV3vjyMtI+5/PoFwl48upkApBOIpNfd
         GSk3cIJ8czJdeDks5iFBUcI46eYRLBlKqmtI1isXX6kT+KoUtSPbUqH1z1zzCk9HlTTl
         ofdw==
X-Gm-Message-State: AOAM532xHjrSp0tc6YU2d6cy1/AGw9cygOBjKmeHBAm2MQe2ZFyFkQSd
        DXCSn2IXX979MuFLWTW8IBlaZQ==
X-Google-Smtp-Source: ABdhPJzUCNeOwHknlQZM7Ul3EFGTdKlng3cqPx3cUs2SE9y8e580w0uMCcjc3+ZfZBaLVJvy1EZjLg==
X-Received: by 2002:a65:6213:: with SMTP id d19mr20121043pgv.110.1629496702833;
        Fri, 20 Aug 2021 14:58:22 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:58f3:22ab:ac76:60f1])
        by smtp.gmail.com with ESMTPSA id k3sm7918945pfc.16.2021.08.20.14.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 14:58:22 -0700 (PDT)
Date:   Sat, 21 Aug 2021 07:58:07 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     krisman@collabora.com
Cc:     pvorel@suse.cz, Amir Goldstein <amir73il@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Message-ID: <YSAlb7XGUNoc73ZJ@google.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
 <YR+CH2+GYzwU2/SG@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR+CH2+GYzwU2/SG@pevik>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Gabriel,

On Fri, Aug 20, 2021 at 12:21:19PM +0200, Petr Vorel wrote:
> Hi all,
> 
> > No problem. That's what review is for ;-)
> 
> > BTW, unless anyone is specifically interested I don't think there
> > is a reason to re post the test patches before the submission request.
> > Certainly not for the small fixes that I requested.
> 
> > I do request that you post a link to a branch with the fixed test
> > so that we can experiment with the kernel patches.
> 
> > I've also CC'ed Matthew who may want to help with review of the test
> > and man page that you posted in the cover letter [1].
> 
> @Amir Thanks a lot for your review, agree with all you mentioned.
> 
> @Gabriel Thanks for your contribution. I'd also consider squashing some of the
> commits.

Is the FAN_FS_ERROR feature to be included within the 5.15 release? If so,
I may need to do some shuffling around as these LTP tests collide with the
ones I author for the FAN_REPORT_PIDFD series.

/M
