Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2919A39C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbgDACbH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Mar 2020 22:31:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43520 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgDACbH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Mar 2020 22:31:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0312NxCk068145;
        Wed, 1 Apr 2020 02:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bXQZeUAriccPMRpjhbeFP92QDjyQPo2S+U2dDe4VZSo=;
 b=BOfGWGXg7zLgRRAbC5otYR0Lma3zTTZzly8t45DOIpQYGXaXQ7VaXNIBvbBeEazjMZRN
 DZgTYKsl9EF3J53ioDGysRL0OEiNgjZNxzdfXUTCmHbncDj0SkfqFXEWPaxSC0BxpVSf
 Tf3yXqpLQuxZWzP236maSnh8ko/7vEhVEDSezMYZGlHg1nsvdfIm3dniTHV8PtDf0rGl
 ohn4n2/TrgKIOKxoYSPoodgXKFX0FPa1RRAG/qaLmmTbGKGmH3EJGsy3F1j9CvY50To/
 NPoFC2Y4EFVSyrxX7cqzTE9u6TqiZybOJdG1Qe9+S7XbDomKaaqX1281yyoMtfP0VfIa 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 303cev2syh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 02:30:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0312S7ji086089;
        Wed, 1 Apr 2020 02:30:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302g9ygqup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 02:30:38 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0312URpk008022;
        Wed, 1 Apr 2020 02:30:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Tue, 31 Mar 2020 19:29:46 -0700
ORGANIZATION: Oracle Corporation
USER-AGENT: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Message-ID: <yq1mu7w546h.fsf@oracle.com>
Date:   Tue, 31 Mar 2020 19:29:42 -0700 (PDT)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     hch@lst.de, martin.petersen@oracle.com, darrick.wong@oracle.com,
        axboe@kernel.dk, tytso@mit.edu, adilger.kernel@dilger.ca,
        ming.lei@redhat.com, jthumshirn@suse.de, minwoo.im.dev@gmail.com,
        damien.lemoal@wdc.com, andrea.parri@amarulasolutions.com,
        hare@suse.com, tj@kernel.org, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, ajay.joshi@wdc.com, bvanassche@acm.org,
        arnd@arndb.de, houtao1@huawei.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
In-Reply-To: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com> <(Chaitanya>
 <Kulkarni's> <message> <of> <"Sun> <> <29> <Mar> <2020> <10:47:10> <-0700")>
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010020
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Chaitanya,

> This patchset introduces REQ_OP_ASSIGN_RANGE, which is going
> to be used for forwarding user's fallocate(0) requests into
> block device internals.

s/assign_range/allocate/g

-- 
Martin K. Petersen	Oracle Linux Engineering
