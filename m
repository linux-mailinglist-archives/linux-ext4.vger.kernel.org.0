Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD635F482C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 19:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJDRTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJDRTb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 13:19:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204D5F133;
        Tue,  4 Oct 2022 10:19:30 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294GHr3Y016325;
        Tue, 4 Oct 2022 17:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vf+odzlmoDUyIdjb+isG/QhQ2gJ91ocADZn/u9Tew+Y=;
 b=YsWT6FPFxaK2W5FllWUki+j0H0ddgdVQ3A6A1gBhwaANSwVyOpOo316vFSPGwFoPnjFQ
 4lcZrtTZ9on06hqw3xirg0jVIiFNgUfArojAnqbLpCRKaTclSlJAfXH3SCUcaY6sH97X
 4mKoI0Y/hL4wk3ues2/WYKKlZB6A6Cm4b+8KmUuvcMcQB4MfELFQTuhGNW7SmBBTaHM6
 9ZLgCDWfcsQRVQSahmFOOQNqrFCMwcPdOZJPzyIKsNzUxUY6e1nV6hvLcqWhqPOU4zIU
 rSq6w4GY/g3SnH6NtI8wgabnKIQA3sODTYbbqm8o6Tw9FfmK2D3U9cFcOjq2UsVcinPR Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0bdsrefa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 17:19:27 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 294FjRRv020177;
        Tue, 4 Oct 2022 17:19:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0bdsreea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 17:19:27 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 294H5wq1030419;
        Tue, 4 Oct 2022 17:19:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jxctj4gsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 17:19:25 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 294HJNXf59179436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 17:19:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CC8211C04C;
        Tue,  4 Oct 2022 17:19:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9866311C04A;
        Tue,  4 Oct 2022 17:19:21 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.28.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  4 Oct 2022 17:19:21 +0000 (GMT)
Date:   Tue, 4 Oct 2022 22:49:18 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext4: remove unused string "deprecated_msg"
Message-ID: <Yzxq/pGpMxz2CRj8@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20221004112114.101799-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004112114.101799-1-colin.i.king@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: atK1SsYVzz3aUWMvYXU829hZ3raR-31I
X-Proofpoint-GUID: kWybiqWaUv9WeRnYytwAkaDEh0xa86TI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_08,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 04, 2022 at 12:21:14PM +0100, Colin Ian King wrote:
> The string deprecated_msg is no longer being used, remove it.

So if IIUC we use this string as a standard message whenever we use any
mount options about to be deprecated. We don't seem to have any
deprecated mount options right now but we might want to keep the string
around for future?

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/ext4/super.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 2335452efed0..981563c8245e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1740,10 +1740,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  
>  #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
>  
> -static const char deprecated_msg[] =
> -	"Mount option \"%s\" will be removed by %s\n"
> -	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
> -
>  #define MOPT_SET	0x0001
>  #define MOPT_CLEAR	0x0002
>  #define MOPT_NOSUPPORT	0x0004
> -- 
> 2.37.1
> 
