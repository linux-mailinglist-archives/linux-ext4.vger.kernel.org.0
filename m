Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2A1FF96A
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbgFRQkd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 12:40:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50142 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728929AbgFRQkb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 12:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592498430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=cdm6RrH1NpWejVPngNSf517l/h1SpZ+fivdFekEw1Tn2FRtYit2i3cc6VMnszQ5eKnfPOA
        NlJjO2VVvJU1J0oDvazQ62XrDMo78nqLgdlQrZNYaPAArwfxonJBKCiMb9EJ9D92PshR/h
        FJ/TUNIXe63syEtT8yes1Gd6caokSI0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-yf34vRbhOfOpuU7XoJSuEQ-1; Thu, 18 Jun 2020 12:40:28 -0400
X-MC-Unique: yf34vRbhOfOpuU7XoJSuEQ-1
Received: by mail-oo1-f70.google.com with SMTP id o14so191204oon.12
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=gBu889kTCG1xdpH1HjVvteqP0+s3puM4RnhjnIogeM4EyTB1f5gzTQe8yjCzSOcNqt
         NBB1N1rpjrclyAQ2d0StuLxQmDsvu0Wrt+JVsObNiZnUtvZo9PSrQevHds42w5t2Lkfk
         qxzNK9Yml4b49nMVx+k7ftML8VWo9ecGsQEh38Bvthhm0xNvb9UOpacO2gjVB2lzDUsz
         VpBn3MtNeVyHM0gDoKEXsSDhUQ2raIVe8Ski7lBrASHVwoz/MIfysszQ27eoslTSQMW6
         29RjEtmNOk/4zy8WLTIjd/74g1SpRQ/tz2RVvoLjQe6+7VjZMZNB6fB5W1tclbXIwE0c
         daIg==
X-Gm-Message-State: AOAM531TZcd7mNTdoBMJwbaFDwNuKuet3wbDNSRoddyr3eRBvuJRE5kI
        gz3xq1z/yEEJvYICJVnPmuSHy3b3hssUui+8juQmaSIg7slxMmb29Rq1G/tyLNLZhzfdVRhDq5a
        ZettpodYoA1GBqCv+6HmKVkgqcXJzXHOnLuyULA==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000187oto.95.1592498427402;
        Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE8nhb2Q0d4GxQpaInRB14NGapvcWpYnTg96Ky3B2ltZU9DxgAABVkj/Ptn9PHhgl8mMoH1G9lpq5ufccfhow=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000168oto.95.1592498427103;
 Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org> <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org> <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
 <20200618150309.GP8681@bombadil.infradead.org>
In-Reply-To: <20200618150309.GP8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 18:40:15 +0200
Message-ID: <CAHc6FU6TYTiQ0a0GkN1dhh3VeQKVKrL+eALvuYzZ8nq5jvNHjg@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 18, 2020 at 02:46:03PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> > > On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=83=C2=BCnbach=
er wrote:
> > > > Right, the approach from the following thread might fix this:
> > > >
> > > > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruen=
ba@redhat.com/T/#t
> > >
> > > In general, I think this is a sound approach.
> > >
> > > Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> > > will bring in the pages which are in the page cache, so when we get t=
o
> > > gfs2_fault(), we know there's a reason to acquire the glock.
> >
> > We'd still be grabbing a glock while holding a dependent page lock.
> > Another process could be holding the glock and could try to grab the
> > same page lock (i.e., a concurrent writer), leading to the same kind
> > of deadlock.
>
> What I'm saying is that gfs2_fault should just be:
>
> +static vm_fault_t gfs2_fault(struct vm_fault *vmf)
> +{
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +       struct gfs2_inode *ip =3D GFS2_I(inode);
> +       struct gfs2_holder gh;
> +       vm_fault_t ret;
> +       int err;
> +
> +       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> +       err =3D gfs2_glock_nq(&gh);
> +       if (err) {
> +               ret =3D block_page_mkwrite_return(err);
> +               goto out_uninit;
> +       }
> +       ret =3D filemap_fault(vmf);
> +       gfs2_glock_dq(&gh);
> +out_uninit:
> +       gfs2_holder_uninit(&gh);
> +       return ret;
> +}
>
> because by the time gfs2_fault() is called, map_pages() has already been
> called and has failed to insert the necessary page, so we should just
> acquire the glock now instead of trying again to look for the page in
> the page cache.

Okay, that's great.

Thanks,
Andreas

