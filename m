Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA977550F93
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jun 2022 07:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbiFTFF7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jun 2022 01:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiFTFF5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Jun 2022 01:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40610DEBD;
        Sun, 19 Jun 2022 22:05:56 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25K54RSA019143;
        Mon, 20 Jun 2022 05:05:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=oKkMgzEHVwGgtVKFhkWcqMiX/1k7A6Gq80QjA4WeFu0=;
 b=Dit+wJGDSRFUx9WRXvxw8I7lPkXk8WnHQKvZs+iB7NsV9O5fKaLJrxPr6pWZJw9kDqOM
 iAHp6/5bkoB1bcABF/smPkCOShR88OakPJBTC95qocEpdhigClmNV5WuVpD0ymBCKbAk
 mSgxSNSu5+tdnI/4p+JRSlYIM0WGU22EPaeXlDN8So7uOJTIYiZTsd5L23A4Q1ZDLsTC
 4sOJUcs7mL8QEMRVxlRTFWICpy+7Z2bmnj15XVpFEJcoR2aYk5wBYt+w66i6dbT2zFGN
 W8JCU7e6Xt64S9qii4fJZ1jdi09M9xYrK8fp8bByOXuLbnlp5QtonoM5pRixbjR+QE6X dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr4k6jv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 05:05:50 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25K4S4El004062;
        Mon, 20 Jun 2022 05:05:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gsr4k6ju3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 05:05:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25K55IGf032245;
        Mon, 20 Jun 2022 05:05:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3gs6b8swk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jun 2022 05:05:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25K55jlc15598034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jun 2022 05:05:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D75E8A4054;
        Mon, 20 Jun 2022 05:05:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4BE9A405B;
        Mon, 20 Jun 2022 05:05:43 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.60.58])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Jun 2022 05:05:43 +0000 (GMT)
Date:   Mon, 20 Jun 2022 10:35:40 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <YrAAJEWb9gLzBff5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220516084505.97655-1-ojaswin@linux.ibm.com>
 <Yqb21hTVUvob/sgc@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20220615095607.zkvq2vnh4ebue3qi@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615095607.zkvq2vnh4ebue3qi@zlang-mailbox>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jv9vfzXn9dp_nYjlRKT-OsS7T4WUIzMg
X-Proofpoint-GUID: EVEsk4G9WVMrcfr44B6XWpHx-BNWo_Sr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-20_03,2022-06-17_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=549 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206200023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 15, 2022 at 05:56:07PM +0800, Zorro Lang wrote:
> On Mon, Jun 13, 2022 at 02:05:34PM +0530, Ojaswin Mujoo wrote:
> > Greetings,
> > 
> > Please let me know if there are any reviews/suggestions on this
> > patch.
> 
> This patch has been merged in fstests v2022.05.22, as below
> 
>   ee264b3f common/rc: Modify _require_batched_discard to improve test coverage
> 
> Is there anything wrong with that?
> 
> Thanks,
> Zorro
> 

Ahh I wasn't aware of that, thanks for picking this up :)

Regards,
Ojaswin
