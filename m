Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256381FC1BA
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jun 2020 00:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFPWge (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Jun 2020 18:36:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20248 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726401AbgFPWga (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 16 Jun 2020 18:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592346989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjA7zgwqv80y4xmAR3IWOMUOAyE53XKax4l1DtqqEck=;
        b=F+ZCKP/pO88AJj755FSRxWuieNVWxHCCsztlYyIB2knySypa6BSFBNzg6YoBhvzR4nkjs6
        898OCMNDJ+BwO50vK+6MIsFzwdTJCxMRXXaSLWeSDZtvAdBBxPmOpJEp9Qo2TIAPAZQFK+
        Qia28yr+FTWe5+zvGSdQJ4GcLRHPkpM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-BDSGzoz6PI6Ne_Rt4OSzJg-1; Tue, 16 Jun 2020 18:36:25 -0400
X-MC-Unique: BDSGzoz6PI6Ne_Rt4OSzJg-1
Received: by mail-ot1-f72.google.com with SMTP id f21so167586otq.6
        for <linux-ext4@vger.kernel.org>; Tue, 16 Jun 2020 15:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjA7zgwqv80y4xmAR3IWOMUOAyE53XKax4l1DtqqEck=;
        b=qSz9EggHCW321WnrK05sf24gVpW5QMbYim7negJFdBc0Mz/n8HUjmkj1/vA+cb0rpP
         CwQeyf73NeD1QOGdfmcLDox5HEG/J91tTufY+FHW3mWt2hwL2OjdaYTNkdZ4w+6LM14t
         IwCojfmxMM0vJ1CWloeFhHhlivBtrfdkUwW6n8Kcdee1FjJqWHL9DOTkurHHCXPSI5Rq
         m04jbN9faYXlAf+Avcr02ZGDO/xxZPbrJzDhDh+r29qE+xBVRK+AQus4DtF/mn2t6DQC
         l4oomFUBuK4spWYR8uVuXDJ+XJPOc75EuvKReZiK+wWcae9rraOdxMpK1snUeI02SuvX
         Xmhw==
X-Gm-Message-State: AOAM53027+nu5J88nHSy2KlqcezJ9qOKSTYwSPi6Bpp0w276ZJKuRh4l
        x5otTWunGEVUz1ljgADZ//vzKsSruvJBhIkvOL1h+YboH3J+gO5gpUGsb+WhW7p//trCVAEXv63
        faO4895nB/w4BWPRazb7O6tosS4gUJleeHsvvxQ==
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr4427239otr.58.1592346984854;
        Tue, 16 Jun 2020 15:36:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoYNEk859HKJnIJ4XSJZ0fYGYB8IyuHx9XmftKrB9TO1HP0sg3cpUFv1zd47ilgV+zJ3II6JUZaM7vtE9AC3A=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr4427227otr.58.1592346984642;
 Tue, 16 Jun 2020 15:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
In-Reply-To: <20200414150233.24495-17-willy@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Jun 2020 00:36:13 +0200
Message-ID: <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Implement the new readahead aop and convert all callers (block_dev,
> exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.

This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2.

Our lock hierarchy is such that the inode cluster lock ("inode glock")
for an inode needs to be taken before any page locks in that inode's
address space. However, the readahead address space operation is
called with the pages already locked. When we try to grab the inode
glock inside gfs2_readahead, we'll deadlock with processes that are
holding that inode glock and trying to lock one of those same pages.

One possible solution is to use a trylock on the glock in
gfs2_readahead, and to give up the readahead in case of a locking
conflict. I have no idea how this is going to affect performance.

Any other ideas?

Thanks,
Andreas

