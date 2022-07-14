Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50375752BF
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 18:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiGNQ2r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiGNQ2l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 12:28:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A90EB1FD
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 09:28:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso6352183pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=51FMChkJehx7pHQ73T1R4wuQ3K5opuWy1ShYWSXgcLc=;
        b=2bg3ecZuRFVjrx0xZziz+wHecVVGRtdcCdgSMS92KHHiTPhlz0piUC25EoCFkiNcXD
         ZrtVuuscGJ3ZnZfBTgChXQnCFyfUBrhPX5e8M/zFNjSoVGmOABMfhOMMc1VXJeZde9yF
         rkhBC/zlk12GZPYcdOE70ojApWUfJrQ4v8wfHrqZpA5XAHgkgkqr0BJRHbcyKTV9uRWM
         yZunbnmee68SYkDf5V4/Nt2oZmzcf/IUmstH+wxkeEimDPJbvqE9p7Zx5YNXRPqCEw54
         Z8ZJSqV8x7AwD/xypaV8GyHoC46hA1ZkCv7+2DReyqjnduqQHonXixJQXYq22vERL21P
         m8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=51FMChkJehx7pHQ73T1R4wuQ3K5opuWy1ShYWSXgcLc=;
        b=vw2UKzoFXVI+nkl3Ru53UAz1vVYkot6PFJMN80NyFzOItSvK/TkaywZ0nh9pvW6yw1
         2fS6GJR64AcYX4ZwaBFNZqL+qEZfGfi6GZoWlTOsWft711WZ+INGKO0YP8Rfp95p4Fgh
         wvKak0JXKhVG37SsydbWJLhw7PQCw5/2E96FemGPxH/g+G3QW3VneWUicV/Z3jblXCb2
         47DRWr6MyRN3KLyxvfvs2NZegJ6buUy1U5Q9/U5S/mH+i3+edmRxN0NAHyeC6LOGj/rs
         Ql+QTC6bXIg+V7aLDXfiBDWNZAG0B5IxOKlaaUm8Cp4+1Pr+XGcWDSIAthO6g+LL8ehj
         MacQ==
X-Gm-Message-State: AJIora8aN4gxUKxqyzuz7CCIT3x7skrcNukzQCJ5c4mCxdVca8E1WYSC
        VKEkPtoVwry/imCd8TFut6Q6dg==
X-Google-Smtp-Source: AGRyM1sNF6svcWGxSuUx8Ka7ezTADczi0FQJjbOAHkM55oW99hTvyuSUoBOHMICbkM3Ftbz1hcJ25g==
X-Received: by 2002:a17:90b:3c4f:b0:1f0:b59f:8b86 with SMTP id pm15-20020a17090b3c4f00b001f0b59f8b86mr5752596pjb.225.1657816119680;
        Thu, 14 Jul 2022 09:28:39 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mv2-20020a17090b198200b001f0ade18babsm2395855pjb.55.2022.07.14.09.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:28:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        jinpu.wang@ionos.com, christoph.boehmwalder@linbit.com,
        linux-raid@vger.kernel.org, song@kernel.org, mark@fasheh.com,
        tytso@mit.edu, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, ocfs2-devel@oss.oracle.com,
        joseph.qi@linux.alibaba.com, jack@suse.com, haris.iqbal@ionos.com,
        jlbec@evilplan.org
In-Reply-To: <20220713055317.1888500-1-hch@lst.de>
References: <20220713055317.1888500-1-hch@lst.de>
Subject: Re: remove bdevname
Message-Id: <165781611803.623079.18294279066897804471.b4-ty@kernel.dk>
Date:   Thu, 14 Jul 2022 10:28:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 13 Jul 2022 07:53:08 +0200, Christoph Hellwig wrote:
> this series removes the final uses and the implementation of the bdevname()
> function.
> 
> Diffstat:
>  block/bdev.c                        |   10 ++---
>  block/blk-lib.c                     |    6 +--
>  block/genhd.c                       |   23 ------------
>  drivers/block/drbd/drbd_req.c       |    6 +--
>  drivers/block/pktcdvd.c             |   10 +----
>  drivers/block/rnbd/rnbd-srv-dev.c   |    1
>  drivers/block/rnbd/rnbd-srv-dev.h   |    1
>  drivers/block/rnbd/rnbd-srv-sysfs.c |    5 +-
>  drivers/block/rnbd/rnbd-srv.c       |    9 ++---
>  drivers/block/rnbd/rnbd-srv.h       |    3 -
>  drivers/md/md.c                     |    2 -
>  drivers/md/raid1.c                  |    2 -
>  drivers/md/raid10.c                 |    2 -
>  fs/ext4/mmp.c                       |    9 ++---
>  fs/jbd2/journal.c                   |    6 ++-
>  fs/ocfs2/cluster/heartbeat.c        |   64 ++++++++++++++++--------------------
>  include/linux/blkdev.h              |    1
>  kernel/trace/blktrace.c             |    4 +-
>  18 files changed, 62 insertions(+), 102 deletions(-)
> 
> [...]

Applied, thanks!

[1/9] block: stop using bdevname in bdev_write_inode
      commit: 5bf83e9a14ddae994d783dee96b91bf46f04839c
[2/9] block: stop using bdevname in __blkdev_issue_discard
      commit: 02ff3dd20f512cf811ae8028c44fdb212b5f2bf7
[3/9] drbd: stop using bdevname in drbd_report_io_error
      commit: 1b70ccecaed4c3c50239e8409156fb447f965554
[4/9] pktcdvd: stop using bdevname in pkt_seq_show
      commit: fa070a3b50a17506a230e72bd48dba89e7bb5fea
[5/9] pktcdvd: stop using bdevname in pkt_new_dev
      commit: beecf70ee84363e92f3bf783b74da5f26e765d8d
[6/9] rnbd-srv: remove the name field from struct rnbd_dev
      commit: 6e880cf59932a14bca128fc8e8faae0554932942
[7/9] ocfs2/cluster: remove the hr_dev_name field from struct o2hb_region
      commit: 4664954c9421ce326bb5c84f175902b03f17237e
[8/9] ext4: only initialize mmp_bdevname once
      commit: c5b045b9838972cc4c4985a32fa5d35ecf2ab15a
[9/9] block: remove bdevname
      commit: 900d156bac2bc474cf7c7bee4efbc6c83ec5ae58

Best regards,
-- 
Jens Axboe


