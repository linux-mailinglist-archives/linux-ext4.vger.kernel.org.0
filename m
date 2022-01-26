Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09FB49C49E
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jan 2022 08:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiAZHhY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jan 2022 02:37:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55178 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229676AbiAZHhY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Jan 2022 02:37:24 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7Gre3028185;
        Wed, 26 Jan 2022 07:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ppOwec3ujgFefQkPlGu/OQiFV3uMMY3XME23EBzyWS0=;
 b=MmyWjn/N2fVl5zj6WS7Jgv42DgJqDAF+HTZ2SMjsWeJwXPdqlR9mfKYTmUNaPXQn0EKg
 doJGP/iDF50h4MZ1RmeWvUoGTtJSD5Cm+fpZbJWViFEQV1gh9zX/NDTHZJJrK1zJ/R8S
 6e8wJibdUkbJTx/mFAufZ5gd9YtuzQ6SWIvDA8qEvkt8xh/3T6Jn4GjQHwC7U0ZRVw7c
 WcXwFkJrzLi8A+ijD2T41v+cYqjrLZOJ/JhUmf0OwRGt+XsEUQKyFx5AynClfJ6xVrdz
 5St35f82lmT9EGWL4ub0aaK0zcozbS4yS78X6Un8nmGoc3Dj5wgJlOWcOqzU04r19nNg ug== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du1s78cfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 07:37:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7Xjdf029309;
        Wed, 26 Jan 2022 07:37:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j9bxse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 07:37:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20Q7b3rd48300328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:37:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567F642045;
        Wed, 26 Jan 2022 07:37:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D306D42049;
        Wed, 26 Jan 2022 07:37:01 +0000 (GMT)
Received: from localhost (unknown [9.43.37.89])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 07:37:01 +0000 (GMT)
Date:   Wed, 26 Jan 2022 13:06:59 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        chenlong <chenlongcl.chen@huawei.com>
Subject: Re: [RFC 0/1] ext4/054: Should we remove auto and quick group?
Message-ID: <20220126073659.zo2znw273jr6i6rs@riteshh-domain>
References: <cover.1643089143.git.riteshh@linux.ibm.com>
 <YfBY2pMmEFPb+qCF@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfBY2pMmEFPb+qCF@mit.edu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y6vyDnch9SGVqKddU71x8c3gX9z1dlS0
X-Proofpoint-ORIG-GUID: Y6vyDnch9SGVqKddU71x8c3gX9z1dlS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=887 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260040
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/25 03:08PM, Theodore Y. Ts'o wrote:
> On Tue, Jan 25, 2022 at 11:32:01AM +0530, Ritesh Harjani wrote:
> > Hello Zhang/Ted,
> >
> > Looks like the issue fixed by patches at [1], were observed with fault injection
> > testing and with errors=continue mount option. But were not cc'd to stable.
> >
> > Do you think those should be cc'd to stable tree?
>
> I already requested that they be backported, and they are in 5.10.89+
> and 5.15.12+.  Unfortunately the patches don't backport cleanly into
> 5.4, and while I did the manual backport for 5.10, I haven't gotten
> around to backporting them into 5.4 or older kernels.
>

Sure Ted, thanks a lot for the backport and for providing above information.

-ritesh
