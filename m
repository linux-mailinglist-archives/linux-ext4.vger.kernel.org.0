Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AC1BD5E9
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 09:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD2HWy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 03:22:54 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:32982 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726401AbgD2HWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 03:22:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tx.9S2O_1588144970;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Tx.9S2O_1588144970)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Apr 2020 15:22:50 +0800
Subject: Re: [PATCH RFC 1/2] xfstests: fsx: add support for cluster size
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
References: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
 <1587720830-11955-2-git-send-email-jefflexu@linux.alibaba.com>
 <20200427172929.GL6740@magnolia>
From:   JeffleXu <jefflexu@linux.alibaba.com>
Message-ID: <66363e66-9c89-b877-e8d5-830d2c100b3b@linux.alibaba.com>
Date:   Wed, 29 Apr 2020 15:22:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427172929.GL6740@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 4/28/20 1:29 AM, Darrick J. Wong wrote:
> On Fri, Apr 24, 2020 at 05:33:49PM +0800, Jeffle Xu wrote:
>> The offset and size should be aligned with cluster size when inserting
>> or collapsing range on ext4 with 'bigalloc' feature enabled. Currently
>> I can find only ext4 with this limitation.
> ocfs2 also has this magic, um, ability.
>
> As does xfs under certain circumstance (realtime volumes).
>
>> Since fsx should have no assumption of the underlying filesystem, and
>> thus add the '-u cluster_size' option. Tests can set this option when
>> the underlying filesystem is ext4 with bigalloc enabled.
> Do copyrange, clonerange, or deduperange have this problem? ;)


clonerange and deduperange are not supported in ext4, while copyrange
  and zerorange work as the range has no need to be aligned with cluster size
in these two situations.

