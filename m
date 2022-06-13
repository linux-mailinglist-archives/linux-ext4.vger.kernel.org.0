Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA5D54822F
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbiFMIfq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jun 2022 04:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiFMIfp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Jun 2022 04:35:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A15513E3E;
        Mon, 13 Jun 2022 01:35:45 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D7wsuk029182;
        Mon, 13 Jun 2022 08:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=Tq+rZQb+sQaBbAJUXL5hT94FZDnniayd4qMtgChCTks=;
 b=rKvvzjUNDn/8P3q5T6NHNxSOjMZf/xHoY2ACMFFUp5UHp6RYPeCGI3lrywHctg3tYTeU
 cRRWifzFw3e3GCHUIl1kN2RB4Tx5sWRc6jRFjiSaril8FNPYxsEvXrPjCN2JOpb9BjjP
 y9ITX98VKRaCg5ZvKdiX9glkzvAP6OZsxor5zWBriiZevqShDsOrKWiinPwHdAmDXqp3
 YmD6UuNDOncVvs5DFa623YCVG0AwZhgYY8jViwXm1TKU+4i5IJXxE6gPlnjlDkcd8WDK
 wZfgPjiQ9LujtnVz+PQqPMhX/nXVqBW54BeMHvj+C1VNcNVxg5wMhawovSgobOA5kPhM Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn54835h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 08:35:44 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25D8Zh8L010644;
        Mon, 13 Jun 2022 08:35:43 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gn54835gs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 08:35:43 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25D8KFZG021366;
        Mon, 13 Jun 2022 08:35:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajaemh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 08:35:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25D8ZdOc10879334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 08:35:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE2942041;
        Mon, 13 Jun 2022 08:35:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0D014203F;
        Mon, 13 Jun 2022 08:35:37 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.28.249])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jun 2022 08:35:37 +0000 (GMT)
Date:   Mon, 13 Jun 2022 14:05:34 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <Yqb21hTVUvob/sgc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220516084505.97655-1-ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516084505.97655-1-ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6HYtaS7_8OogXTh-y_nA-LkW2SGiBzIF
X-Proofpoint-ORIG-GUID: CzJHXZ451k5fwWDgfT5MaGxdz85Doc72
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_02,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=638 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206130038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Greetings,

Please let me know if there are any reviews/suggestions on this
patch.

Thank you!

On Mon, May 16, 2022 at 02:15:05PM +0530, Ojaswin Mujoo wrote:
> A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> have a discard granularity as big as 42MB which makes it larger
> than the group size of ext4 FS with 1k BS.  This causes the FITRIM
> IOCTL to fail.
> 
> This case was not correctly handled by this test since
> "_require_batched_discard" incorrectly interpreted the FITRIM
> failure as SCRATCH_DEV not supporting the IOCTL. This caused the test
> to report "not run" instead of "failed" in case of large discard granularity.
> 
> Fix "_require_batched_discard" to use a more accurate method
> to determine if discard is supported.
> 
> [1] commit 173b6e383d2
>     ext4: avoid trim error on fs with small groups
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
> 
> Changes since v2 [1] 
> 
> *  Eliminated redundant $ret variable
> 
> [1]
> https://lore.kernel.org/all/20220516063951.87838-1-ojaswin@linux.ibm.com/
