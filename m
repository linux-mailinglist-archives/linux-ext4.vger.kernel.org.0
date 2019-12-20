Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16DB127375
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 03:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfLTCXH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 21:23:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLTCXH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Dec 2019 21:23:07 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK2Ft2F010080;
        Fri, 20 Dec 2019 02:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=UJWbPBLIw8v2NtR3K7tOCA0lIPKrvRnjfNoGkJqvNLw=;
 b=o5pMNgBDCHodm/dDo4k5bp6zaRnszLzYsSQ6dlBmtYwhtkmGmUloMpGFYtzOWATVgkKc
 2cvRtFmz+7cLmKVFuPt69Qwm4Fheg1CTuVGtiv9Hk9EcQc7ALk1PKUKjnJKSDw9JcBcU
 9K5s3KfPUohCuerXob0/O/tJHDFwxn+qDkIwhA8vmatQ2UFQtbcrVm111kgd6Op98QiM
 4KfJuubjS51m2LNYMgPfuCagwdwIKqGed23iSBwX7LgoKeTIsn/ThLeDgseP8IPrV3fB
 61cLD202Ge8PbHEKBRXsn3BOgJ/CnTy3YoALqRdZNCHyEleu7oPathSVdRJ9CvKp6PjA cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2x01jae80k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 02:22:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK2JN0t072948;
        Fri, 20 Dec 2019 02:22:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wyxqjmt50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 02:22:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBK2MfI4026306;
        Fri, 20 Dec 2019 02:22:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 18:22:41 -0800
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        chaitanya.kulkarni@wdc.com, bvanassche@acm.org,
        dhowells@redhat.com, asml.silence@gmail.com
Subject: Re: [PATCH RFC 1/3] block: Add support for REQ_OP_ASSIGN_RANGE operation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <157599668662.12112.10184894900037871860.stgit@localhost.localdomain>
        <157599696813.12112.14140818972910110796.stgit@localhost.localdomain>
        <yq1woatc8zd.fsf@oracle.com>
        <3f2e341b-dea4-c5d0-8eb0-568b6ad2f17b@virtuozzo.com>
        <yq1a77oc56s.fsf@oracle.com> <20191220015338.GB7473@magnolia>
Date:   Thu, 19 Dec 2019 21:22:36 -0500
In-Reply-To: <20191220015338.GB7473@magnolia> (Darrick J. Wong's message of
        "Thu, 19 Dec 2019 17:53:39 -0800")
Message-ID: <yq1a77nag7n.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200014
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Darrick,

[Anchor]

> What happens if you anchor and then try to read the results?  IO
> error?

Depends on the device. Typically you get the same results as UNMAP.

Anchoring is essentially a way to preallocate blocks on a thinly
provisioned device. If you then run out of actual storage capacity you
won't get a write failure writing to those LBAs. It is intended to
protect block ranges that do not tolerate write failures (journals,
metadata).

-- 
Martin K. Petersen	Oracle Linux Engineering
