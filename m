Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B2F3BB760
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhGEHBb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 03:01:31 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46312 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229823AbhGEHBb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 03:01:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uejs0rR_1625468331;
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uejs0rR_1625468331)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 05 Jul 2021 14:58:52 +0800
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Reply-To: 20200427173354.GM6740@magnolia
From:   JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [RFC,2/2] xfstests: common/rc: add cluster size support for ext4
Message-ID: <0939cdf0-895c-7287-569a-2a9b4269b1ca@linux.alibaba.com>
Date:   Mon, 5 Jul 2021 14:58:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Sorry for digging this really old post [1]. The overall background is
that, @offset and @len need to be aligned with cluster size when doing
fallocate(), or several xfstests cases calling fsx will fail if the
tested filesystem enabling 'bigalloc' feature.

On April 27, 2020, 5:33 p.m. UTC Darrick J. Wong wrote:

> On Fri, Apr 24, 2020 at 05:33:50PM +0800, Jeffle Xu wrote:
>> Inserting and collapsing range on ext4 with 'bigalloc' feature will
>> fail due to the offset and size should be alligned with the cluster
>> size.
>> 
>> The previous patch has add support for cluster size in fsx. Detect and
>> pass the cluster size parameter to fsx if the underlying filesystem
>> is ext4 with bigalloc.
>> 
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>> ---
>>  common/rc | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
>> diff --git a/common/rc b/common/rc
>> index 2000bd9..71dde5f 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3908,6 +3908,15 @@ run_fsx()
>>  {
>>  	echo fsx $@
>>  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
>> +
>> +	if [ "$FSTYP" == "ext4" ]; then
>> +		local cluster_size=$(tune2fs -l $TEST_DEV | grep 'Cluster size' | awk '{print $3}')
>> +		if [ -n $cluster_size ]; then
>> +			echo "cluster size: $cluster_size"
>> +			args="$args -u $cluster_size"
>> +		fi
>> +	fi
> 
> Computing the file allocation block size ought to be a separate helper.
> 
> I wonder if there's a standard way to report cluster sizes, seeing as
> fat, ext4, ocfs2, and xfs can all have minimum space allocation units
> that are larger than the base fs block size.

In fact only for insert_range and collapse range of ext4 and xfs (in
realtime mode), @offset and @len need to be aligned with cluster size.

Though fat and ocfs2 also support cluster size, ocfs2 only supports
preallocate and punch_hole, and fat only supports preallocate, in which
case @offset and @len needn't be aligned with cluster size.


So we need to align @offset and @len with cluster size only for ext4 and
xfs (in realtime mode) at a minimum cost, to fix this issue. But the
question is, there's no standard programming interface exporting cluster
size. For both ext4 and xfs, it's stored as a binary data in disk
version superblock, e.g., tune2fs could detect the cluster size of ext4.


Any idea on how to query the cluster size?


[1]
https://patchwork.kernel.org/project/fstests/cover/1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com/

-- 
Thanks,
Jeffle
