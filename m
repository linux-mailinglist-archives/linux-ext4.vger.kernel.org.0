Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49F6200AC5
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 15:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgFSNxv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jun 2020 09:53:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731581AbgFSNxv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jun 2020 09:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592574830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GACF9F5CJXHMMRhKONk7G6GG/DsczmK7cX9umo++kj4=;
        b=Tn8SE7RHoc/k1lmy2Ogj5V9gzWJhdajBx7Tdf52HpcxdmyVFFJQsqnr3dTH63vcxNsxdXO
        LODpyOytmGHKJRcBISy148sTlsHq4iUQtfW8eiVuwM71IL1luDbR+2A6qgT/rGQVHq5Qkr
        nCkJb366MaHWy3K6a90MccZq67E8Vg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-P6KuuS-NOBa8DS0ZHnJghg-1; Fri, 19 Jun 2020 09:53:45 -0400
X-MC-Unique: P6KuuS-NOBa8DS0ZHnJghg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDC70102CC49;
        Fri, 19 Jun 2020 13:53:44 +0000 (UTC)
Received: from work (unknown [10.40.192.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB21019D61;
        Fri, 19 Jun 2020 13:53:37 +0000 (UTC)
Date:   Fri, 19 Jun 2020 15:53:33 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     Eric Sandeen <sandeen@redhat.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
Message-ID: <20200619135333.3idxuwhyax543ibt@work>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
 <20200619064122.vj346xptid5viogv@work>
 <20200619070854.z3dslhh7yebainhd@work>
 <20200619111631.ugx7sdpci32ohgir@work>
 <be37a8fe-78a8-bcb6-8d30-d975fb1ec080@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be37a8fe-78a8-bcb6-8d30-d975fb1ec080@sandeen.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jun 19, 2020 at 08:44:19AM -0500, Eric Sandeen wrote:
> On 6/19/20 6:16 AM, Lukas Czerner wrote:
> 
> >> The other possibility is that map[i].size is not right and indeed there
> >> seems to be a bug in dx_make_map()
> >>
> >> map_tail->size = le16_to_cpu(de->rec_len);
> >>
> >> should be
> >>
> >> map_tail->size = ext4_rec_len_from_disk(de->rec_len, blocksize));
> >>
> >> right ? Otherwise with large enough records the size will be smaller
> >> than it really is.
> >>
> >> A quick look at fs/ext4/namei.c reveals couple of places there rec_len
> >> is used without the conversion and we should check whether it needs
> >> fixing.
> >>
> >> -Lukas
> > 
> > And indeed the following patch seems to have fixed the issue we were
> > seeing. Eric I think that this might be a proper fix. But we still need
> > to check the other uses of rec_len to make sure it's ok as well.
> > 
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 94ec882..5509fdc 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -1068,7 +1068,7 @@ static int dx_make_map(struct ext4_dir_entry_2 *de, unsigned blocksize,
> >                         map_tail--;
> >                         map_tail->hash = h.hash;
> >                         map_tail->offs = ((char *) de - base)>>2;
> > -                       map_tail->size = le16_to_cpu(de->rec_len);
> > +                       map_tail->size = ext4_rec_len_from_disk(le16_to_cpu(de->rec_len), blocksize);
> 
> That isn't right, ext4_rec_len_from_disk /takes/ an __le16 :)
> 
> -                       map_tail->size = le16_to_cpu(de->rec_len);
> +                       map_tail->size = ext4_rec_len_from_disk(de->rec_len), blocksize);

Yep, my bad.

> 
> would be more correct, but won't matter for PAGE_SIZE < 65536 right?

True, it's not the problem we're seeing.

-Lukas

> 
> -Eric
> 

