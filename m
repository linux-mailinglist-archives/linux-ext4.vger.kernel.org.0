Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140B5441DED
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Nov 2021 17:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhKAQV4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Nov 2021 12:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232498AbhKAQV4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Nov 2021 12:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=ioV3bcGv85AIWOyDAkvGTS2TjAGuZiacWuWeZda+/ETDMsG5qLftSzKgmpK4q7FS2Umsnf
        OuoVbJYNu0QBQKDOLBcLohvnvmr9NWJFWEYFcXZ9DiQb5Vo6bNW/Ia5YX9AjfY0Qa//PCi
        FpPo81IXuUBBkxwQAldvhalUJRAF/xs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-jWNbjHsPOrWXhoX4sal6OA-1; Mon, 01 Nov 2021 12:19:21 -0400
X-MC-Unique: jWNbjHsPOrWXhoX4sal6OA-1
Received: by mail-qk1-f198.google.com with SMTP id br11-20020a05620a460b00b004630d0237f2so3254895qkb.17
        for <linux-ext4@vger.kernel.org>; Mon, 01 Nov 2021 09:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C05du9bq5580dSm6IfhlDVs1xfqwhE2XhWSAZIf2yew=;
        b=vhUpnaBHomZryi3z/BE0wsBFUQY0Rv4c52eUjwTSHtO4zDFvGjUkPbwcLEP7lohe/Z
         6H6GvJ3K1p9eM35MBt7OCHuXvJWuT06LVqZFAYE6/V21n7PpH9d6YDBTyab5r7IlCTit
         4NfCyzjmSXYz7gW6QTT7DSab6zpCRyZdv1CvzNIuzLYt/+Pbce9tJgCJqOl4cu4ZvMN9
         ASf350xcNt/70iin2bbjZqaSFZWXpY6uWfTpqFYRogPuVjFQw9Vox4qZVYJVUI0U8jGd
         tEIh2Slz3u1iKxWpy9kC/XVIM9hqTCmSdmd9rSRBKpSC9RPgZ7BELVz/xsXCWkTuw2kE
         VA9Q==
X-Gm-Message-State: AOAM5327S7irvATTginE66IEESXaTloYg2Ii1gQzRaoxzGH+JIU2YZjg
        23shqECqjIJhLy+5oX9Xeg0KnSo7jTJHfePn611jYQlA1HsvxJyU1WDVgFchUMfgXUdsZHMvEGc
        erRYIL1ezpxL9OQhmo9z+
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270552qvf.21.1635783560973;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvmIEea110PcdB5LDCY7U1ej3BdqkCE7DUWVGoDnBFq+m2W3EEPnU5Ptqvnzv3GNnSJbsMew==
X-Received: by 2002:a0c:b341:: with SMTP id a1mr28270537qvf.21.1635783560844;
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g8sm1775746qko.27.2021.11.01.09.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:19:20 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:19:19 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 09/11] dm-log-writes: add a log_writes_dax_pgoff helper
Message-ID: <YYATh6yxGehyjpcm@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-10-hch@lst.de>
 <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iaUPEo73+KsBdYhM72WqKqJpshL-YU_iWoujk5jNUhmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 27 2021 at  9:36P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a helper to perform the entire remapping for DAX accesses.  This
> > helper open codes bdev_dax_pgoff given that the alignment checks have
> > already been done by the submitting file system and don't need to be
> > repeated.
> 
> Looks good.
> 
> Mike, ack?
> 

Acked-by: Mike Snitzer <snitzer@redhat.com>

