Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698C62283F6
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGUPiL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 11:38:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37408 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgGUPiL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 11:38:11 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFHT9X026895;
        Tue, 21 Jul 2020 15:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=7v7sM4o9BcwAeO/G1v01JNEWMbOxJCGDgnJlpAGJe0E=;
 b=RasBQHSduKrBzItygh9yavlIQkiGqohuFYkxumA0z887ZPRe1ZiBIExUPb8geQdaLYHE
 9l7xmDAMbi7hjabkZgZb2nmjogSYm6TS6fgY+C0nynW3NGEHd70Ws8Tii1+iMhtOp3oa
 px/fwdmNtDllYZ1LhiW4oIUFB3QOpgAzOM2IReDAOk5F/KpsovYtOdixZxu1KnNxdOzc
 uZtki3VDpX2/xWB2aJKq5u8nZGkw7u48cgg/Pd4/bs7vLQHkOZjzPV4DcrV/i4i7K+yQ
 KUQ0RP+aQERDtr8CEvdfnYZS677piKzVAYh+0qPzY52jzbtskJo1nYGFAMrG9x6UFZux 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32d6ksj846-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jul 2020 15:38:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06LFMwiE043957;
        Tue, 21 Jul 2020 15:38:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32dyj64q62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:38:03 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06LFc0Gm032687;
        Tue, 21 Jul 2020 15:38:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jul 2020 08:38:00 -0700
Date:   Tue, 21 Jul 2020 08:37:59 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200721153759.GC848607@magnolia>
References: <20200422161242.GD6733@magnolia>
 <20200401151837.GB56931@magnolia>
 <2461554.1585726747@warthog.procyon.org.uk>
 <2504712.1587485842@warthog.procyon.org.uk>
 <BFC9114B-7D3D-4B8F-A8BB-75C2770EE36D@dilger.ca>
 <533172.1595323235@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533172.1595323235@warthog.procyon.org.uk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=1
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9689 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 bulkscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210111
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 21, 2020 at 10:20:35AM +0100, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > The other properties look fine (in principle) to me though. :)
> 
> Can I put that down as a reviewed-by?

Hang on, let me take a second look and do a real review. :)

--D

> Thanks,
> David
> 
