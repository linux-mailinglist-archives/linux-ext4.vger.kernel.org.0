Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92D4CC6CC
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiCCUI7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCCUI7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 15:08:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D549F14
        for <linux-ext4@vger.kernel.org>; Thu,  3 Mar 2022 12:08:12 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223JngJK006676;
        Thu, 3 Mar 2022 20:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=DRuQwyOwzrhz9FBfORfRGfbp6vYglBz5TovG695+I/s=;
 b=G1sO+NKD/81J1FP/KsJj+XA+8T8wWZyTi3fozb97tHCE9D6HHhWbQsrgOXPCfKDrQS+6
 iOQGdhXNXTbQlfBgm4A9/epDr8kRTCKKK7MPBoOvEDn8sude4FX/X0Yew7IEk79tjm/j
 tPgGMiaYHFkev0H7jjlPeu6JpxXz4e1Z/+mRQ9LHwxfaYRJa+nJYt/jTrCKjyIddCXHe
 eFdp086w/kYX83YOakrVKGY9S6QczdWW2OApRNxzWGixbphW3ELhZFL5bZhULLlrLtRD
 so0iMZYssuE8Uv0y90B+7NH8eeet3eeS6qKQ7Zh4yXBobmSFpmACP0V8vNvTqA+rMGtf lA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ek464ga5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 20:08:09 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223K3ToU018337;
        Thu, 3 Mar 2022 20:08:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3efbfju2v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 20:08:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223K85OJ53281164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 20:08:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD1CDA404D;
        Thu,  3 Mar 2022 20:08:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C03A4040;
        Thu,  3 Mar 2022 20:08:05 +0000 (GMT)
Received: from localhost (unknown [9.43.88.206])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 20:08:05 +0000 (GMT)
Date:   Fri, 4 Mar 2022 01:38:04 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: BUG in ext4_ind_remove_space
Message-ID: <20220303200804.hugwhtqovxiutkfd@riteshh-domain>
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
 <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
 <20220303145651.ackek7wotphg26gm@riteshh-domain>
 <995d8b3c-44ee-e190-42ae-75f2562b8d6b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <995d8b3c-44ee-e190-42ae-75f2562b8d6b@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2aGh6iX59wZlkWlqW_qXEDdrROq3V5pn
X-Proofpoint-ORIG-GUID: 2aGh6iX59wZlkWlqW_qXEDdrROq3V5pn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=794 spamscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/03 07:37AM, Tadeusz Struk wrote:
> On 3/3/22 06:56, Ritesh Harjani wrote:
> > On 22/03/02 03:14PM, Tadeusz Struk wrote:
> > > On 2/25/22 11:19, Tadeusz Struk wrote:
> > > > > I can verify this sometime next week when I get back to it.
> > > > > But thanks for reporting the issue :)
> > > >
> > > > Next week is perfectly fine. Thanks for looking into it.
> > >
> > > Hi Ritesh,
> > > Did you have chance to look into this?
> > > If you want I can send a patch that fixes the off by 1 calculation error.
> >
> > Hi Tadeusz,
> >
> > I wanted to look at that path a bit more before sending that patch.
> > Last analysis by me was more of a cursory look at the kernel dmesg log which you
> > had shared.
> >
> > In case if you want to pursue that issue and spend time on it, then feel free to
> > do it.
> >
> > I got pulled into number of other things last week and this week. So didn't get
> > a chance to look into it yet. I hope to look into this soon (if no one else
> > picks up :))
>
> I'm not familiar with the internals of ext4 implementation so I would rather
> have someone who knows it look at it.

No problem. I am willing to look into this anyways.
btw, this issue could be seen easily with below cmd on non-extent ext4 FS.

sudo xfs_io -f -c "truncate 0x4010040c000" -c "fsync" -c "fpunch 0x1000000 0xffefffff000" testfile

-ritesh

