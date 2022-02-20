Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020334BD014
	for <lists+linux-ext4@lfdr.de>; Sun, 20 Feb 2022 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240065AbiBTRDk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 20 Feb 2022 12:03:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbiBTRDj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 20 Feb 2022 12:03:39 -0500
Received: from out20-109.mail.aliyun.com (out20-109.mail.aliyun.com [115.124.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A73BFB2;
        Sun, 20 Feb 2022 09:03:17 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0766703|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0565146-0.000238755-0.943247;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=guan@eryu.me;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.MsqYt2R_1645376594;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MsqYt2R_1645376594)
          by smtp.aliyun-inc.com(33.40.23.6);
          Mon, 21 Feb 2022 01:03:14 +0800
Date:   Mon, 21 Feb 2022 01:03:14 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 0/6] fstests: fix _scratch_mkfs_sized failure handling
Message-ID: <YhJ0Uql0Z5eK0IQh@desktop>
References: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218073156.2179803-1-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 18, 2022 at 04:31:50PM +0900, Shin'ichiro Kawasaki wrote:
> When generic/204 is run for btrfs-zoned filesystem on zoned block devices with
> GB size order, it takes very long time to complete. The test case creates 115MiB
> filesystem on the scratch device and fills files in it within decent run time.
> However, with btrfs-zoned condition, the test case creates filesystem as large
> as the device size and it takes very long time to fill it all. Three causes were
> identified for the long run time, and this series addresses them.
> 
> The first cause is mixed mode option that _scratch_mkfs_sized helper function
> adds to mkfs.btrfs. This option was added for both regular btrfs and
> zoned-btrfs. However, zoned-btrfs does not support mixed mode. The mkfs with
> mixed mode fails and results in _scratch_mkfs_sized failure. The mixed mode
> shall not be specified for btrfs-zoned filesystem.
> 
> The second cause is unnecessary call of the _scratch_mkfs helper function in the
> test case generic/204. This helper function is called to obtain data block size
> and i-node size. However, these numbers can be obtained from _scratch_mkfs_sized
> call. The _scratch_mkfs function call shall be removed.
> 
> The third cause is no check of return code from _scratch_mkfs_sized. The test
> case generic/204 calls both _scratch_mkfs and _scratch_mkfs_sized, and does not
> check return code from them. If _scratch_mkfs succeeds and _scratch_mkfs_sized
> fails, the scratch device still has valid filesystem created by _scratch_mkfs.
> Following test workload can be executed without failure, but the filesystem
> does not have the size specified for _scratch_mkfs_sized. The return code of
> _scratch_mkfs_sized shall be checked to catch the mkfs failure. This problem
> exists not only in generic/204, but also in other test cases which call both
> _scratch_mkfs and _scratch_mkfs_sized.
> 
> In this series, the first patch addresses the first cause, and the second patch
> addresses the second cause. These two patches fix the test case generic/204.
> Following three patches address the third cause, and fix other test cases than
> generic/204.
> 
> The last patch is an additional clean up of the helper function _filter_mkfs.
> During this fix work, it was misunderstood that this function were xfs unique.
> To clarify it can be extended to other filesystems, factor out xfs unique part.
> 
> Changes from v2:
> * Added Reviewed-by tags
> 
> Changes from v1:
> * Added 2nd patch which removes _scratch_mkfs call from generic/204
> * Added 6th patch which factors out xfs unique part from _filter_mkfs
> * Dropped 3 patches which had renamed _filter_mkfs to _xfs_filter_mkfs
> * Dropped generic/204 hunk from the 3rd patch
> 
> Shin'ichiro Kawasaki (6):
>   common/rc: fix btrfs mixed mode usage in _scratch_mkfs_sized
>   generic/204: remove unnecessary _scratch_mkfs call
>   generic/{171,172,173,174}: check _scratch_mkfs_sized return code
>   ext4/021: check _scratch_mkfs_sized return code
>   xfs/015: check _scratch_mkfs_sized return code
>   common: factor out xfs unique part from _filter_mkfs

Thanks a lot for all the changes! I've applied all patches except the
first one. Also many thanks to Darrick for reviewing them!

Thanks,
Eryu

> 
>  common/filter     | 40 +---------------------------------------
>  common/rc         |  8 ++++----
>  common/xfs        | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/021    |  2 +-
>  tests/generic/171 |  2 +-
>  tests/generic/172 |  2 +-
>  tests/generic/173 |  2 +-
>  tests/generic/174 |  2 +-
>  tests/generic/204 |  6 +-----
>  tests/xfs/015     |  2 +-
>  10 files changed, 53 insertions(+), 54 deletions(-)
> 
> -- 
> 2.34.1
