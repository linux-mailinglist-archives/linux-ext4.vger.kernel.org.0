Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E261414F74
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Sep 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbhIVR4n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Sep 2021 13:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhIVR4m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Sep 2021 13:56:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18524C061574
        for <linux-ext4@vger.kernel.org>; Wed, 22 Sep 2021 10:55:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z14-20020a17090a8b8e00b0019cc29ceef1so5084030pjn.1
        for <linux-ext4@vger.kernel.org>; Wed, 22 Sep 2021 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8+jps3A14GynJSmzw6LICUadjrSD3zVUsUJsLV0rZk=;
        b=WEcDd3eyNLlpTBr5G2w6/U3ACRbzvqkURm/T54pVZ+ceKtWFyz/x6J/QBF0iuPstI0
         1j3TF0GlIoCp7/8Gtpg5SUC2Z8lXRey+3ZSd0qP+bgpH4hvRdZ1eOTYTnDA2kLhJV2cm
         GRk3lliL6TVYocTBnXxg+aM88nDKCNWeLAk17R3QoD1Ex6ff43CPVBz9J/umHz4iRr4t
         ujejwc7J+kLTEOfVRs4pdFl7ZL08fpR1kKMcT8dcabFhV/KeLTqixR4pnnJYCkPilrWu
         wqd+UZ0QdBW29D/8b95V/HVgg8egLQHf//AegMC/8d1bHR0TitPJsMVNEegYPonB3lP1
         +6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8+jps3A14GynJSmzw6LICUadjrSD3zVUsUJsLV0rZk=;
        b=nnETX26FRLfI6r+M8qhYZczb1cwevaCU0RY3jpmNcPZVTT5OijGPUpiWHEEFoPWEY5
         wMurG0fLIHSnaF4MC0KeZuPlBJEjo/8jtoxSSB1OoyJQ4CWCoR9PNfsmoA6zxzVqQ1hm
         oD6zbIhIJeJR3Z9jmRE6msogXjTHBkX3Bys3yeOVVShrIf7knhYsrJWhUb6SBXlkXQzm
         Uok8S3zaVL1qrksANeuHpDqoEQsQVs4YVJktd5oyxRWOrT0UFlJpWpEMgj3U19JM/fH9
         x6FupUWmU9bzdEn7JHC83t8jkB28ISa4OrzlbnKDzybS1EII3xXO5wRBBgU6fiZHGrI6
         eAAQ==
X-Gm-Message-State: AOAM533V6TV9uYKLF9QK4X3MfTyi3wdKJLSYJzvxLaYJ/3Jrb/ZYBsOp
        JUCkDPlTqbQ8r8Tfs+S8sK+PQdM6/YH1184sNFTVpjVJ2Ts=
X-Google-Smtp-Source: ABdhPJxDpETDisB1tJJJ3uVbr3cMcT+3v7yQjIsumtaYD7TRgjGOZKPn8Hi8Ai2wCoWFgFR5Pq9dPHOWjA1n+IRsAWM=
X-Received: by 2002:a17:90a:f18f:: with SMTP id bv15mr307453pjb.93.1632333311632;
 Wed, 22 Sep 2021 10:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210922173431.2454024-1-hch@lst.de>
In-Reply-To: <20210922173431.2454024-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 10:55:01 -0700
Message-ID: <CAPcyv4jpTyzofDyUPi7ADbGcV+cJHSohctwxu5yDNTF34KWeOg@mail.gmail.com>
Subject: Re: dax_supported() related cleanups v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 22, 2021 at 10:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series first clarifies how to use fsdax in the Kconfig help a bit,
> and then untangles the code path that checks if fsdax is supported.
>
> Changes since v1:
>  - improve the FS_DAX Kconfig help text further
>  - write a proper commit log for a patch missing it
>

This looks like your send script picked up the wrong cover letter?

> Diffstat
>  drivers/dax/super.c   |  191 +++++++++++++++++++-------------------------------
>  drivers/md/dm-table.c |    9 --
>  drivers/md/dm.c       |    2
>  fs/Kconfig            |   21 ++++-
>  fs/ext2/super.c       |    3
>  fs/ext4/super.c       |    3
>  fs/xfs/xfs_super.c    |   16 +++-
>  include/linux/dax.h   |   41 +---------
>  8 files changed, 117 insertions(+), 169 deletions(-)
