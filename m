Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D479A3DFC36
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbhHDHk0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 03:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbhHDHkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 03:40:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7970C0613D5
        for <linux-ext4@vger.kernel.org>; Wed,  4 Aug 2021 00:40:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l19so1806953pjz.0
        for <linux-ext4@vger.kernel.org>; Wed, 04 Aug 2021 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ufsAD/3Qdi1T2HB3quxBOdR/T1U1h8GciPGwUgTjHCI=;
        b=qqocDoGSTbG1vEp6u73Alx+v/Hts8tf3aADkUHdMUM+qdnPusHXtBXwz5UV8Bi5Aay
         MSEByll6Ne+XnITdf9lRuktuFv/jdget/bDiltssjlXsx/jrlw+jCTSIIeVRY4AOpqI3
         P2dCZXuVbafOx2LGtlpLd9cN0Cl5xGApnS0hmc6LQfolI/ZC/9GKJ4IcSIjsc1L/15Pe
         i6cDkHrVV4jTL5IMqziWgBynBnEYLKFnDlmRZAiSTeqfukID/SgYlMunruRg3tZkAkst
         OqaLbg+3MxBJbCZaKKu+UJTMxEkhpYXd86wtoHGMmox5mLIlrhZxYsmiUQGH232D1+n+
         oyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ufsAD/3Qdi1T2HB3quxBOdR/T1U1h8GciPGwUgTjHCI=;
        b=GRFZ3b1eMFyQYt9YQZvyJlsby9PhtiFhJAKtt/v9XeMc2/s8YPqrAYnbIwvHs+Fx/G
         yX8+IEeogN4eM4wRPbgPd5l6Iob4s6ev3GLCyC4DuETBXRNJ/sFPXAS4S295sqVqkWKQ
         mvah+RVg1noCJTkcfPPhCYA1MPibtd+HfwiXQoelFR4bktsuQcT088M3i9ObiLdsWECY
         pf/opd5xXGxI8ljbOsqMwrN9ef6MABTi5U76v7nQjEicCzgTCmG3xO8MwanWp0Dth0YH
         tXMnhIcAoeq/GjC6UAME3+Spy+cxLxK17NNWyFqhirdStnBgUxw2GZViFNitWekVrNHR
         b/Eg==
X-Gm-Message-State: AOAM531OW8c1N80tOxa7wWMXsVctweTn9Egba86ki7TLQUF22K5vRMrU
        sxBeCbvCpfwRIBAFyFn5gM2YCw==
X-Google-Smtp-Source: ABdhPJyJzGt5DaIcM08PAh3ojkjZLyP/hOJ8VK8e6kqydHwEcjJ0mjGGqd66M4KyR8PZSrTHwFsxnw==
X-Received: by 2002:a62:8643:0:b029:3b1:a6ee:196 with SMTP id x64-20020a6286430000b02903b1a6ee0196mr23380719pfd.13.1628062813093;
        Wed, 04 Aug 2021 00:40:13 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:7ff1:360d:6b2e:2bd2])
        by smtp.gmail.com with ESMTPSA id r18sm2164903pgk.54.2021.08.04.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 00:40:12 -0700 (PDT)
Date:   Wed, 4 Aug 2021 17:40:00 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     krisman@collabora.com
Cc:     amir73il@gmail.com, LTP List <ltp@lists.linux.it>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>, kernel@collabora.com
Subject: Re: [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Message-ID: <YQpEEQT358LYPbMX@google.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 04, 2021 at 08:39:55AM +0300, Amir Goldstein wrote:
> On Wed, Aug 4, 2021 at 7:54 AM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> > > On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
> > > <krisman@collabora.com> wrote:
> > >>
> > >> Verify the FID provided in the event.  If the testcase has a null inode,
> > >> this is assumed to be a superblock error (i.e. null FH).
> > >>
> > >> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > >> ---
> > >>  .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
> > >>  1 file changed, 51 insertions(+)
> > >>
> > >> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > >> index fd5cfb8744f1..d8d788ae685f 100644
> > >> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> > >> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> > >> @@ -40,6 +40,14 @@
> > >>
> > >>  #define FAN_EVENT_INFO_TYPE_ERROR      4
> > >>
> > >> +#ifndef FILEID_INVALID
> > >> +#define        FILEID_INVALID          0xff
> > >> +#endif
> > >> +
> > >> +#ifndef FILEID_INO32_GEN
> > >> +#define FILEID_INO32_GEN       1
> > >> +#endif
> > >> +
> > >>  struct fanotify_event_info_error {
> > >>         struct fanotify_event_info_header hdr;
> > >>         __s32 error;
> > >> @@ -57,6 +65,9 @@ static const struct test_case {
> > >>         char *name;
> > >>         int error;
> > >>         unsigned int error_count;
> > >> +
> > >> +       /* inode can be null for superblock errors */
> > >> +       unsigned int *inode;
> > >
> > > Any reason not to use fanotify_fid_t * like fanotify16.c?
> >
> > No reason other than I didn't notice they existed. Sorry. I will get
> > this fixed.
> 
> No problem. That's what review is for ;-)
> 
> BTW, unless anyone is specifically interested I don't think there
> is a reason to re post the test patches before the submission request.
> Certainly not for the small fixes that I requested.
> 
> I do request that you post a link to a branch with the fixed test
> so that we can experiment with the kernel patches.
> 
> I've also CC'ed Matthew who may want to help with review of the test
> and man page that you posted in the cover letter [1].

I'll get around to going through both the LTP and man-page series by the
end of this week. Feel free to also loop me in directly on any subsequent
iterations of the like.

/M
