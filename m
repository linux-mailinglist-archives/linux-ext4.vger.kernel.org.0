Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA8E9C5E4
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 21:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfHYTkv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 15:40:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37099 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfHYTkv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 15:40:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so16050313qto.4
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbwQAvf1EYum17/LkDk/Jqba2/uydGN6gfIsgEOsYXY=;
        b=csbaERMJ0Qm3fTZnuLpzIjVz7PuxaBDQQJ/N3o9t1f1/O1EC67YkcNUX1PTDR0QX9F
         CsiyO4OBG8bzeZJciVsQB91tb6blADeyhKHLyLThI3ARBz75ebkC45wlGR0IkSxBcUD2
         2xeTuyMoSBYRe5bqNxCmJQnvuICJPZ9GuLJ4Nml7q/xr5iz9leiEmNUNS3NKBkqV5G3W
         GoPTz9MQ0GzalUXYG6AV6bPU/WGtGLWX68CCfjNTgPu4NarALIprMgs485MAmtIHW4hf
         3vVykhJ+Upyxi5DrpPD1TXlQZLPEEbmUpkTiXOjfd8adN/oepc2B/zAbciY4ewq8xIm/
         RYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbwQAvf1EYum17/LkDk/Jqba2/uydGN6gfIsgEOsYXY=;
        b=NnVBo3jxOSFKH+9+u6PBxTCvCm/ZwjZt6Zse/tTlZPeD7zdKQqOeArSAQjupC3YDJT
         djVQOPxmrbOhY05IRWmXiZxxs7PzmrjppwflE5AMsy9vB08w0V6zDR4HMWLHv3CA17nr
         EpbJw9byACqmldJfig8mlCmFXwwwJxrj0nHB+J+LlUTipU+ZEpQcINcCTk4+wT4UaExd
         jUlYIg4lAiSR2PuN/6FmwSQ27OcbTjqKRd4Kpd5TKLP9F+oTjUKqBwMQuK5bMpO8HDsS
         wXg8gcGMnoEph53J4b+VXk53lzDrhH4bIMtCoEO8tedlq/vBL+RTjhsJ7xZ04fXrd+MC
         w6mA==
X-Gm-Message-State: APjAAAXh1zhrAP6U31bJ5AAazuAAsR18TYjDRRvnbm4JptsJhGbnjWgc
        xz4YgHDSBcoxy3aVB5I+4MSLNg==
X-Google-Smtp-Source: APXvYqxk7xnMH5RsCss+5xcOEKbvxQMkTe4ENpEKEAcbqmZYFpESkrWsVxsf7euTTp0g3Hl9/ekeqA==
X-Received: by 2002:ac8:42c4:: with SMTP id g4mr14703846qtm.228.1566762050152;
        Sun, 25 Aug 2019 12:40:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id c5sm5783563qtc.90.2019.08.25.12.40.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 12:40:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1yNd-0005pU-9Z; Sun, 25 Aug 2019 16:40:49 -0300
Date:   Sun, 25 Aug 2019 16:40:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
Message-ID: <20190825194049.GB21239@ziepe.ca>
References: <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
 <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
 <20190823032345.GG1119@dread.disaster.area>
 <20190824044911.GB1092@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824044911.GB1092@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 09:49:12PM -0700, Ira Weiny wrote:

> So far, I have not been able to get RDMA to have an issue like Jason suggested
> would happen (or used to happen).  So from that perspective it may be ok to
> hang the close.

No, it is not OK to hang the close. You will deadlock on process
destruction when the 'lease fd' hangs waiting for the 'uverbs fd'
which is later in the single threaded destruction sequence.

This is different from the uverbs deadlock I outlined

Jason
