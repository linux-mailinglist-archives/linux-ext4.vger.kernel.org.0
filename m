Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240C1FF232
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgFRMqZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 08:46:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40782 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729145AbgFRMqV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 18 Jun 2020 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592484379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
        b=MtqFryuGdibC7xV3aPD1wwqC9spIagZf/VJ2+B/KccWAghLI/FkiCHRh/ySDwZe71Fmd61
        WPuNheq5BiY8nWh//h29sTjjbZas8FwfyIIzlqLB4fQlOqMEpXDDQrl0oB4WTRLqEYpKxc
        ubtS8F+RH+K+1jdMF3Ap4rCMMefiz9M=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-PdUET_cjO1C7bnH18ByV6w-1; Thu, 18 Jun 2020 08:46:15 -0400
X-MC-Unique: PdUET_cjO1C7bnH18ByV6w-1
Received: by mail-ot1-f69.google.com with SMTP id n6so2554586otr.4
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
        b=EOSDoOVkTVq7Auq0DJUQQHmX+lU6EoTyl8o5/Q67GXQTwPOy8K56lPP6VgaJgqOFo5
         ev4X/tV8cKosPY6caGHBesnvLD8u1zDi7WZaC6Z4aXPjjx+Ef62pF+G6dpenNvU7qiv9
         BNAwxooeMfgSie+dAla3COtP1VmHTrcUZ8A2Ta5t3dBs6R6jmFgJwO9cehbC0srFK52a
         v0qw/1ieH7Fpv0nyqU53A4PWb2mKwpNFhEgoM2EaEL419L8DQDz8/xomoInPZXwypO7x
         hATKVmE8Lq1iNnWH9yWG1tB8O+AY3cRFewO9nOzzjtXTzDazE0b08cm6pMaUH5xEhxCf
         x+Jw==
X-Gm-Message-State: AOAM532/c5EnYjlKhQ6dvMUslz3An8lA2hyaDGTcuZuZtzEhxmj892wN
        hdT2kIPYxGrqTUkzEmRtwX+yeafx9IlIuko+IyT+xJaVTn1i1d1r5EgGp/ahheaKngVGriK8dha
        lcB6mtJd9um3sA/2jnFkEv9TXYleyuqqeO+h44Q==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr3014457oto.95.1592484374640;
        Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOwYhxZwvrmXCEEJ4lNIcITT1uhrr+sNqXkjoRh5QLgqAWYsSVfGAkiWuBNYfSRh2ekFx49DQ8VN9O2a7lFfU=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr3014426oto.95.1592484374383;
 Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org> <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org>
In-Reply-To: <20200617022157.GF8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 14:46:03 +0200
Message-ID: <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mi., 17. Juni 2020 um 02:33 Uhr schrieb Matthew Wilcox <willy@infrad=
ead.org>:
> > >
> > > On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> > > > Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@in=
fradead.org>:
> > > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > >
> > > > > Implement the new readahead aop and convert all callers (block_de=
v,
> > > > > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qn=
x6,
> > > > > reiserfs & udf).  The callers are all trivial except for GFS2 & O=
CFS2.
> > > >
> > > > This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2=
.
> > > >
> > > > Our lock hierarchy is such that the inode cluster lock ("inode gloc=
k")
> > > > for an inode needs to be taken before any page locks in that inode'=
s
> > > > address space.
> > >
> > > How does that work for ...
> > >
> > > writepage:              yes, unlocks (see below)
> > > readpage:               yes, unlocks
> > > invalidatepage:         yes
> > > releasepage:            yes
> > > freepage:               yes
> > > isolate_page:           yes
> > > migratepage:            yes (both)
> > > putback_page:           yes
> > > launder_page:           yes
> > > is_partially_uptodate:  yes
> > > error_remove_page:      yes
> > >
> > > Is there a reason that you don't take the glock in the higher level
> > > ops which are called before readhead gets called?  I'm looking at XFS=
,
> > > and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
> > > (called from xfs_file_read_iter).
> >
> > Right, the approach from the following thread might fix this:
> >
> > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@r=
edhat.com/T/#t
>
> In general, I think this is a sound approach.
>
> Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> will bring in the pages which are in the page cache, so when we get to
> gfs2_fault(), we know there's a reason to acquire the glock.

We'd still be grabbing a glock while holding a dependent page lock.
Another process could be holding the glock and could try to grab the
same page lock (i.e., a concurrent writer), leading to the same kind
of deadlock.

Andreas

