Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FE6720955
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jun 2023 20:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbjFBSon (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jun 2023 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjFBSon (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jun 2023 14:44:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6661B3
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jun 2023 11:44:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so3368377a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 02 Jun 2023 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685731478; x=1688323478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS2PPB5+6vCBsSxepSbGKCuyaQT9nPsi9usTi72Jayc=;
        b=Dh5hdhHUskk0dJUgRg/dHNjcoQaoFcCqqW49L8C4cxOuUHd7A5klJumDFALbc77kfN
         TOe0SZh9Dxxkx8+yCDim6XmVdsfaY+BAN/Pm0iZaRA5iIdCJ7AcEHtdbfhfKBnMbqXKg
         IrjS0jeZ4gkJK0nbaCc7bGKUFbSb6IaEGqIDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731478; x=1688323478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS2PPB5+6vCBsSxepSbGKCuyaQT9nPsi9usTi72Jayc=;
        b=AXnQI/nDHEgMeLSQksg6Oz3TgGTHqE8pfCsrRZa4+uwFpKtxNqRTjEHe22GBXir6NF
         ctE9uTexo2Gw+6uMG2GekRd3mkKkXy5Ax9Im5zuBjffMVMw/+/UtVF57blLIC/k2z+VL
         ru2EjE/+P8yvD5gLmDearuo/IxFgaoGFC1SY7/V0SU521ESKr4o1f4KgLkN+Mx1vJdtt
         gsRErLEtdJ/8/PsMKbGg5abR3gj6yvVpwKx1W/oFxK8AcNNnV8Ul2i/uuKlHirYqPtt/
         v/8HFA27HNAlsV3BDxlyIaNggp6qh3Rt/afM7tj5FR3bD5XkIZ1nLa2AMiJJzllvBb32
         2WMw==
X-Gm-Message-State: AC+VfDz58DRqu7Kh7gzl7vs4GGCGhul+xcfYHXnVdo/CEMQYjok98gfg
        PrjwKdjfa6JRvqC0qNauXFgG1jACYgwrIUXD2VFkzw==
X-Google-Smtp-Source: ACHHUZ7H8ymmvsuV8pIQreDZRzT1x8Q5ySH7cuWVFpH38pUlAJ9sGk9vksaBVqGaNtyGZXGewzGH8jOcPNcYXgPHGa4=
X-Received: by 2002:a17:906:eec8:b0:970:c9f:2db6 with SMTP id
 wu8-20020a170906eec800b009700c9f2db6mr11444588ejb.63.1685731478182; Fri, 02
 Jun 2023 11:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <ZGzIJlCE2pcqQRFJ@bfoster> <ZGzbGg35SqMrWfpr@redhat.com>
 <ZG1dAtHmbQ53aOhA@dread.disaster.area> <ZG+KoxDMeyogq4J0@bfoster>
 <ZHB954zGG1ag0E/t@dread.disaster.area> <CAJ0trDbspRaDKzTzTjFdPHdB9n0Q9unfu1cEk8giTWoNu3jP8g@mail.gmail.com>
 <ZHFEfngPyUOqlthr@dread.disaster.area> <CAJ0trDZJQwvAzngZLBJ1hB0XkQ1HRHQOdNQNTw9nK-U5i-0bLA@mail.gmail.com>
 <ZHYB/6l5Wi+xwkbQ@redhat.com> <CAJ0trDaUOevfiEpXasOESrLHTCcr=oz28ywJU+s+YOiuh7iWow@mail.gmail.com>
 <ZHYWAGmKhwwmTjW/@redhat.com>
In-Reply-To: <ZHYWAGmKhwwmTjW/@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Fri, 2 Jun 2023 11:44:27 -0700
Message-ID: <CAG9=OMMnDfN++-bJP3jLmUD6O=Q_ApV5Dr392_5GqsPAi_dDkg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Introduce provisioning primitives
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Joe Thornber <thornber@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, dm-devel@redhat.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Joe Thornber <ejt@redhat.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 30, 2023 at 8:28=E2=80=AFAM Mike Snitzer <snitzer@kernel.org> w=
rote:
>
> On Tue, May 30 2023 at 10:55P -0400,
> Joe Thornber <thornber@redhat.com> wrote:
>
> > On Tue, May 30, 2023 at 3:02=E2=80=AFPM Mike Snitzer <snitzer@kernel.or=
g> wrote:
> >
> > >
> > > Also Joe, for you proposed dm-thinp design where you distinquish
> > > between "provision" and "reserve": Would it make sense for REQ_META
> > > (e.g. all XFS metadata) with REQ_PROVISION to be treated as an
> > > LBA-specific hard request?  Whereas REQ_PROVISION on its own provides
> > > more freedom to just reserve the length of blocks? (e.g. for XFS
> > > delalloc where LBA range is unknown, but dm-thinp can be asked to
> > > reserve space to accomodate it).
> > >
> >
> > My proposal only involves 'reserve'.  Provisioning will be done as part=
 of
> > the usual io path.
>
> OK, I think we'd do well to pin down the top-level block interfaces in
> question. Because this patchset's block interface patch (2/5) header
> says:
>
> "This patch also adds the capability to call fallocate() in mode 0
> on block devices, which will send REQ_OP_PROVISION to the block
> device for the specified range,"
>
> So it wires up blkdev_fallocate() to call blkdev_issue_provision(). A
> user of XFS could then use fallocate() for user data -- which would
> cause thinp's reserve to _not_ be used for critical metadata.
>
> The only way to distinquish the caller (between on-behalf of user data
> vs XFS metadata) would be REQ_META?
>
> So should dm-thinp have a REQ_META-based distinction? Or just treat
> all REQ_OP_PROVISION the same?
>
I'm in favor of a REQ_META-based distinction. Does that imply that
REQ_META also needs to be passed through the block/filesystem stack
(eg. REQ_OP_PROVION + REQ_META on a loop device translates to a
fallocate(<insert meta flag name>) to the underlying file)?

<bikeshed>
I think that might have applications beyond just provisioning:
currently, for stacked filesystems (eg filesystems residing in a file
on top of another filesystem), even if the upper filesystem issues
read/write requests with REQ_META | REQ_PRIO, these flags are lost in
translation at the loop device layer.  A flag like the above would
allow the prioritization of stacked filesystem metadata requests.
</bikeshed>

Bringing the discussion back to this series for a bit, I'm still
waiting on feedback from the Block maintainers before sending out v8
(which at the moment, only have a
s/EXPORT_SYMBOL/EXPORT_SYMBOL_GPL/g). I believe from the conversation
most of the above is follow up work, but please let me know if you'd
prefer I add some of this to the current series!

Best
Sarthak

> Mike
