Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A2119CEEB
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 05:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbgDCDqo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 23:46:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51858 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389477AbgDCDqn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 23:46:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0333df0P052079;
        Fri, 3 Apr 2020 03:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LP7MuDfUnm55cjU9l7zcHfb9C7qAOx6lnmRiUvL5W3w=;
 b=d9WWJvW5KLLw/zgxDi+0crxqY1bNiZGCtqvWWx2SGooEBfH4mF/qnsRPs6fVQMkyDlj9
 4dLHigyfRG2F6fBaOqXEfBDnTlKwr2zKIjEuR2rpRbCTf4H+atilh+GxnMS3NRr6TCOp
 Y9d+1G4ulSU1mL03p3Mqq8TWG+n8KdhPUCQ6+Et/9faPs/JbeYavyOiZdUE0fopbY+Jj
 cvMg7HHBgBY/3YdoSsHEnXmOzry763FKCarlzS3O6v984NbW4CMbxouTbtWMQCQpkOsu
 7CdiankJkhoKv+BwO64W3zW2FoCbPMiqA2ynVbIt9UjdewKJKGcOJTuMBXV2XZ04My/Q gw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 303ceveudu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 03:46:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0333cILs098315;
        Fri, 3 Apr 2020 03:46:11 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 302ga3pctu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 03:46:11 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0333k0PQ019888;
        Fri, 3 Apr 2020 03:46:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Thu, 02 Apr 2020 20:45:34 -0700
ORGANIZATION: Oracle Corporation
USER-AGENT: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Message-ID: <yq1a73t44h1.fsf@oracle.com>
Date:   Thu, 2 Apr 2020 20:45:30 -0700 (PDT)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
        darrick.wong@oracle.com, axboe@kernel.dk, tytso@mit.edu,
        adilger.kernel@dilger.ca, ming.lei@redhat.com, jthumshirn@suse.de,
        minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        hannes@cmpxchg.org, khlebnikov@yandex-team.ru, ajay.joshi@wdc.com,
        bvanassche@acm.org, arnd@arndb.de, houtao1@huawei.com,
        asml.silence@gmail.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/4] block: Add support for REQ_OP_ASSIGN_RANGE
References: <20200329174714.32416-1-chaitanya.kulkarni@wdc.com>
 <20200402224124.GK10737@dread.disaster.area> <yq1imih4aj0.fsf@oracle.com>
 <20200403025757.GL10737@dread.disaster.area>
In-Reply-To: <20200403025757.GL10737@dread.disaster.area> <(Dave> <Chinner's>
 <message> <of> <"Fri> <> <3> <Apr> <2020> <13:57:57> <+1100")>
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030029
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Dave,

> .... because when backed by thinp storage, plumbing user level
> fallocate() straight through from the filesystem introduces a
> trivial, user level storage DOS vector....
>
> i.e. a user can just fallocate a bunch of files and, because the
> filesystem can do that instantly, can also run the back end array
> out of space almost instantly. Storage admins are going to love
> this!

In the standards space, the allocation concept was mainly aimed at
protecting filesystem internals against out-of-space conditions on
devices that dedup identical blocks and where simply zeroing the blocks
therefore is ineffective.

So far we have mainly been talking about fallocate on block devices. How
XFS decides to enforce space allocation policy and potentially leverage
this plumbing is entirely up to you.

-- 
Martin K. Petersen	Oracle Linux Engineering
