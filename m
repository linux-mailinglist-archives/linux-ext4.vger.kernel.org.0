Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7153A2BD4
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jun 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFJMp2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Jun 2021 08:45:28 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:44738 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhFJMp1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Jun 2021 08:45:27 -0400
Received: by mail-ua1-f48.google.com with SMTP id 68so1214033uao.11
        for <linux-ext4@vger.kernel.org>; Thu, 10 Jun 2021 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERGvPKyejnfegUXiUI5TBALLR98HuWU+7/Q+tACPbYI=;
        b=bWmonaOQtQnoMrqggNjQmbBLp/OFsefkhaXRpT3N30oDxasxyxX5+zHqOhyxg8TwQ1
         9WhDWldZuNugQzNq9CRVa79/7odXcgVZfZJpa4jozV3UwwVJh+rViZAq1j+cqvO83+lk
         Ul0lp34cK0STCoHisDcJwkiJqPEl1W1Jca9Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERGvPKyejnfegUXiUI5TBALLR98HuWU+7/Q+tACPbYI=;
        b=FXQtSW60oY+rMeq9xu8X5X8hJxT7GkUENJybYYOZqjjCxeNA4/5DrXL+uNgtozM9Ae
         ITnujoqgjIxxsGRakSVIdDB63Gu+tFiysUpbKUPrpp8/vO+jkPClC9yQHzBUXAJi800d
         LoPcvm3/ckwfovtVQyWRaaJzebJviTYAsUVqFjF/OW5tNUy8x+zE4t9iOubcp+rtIFNu
         iVPkyuluqrKdkzugC5lqrcCQ/Cw8OgXUnbVW9BJLigwR9TlK4YoI9m7b/SzmEl53oXnc
         YPsWn2RRmhTxt8c4IAje2mN5IqCQukiWuVcSrl4rTCh0WCJjr5XvhhamRSs/DN4FDCv0
         fYYQ==
X-Gm-Message-State: AOAM532m4zF4A53HrpJhH7thNwf0A7c/B0N8yxLc8u0oa0QsvEZKjgvz
        yKsFZtE119VLUNZH23ls0cfNNSCfPQcCX2B/XxGCfKXTOLngCQ==
X-Google-Smtp-Source: ABdhPJzSnBnKZyOmEQg1Mlk1J3k9vxKYbX0hKrYXjQBdDrHZwFo89gBvp5Cl9ryn+jRW8T0jKkHsp9O4DmV9/7gYf0I=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr4105093uao.9.1623328942641;
 Thu, 10 Jun 2021 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210607144631.8717-1-jack@suse.cz> <20210607145236.31852-12-jack@suse.cz>
In-Reply-To: <20210607145236.31852-12-jack@suse.cz>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Jun 2021 14:42:12 +0200
Message-ID: <CAJfpegtLD6SzSOh0phgNcdU_Xp+pzUCQWZ+CB8HjKFV5nS3SCA@mail.gmail.com>
Subject: Re: [PATCH 12/14] fuse: Convert to using invalidate_lock
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mm <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 7 Jun 2021 at 16:52, Jan Kara <jack@suse.cz> wrote:
>
> Use invalidate_lock instead of fuse's private i_mmap_sem. The intended
> purpose is exactly the same. By this conversion we fix a long standing
> race between hole punching and read(2) / readahead(2) paths that can
> lead to stale page cache contents.
>
> CC: Miklos Szeredi <miklos@szeredi.hu>
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
