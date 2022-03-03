Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FDD4CC070
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiCCO5z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 09:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiCCO5u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 09:57:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2718FAD1
        for <linux-ext4@vger.kernel.org>; Thu,  3 Mar 2022 06:57:03 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223EYTnD025418;
        Thu, 3 Mar 2022 14:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=YN7DtEPoSLmoBwfIMa0FHhdIHuih+2lkcslH1MRFYnE=;
 b=sQY3HirvXlRnm+eE1MfFtZNPH6wqsvOUFA2clWjUykWvg+vRzWvlPNH5/RC2PXatVk3V
 wNhjwfU9ASAHr+8w/MlDex2seZRhzQJtgejhFjYVGRvhVDIbqqHaTL0DKkQGjNpbgb+w
 pCgeQ02bveKYEsNWEQ+z9zcYEvNkIFnFmCZ13EWo08VF9/wJF0moIkWUoqTrM4yR2kQe
 ogu87iOUuy28koXZkhVIQjljd8l6G7HmJheeWhQCbBiYwLotQGqSWFlf4qUBMqrPd4Ie
 E2sT0TPHK5LNvvxrolKLnegzBn/QSffr4A6dln6bM44gAxY1jmwc0A0VXWkoflmsMO+O tA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejnp24uqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:56:57 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 223Emusx025229;
        Thu, 3 Mar 2022 14:56:55 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3efbu9jb43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 14:56:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 223Eurk846006546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Mar 2022 14:56:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83A1E11C054;
        Thu,  3 Mar 2022 14:56:53 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14A8011C05B;
        Thu,  3 Mar 2022 14:56:53 +0000 (GMT)
Received: from localhost (unknown [9.43.2.236])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Mar 2022 14:56:52 +0000 (GMT)
Date:   Thu, 3 Mar 2022 20:26:51 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: BUG in ext4_ind_remove_space
Message-ID: <20220303145651.ackek7wotphg26gm@riteshh-domain>
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
 <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EI3aU6HZoiwHTkNldH2ejjhL3qqr5OFu
X-Proofpoint-GUID: EI3aU6HZoiwHTkNldH2ejjhL3qqr5OFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=823
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203030069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/02 03:14PM, Tadeusz Struk wrote:
> On 2/25/22 11:19, Tadeusz Struk wrote:
> > > I can verify this sometime next week when I get back to it.
> > > But thanks for reporting the issue :)
> >
> > Next week is perfectly fine. Thanks for looking into it.
>
> Hi Ritesh,
> Did you have chance to look into this?
> If you want I can send a patch that fixes the off by 1 calculation error.

Hi Tadeusz,

I wanted to look at that path a bit more before sending that patch.
Last analysis by me was more of a cursory look at the kernel dmesg log which you
had shared.

In case if you want to pursue that issue and spend time on it, then feel free to
do it.

I got pulled into number of other things last week and this week. So didn't get
a chance to look into it yet. I hope to look into this soon (if no one else
picks up :))

-ritesh


>
> --
> Thanks,
> Tadeusz
