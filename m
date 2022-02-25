Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2F4C4BAB
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiBYRLH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 12:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243480AbiBYRK6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 12:10:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA376202887
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 09:10:26 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PGss8t023872;
        Fri, 25 Feb 2022 17:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=obE+YW7iM5H9TY62oEC8DEz8NALnqXfWdHal5NcV3KQ=;
 b=MeaKw1C0lBb3ytNf4o/tYmLqjMjr9MnGUIcuwSZusitV2MGh/uub1PvTyKDTLgBOTENH
 k4YyMaZdKJrZsWL0A1AjIKbuSSkqJOHlHpZPs9m7PLyGHzdohYu4yl66pXhBGnK3toUA
 WV0PAVieBUFFLThOrYQf9IwaLte+57vgBUDC2LBSeC+658kJrVt52yo04k52poK0WM7r
 r8ND7Ex8PBFnFwwh/ALf2JjlLraRNd7qF7NWNNDCWekprxGrWzmX2l1ISHcoWj6m1cND
 VlD2fSq97Gw2vL748oYfLb/rkn+zhqiPF+u3hvuHWlWyPu7YBE1saWbKlzJGTuQ3LZiq Ug== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef0p64nfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 17:10:22 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PGxBOl031283;
        Fri, 25 Feb 2022 17:10:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3ear69ym4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 17:10:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PHAIfT55312850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 17:10:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D8AA405F;
        Fri, 25 Feb 2022 17:10:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8CD5A405C;
        Fri, 25 Feb 2022 17:10:17 +0000 (GMT)
Received: from localhost (unknown [9.43.33.143])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 17:10:17 +0000 (GMT)
Date:   Fri, 25 Feb 2022 22:40:16 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: BUG in ext4_ind_remove_space
Message-ID: <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: deyaSjggmfB-sn4cspYyaurgI6aEOALu
X-Proofpoint-ORIG-GUID: deyaSjggmfB-sn4cspYyaurgI6aEOALu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/24 05:12PM, Tadeusz Struk wrote:
>
> Hi,
> Syzbot found an issue [1] in fallocate() that looks to me like a loss of precision.
> The C reproducer [2] calls fallocate() and passes the size 0xffeffeff000ul, and
> offset 0x1000000ul, which is then used to calculate the first_block and
> stop_block using ext4_lblk_t type (u32). I think this gets the MSB of the size
> truncated and leads to invalid calculations, and eventually his BUG() in
> https://elixir.bootlin.com/linux/v5.16.11/source/fs/ext4/indirect.c#L1244
> The issue can be reproduced on 5.17.0-rc5, but I don't think it's a new
> regression. I spent some time debugging it, but could spot anything obvious.
> Can someone have a look please.

I did look into it a little. Below are some of my observations.
If nobody gets to it before me, I can spend sometime next week to verify it's
correctness.

So I think based on the warning log before kernel BUG_ON() [1], it looks like it
has the problem with ext4_block_to_path() calculation with end offset.
It seems it is not fitting into triple block ptrs calculation.

<log>
======
EXT4-fs warning (device sda1): ext4_block_to_path:107: block 1074791436 > max in inode 1137

But ideally it should fit in (right?) since we do make sure if end >= max_block;
then we set it to end = max_block.

Then looking at how we calculate max_block is below
	max_block = (EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1) >> EXT4_BLOCK_SIZE_BITS(inode->i_sb);

So looking closely I think there _could be_ a off by 1 calculation error in
above. So I think above calculation is for max_len and not max_end_block.

I think max_block should be max_end_block which should be this -
	max_end_block = ((EXT4_SB(inode->i_sb)->s_bitmap_maxbytes + blocksize-1) >> EXT4_BLOCK_SIZE_BITS(inode->i_sb))-1;


But I haven't yet verified it completely. This is just my initial thought.
Maybe others can confirm too. Or maybe there is more then one problem.
But somehow above looks more likely to me.

I can verify this sometime next week when I get back to it.
But thanks for reporting the issue :)

-ritesh

[1] https://syzkaller.appspot.com/bug?id=b80bd9cf348aac724a4f4dff251800106d721331

>
>
> [1] https://syzkaller.appspot.com/bug?id=b80bd9cf348aac724a4f4dff251800106d721331
> [2] https://syzkaller.appspot.com/text?tag=ReproC&x=14ba0238700000
>
> --
> Thanks,
> Tadeusz
