Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4E6DAC1A
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Apr 2023 13:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjDGLKn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Apr 2023 07:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGLKl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Apr 2023 07:10:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2C19C;
        Fri,  7 Apr 2023 04:10:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AFVu2032509;
        Fri, 7 Apr 2023 11:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k41tjd4bM2A6RL5KfGaSlVRapOqsdVZoLPjDaoGbXi0=;
 b=Y+9w2OMD50TZdV2s4VFK9NluJMc3gkH14xNOLvGzSMPDeTeW5Ad4QfaRyYBR+Imc3WtY
 OjqQxTp3ETVs1C4tL0SchyM6t5Oqmr3JCYxh7Oe/scd610tRPhioXMe0RH9numiT76G6
 c+FaKbAe0ZjJhnNt8Bs+npqYJM2yk05+fIlcgpLlXjiK2bS9BGZ03vRqLlER+yn7elHi
 SmGGfNs1DeZf5HTD1uTy/5k99kIh7lheBdJuOEC3tBjOAPsSGFWLFqZLGmlv87gYvDfA
 GUzgWAwAm9P3YD2mNr7yyoIN+dBAQHmjUCwq1UKiGoFhrsdkPrzy8nOVTl/cvojV4Gqk VQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pt6fh5afd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:10:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3373vP42015886;
        Fri, 7 Apr 2023 11:10:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg4we9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:10:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337BAS0Y40764142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:10:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 734E32004B;
        Fri,  7 Apr 2023 11:10:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAE8020040;
        Fri,  7 Apr 2023 11:10:26 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.66.68])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:10:26 +0000 (GMT)
Date:   Fri, 7 Apr 2023 16:40:24 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] ext4: try all groups in ext4_mb_new_blocks_simple
Message-ID: <ZC/6IJT8NxQTTE27@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
 <20230321161220.418652-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-9-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DlntX4CQO1YOP3-Z_NziU0ix36jYstav
X-Proofpoint-GUID: DlntX4CQO1YOP3-Z_NziU0ix36jYstav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=738 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:20AM +0800, Kemeng Shi wrote:
> ext4_mb_new_blocks_simple ignores the group before goal, so it will fail
> if free blocks reside in group before goal. Try all groups to avoid
> unexpected failure.
> Search finishes either if any free block is found or if no available
> blocks are found. Simpliy check "i >= max" to distinguish the above
> cases.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/mballoc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
