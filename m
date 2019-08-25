Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052679C169
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 05:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfHYDZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Aug 2019 23:25:43 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38571 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727708AbfHYDZm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Aug 2019 23:25:42 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7P3POUv029060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 23:25:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7F19A42049E; Sat, 24 Aug 2019 23:25:24 -0400 (EDT)
Date:   Sat, 24 Aug 2019 23:25:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
Message-ID: <20190825032524.GD5163@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guo <guoyang2@huawei.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 23, 2019 at 10:47:34AM +0800, Shaokun Zhang wrote:
> From: Yang Guo <guoyang2@huawei.com>
> 
> @es_stats_cache_hits and @es_stats_cache_misses are accessed frequently in
> ext4_es_lookup_extent function, it would influence the ext4 read/write
> performance in NUMA system.
> Let's optimize it using percpu_counter, it is profitable for the
> performance.
> 
> The test command is as below:
> fio -name=randwrite -numjobs=8 -filename=/mnt/test1 -rw=randwrite
> -ioengine=libaio -direct=1 -iodepth=64 -sync=0 -norandommap -group_reporting
> -runtime=120 -time_based -bs=4k -size=5G
> 
> And the result is better 10% than the initial implement:
> without the patch，IOPS=197k, BW=770MiB/s (808MB/s)(90.3GiB/120002msec)
> with the patch,  IOPS=218k, BW=852MiB/s (894MB/s)(99.9GiB/120002msec)
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Signed-off-by: Yang Guo <guoyang2@huawei.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Applied with some adjustments so it would apply.  I also changed the patch summary to:

    ext4: use percpu_counters for extent_status cache hits/misses

    	      		      	  		- Ted
