Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C57A46D3
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbjIRKVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbjIRKUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 06:20:42 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAA3AD;
        Mon, 18 Sep 2023 03:20:33 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IA8gC2030043;
        Mon, 18 Sep 2023 10:20:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2Zg8gA925yQ/p+JDB+pZFZfdvzHgwV2x+8QSkYSk+BA=;
 b=kjUgQgHrE3WNBqJkMh3q83907YoQB1C+3XVjgxej//ZvQ/s1N3AirudiMMgytL9V8Cmr
 xy5rpF31I7vPA/y2/BhbmhAeElhU7v48gHl72LAPZokDNhE9sfy9nfyVb8eG8q6rYkDS
 USvxwdjPvmhpVCf9T25U/obpAyNK0jAjL/rE8/8lP4DVpMt1zvchz1eOh1pPv+3JvVGd
 6+BfeEffNhI/tAsRypC4XrcJAxV2M8WRVriQ/B1auLC/T7ZT5HXdrnxmOFAUHGcbdSJT
 mQFtHiC1PxniTo/jxKMkri/Xzz6wN/pV+0k9oRsyPzp90rkF9o5UdaWDCqfMsfk3oVXs Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6jxgabps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:20:27 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IA9O75000481;
        Mon, 18 Sep 2023 10:20:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6jxgabpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:20:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I9S95Z005564;
        Mon, 18 Sep 2023 10:20:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2ya014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:20:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IAKOIw42795280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 10:20:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07A222006C;
        Mon, 18 Sep 2023 10:20:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB4322004E;
        Mon, 18 Sep 2023 10:20:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.103.37])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 18 Sep 2023 10:20:18 +0000 (GMT)
Date:   Mon, 18 Sep 2023 15:50:13 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <ZQgkXWy2UTgDf2gU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1694860198.git.ojaswin@linux.ibm.com>
 <2fe0c7461d7a49eec46a1c83667ae678825d8b76.1694860198.git.ojaswin@linux.ibm.com>
 <20230918072609.teegybfhht23gzzc@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918072609.teegybfhht23gzzc@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 810UHDBZIyhQG215-njLSOd5HhwGq512
X-Proofpoint-ORIG-GUID: 2YVxHUeAgwDTzx5nyHGb861eHMJEiIZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_02,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 mlxlogscore=764 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Thanks for the review!

On Mon, Sep 18, 2023 at 09:26:09AM +0200, Jan Kara wrote:
> On Sat 16-09-23 16:12:13, Ojaswin Mujoo wrote:
> > ** Short Version **
> > 
> > In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> > get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> > UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> > never zero out the range of bh that is not under write, causing whatever stale
> > data is present in the folio at that time to be written out to disk. To fix this
> > mark the buffer as new in ext4_get_block_unwritten(), in case it is unwritten.
> > 
> > -----
> 
> I'm not sure if this separator isn't going to confuse some tools processing
> patches ;)

Oh no, my bad :/ Let me quickly send a v3 to fix this. Thanks for
pointing it out.

Regards,
ojaswin
