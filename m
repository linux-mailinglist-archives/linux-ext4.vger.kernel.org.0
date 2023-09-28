Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1A57B1FE2
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Sep 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1OlD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Sep 2023 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1OlD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Sep 2023 10:41:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE95F9
        for <linux-ext4@vger.kernel.org>; Thu, 28 Sep 2023 07:41:01 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEe9K6004509;
        Thu, 28 Sep 2023 14:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MWi78a0hmZeI6aeoX9068H2SAJRHPRn1AEhlhaeGANU=;
 b=Rpr/x3gmtnP/J8+xhzjJiH4t47+utHoWjXQGM++LW0PuxQw/dRsWfaarGVg6eDSAd/jn
 Y5j6YCkXDuyV6HulBedxRQZISIGeYFs4O1aBLc5qwnPCURh7pE/xWRz7JY5vNLqwYoTo
 b2MaoAsIQRbZzvePYyI7qcRLupxg/86ZzgCtoDG7hO/bqVSKsbdlm6sEMVUblgMx5VJd
 8iIc5kuOfSvky9LmDNtEYUIlQkLfql5NhwALmJcHKE/PAngnI3h+hulNGYrIQW50P7v+
 QDlSH9UFtCBViU3B6Eqk331gQ/pgabDfJTYgv6XHBk9yNhZ0wHkIbyZIy4zGxy3qVogf uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5kq3bda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:40:56 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEeumi008982;
        Thu, 28 Sep 2023 14:40:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td5kq3bcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:40:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SDmCAv008253;
        Thu, 28 Sep 2023 14:40:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabbnn5at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:40:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SEeqcr41615816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:40:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8783420043;
        Thu, 28 Sep 2023 14:40:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80D422004D;
        Thu, 28 Sep 2023 14:40:51 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 28 Sep 2023 14:40:51 +0000 (GMT)
Date:   Thu, 28 Sep 2023 20:10:49 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Bobi Jam <bobijam@hotmail.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Message-ID: <ZRWQcRtoneJD06UP@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
 <OS3P286MB056790B5527B8DD75F1B21B7AFF1A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3P286MB056790B5527B8DD75F1B21B7AFF1A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bUj_520uwR9wgb6XMSmkOrFIWRh1UdnO
X-Proofpoint-GUID: WCq8Vys5-E3kGbfMIu4ob1r6zzfjwuEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=769
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 12, 2023 at 02:59:24PM +0800, Bobi Jam wrote:
> With LVM it is possible to create an LV with SSD storage at the
> beginning of the LV and HDD storage at the end of the LV, and use that
> to separate ext4 metadata allocations (that need small random IOs)
> from data allocations (that are better suited for large sequential
> IOs) depending on the type of underlying storage.  Between 0.5-1.0% of
> the filesystem capacity would need to be high-IOPS storage in order to
> hold all of the internal metadata.
> 
> This would improve performance for inode and other metadata access,
> such as ls, find, e2fsck, and in general improve file access latency,
> modification, truncate, unlink, transaction commit, etc.
> 
> This patch split largest free order group lists and average fragment
> size lists into other two lists for IOPS/fast storage groups, and
> cr 0 / cr 1 group scanning for metadata block allocation in following
> order:
> 
> if (allocate metadata blocks)
>       if (cr == 0)
>               try to find group in largest free order IOPS group list
>       if (cr == 1)
>               try to find group in fragment size IOPS group list
>       if (above two find failed)
>               fall through normal group lists as before
> if (allocate data blocks)
>       try to find group in normal group lists as before
>       if (failed to find group in normal group && mb_enable_iops_data)
>               try to find group in IOPS groups
> 
> Non-metadata block allocation does not allocate from the IOPS groups
> if non-IOPS groups are not used up.
> 
> Add for mke2fs an option to mark which blocks are in the IOPS region
> of storage at format time:
> 
>   -E iops=0-1024G,4096-8192G
> 
> so the ext4 mballoc code can then use the EXT4_BG_IOPS flag in the
> group descriptors to decide which groups to allocate dynamic
> filesystem metadata.
> 
> Signed-off-by: Bobi Jam <bobijam@hotmail.com
> 
> --
> v2->v3: add sysfs mb_enable_iops_data to enable data block allocation
>         from IOPS groups.
> v1->v2: for metadata block allocation, search in IOPS list then normal
>         list.
> ---

Hi Bobi, Andreas,

So I took a look at this patch and the idea is definitely interesting!
I'll add my review comments inline in a separate mail, but just adding
some high level observations in this mail:

1. Since most of the times our metadata allocation would only request
   1 block, we will actually end up skipping CR_POWER2_ALIGNED (aka CR0)
	 since it only works for len >= 2. But I think it's okay cause some
	 metadata allocaitons like xattrs might benefit from it.

2. We always try the goal group first in ext4_mb_find_by_goal() before
   going through the mballoc criterias and I dont think there is any logic
   to stop that incase the goal group is non IOPS and metadata is being
   allocated. So I think we are relying on the goal finding logic to give
   us IOPS blocks as goal for metadata, but does it do that currently?

Thanks!
ojaswin


